import re, glob, os, collections, json
base = os.path.join(os.path.dirname(__file__), 'x')
files = glob.glob(os.path.join(base, '**', '*.xml'), recursive=True)

items = {}
recipes = collections.OrderedDict()
item_re = re.compile(r'<item\s([^>]*?)/?>(.*?)(?:</item>|(?=<item\s))', re.S)
attr_re = re.compile(r'(\w+)\s*=\s*"([^"]*)"')
for f in files:
    t = open(f, encoding='utf-8', errors='replace').read()
    t = re.sub(r'<!--.*?-->', '', t, flags=re.S)
    if 'items_plus' in f:
        continue
    for m in item_re.finditer(t):
        a = dict(attr_re.findall(m.group(1)))
        if 'name' not in a:
            continue
        tags = re.search(r'<tags>(.*?)</tags>', m.group(2), re.S)
        a['tags'] = [x.strip() for x in tags.group(1).split(',')] if tags else []
        a['file'] = os.path.relpath(f, base)
        items.setdefault(a['name'], a)
    for m in re.finditer(r'<recipe\s([^>]*)>(.*?)</recipe>', t, re.S):
        a = dict(attr_re.findall(m.group(1)))
        ings = [(i['item_name'], int(i['quantity'])) for i in
                (dict(attr_re.findall(x)) for x in re.findall(r'<ingredient\s([^>]*)/>', m.group(2)))]
        a['ings'] = ings
        a['file'] = os.path.relpath(f, base)
        recipes[a.get('name_name')] = a

json.dump({'items': items, 'recipes': recipes}, open(os.path.join(os.path.dirname(__file__), 'data.json'), 'w'), indent=1)

def kind(n):
    it = items.get(n)
    if not it:
        return '?'
    tg = it['tags']
    c = it.get('category', '')
    if 'MutagenIngredient' in tg: return 'MUTAGEN'
    if c in ('alchemy_ingredient',) and 'AlchemyIngredient' in tg and 'Alcohol' in str(tg): return 'alc'
    return c + ':' + '|'.join(x for x in tg if x not in ('AlchemyIngredient', 'mod_alchemy', 'ReadableItem'))

used = collections.Counter()
for r in recipes.values():
    if r.get('cookedItemType') in ('potion', 'petard'):
        for n, q in r['ings']:
            used[n] += q
print('== ingredients used in potion/petard recipes')
for n, q in sorted(used.items(), key=lambda x: kind(x[0])):
    it = items.get(n, {})
    print('%-28s %-60s price=%-4s total_qty=%d' % (n, kind(n)[:60], it.get('price', '?'), q))
