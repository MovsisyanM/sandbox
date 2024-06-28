

---

### Fixed-size chunking
Choose a character/word limit (e.g. max 60 words per chunk). Can have overlapping characters witha limit

### Recursive chunking/separator chunking
Choose a separator as a chunk cutoff. Can have a fixed-size chunk limit.

### Semantic chunking
Embed the document and implement cutoof based on embedding distance.

### Agentic chunking
Use an LLM to extract propositions, combine those propositions to form a chunk.

### Mixed-method chunking
Use multiple methods of chunking simultaneously

### Sentence window retrieval
Find the most relevant sentence, take a few sentences before and after it for context.

### Small2big
Search using small chunks for accuracy, refer small chunks to larger chunks for more context. Can be repeatedly layered.