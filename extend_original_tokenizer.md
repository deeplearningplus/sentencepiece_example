## Extending `llama2.c/tokenizer.model` to support cfDNA end-motifs.


**1. Export the Current Vocabulary**
```bash
spm_export_vocab --model /opt/github/llama2.c/tokenizer.model --output=original_vocab.txt
```

**2. Generate Synthetic Training Data**
```python
import random

# Load the original vocabulary
with open("original_vocab.txt", "r") as vocab_file:
    vocab = [line.strip() for line in vocab_file]

# Generate synthetic data
with open("synthetic_data.txt", "w") as synthetic_file:
    for i in range(0, len(vocab), 20):
        sentence = " ".join(vocab[i: i + 20])
        synthetic_file.write(sentence + "\n")
    for _ in range(100000):  # Adjust the size of synthetic data
        sentence = " ".join(random.choices(vocab, k=random.randint(5, 15)))
        synthetic_file.write(sentence + "\n")
```

**3. Add New Tokens**
Create a predefined 4-kmer cfDNA end-motifs (n = 256) - `predefined_cfDNA_end_motifs.txt`.
Also add `<pad>` token given that `llama2.c/tokenizer.model` disable `<pad>` (it is set to -1).
```bash
<pad>
<AAAA>
<AAAC>
...
<TTTT>
```

**4. Retrain the Tokenizer**
```bash
# vocab_size=<original_vocab_size + number_of_new_tokens>
vocab_size = 32257 # 32000 (original token) + 256 (4-kmer) + 1 (<pad>)
spm_train \
--input=synthetic_data.txt \
--model_prefix=extended_tokenizer \
--input_format="text" --model_type=bpe --allow_whitespace_only_pieces=true --split_digits=true \
--unk_surface=" \342\201\207 " --normalization_rule_name=identity --byte_fallback=false \
--vocab_size=$vocab_size \
--character_coverage=1.0 \
--split_by_whitespace=true \
--user_defined_symbols=$(cat predefined_cfDNA_end_motifs.txt | tr '\n' ',')
```

**5. Verify the New Tokenizer**
```bash
spm_export_vocab --model=extended_tokenizer.model --output=extended_vocab.txt
```

## Caveats
- Retraining without original data may slightly alter the tokenization behavior for existing tokens.

- Test the extended tokenizer to ensure it behaves as expected.
