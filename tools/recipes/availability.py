"""Where can each potion/bomb/decoction ingredient be obtained? (shops, herb nodes, monsters, containers)."""
import json, os, re, glob, collections
here = os.path.dirname(os.path.abspath(__file__))
d = json.load(open(os.path.join(here, 'data.json')))
items, recipes = d['items'], d['recipes']
BOMB_BASES = ('Saltpetre', 'Stammelfords dust', 'Alchemists powder')
TH = 16

def price(n): return int(items.get(n, {}).get('price', 0))
def tags(n): return items.get(n, {}).get('tags', [])
def prev(n): return items.get(n, {}).get('category') in ('potion', 'petard')
def keep(n): return 'StrongAlcohol' in tags(n) or n in BOMB_BASES or price(n) <= TH

used = collections.OrderedDict()
for r in recipes.values():
    if r.get('cookedItemType') not in ('potion', 'petard', 'mutagen_potion'): continue
    if r['cookedItem_name'].startswith(('sq', 'mq')): continue
    for n, q in r['ings']:
        if not prev(n):
            used.setdefault(n, set()).add(r['cookedItem_name'])

# loot tables: name -> set(entries); grouped by source file kind
src = collections.defaultdict(lambda: collections.defaultdict(set))   # ingredient -> kind -> loot names
base = os.path.join(here, 'x')
for f in glob.glob(os.path.join(base, '**', 'def_loot*.xml'), recursive=True) + glob.glob(os.path.join(base, '**', '*shop*.xml'), recursive=True):
    if 'items_plus' in f: continue
    fn = os.path.basename(f)
    kind = ('shop' if 'shop' in fn else 'herb' if 'herb' in fn else 'monster' if 'monster' in fn or 'animal' in fn or 'actor' in fn
            else 'container' if 'container' in fn or 'treasure' in fn or 'unique' in fn else 'other')
    t = re.sub(r'<!--.*?-->', '', open(f, encoding='utf-8', errors='replace').read(), flags=re.S)
    for m in re.finditer(r'<loot\s+name="([^"]+)"[^>]*>(.*?)</loot>', t, re.S):
        for e in re.findall(r'<loot_entry\s+name="([^"]+)"', m.group(2)):
            if e in used:
                src[e][kind].add(m.group(1))

def short(s, k=4):
    s = sorted(s)
    return ', '.join(s[:k]) + (' +%d' % (len(s) - k) if len(s) > k else '')

def common(n):
    if n == 'White Gull 1': return False
    return 'StrongAlcohol' in tags(n) or len(src[n]['herb']) > 0 or len(src[n]['shop']) >= 7

import sys
if len(sys.argv) > 1 and sys.argv[1] == 'copies':
    for r in recipes.values():
        if r.get('cookedItemType') not in ('potion', 'petard', 'mutagen_potion'): continue
        if r['cookedItem_name'].startswith(('sq', 'mq')): continue
        full = [(n, q) for n, q in r['ings'] if not prev(n)]
        cp = [(n, q) for n, q in full if common(n)] + [('Alcohest', q) for n, q in full if n == 'White Gull 1']
        c = lambda l: sum(price(n) * q for n, q in l)
        out = [n for n, q in full if not common(n)]
        print('%-28s full=%4d copy=%4d  out: %s' % (r['cookedItem_name'], c(full), c(cp), ', '.join(out)))
    sys.exit()

rows = sorted(used, key=lambda n: (not keep(n), price(n)))
for n in rows:
    s = src[n]
    print('%-5s %-6s %-26s %3d | shop %3d [%s] | herb %d | monster %3d [%s] | cont %3d | other %d' % (
        'KEEP' if keep(n) else 'drop', 'common' if common(n) else 'RARE', n, price(n), len(s['shop']), short(s['shop'], 3), len(s['herb']),
        len(s['monster']), short(s['monster'], 2), len(s['container']), len(s['other'])))
