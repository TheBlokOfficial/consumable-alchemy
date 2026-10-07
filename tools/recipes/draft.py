"""Draft of recipes_table.json - the hand-edited recipe table read by the mod (decision D19).

python draft.py            write recipes_table.json (refuses to overwrite an existing table)
python draft.py --force    overwrite the existing table (hand edits are lost!)
python draft.py --diff     compare the existing table with a fresh draft (shows hand edits)

The draft reproduces the v0.3 behaviour: full = vanilla recipe (XML order),
copy = rule.py (price threshold 16, quantity divisor 2).
Covered: every alchemy recipe whose item is a consumable in the mod
(mirrors CA_IsConsumableItemName in consumableAlchemy_common.ws).
Needs data.json (recipes.py).
"""
import json, os, re, sys
import rule

HERE = os.path.dirname(os.path.abspath(__file__))
TABLE = os.path.join(HERE, 'recipes_table.json')
KINDS = ('potion', 'bomb', 'decoction')

items, recipes = rule.items, rule.recipes

def is_consumable(n):
    # CA_IsConsumableItemName
    it = items.get(n)
    if not it:
        return False
    t = it['tags']
    if 'SingletonItem' not in t:
        return False
    if n in ('Snow Ball', 'Tutorial Bomb', 'Village drink'):
        return False
    if 'Quest' in t or 'NoAdditionalAmmo' in t or 'InfiniteAmmo' in t:
        return False
    return it.get('category') == 'petard' or 'Potion' in t

def kind(r):
    n = r['cookedItem_name']
    if items[n].get('category') == 'petard':
        return 'bomb'
    if r.get('cookedItemType') == 'mutagen_potion' or 'Mutagen' in items[n]['tags']:
        return 'decoction'
    return 'potion'

def family(n, k):
    if k == 'decoction':
        return n                                      # 'Mutagen 12' is not level 12
    return re.sub(r' [123]$', '', n)

def natural(s):
    return [int(x) if x.isdigit() else x.lower() for x in re.split(r'(\d+)', s)]

def sort_key(item):
    key, e = item
    return (KINDS.index(e['kind']), natural(e['family']), e['level'], key)

def draft():
    table = {}
    for key, r in recipes.items():
        n = r['cookedItem_name']
        if not is_consumable(n):
            continue
        k = kind(r)
        table[key] = {
            'item': n,
            'family': family(n, k),
            'level': int(r.get('level', 1)),
            'kind': k,
            'full': [[i, q] for i, q in r['ings']],
            'copy': [[i, q] for i, q in rule.copy(r['ings'])],
            'note': '',
        }
    return dict(sorted(table.items(), key=sort_key))

def dumps(table):
    # One recipe per block, one field per line, ingredient lists on one line each.
    out = ['{']
    keys = list(table)
    for i, key in enumerate(keys):
        e = table[key]
        fields = ['    %s: %s' % (json.dumps(f), json.dumps(e[f], ensure_ascii=False)) for f in e]
        out.append('  %s: {' % json.dumps(key, ensure_ascii=False))
        out.append(',\n'.join(fields))
        out.append('  }' + (',' if i < len(keys) - 1 else ''))
    out.append('}')
    return '\n'.join(out) + '\n'

def fmt(lst):
    return ', '.join('%s x%d' % (n, q) for n, q in lst)

def diff(old, new):
    count = 0
    for key in sorted(set(old) | set(new)):
        if key not in old:
            print('missing in table: %s' % key); count += 1; continue
        if key not in new:
            print('only in table:    %s' % key); count += 1; continue
        for f in ('item', 'family', 'level', 'kind', 'full', 'copy', 'note'):
            if old[key].get(f) != new[key][f]:
                a, b = old[key].get(f), new[key][f]
                if f in ('full', 'copy'):
                    a, b = fmt(a or []), fmt(b)
                print('%-40s %-6s table: %s\n%-40s %-6s draft: %s' % (key, f, a, '', '', b))
                count += 1
    print('%d difference(s)' % count)

if __name__ == '__main__':
    args = sys.argv[1:]
    table = draft()
    if '--diff' in args:
        diff(json.load(open(TABLE, encoding='utf-8')), table)
        sys.exit(0)
    if os.path.exists(TABLE) and '--force' not in args:
        sys.exit('%s exists (hand-edited). Use --force to overwrite or --diff to compare.' % TABLE)
    with open(TABLE, 'w', encoding='utf-8', newline='\n') as f:
        f.write(dumps(table))
    counts = {k: sum(1 for e in table.values() if e['kind'] == k) for k in KINDS}
    print('%s: %d recipes %s' % (TABLE, len(table), counts))
