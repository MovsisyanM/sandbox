# Alignment
###### by Mher Movsisyan

---


Understanding complex data, like tables, can be tricky for RAG. One way to improve the indexing is by using counterfactual training, where we create hypothetical (what-if) questions. This increases the alignment and reduces the disparity between documents.

### Key Concepts in RAG Alignment
1. **Indexing**: The process of organizing and storing data to facilitate efficient retrieval. Good indexing is crucial for RAG models as it determines the quality of the retrieved documents.

2. **Counterfactual** Training: This involves creating hypothetical scenarios (what-if questions) to train the model. It helps in:  
- Increasing the model's understanding of the data.  
- Reducing the disparity between documents by forcing the model to consider different possibilities and edge cases.  

3. Alignment Techniques:  
- **Document Relevance**: Ensuring retrieved documents are highly relevant to the query.  
- **Consistency**: The generated response should be consistent with the information in the retrieved documents.  
- **Diversity**: Training the model on diverse questions and scenarios to improve its robustness.


### Example

```{python}
!pip install transformers

from transformers import RagTokenizer, RagRetriever, RagSequenceForGeneration

# Initialize the tokenizer, retriever, and model
tokenizer = RagTokenizer.from_pretrained("facebook/rag-sequence-nq")
retriever = RagRetriever.from_pretrained("facebook/rag-sequence-nq", index_name="exact", passages_path=None)
model = RagSequenceForGeneration.from_pretrained("facebook/rag-sequence-nq", retriever=retriever)

# Original question and context
original_question = "What is the capital of France?"
context = "Paris is the capital of France."

# Counterfactual examples
counterfactual_questions = [
    "What is the capital of Germany?",
    "What is the capital of Spain?",
    "What is the capital of Italy?"
]

# Expected contexts
counterfactual_contexts = [
    "Berlin is the capital of Germany.",
    "Madrid is the capital of Spain.",
    "Rome is the capital of Italy."
]

from transformers import TrainingArguments, Trainer
from torch.utils.data import Dataset

class CounterfactualDataset(Dataset):
    def __init__(self, questions, contexts, tokenizer):
        self.questions = questions
        self.contexts = contexts
        self.tokenizer = tokenizer

    def __len__(self):
        return len(self.questions)

    def __getitem__(self, idx):
        question = self.questions[idx]
        context = self.contexts[idx]
        inputs = self.tokenizer(question, return_tensors="pt")
        labels = self.tokenizer(context, return_tensors="pt")["input_ids"]
        inputs["labels"] = labels
        return inputs

# Create the dataset
dataset = CounterfactualDataset(counterfactual_questions, counterfactual_contexts, tokenizer)

# Define training arguments
training_args = TrainingArguments(
    output_dir="./results",
    evaluation_strategy="steps",
    num_train_epochs=1,
    save_steps=10,
    per_device_train_batch_size=2,
    per_device_eval_batch_size=2,
    warmup_steps=10,
    weight_decay=0.01,
    logging_dir='./logs',
)

# Initialize the Trainer
trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=dataset,
)

# Fine-tune the model
trainer.train()
```
