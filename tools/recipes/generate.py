"""recipes_table.json -> consumableAlchemy_recipes_table.ws (decision D19).

python generate.py

Validates the table (exits with an error on a problem) and writes the generated script.
One small function per recipe and one switch per kind: vanilla splits big functions
because the script compiler runs out of memory (HACK_NO_MEMORY_TO_COMPILE_* in
gameEffectManager.ws, OutOfMemoryHack_* in quest_function.ws).
"""
import json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
TABLE = os.path.join(HERE, 'recipes_table.json')
OUT = os.path.join(HERE, '..', '..', 'src', 'modConsumableAlchemy', 'content', 'scripts', 'local',
                   'consumableAlchemy_recipes_table.ws')
KINDS = ('potion', 'bomb', 'decoction')
FIELDS = ('item', 'family', 'level', 'kind', 'full', 'copy', 'note')
NAME_RE = re.compile(r"^[A-Za-z0-9 _\-.]+$")         # safe inside a 'name' literal

def natural(s):
    return [int(x) if x.isdigit() else x.lower() for x in re.split(r'(\d+)', s)]

def validate(table):
    errors = []
    def err(key, msg): errors.append('%s: %s' % (key, msg))
    if not isinstance(table, dict) or not table:
        sys.exit('table is empty or not an object')
    for key, e in table.items():
        if not NAME_RE.match(key):
            err(key, 'invalid recipe name')
        if not isinstance(e, dict):
            err(key, 'entry is not an object'); continue
        for f in FIELDS:
            if f not in e:
                err(key, 'missing field "%s"' % f)
        for f in e:
            if f not in FIELDS:
                err(key, 'unknown field "%s"' % f)
        if e.get('kind') not in KINDS:
            err(key, 'kind must be one of %s' % (KINDS,))
        if e.get('level') not in (1, 2, 3):
            err(key, 'level must be 1, 2 or 3')
        if not isinstance(e.get('item'), str) or not NAME_RE.match(e.get('item', '')):
            err(key, 'invalid item name')
        if not isinstance(e.get('family'), str) or not isinstance(e.get('note'), str):
            err(key, '"family" and "note" must be strings')
        for f in ('full', 'copy'):
            lst = e.get(f)
            if not isinstance(lst, list) or not lst:
                err(key, '"%s" must be a non-empty list' % f); continue
            seen = set()
            for ing in lst:
                if not (isinstance(ing, list) and len(ing) == 2 and isinstance(ing[0], str)
                        and isinstance(ing[1], int) and not isinstance(ing[1], bool)):
                    err(key, '%s: ingredient must be ["name", quantity]: %r' % (f, ing)); continue
                n, q = ing
                if not NAME_RE.match(n):
                    err(key, '%s: invalid ingredient name %r' % (f, n))
                if q <= 0:
                    err(key, '%s: quantity must be > 0: %r' % (f, ing))
                if n in seen:
                    err(key, '%s: duplicate ingredient %r' % (f, n))
                seen.add(n)
    if errors:
        sys.exit('recipes_table.json is invalid:\n  ' + '\n  '.join(errors))

def func_names(keys):
    names, used = {}, set()
    for key in keys:
        base = 'CA_TableRecipe_' + re.sub(r'\W+', '_', key.replace('Recipe for ', '')).strip('_')
        name, i = base, 2
        while name in used:
            name, i = '%s_%d' % (base, i), i + 1
        used.add(name)
        names[key] = name
    return names

def ingredients(lst, indent):
    return ["%sCA_AddTableIngredient(ingredients, '%s', %d);" % (indent, n, q) for n, q in lst]

def generate(table):
    keys = sorted(table, key=lambda k: (KINDS.index(table[k]['kind']), natural(table[k]['family']),
                                         table[k]['level'], k))
    fn = func_names(keys)
    L = [
        '/***********************************************************************/',
        '/** \tConsumable Alchemy - recipe table',
        '/***********************************************************************/',
        '',
        '// GENERATED FILE - DO NOT EDIT BY HAND.',
        '// Source: tools/recipes/recipes_table.json, generator: tools/recipes/generate.py.',
        '',
        '// Full (first brew) or copy recipe from the table. False if the recipe is not in the table.',
        'function CA_GetTableIngredients(recipeName : name, isCopy : bool, out ingredients : array<SItemParts>) : bool',
        '{',
        '\tingredients.Clear();',
        '',
    ]
    for k in KINDS:
        L.append('\tif(CA_GetTableIngredients_%s(recipeName, isCopy, ingredients))' % k.capitalize())
        L.append('\t\treturn true;')
        L.append('')
    L += [
        '\treturn false;',
        '}',
        '',
        'function CA_AddTableIngredient(out ingredients : array<SItemParts>, itemName : name, quantity : int)',
        '{',
        '\tvar ing : SItemParts;',
        '',
        '\ting.itemName = itemName;',
        '\ting.quantity = quantity;',
        '\tingredients.PushBack(ing);',
        '}',
        '',
    ]
    for k in KINDS:
        L += [
            'function CA_GetTableIngredients_%s(recipeName : name, isCopy : bool, out ingredients : array<SItemParts>) : bool' % k.capitalize(),
            '{',
            '\tswitch(recipeName)',
            '\t{',
        ]
        for key in keys:
            if table[key]['kind'] != k:
                continue
            L.append("\t\tcase '%s':" % key)
            L.append('\t\t\t%s(isCopy, ingredients);' % fn[key])
            L.append('\t\t\treturn true;')
        L += ['\t}', '', '\treturn false;', '}', '']
    for key in keys:
        e = table[key]
        L += [
            '// %s' % e['item'],
            'function %s(isCopy : bool, out ingredients : array<SItemParts>)' % fn[key],
            '{',
            '\tif(isCopy)',
            '\t{',
        ]
        L += ingredients(e['copy'], '\t\t')
        L += ['\t}', '\telse', '\t{']
        L += ingredients(e['full'], '\t\t')
        L += ['\t}', '}', '']
    return '\n'.join(L)

if __name__ == '__main__':
    def no_duplicate_keys(pairs):
        keys = [k for k, _ in pairs]
        dup = sorted(set(k for k in keys if keys.count(k) > 1))
        if dup:
            sys.exit('recipes_table.json is invalid: duplicate key(s) %s' % dup)
        return dict(pairs)
    with open(TABLE, encoding='utf-8') as f:
        table = json.load(f, object_pairs_hook=no_duplicate_keys)
    validate(table)
    text = generate(table)
    out = os.path.normpath(OUT)
    with open(out, 'w', encoding='utf-8', newline='\n') as f:
        f.write(text)
    counts = {k: sum(1 for e in table.values() if e['kind'] == k) for k in KINDS}
    print('%s: %d recipes %s, %d bytes' % (out, len(table), counts, len(text.encode('utf-8'))))
