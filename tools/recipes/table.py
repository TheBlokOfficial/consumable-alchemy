import json, os
d = json.load(open(os.path.join(os.path.dirname(__file__), 'data.json')))
items, recipes = d['items'], d['recipes']

def kind(n):
    it = items.get(n)
    if not it: return 'quest'
    tg = it['tags']; c = it.get('category')
    if c in ('potion', 'petard'): return 'PREV'
    if 'StrongAlcohol' in tg or 'Alcohol' in tg or n == 'White Gull 1': return 'alc'
    if 'HerbGameplay' in tg: return 'herb'
    if c == 'crafting_ingredient': return 'craft'
    if it.get('grid_size') or float(it.get('weight', 0)) > 0.15: return 'monster'
    return 'mineral'

def price(n):
    return int(items.get(n, {}).get('price', 0))

for r in recipes.values():
    if r.get('cookedItemType') not in ('potion', 'petard'): continue
    ings = r['ings']
    full = sum(price(n) * q for n, q in ings if kind(n) != 'PREV')
    s = ', '.join('%s x%d [%s %d]' % (n, q, kind(n), price(n)) for n, q in ings)
    print('%-34s L%s %-6s full=%4d | %s' % (r['cookedItem_name'], r.get('level'), r['cookedItemType'], full, s))
