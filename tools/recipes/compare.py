"""Compare copy-recipe rules: v2 (base + cheap) vs 'drop the most expensive ingredient'."""
import json, os
d = json.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'data.json')))
items, recipes = d['items'], d['recipes']
BOMB_BASES = ('Saltpetre', 'Stammelfords dust', 'Alchemists powder')

def price(n): return int(items.get(n, {}).get('price', 0))
def tags(n): return items.get(n, {}).get('tags', [])
def prev(n): return items.get(n, {}).get('category') in ('potion', 'petard')
def alc(n): return 'StrongAlcohol' in tags(n)
def cost(lst): return sum(price(n) * q for n, q in lst)

def v2(ings):
    out = []
    for n, q in ings:
        if prev(n): continue
        if n == 'White Gull 1': out.append(('Alcohest', q)); continue
        if alc(n) or n in BOMB_BASES or price(n) <= 16: out.append((n, q))
    return out

def drop_max(ings):
    rest = [(n, q) for n, q in ings if not prev(n)]
    cand = [(n, q) for n, q in rest if not alc(n)]
    if cand:
        top = max(cand, key=lambda x: price(x[0]) * x[1])
        rest.remove(top)
    return rest

for r in recipes.values():
    if r.get('cookedItemType') not in ('potion', 'petard', 'mutagen_potion'): continue
    if r['cookedItem_name'].startswith(('sq', 'mq')): continue
    full = [(n, q) for n, q in r['ings'] if not prev(n)]
    a, b = v2(r['ings']), drop_max(r['ings'])
    left = [n for n, q in b if price(n) > 16 and not alc(n)]
    print('%-28s full=%4d v2=%4d dropmax=%4d  dropmax keeps expensive: %s' % (
        r['cookedItem_name'], cost(full), cost(a), cost(b), ', '.join(left)))
