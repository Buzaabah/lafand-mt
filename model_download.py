from transformers import T5ForConditionalGeneration, AutoTokenizer

model = T5ForConditionalGeneration.from_pretrained('google/byt5-xxl')
tokenizer = AutoTokenizer.from_pretrained('google/byt5-xxl')