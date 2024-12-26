# ChatLLM

ChatLLM is a simple Delphi application for chatting with Large Language Models (LLMs).  Its primary purpose is to act as a coding assistant.

## Features
- Supports both cloud based LLM models ([ChatGPT](https://openai.com/chatgpt) and [Gemini](https://gemini.google.com/)) and local models using [Ollama](https://github.com/ollama/ollama).
- Supports both the legacy [completions](https://platform.openai.com/docs/api-reference/completions) and the [chat/completions] (https://platform.openai.com/docs/api-reference/chat) API endpoints.
- The chat is organized around multiple topics.
- Can save and restore the chat history and settings.
- Streamlined user interface.
- Syntax highlighting of code (python and pascal).
- Markdown output rendering.
- High-DPI awareness.

The application uses standard HTTP client and JSON components from the Delphi RTL and can be easily integrated in other Delphi applications.

## Usage

### Chat with OpenAI cloud based models such as gpt-4
The screenshot below shows the settings for using gpt3.5-turbo which offers a good balance between cost and performance.

![image](https://github.com/pyscripter/ChatLLM/assets/1311616/ea5f3849-6ace-4186-a094-252e6cc181a5)

**Settings**:
- Endpoint:  The base URL for accessing the openai API
- Model: The OpenAI model you want to use.
- API key: You need to get one from https://platform.openai.com/api-keys to use the OpenAI models
- Timeout:  How long you are prepared to wait for an answer.
- Maximum number of response tokens: An integer value that determines the maximum length of the response.
- System prompt: A string providing context to the LLM, e.g. "You are my python coding assistant".

### Chat with Gemini cloud based models such as gemini-1.5-flash

**Settings**:
- Endpoint:  The base URL for accessing the openai API
- Model: The Gemini model you want to use.
- API key: You need to get one from https://aistudio.google.com/app/apikey to use the Gemini models
- Timeout:  How long you are prepared to wait for an answer.
- Maximum number of response tokens: An integer value that determines the maximum length of the response.
- System prompt: A string providing context to the LLM, e.g. "You are my python coding assistant".

### Chat with local models

You first need to download the [ollama installer](https://ollama.com/download/OllamaSetup.exe) and install it.  Ollama provides access to a large number of [LLM models](https://ollama.com/library?sort=popular) such as codegemma from Google and codelllama from Meta.  To use a given model you need to install it locally.  You do that from a command prompt by issuing the command:
```
ollama pull model_name
```
After that you are ready to use the local model in ChatLLM.

The screenshot below shows the settings for using codellama. 

![image](https://github.com/pyscripter/ChatLLM/assets/1311616/7cd3d4ec-7c52-42be-a2fb-e5c3a083abf9)

You do not need an API key to use Ollama models and usage is free.  The downside is that it may take a long time to get answers, depending on the question, the size of the model and the power of your CPU and GPU.

### Chat topics

The chat is organized around topics.   You can create new topics and back and forth between the topics using the next/previous buttons on the toolbar.   When you save the chat all topics are soved and then restored when you next start the application.  _Questions within a topic are asked in the context of the previous questions and answers of that topic_.

## Screenshot
![image](https://github.com/pyscripter/ChatLLM/assets/1311616/98eac838-1670-4dda-8b7b-ee21f3cd8b5d)

## Compilation requirements

- [SpTBXLib](https://github.com/SilverpointDev/sptbxlib)
- [SVGIconImageList](https://github.com/EtheaDev/SVGIconImageList)
- [SynEdit](https://github.com/pyscripter/SynEdit)

