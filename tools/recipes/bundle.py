import struct, sys, os, zlib

def entries(path):
    with open(path, 'rb') as f:
        hdr = f.read(32)
        assert hdr[:8] == b'POTATO70', hdr[:8]
        bsize, dsize, toc = struct.unpack_from('<III', hdr, 8)
        f.seek(32)
        data = f.read(toc)
    out = []
    for o in range(0, toc, 0x130):
        e = data[o:o+0x130]
        if len(e) < 0x130:
            break
        name = e[:0x100].split(b'\0')[0].decode('latin1')
        off, _z, size, zsize = struct.unpack_from('<IIII', e, 0x110)
        comp = struct.unpack_from('<I', e, 0x124)[0]
        out.append((name, size, zsize, off, comp))
    return out

def read(path, ent):
    name, size, zsize, off, comp = ent
    with open(path, 'rb') as f:
        f.seek(off)
        raw = f.read(zsize)
    if comp == 0:
        return raw
    if comp == 1:
        return zlib.decompress(raw)
    if comp in (4, 5):
        import lz4.block
        return lz4.block.decompress(raw, uncompressed_size=size)
    if comp == 2:
        import snappy
        return snappy.decompress(raw)
    raise Exception('compression %d' % comp)

if __name__ == '__main__':
    cmd, path = sys.argv[1], sys.argv[2]
    ents = entries(path)
    if cmd == 'list':
        pat = sys.argv[3] if len(sys.argv) > 3 else ''
        for e in ents:
            if pat in e[0]:
                print(e)
    elif cmd == 'extract':
        pat, outdir = sys.argv[3], sys.argv[4]
        for e in ents:
            if pat in e[0]:
                d = read(path, e)
                p = os.path.join(outdir, e[0].replace('\\', os.sep))
                os.makedirs(os.path.dirname(p), exist_ok=True)
                open(p, 'wb').write(d)
                print('ok', e[0], len(d))

