
# Get alpha.txt
# python alpha.txt


# set --add_dummy_prefix=false to disable 
#+the tokenizer automaically adds leading space at the start of text.


# How to set vocab_size?
# 1. number of tokens in prefined_tokens.txt is 102 (n1)
# 2. number of lines in alpha.txt is 95 (n2)
# 3. number of special tokens 4 (k, i.e., unk_id, bos_id, eos_id, pad_id)
# vocab_size = n1 + n2 + k = 102 + 95 + 4 = 201

# By default, spm_train disable pad_id (set to -1).
# By default, unk_id=0, bos_id=1, eos_id=2

spm_train \
--input=alpha.txt \
--add_dummy_prefix=false \
--model_prefix=alphabet \
--unk_id 0 --bos_id 1 --eos_id 2 --pad_id 3 \
--input_format="text" --model_type=bpe --allow_whitespace_only_pieces=true --split_digits=true \
--unk_surface=" \342\201\207 " --normalization_rule_name=identity --byte_fallback=false \
--vocab_size=201 \
--character_coverage=1.0 \
--split_by_whitespace=true \
--user_defined_symbols=$(cat prefined_tokens.txt | tr '\n' ',')


