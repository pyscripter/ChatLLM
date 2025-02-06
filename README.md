# ChatLLM

ChatLLM is a simple Delphi application for chatting with Large Language Models (LLMs).  Its primary purpose is to act as a coding assistant.

## Features
- Supports both cloud based LLM models ([DeepSeek](https://www.deepseek.com/), [ChatGPT](https://openai.com/chatgpt) and [Gemini](https://gemini.google.com/)) and local models using [Ollama](https://github.com/ollama/ollama).
- Supports reasoning models such as OpenAI's *o1-mini* and DeeepSeeks *deepseek-reasoner*.
- Supports both the legacy [completions](https://platform.openai.com/docs/api-reference/completions) and the [chat/completions] (https://platform.openai.com/docs/api-reference/chat) API endpoints.
- The chat is organized around multiple topics.
- Persistent chat history and settings.
- Streamlined user interface.
- Syntax highlighting of code (300 languages supported thanks to [Prism](https://prismjs.com/)).
- Support for Markdown output.

The application uses standard HTTP client and JSON components from the Delphi RTL and can be easily integrated in other Delphi applications.

## Usage

### Chat with cloud-based LLM providers
You need to get an API key if you don't have one:
- Deepseek: from https://platform.deepseek.com/api_keys
- Gemini: from https://aistudio.google.com/app/apikey
- OpenAI: from https://platform.openai.com/api-keys

You also need to top-up your balance.  Gemini is free for light usage and Deepseek is very
competitively priced.

**Settings**:

- Endpoint:  The base URL for accessing the cloud API
- Model: The model you want to use.  Example values:
    - Deepseek: deepseek-chat deepseek-reasoner
    - OpenAI: gpt4-o, gpt-4o-mini, o1-mini
    - Gemini: gemini-1.5-flash, gemini-1.5-pro
- API key: Required
- Temperature: A decimal value between 0 and 2 that controls the randomness of the answers
  (the greater the temperature the greater the randomness).  Default value: 1.0.
- Timeout:  How long you are prepared to wait for an answer.
- Maximum number of response tokens: An integer value that determines the maximum length of the response.
- System prompt: A string providing context to the LLM, e.g. "You are my python coding assistant".

Suitable defaults are provided for all parameters except the API key which you need to provide.

### Chat with local models

You first need to download the [ollama installer](https://ollama.com/download/OllamaSetup.exe) 
and install it.  Ollama provides access to a large and rapidly expanding number of 
[LLM models](https://ollama.com/library?sort=popular) such as codegemma from Google and 
codelllama from Meta.  To use a given model you need to install it locally.  You do that from a 
command prompt by issuing the command:
```
ollama pull model_name
```
After that you are ready to use the local model in ChatLLM.  The settings are similar to those
for cloud-based models, except that there is no need for an API key. The downside of Ollama is 
that it may take a long time to get answers, depending on the question, the size of the model
 and the power of your CPU and GPU.  A fast GPU with a lot of memory, can make Ollama much more
 responsive.

### Chat topics

The chat is organized around topics.   You can create new topics and back and forth between the 
topics using the next/previous buttons on the toolbar.   When you save the chat all topics are 
soved and then restored when you next start the application.  _Questions within a topic are 
asked in the context of the previous questions and answers of that topic_.

## Screenshots
![image](https://github.com/pyscripter/ChatLLM/assets/1311616/98eac838-1670-4dda-8b7b-ee21f3cd8b5d)

## Compilation requirements

- Delphi 12 (Restriction due to the use of multi-line strings)
- [SpTBXLib](https://github.com/SilverpointDev/sptbxlib)
- [SVGIconImageList](https://github.com/EtheaDev/SVGIconImageList)
- [SynEdit](https://github.com/pyscripter/SynEdit)
- [Markdown Processor](https://github.com/EtheaDev/MarkdownProcessor)
