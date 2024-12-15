import string

# 获取 26 个小写字母
lowercase_letters = string.ascii_lowercase
# 获取 26 个大写字母
uppercase_letters = string.ascii_uppercase
# 获取阿拉伯数字 0-9
digits = string.digits
# 获取一些常见的表达符号
symbols = string.punctuation

# 组合在一起
all_characters = lowercase_letters + uppercase_letters + digits + symbols


fout = open('alpha.txt', 'w')
a = sorted(set(list(all_characters)))
for e in a:
  print(e, file=fout)
# To make spm_train to correctly tokenize empty space ' '.
print('a b', file=fout)
fout.close()
