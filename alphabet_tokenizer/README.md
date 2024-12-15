## Create an alphabet tokenizer with predefined tokens by using [sentencepiece](https://github.com/google/sentencepiece)


### Train the tokenizer
```bash
#python alpha.py
bash spm_train_alphabet.sh
```

### Example

```python
from sentencepiece import SentencePieceProcessor
sp_model = SentencePieceProcessor(model_file="alphabet.model")

sp_model.encode_as_pieces("What is life?")
# ['W', 'h', 'a', 't', '▁', 'i', 's', '▁', 'l', 'i', 'f', 'e', '?']

sp_model.encode_as_pieces("<|vision0|><|vision1|>what is?")
# ['<|vision0|>', '<|vision1|>', 'w', 'h', 'a', 't', '▁', 'i', 's', '?']

sp_model.encode_as_pieces("What's 3.14?")
# ['W', 'h', 'a', 't', "'", 's', '▁', '3', '.', '1', '4', '?']

```
