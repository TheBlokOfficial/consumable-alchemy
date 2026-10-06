"""Copy-recipe rule (variant A, session 4) - mirrors CA_GetCopyIngredients in consumableAlchemy_recipes.ws.

python rule.py [price_threshold=16] [quantity_divisor=2]

Kept: alcohol (StrongAlcohol, always x1; White Gull 1 -> Alcohest), bomb base powders
and every ingredient with base price <= threshold (quantity / divisor, rounded up).
Dropped: previous-level item, monster parts, mutagens, rare minerals, pearl...
"""
import json, os, sys
d = json.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'data.json')))
items, recipes = d['items'], d['recipes']
TH = int(sys.argv[1]) if len(sys.argv) > 1 else 16
DIV = int(sys.argv[2]) if len(sys.argv) > 2 else 2
BOMB_BASES = ('Saltpetre', 'Stammelfords dust', 'Alchemists powder')

def price(n): return int(items.get(n, {}).get('price', 0))
def tags(n): return items.get(n, {}).get('tags', [])
def cat(n): return items.get(n, {}).get('category')
def cost(lst): return sum(price(n) * q for n, q in lst)

def copy(ings):
    out = []
    for n, q in ings:
        if cat(n) in ('potion', 'petard'):
            continue                                   # previous level
        if 'StrongAlcohol' in tags(n):
            out.append(('Alcohest' if n == 'White Gull 1' else n, 1))
        elif n in BOMB_BASES or ('MutagenIngredient' not in tags(n) and price(n) <= TH):
            out.append((n, (q + DIV - 1) // DIV))
    return out

for r in recipes.values():
    if r.get('cookedItemType') not in ('potion', 'petard', 'mutagen_potion'): continue
    if r['cookedItem_name'].startswith(('sq', 'mq')): continue
    full = [(n, q) for n, q in r['ings'] if cat(n) not in ('potion', 'petard')]
    c = copy(r['ings'])
    print('%-28s full=%4d copy=%3d | %s' % (r['cookedItem_name'], cost(full), cost(c),
          ', '.join('%s x%d' % x for x in c)))
