from transformers import T5ForConditionalGeneration, MT5Model, AutoTokenizer

#model = T5ForConditionalGeneration.from_pretrained('google/byt5-xxl')
#tokenizer = AutoTokenizer.from_pretrained('google/byt5-xxl')


model = MT5Model.from_pretrained('google/mt5-base')
tokenizer = AutoTokenizer.from_pretrained('google/mt5-base')