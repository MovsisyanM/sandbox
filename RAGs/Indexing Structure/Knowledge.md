# Indexing structure
###### by Mher Movsisyan

---

Indexing in Retrieval-Augmented Generation (RAG) involves organizing and storing the document embeddings in a structure that allows for efficient retrieval during the query phase. This is typically done using specialized data structures and libraries designed for fast similarity search, such as FAISS (Facebook AI Similarity Search).

### Indexing Structure in RAG

1. **Document Embedding**: Convert each document (and optionally its metadata) into a fixed-size vector using a pre-trained embedding model.  
2. **Index Creation**: Use a similarity search library to create an index from these vectors, allowing for fast retrieval of documents that are similar to a given query vector.  
3. **Index Optimization**: Enhance the index with various optimizations, such as clustering or partitioning, to speed up retrieval.  
4. **Metadata Storage**: Store metadata separately or within the index to aid in filtering and reranking retrieved documents based on metadata.  


Below is an example demonstrating the indexing structure using FAISS and embeddings from a simple transformer model like BERT:

```{python}
import numpy as np
import faiss
from transformers import BertModel, BertTokenizer

# Example documents
documents = [
    {"text": "Document 1 text about AI.", "metadata": {"title": "AI Overview", "author": "Author A"}},
    {"text": "Document 2 text about machine learning.", "metadata": {"title": "ML Basics", "author": "Author B"}},
    {"text": "Document 3 text about deep learning.", "metadata": {"title": "Deep Learning Insights", "author": "Author C"}}
]

# Initialize BERT model and tokenizer
tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
model = BertModel.from_pretrained('bert-base-uncased')

# Function to get document embeddings
def get_embeddings(documents):
    embeddings = []
    for doc in documents:
        inputs = tokenizer(doc['text'], return_tensors='pt', truncation=True, padding=True, max_length=512)
        outputs = model(**inputs)
        embedding = outputs.last_hidden_state.mean(dim=1).detach().numpy()
        embeddings.append(embedding)
    return np.vstack(embeddings)

# Create embeddings for the documents
document_embeddings = get_embeddings(documents)

# Create a FAISS index
index = faiss.IndexFlatL2(document_embeddings.shape[1])  # Using L2 distance for similarity
index.add(document_embeddings)

# Example query
query_text = "Information about AI and machine learning"
inputs = tokenizer(query_text, return_tensors='pt', truncation=True, padding=True, max_length=512)
outputs = model(**inputs)
query_embedding = outputs.last_hidden_state.mean(dim=1).detach().numpy()

# Retrieve top 2 documents
D, I = index.search(query_embedding, 2)
retrieved_docs = [documents[i] for i in I[0]]

# Print retrieved documents
for doc in retrieved_docs:
    print(f"Retrieved Document: {doc['text']} with metadata {doc['metadata']}")

```

### Explanation:  
1. **Document Preparation**: Documents and their metadata are defined in a list of dictionaries.  
2. **Embedding Model Initialization**: BERT tokenizer and model are initialized to convert text into embeddings.  
3. **Get Embeddings**: A function is defined to generate embeddings for each document using BERT. The embeddings are the mean of the token embeddings from the last hidden state.  
4. **Index Creation**: A FAISS index is created using the document embeddings. Here, IndexFlatL2 is used, which is a simple, flat index based on L2 (Euclidean) distance.  
5. **Query Processing**: A query is processed similarly to documents to get its embedding.  
6. **Document Retrieval**: The query embedding is used to search the FAISS index for the top 2 similar documents. The indices of the retrieved documents are used to fetch the actual documents and their metadata.  


### Enhancements for Real-World Scenarios:  
- **Advanced Indexing Techniques**: Use more advanced FAISS index types like IndexIVFFlat for larger datasets.  
- **Metadata Integration**: Store metadata in a way that allows filtering and reranking based on metadata attributes.  
- **Embedding Model Fine-tuning**: Fine-tune the embedding model on a domain-specific dataset to improve retrieval relevance.  
- **Hybrid Models**: Combine sparse (e.g., TF-IDF) and dense (e.g., BERT) retrieval methods for better performance.  

This structure provides a foundation for building a robust RAG system that can efficiently retrieve and utilize relevant documents for augmented generation tasks.