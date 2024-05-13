import sys
nsize = sys.argv[1]
chrom_file = sys.argv[2]

with open(chrom_file, 'r') as fin:
  for line in fin:
    arry = line.strip().split('\t')
    chrom = arry[0]
    length = int(arry[2])
    window_num = length//nsize
    for i in range(window_num):
      s = 1 + nsize * i
      e = s + nsize - 1
      print('{}\t{}\t{}'.format(chrom, s, e), file=fout, flush=False)
    print('{}\t{}\t{}'.format(chrom, e+1, length), file=fout, flush=False) # the last window for each chromosome
