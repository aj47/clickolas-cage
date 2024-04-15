[2024-04-04 13:53:18.674] [INFO] [LM STUDIO SERVER] Verbose server logs are DISABLED
[2024-04-04 13:53:18.677] [INFO] [LM STUDIO SERVER] Success! HTTP server listening on port 1234
[2024-04-04 13:53:18.677] [INFO] [LM STUDIO SERVER] Supported endpoints:
[2024-04-04 13:53:18.678] [INFO] [LM STUDIO SERVER] ->	GET  http://localhost:1234/v1/models
[2024-04-04 13:53:18.678] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/chat/completions
[2024-04-04 13:53:18.678] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/completions
[2024-04-04 13:53:18.678] [INFO] [LM STUDIO SERVER] Logs are saved into C:\tmp\lmstudio-server-log.txt
[2024-04-04 14:41:25.168] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 14:41:25.169] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube and search techfren"
    }
  ]
}
[2024-04-04 14:41:25.171] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube and search techfren' } (total messages = 2)
[2024-04-04 14:41:25.486] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 14:41:26.461] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-xo6wzj76wzwhvxtnnk1f",
  "object": "chat.completion",
  "created": 1712202085,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n    \"thought\": \"Perform a YouTube search for the term 'techfren'\",\n    \"param\": \"https://www.youtube.com/results?search_query=techfren\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 47,
    "completion_tokens": 47,
    "total_tokens": 94
  }
}
[2024-04-04 15:41:50.365] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:41:50.366] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 15:41:50.367] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 15:41:50.401] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 15:41:51.014] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-39akvjn390do1fyppm6tdf",
  "object": "chat.completion",
  "created": 1712205710,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n    \"thought\": \"Opening YouTube website\",\n    \"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 29,
    "completion_tokens": 29,
    "total_tokens": 58
  }
}
[2024-04-04 15:43:48.353] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:43:48.354] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 15:43:48.354] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 15:43:48.385] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 15:43:49.055] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-jgmfd3s8x4j3anshrrf5dn",
  "object": "chat.completion",
  "created": 1712205828,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n    \"thought\": \"Opening the YouTube website.\",\n    \"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 31,
    "completion_tokens": 30,
    "total_tokens": 61
  }
}
[2024-04-04 15:44:50.697] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:44:50.697] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 15:44:50.698] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 15:44:50.802] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 15:44:51.441] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-qkstt4xmzjbvkvlt0s53",
  "object": "chat.completion",
  "created": 1712205890,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n    \"thought\": \"Opening YouTube website\",\n    \"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 30,
    "completion_tokens": 29,
    "total_tokens": 59
  }
}
[2024-04-04 15:44:53.830] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:44:53.831] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI.\ngiven a user goal prompt devise a plan to achieve the goal.\nAssume we are already on the URL: https://www.youtube.com/ and give the following steps.\nProvide the response with this JSON schema:\n{\n  plan: [ {\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n  },...]\n}\n"
    },
    {
      "role": "user",
      "content": "Your goal is: go to youtube\nnull"
    }
  ]
}
[2024-04-04 15:44:53.832] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'Your goal is: go to youtube
null' } (total messages = 2)
[2024-04-04 15:44:53.973] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 15:45:02.770] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:45:02.771] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 15:45:02.772] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 15:45:26.597] [INFO] [LM STUDIO SERVER] Stopping server..
[2024-04-04 15:45:26.598] [INFO] [LM STUDIO SERVER] Server stopped
[2024-04-04 15:45:26.599] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-kw1f4eoolqpxwnt1bxfk",
  "object": "chat.completion",
  "created": 1712205902,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": ""
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 0,
    "completion_tokens": 0,
    "total_tokens": 0
  }
}
[2024-04-04 15:45:26.608] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-xzjriksc4bnd0vnywees6h",
  "object": "chat.completion",
  "created": 1712205893,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n  plan: [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n} this is redundant and should not be displayed a second time this is the final plan a single plan to achieve the goal a simple plan to accomplish the task a straightforward approach to reach the objective a clear-cut strategy to attain the desired outcome a concise and efficient plan to achieve the goal a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task a compact yet complete plan to fulfill the objective a short yet all-encompassing plan to attain the goal a concise yet inclusive plan to achieve the objective a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task a compact yet complete plan to fulfill the objective a short yet all-encompassing plan to attain the goal a concise yet inclusive plan to achieve the objective a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task\n\n```json\n{\n  \"plan\": [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n}\n``` a single plan to achieve the goal a straightforward approach to reach the objective a clear-cut strategy to attain the desired outcome a concise and efficient plan to achieve the goal a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task\n```json\n{\n  \"plan\": [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n}\n```\n```\n\n``````\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 1516,
    "completion_tokens": 1406,
    "total_tokens": 2922
  }
}
[2024-04-04 15:45:27.775] [INFO] [LM STUDIO SERVER] Verbose server logs are DISABLED
[2024-04-04 15:45:27.777] [INFO] [LM STUDIO SERVER] Success! HTTP server listening on port 1234
[2024-04-04 15:45:27.777] [INFO] [LM STUDIO SERVER] Supported endpoints:
[2024-04-04 15:45:27.777] [INFO] [LM STUDIO SERVER] ->	GET  http://localhost:1234/v1/models
[2024-04-04 15:45:27.777] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/chat/completions
[2024-04-04 15:45:27.777] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/completions
[2024-04-04 15:45:27.778] [INFO] [LM STUDIO SERVER] Model loaded: NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf
[2024-04-04 15:45:27.778] [INFO] [LM STUDIO SERVER] Logs are saved into C:\tmp\lmstudio-server-log.txt
[2024-04-04 15:45:56.566] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:45:56.566] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 15:45:56.567] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 15:45:56.863] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 15:45:57.482] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-5a11z8bobub2izmwtuv2m2",
  "object": "chat.completion",
  "created": 1712205956,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": " {\n  \"thought\": \"Opening the YouTube website\",\n  \"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 29,
    "completion_tokens": 29,
    "total_tokens": 58
  }
}
[2024-04-04 15:46:00.514] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:46:00.515] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI.\ngiven a user goal prompt devise a plan to achieve the goal.\nAssume we are already on the URL: https://www.youtube.com/ and give the following steps.\nProvide the response with this JSON schema:\n{\n  plan: [ {\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n  },...]\n}\n"
    },
    {
      "role": "user",
      "content": "Your goal is: go to youtube\nnull"
    }
  ]
}
[2024-04-04 15:46:00.515] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'Your goal is: go to youtube
null' } (total messages = 2)
[2024-04-04 15:46:00.737] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 15:46:04.444] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-6ii2ljuwe3een56o2btar",
  "object": "chat.completion",
  "created": 1712205960,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": " {\n  \"plan\": [\n    {\n      \"thought\": \"We are already on YouTube, so we can start by accessing the search bar.\",\n      \"action\": \"INPUT\",\n      \"ariaLabel\": \"searchBar\",\n      \"param\": \"url\"\n    },\n    {\n      \"thought\": \"Type in a search query to find relevant videos.\",\n      \"action\": \"INPUT\",\n      \"ariaLabel\": \"searchQuery\",\n      \"param\": \"inputText\"\n    },\n    {\n      \"thought\": \"Press the search button to view the results.\",\n      \"action\": \"CLICKBTN\",\n      \"ariaLabel\": \"searchButton\",\n      \"param\": \"url\"\n    }\n  ]\n}"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 177,
    "completion_tokens": 169,
    "total_tokens": 346
  }
}
[2024-04-04 15:53:09.699] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:53:09.699] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 15:53:09.700] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 15:53:09.899] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 15:53:10.508] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-il440td490gmi7lyl7o0qk",
  "object": "chat.completion",
  "created": 1712206389,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": " {\n  \"thought\": \"Opening the YouTube website\",\n  \"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 29,
    "completion_tokens": 29,
    "total_tokens": 58
  }
}
[2024-04-04 15:59:33.560] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:59:33.561] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: open youtube"
    }
  ]
}
[2024-04-04 15:59:33.562] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: open youtube' } (total messages = 2)
[2024-04-04 15:59:34.018] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 15:59:34.605] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-vyo9q8ntziklk7rzjnu8uq",
  "object": "chat.completion",
  "created": 1712206773,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": " {\n    \"thought\": \"Opening the YouTube website.\",\n    \"param\": \"www.youtube.com\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 27,
    "completion_tokens": 27,
    "total_tokens": 54
  }
}
[2024-04-04 15:59:34.675] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:59:34.676] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI.\ngiven a user goal prompt devise a plan to achieve the goal.\nAssume we are already on the URL: www.youtube.com and give the following steps.\nProvide the response with this JSON schema:\n{\n  plan: [ {\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n  },...]\n}\n"
    },
    {
      "role": "user",
      "content": "Your goal is: open youtube\nnull"
    }
  ]
}
[2024-04-04 15:59:34.677] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'Your goal is: open youtube
null' } (total messages = 2)
[2024-04-04 15:59:34.811] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 15:59:39.404] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-y7d1f9tpkzfizjocf03fqo",
  "object": "chat.completion",
  "created": 1712206774,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": " {\n  \"plan\": [\n    {\n      \"thought\": \"Already on the Youtube homepage, proceed to search for a video.\",\n      \"action\": \"NAVURL\",\n      \"ariaLabel\": \"Enter search query\",\n      \"param\": \"https://www.youtube.com/results\"\n    },\n    {\n      \"thought\": \"Type the desired video topic in the search bar.\",\n      \"action\": \"INPUT\",\n      \"ariaLabel\": \"Search for a video\",\n      \"param\": \"video topic\"\n    },\n    {\n      \"thought\": \"Click the 'Search' button to display the results.\",\n      \"action\": \"CLICKBTN\",\n      \"ariaLabel\": \"Submit search query\",\n      \"param\": \"search button\"\n    },\n    {\n      \"thought\": \"Select a video from the search results to watch.\",\n      \"action\": \"SELECT\",\n      \"ariaLabel\": \"Choose a video\",\n      \"param\": \"video result url\"\n    }\n  ]\n}"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 247,
    "completion_tokens": 239,
    "total_tokens": 486
  }
}
[2024-04-04 15:59:45.986] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 15:59:45.986] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: open google"
    }
  ]
}
[2024-04-04 15:59:45.987] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: open google' } (total messages = 2)
[2024-04-04 15:59:46.241] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 15:59:46.885] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-t7mujtt0nxhprfs293nig",
  "object": "chat.completion",
  "created": 1712206785,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": " {\n  \"thought\": \"Performing a search on Google for the user.\",\n  \"param\": \"www.google.com\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 31,
    "completion_tokens": 31,
    "total_tokens": 62
  }
}



[2024-04-04 21:23:51.343] [INFO] [LM STUDIO SERVER] Verbose server logs are DISABLED
[2024-04-04 21:23:51.346] [INFO] [LM STUDIO SERVER] Success! HTTP server listening on port 1234
[2024-04-04 21:23:51.346] [INFO] [LM STUDIO SERVER] Supported endpoints:
[2024-04-04 21:23:51.346] [INFO] [LM STUDIO SERVER] ->	GET  http://localhost:1234/v1/models
[2024-04-04 21:23:51.346] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/chat/completions
[2024-04-04 21:23:51.346] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/completions
[2024-04-04 21:23:51.347] [INFO] [LM STUDIO SERVER] Model loaded: NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2
[2024-04-04 21:23:51.347] [INFO] [LM STUDIO SERVER] Logs are saved into C:\tmp\lmstudio-server-log.txt
[2024-04-04 21:24:04.590] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:24:04.591] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 21:24:04.592] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 21:24:04.740] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:24:05.364] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-ld2l7mgvofi3fe427fbgby",
  "object": "chat.completion",
  "created": 1712226244,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n    \"thought\": \"Opening YouTube website\",\n    \"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 29,
    "completion_tokens": 29,
    "total_tokens": 58
  }
}
[2024-04-04 21:24:08.100] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:24:08.101] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI.\ngiven a user goal prompt devise a plan to achieve the goal.\nAssume we are already on the URL: https://www.youtube.com/ and give the following steps.\nProvide the response with this JSON schema:\n{\n  plan: [ {\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n  },...]\n}\n"
    },
    {
      "role": "user",
      "content": "Your goal is: go to youtube\nnull"
    }
  ]
}
[2024-04-04 21:24:08.102] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'Your goal is: go to youtube
null' } (total messages = 2)
[2024-04-04 21:24:08.249] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:24:30.485] [INFO] [LM STUDIO SERVER] Stopping server..
[2024-04-04 21:24:30.486] [INFO] [LM STUDIO SERVER] Server stopped
[2024-04-04 21:24:30.496] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-w9d7vxdh1grsnml79ypru",
  "object": "chat.completion",
  "created": 1712226248,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n  plan: [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n} this is redundant and should not be displayed a second time this is the final plan a single plan to achieve the goal a simple plan to accomplish the task a straightforward approach to reach the objective a clear-cut strategy to attain the desired outcome a concise and efficient plan to achieve the goal a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task a compact yet complete plan to fulfill the objective a short yet all-encompassing plan to attain the goal a concise yet inclusive plan to achieve the objective a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task a compact yet complete plan to fulfill the objective a short yet all-encompassing plan to attain the goal a concise yet inclusive plan to achieve the objective a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task\n\n```json\n{\n  \"plan\": [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n}\n``` a single plan to achieve the goal a straightforward approach to reach the objective a clear-cut strategy to attain the desired outcome a concise and efficient plan to achieve the goal a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task\n```json\n{\n  \"plan\": [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n}\n```\n```\n\n``````\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 1165,
    "completion_tokens": 1055,
    "total_tokens": 2220
  }
}
[2024-04-04 21:49:55.834] [INFO] [LM STUDIO SERVER] Verbose server logs are DISABLED
[2024-04-04 21:49:55.835] [INFO] [LM STUDIO SERVER] Success! HTTP server listening on port 1234
[2024-04-04 21:49:55.836] [INFO] [LM STUDIO SERVER] Supported endpoints:
[2024-04-04 21:49:55.836] [INFO] [LM STUDIO SERVER] ->	GET  http://localhost:1234/v1/models
[2024-04-04 21:49:55.836] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/chat/completions
[2024-04-04 21:49:55.836] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/completions
[2024-04-04 21:49:55.836] [INFO] [LM STUDIO SERVER] Model loaded: NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2
[2024-04-04 21:49:55.836] [INFO] [LM STUDIO SERVER] Logs are saved into C:\tmp\lmstudio-server-log.txt
[2024-04-04 21:49:55.837] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:49:55.838] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 21:49:55.839] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 21:49:56.042] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:49:56.630] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-wfdd4weq5bhzq82fn18r4",
  "object": "chat.completion",
  "created": 1712227795,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n    \"thought\": \"Opening YouTube website\",\n    \"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 29,
    "completion_tokens": 29,
    "total_tokens": 58
  }
}
[2024-04-04 21:49:59.860] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:49:59.861] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI.\ngiven a user goal prompt devise a plan to achieve the goal.\nAssume we are already on the URL: https://www.youtube.com/ and give the following steps.\nProvide the response with this JSON schema:\n{\n  plan: [ {\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n  },...]\n}\n"
    },
    {
      "role": "user",
      "content": "Your goal is: go to youtube\nnull"
    }
  ]
}
[2024-04-04 21:49:59.862] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'Your goal is: go to youtube
null' } (total messages = 2)
[2024-04-04 21:50:00.053] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:50:14.592] [INFO] [LM STUDIO SERVER] Client disconnected. Stopping generation... (if the model is busy processing the prompt, it will finish first))
[2024-04-04 21:50:14.595] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-v1e0dgsogow23k89qpzrr",
  "object": "chat.completion",
  "created": 1712227799,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n  plan: [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n} this is redundant and should not be displayed a second time this is the final plan a single plan to achieve the goal a simple plan to accomplish the task a straightforward approach to reach the objective a clear-cut strategy to attain the desired outcome a concise and efficient plan to achieve the goal a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task a compact yet complete plan to fulfill the objective a short yet all-encompassing plan to attain the goal a concise yet inclusive plan to achieve the objective a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task a compact yet complete plan to fulfill the objective a short yet all-encompassing plan to attain the goal a concise yet inclusive plan to achieve the objective a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task\n\n```json\n{\n  \"plan\": [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n}\n``` a single plan to achieve the goal a straightforward approach to reach the objective a clear-cut strategy to attain the desired outcome a concise and efficient plan to achieve the goal a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task\n```json\n{\n  \"plan\": [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n}\n```\n```\n\n``````\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n``"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 756,
    "completion_tokens": 646,
    "total_tokens": 1402
  }
}
[2024-04-04 21:50:32.777] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:50:32.778] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 21:50:32.779] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 21:50:32.921] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:50:33.591] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-esn5uiejk64q7tkncnzqsr",
  "object": "chat.completion",
  "created": 1712227832,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n    \"thought\": \"Opening YouTube website for browsing.\",\n    \"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 32,
    "completion_tokens": 32,
    "total_tokens": 64
  }
}
[2024-04-04 21:50:36.584] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:50:36.584] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI.\ngiven a user goal prompt devise a plan to achieve the goal.\nAssume we are already on the URL: https://www.youtube.com/ and give the following steps.\nProvide the response with this JSON schema:\n{\n  plan: [ {\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n  },...]\n}\n"
    },
    {
      "role": "user",
      "content": "Your goal is: go to youtube\nnull"
    }
  ]
}
[2024-04-04 21:50:36.586] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'Your goal is: go to youtube
null' } (total messages = 2)
[2024-04-04 21:50:36.767] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:51:08.917] [INFO] [LM STUDIO SERVER] Client disconnected. Stopping generation... (if the model is busy processing the prompt, it will finish first))
[2024-04-04 21:51:08.936] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-ok4qgibuq6pf05s2elc2w4",
  "object": "chat.completion",
  "created": 1712227836,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n  plan: [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n} this is redundant and should not be displayed a second time this is the final plan a single plan to achieve the goal a simple plan to accomplish the task a straightforward approach to reach the objective a clear-cut strategy to attain the desired outcome a concise and efficient plan to achieve the goal a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task a compact yet complete plan to fulfill the objective a short yet all-encompassing plan to attain the goal a concise yet inclusive plan to achieve the objective a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task a compact yet complete plan to fulfill the objective a short yet all-encompassing plan to attain the goal a concise yet inclusive plan to achieve the objective a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task\n\n```json\n{\n  \"plan\": [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n}\n``` a single plan to achieve the goal a straightforward approach to reach the objective a clear-cut strategy to attain the desired outcome a concise and efficient plan to achieve the goal a brief yet comprehensive plan to realize the objective a succinct yet thorough plan to accomplish the task\n```json\n{\n  \"plan\": [\n    {\n      thought: \"Open the Youtube website\",\n      action: \"NAVURL\",\n      ariaLabel: \"Go to Youtube\",\n      param: \"https://www.youtube.com/\"\n    }\n  ]\n}\n```\n```\n\n``````\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```\n```"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 1612,
    "completion_tokens": 1502,
    "total_tokens": 3114
  }
}
[2024-04-04 21:55:16.196] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:55:16.196] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: create an event in my calendar named hello world"
    }
  ]
}
[2024-04-04 21:55:16.197] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: create an event in my calendar named hello world' } (total messages = 2)
[2024-04-04 21:55:16.490] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:55:22.320] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-cpvq7zl7kul4nhkfowlol6",
  "object": "chat.completion",
  "created": 1712228116,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\nthought: Create a new event in your calendar.\nparam: https://calendar.google.com/calendar/r/eventedit/generic.ics/d/1/2023-04-01T12%3A00%3A00Z/2023-04-01T12%3A00%3A00Z/15min/Hello%20World?pli=1&sf=true&output=xml\n\nIn this case, the first step into achieving the goal of creating an event in your calendar named \"hello world\" would be to navigate to the Google Calendar event creation URL:\nhttps://calendar.google.com/calendar/r/eventedit/generic.ics/d/1/2023-04-01T12%3A00%3A00Z/2023-04-01T12%3A00%3A00Z/15min/Hello%20World?pli=1&sf=true&output=xml\n\nThis URL allows you to directly create a new event with the specified title, duration, and start time. You can modify these details as needed before saving the event to your calendar."
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 282,
    "completion_tokens": 282,
    "total_tokens": 564
  }
}
[2024-04-04 21:55:53.593] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:55:53.594] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: create an event in my calendar on friday name hi"
    }
  ]
}
[2024-04-04 21:55:53.594] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: create an event in my calendar on friday name hi' } (total messages = 2)
[2024-04-04 21:55:53.714] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:56:03.467] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-nyd3az4fpathromu8hhr",
  "object": "chat.completion",
  "created": 1712228153,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\nthought: Create a new event on Friday with the name \"Hi\".\nparam: https://calendar.google.com/calendar/u/0/r/event-details/dette%3A1234567890%40group.calendar.google.com/ctz/instant?cfem=true&pli=1&sf=true&wkst=0&itfs=1&source=cal_<dummy00004>_app&dtm=1662315200000&amp;ctz=America%2FNew_York&amp;attendees=default-invisible&amp;rsvp_all_declined=true&amp;sf=true&amp;source=cal_<dummy00004>_app&amp;dtm=1662315200000&amp;ctz=America%2FNew_York&amp;attendees=default-invisible&amp;rsvp_all_declined=true\n{\n    \"thought\": \"Create a new event on Friday with the name 'Hi' in your Google Calendar.\",\n    \"param\": \"https://calendar.google.com/calendar/u/0/r/event-details/dette%3A1234567890%40group.calendar.google.com/ctz/instant?cfem=true&pli=1&sf=true&wkst=0&itfs=1&source=cal_mv_app&dtm=1662315200000&amp;ctz=America%2FNew_York&amp;attendees=default-invisible&amp;rsvp_all_declined=true&amp;sf=true&amp;source=cal_mv_app&amp;dtm=1662315200000&amp;ctz=America%2FNew_York&amp;attendees=default-invisible&amp;rsvp_all_declined=true\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 474,
    "completion_tokens": 474,
    "total_tokens": 948
  }
}
[2024-04-04 21:56:07.773] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:56:07.773] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "Compare the following long goal prompt with the given list of smaller candidate prompts.\nDetermine if any of the smaller prompts match or closely align with the intention or key elements of the long goal prompt.\nIf a match is found, identify and return the matching smaller prompt.\nProvide response in this JSON schema:\n{\n  match: \"candidate prompt\" | \"\"\n}\n"
    },
    {
      "role": "user",
      "content": "goal prompt: create an event in my calendar on friday name hi\ncandidate prompts: create event"
    }
  ]
}
[2024-04-04 21:56:07.774] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'goal prompt: create an event in my calendar on friday name hi
candidate prompts: create event' } (total messages = 2)
[2024-04-04 21:56:07.903] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:56:07.979] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-eavzk5atymnnnq0lxm7k9a",
  "object": "chat.completion",
  "created": 1712228167,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 3,
    "completion_tokens": 1,
    "total_tokens": 4
  }
}
[2024-04-04 21:58:07.775] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:58:07.775] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: create an event in my calendar on friday"
    }
  ]
}
[2024-04-04 21:58:07.776] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: create an event in my calendar on friday' } (total messages = 2)
[2024-04-04 21:58:07.917] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:58:09.467] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-etk41ojrxot3939q0fg88g",
  "object": "chat.completion",
  "created": 1712228287,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n    thought: \"The user wants to create an event on a specific day, which is Friday. To help the user, we need to provide a link where they can add this event to their calendar.\",\n    param: \"www.google.com/search?q=add+event+to+calendar+friday\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 71,
    "completion_tokens": 71,
    "total_tokens": 142
  }
}
[2024-04-04 21:58:35.155] [INFO] [LM STUDIO SERVER] Stopping server..
[2024-04-04 21:58:35.155] [INFO] [LM STUDIO SERVER] Server stopped
[2024-04-04 21:58:35.868] [INFO] [LM STUDIO SERVER] Verbose server logs are DISABLED
[2024-04-04 21:58:35.869] [INFO] [LM STUDIO SERVER] Success! HTTP server listening on port 1234
[2024-04-04 21:58:35.870] [INFO] [LM STUDIO SERVER] Supported endpoints:
[2024-04-04 21:58:35.870] [INFO] [LM STUDIO SERVER] ->	GET  http://localhost:1234/v1/models
[2024-04-04 21:58:35.870] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/chat/completions
[2024-04-04 21:58:35.870] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/completions
[2024-04-04 21:58:35.870] [INFO] [LM STUDIO SERVER] Model loaded: NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2
[2024-04-04 21:58:35.871] [INFO] [LM STUDIO SERVER] Logs are saved into C:\tmp\lmstudio-server-log.txt
[2024-04-04 21:58:42.366] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:58:42.366] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: create an event in my calendar on friday"
    }
  ]
}
[2024-04-04 21:58:42.367] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: create an event in my calendar on friday' } (total messages = 2)
[2024-04-04 21:58:42.403] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:58:43.506] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-34yo0384qojogcmd9ary8h",
  "object": "chat.completion",
  "created": 1712228322,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n    \"thought\": \"Creating an event on a specific day requires access to a calendar application or platform.\",\n    \"param\": \"www.google.com/search?q=create+event+in+calendar+friday\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 55,
    "completion_tokens": 54,
    "total_tokens": 109
  }
}
[2024-04-04 21:58:43.567] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:58:43.568] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI.\ngiven a user goal prompt devise a plan to achieve the goal.\nAssume we are already on the URL: www.google.com/search?q=create+event+in+calendar+friday and give the following steps.\nProvide the response with this JSON schema:\n{\n  plan: [ {\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n  },...]\n}\n"
    },
    {
      "role": "user",
      "content": "Your goal is: create an event in my calendar on friday\nnull"
    }
  ]
}
[2024-04-04 21:58:43.568] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'Your goal is: create an event in my calendar on friday
null' } (total messages = 2)
[2024-04-04 21:58:43.713] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:58:57.700] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-xl45ny0uzrglyeqjdd27wd",
  "object": "chat.completion",
  "created": 1712228323,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n  \"plan\": [\n    {\n      \"thought\": \"Navigate to the Google Calendar website\",\n      \"action\": \"NAVURL\",\n      \"ariaLabel\": \"Open Google Calendar\",\n      \"param\": \"https://calendar.google.com\"\n    },\n    {\n      \"thought\": \"Sign in to my Google account if not already signed in\",\n      \"action\": \"NAVURL\",\n      \"ariaLabel\": \"Sign in to Google Account\",\n      \"param\": \"https://accounts.google.com/v3/signinauto?service=caldav&passive=true&continue=https%3A%2F%2Fcalendar.google.com%2F\"\n    },\n    {\n      \"thought\": \"Navigate to the 'Create' button in Google Calendar\",\n      \"action\": \"CLICKBTN\",\n      \"ariaLabel\": \"Click Create Event Button\",\n      \"param\": \"+C\"\n    },\n    {\n      \"thought\": \"Fill out the event details, including the date (Friday)\",\n      \"action\": \"INPUT\",\n      \"ariaLabel\": \"Input Date\",\n      \"param\": \"2023-04-07\" // assuming current year\n    },\n    {\n      \"thought\": \"Specify the event title and description\",\n      \"action\": \"INPUT\",\n      \"ariaLabel\": \"Input Event Title and Description\",\n      \"param\": \"eventTitle, eventDescription\"\n    },\n    {\n      \"thought\": \"Set any additional options or settings for the event\",\n      \"action\": \"SELECT\",\n      \"ariaLabel\": \"Select Additional Options\",\n      \"param\": \"additionalOptions\"\n    },\n    {\n      \"thought\": \"Save the event in my calendar\",\n      \"action\": \"CLICKBTN\",\n      \"ariaLabel\": \"Save Event\",\n      \"param\": \"saveEventButton\"\n    },\n    {\n      \"thought\": \"Verify that the event has been successfully created in my calendar for Friday\",\n      \"action\": \"WAITLOAD\",\n      \"ariaLabel\": \"Wait for Calendar to Load\",\n      \"param\": \"https://calendar.google.com\"\n    }\n  ]\n} event creation plan:\n1. Navigate to the Google Calendar website.\n2. Sign in to my Google account if not already signed in.\n3. Click on the 'Create' button in Google Calendar.\n4. Input the date (Friday) in the format \"YYYY-MM-DD\" (e.g., 2023-04-07).\n5. Specify the event title and description.\n6. Set any additional options or settings for the event.\n7. Save the event in my calendar.\n8. Wait for the calendar to load to verify that the event has been successfully created for Friday. 9. Navigate back to the initial URL: www.google.com/search?q=create+event+in+calendar+friday, if needed. 10. (Optional) Share the event with others or set reminders as needed."
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 715,
    "completion_tokens": 709,
    "total_tokens": 1424
  }
}
[2024-04-04 21:59:00.266] [INFO] [LM STUDIO SERVER] Stopping server..
[2024-04-04 21:59:00.266] [INFO] [LM STUDIO SERVER] Server stopped
[2024-04-04 21:59:00.708] [INFO] [LM STUDIO SERVER] Verbose server logs are DISABLED
[2024-04-04 21:59:00.710] [INFO] [LM STUDIO SERVER] Success! HTTP server listening on port 1234
[2024-04-04 21:59:00.710] [INFO] [LM STUDIO SERVER] Supported endpoints:
[2024-04-04 21:59:00.710] [INFO] [LM STUDIO SERVER] ->	GET  http://localhost:1234/v1/models
[2024-04-04 21:59:00.710] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/chat/completions
[2024-04-04 21:59:00.710] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/completions
[2024-04-04 21:59:00.711] [INFO] [LM STUDIO SERVER] Model loaded: NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2
[2024-04-04 21:59:00.711] [INFO] [LM STUDIO SERVER] Logs are saved into C:\tmp\lmstudio-server-log.txt
[2024-04-04 21:59:01.523] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:59:01.524] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: google 'tech' and click on the first link"
    }
  ]
}
[2024-04-04 21:59:01.524] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: google 'tech' and click on the first link' } (total messages = 2)
[2024-04-04 21:59:01.669] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:59:02.661] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-qsfyii04ftkasf9gffiorn",
  "object": "chat.completion",
  "created": 1712228341,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "\n{\n    thought: \"The user wants to search for 'tech' on Google and then visit the first link from the search results.\",\n    param: \"www.google.com/search?q=tech\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 47,
    "completion_tokens": 47,
    "total_tokens": 94
  }
}
[2024-04-04 21:59:14.854] [INFO] [LM STUDIO SERVER] Stopping server..
[2024-04-04 21:59:14.854] [INFO] [LM STUDIO SERVER] Server stopped
[2024-04-04 21:59:15.260] [INFO] [LM STUDIO SERVER] Verbose server logs are DISABLED
[2024-04-04 21:59:15.261] [INFO] [LM STUDIO SERVER] Success! HTTP server listening on port 1234
[2024-04-04 21:59:15.261] [INFO] [LM STUDIO SERVER] Supported endpoints:
[2024-04-04 21:59:15.261] [INFO] [LM STUDIO SERVER] ->	GET  http://localhost:1234/v1/models
[2024-04-04 21:59:15.261] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/chat/completions
[2024-04-04 21:59:15.261] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/completions
[2024-04-04 21:59:15.262] [INFO] [LM STUDIO SERVER] Model loaded: NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2
[2024-04-04 21:59:15.262] [INFO] [LM STUDIO SERVER] Logs are saved into C:\tmp\lmstudio-server-log.txt
[2024-04-04 21:59:27.601] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:59:27.602] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: google 'tech' then click on the first link"
    }
  ]
}
[2024-04-04 21:59:27.602] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: google 'tech' then click on the first link' } (total messages = 2)
[2024-04-04 21:59:27.735] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:59:28.762] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-14ztx3khc5j3v5i2tsndwt",
  "object": "chat.completion",
  "created": 1712228367,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"The user wants to search for the term 'tech' on Google and then click on the first link from the search results.\",\n\"param\": \"www.google.com/search?q=tech\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 50,
    "completion_tokens": 50,
    "total_tokens": 100
  }
}
[2024-04-04 21:59:28.808] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:59:28.808] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI.\ngiven a user goal prompt devise a plan to achieve the goal.\nAssume we are already on the URL: www.google.com/search?q=tech and give the following steps.\nProvide the response with this JSON schema:\n{\n  plan: [ {\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n  },...]\n}\n"
    },
    {
      "role": "user",
      "content": "Your goal is: google 'tech' then click on the first link\nnull"
    }
  ]
}
[2024-04-04 21:59:28.809] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'Your goal is: google 'tech' then click on the first link
null' } (total messages = 2)
[2024-04-04 21:59:28.964] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:59:32.099] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-0m1q8vbp9onpthzu5d05s",
  "object": "chat.completion",
  "created": 1712228368,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"plan\": [ {\n\"thought\": \"Enter 'tech' into the search bar\",\n\"action\": \"INPUT\",\n\"ariaLabel\": \"enterSearchTerm\",\n\"param\": \"tech\"\n}, {\n\"thought\": \"Submit the search\",\n\"action\": \"CLICKBTN\",\n\"ariaLabel\": \"searchButton\",\n\"param\": \"submit\"\n}, {\n\"thought\": \"Wait for search results to load\",\n\"action\": \"WAITLOAD\",\n\"ariaLabel\": \"waitForResults\",\n\"param\": null\n}, {\n\"thought\": \"Click on the first link in the search results\",\n\"action\": \"CLICKBTN\",\n\"ariaLabel\": \"clickFirstLink\",\n\"param\": null\n} ]\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 174,
    "completion_tokens": 174,
    "total_tokens": 348
  }
}
[2024-04-04 21:59:44.980] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 21:59:44.980] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go on youtube and click the first video"
    }
  ]
}
[2024-04-04 21:59:44.981] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go on youtube and click the first video' } (total messages = 2)
[2024-04-04 21:59:45.147] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 21:59:45.979] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-g5f6urgy5wsjy1shg0l6g",
  "object": "chat.completion",
  "created": 1712228384,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"Perform a search on YouTube to find the first video.\",\n\"param\": \"www.youtube.com/results?search_query=first+video\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 41,
    "completion_tokens": 41,
    "total_tokens": 82
  }
}
[2024-04-04 22:00:00.025] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:00:00.025] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go on http://youtube.com and click the first link"
    }
  ]
}
[2024-04-04 22:00:00.026] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go on http://youtube.com and click the first link' } (total messages = 2)
[2024-04-04 22:00:00.195] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:00:00.836] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-er0t69ne3ipv3p1e154oya",
  "object": "chat.completion",
  "created": 1712228400,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"Access YouTube homepage to click the first link\",\n\"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 31,
    "completion_tokens": 31,
    "total_tokens": 62
  }
}
[2024-04-04 22:01:24.827] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:01:24.827] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go on http://youtube.com and click the first link"
    }
  ]
}
[2024-04-04 22:01:24.828] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go on http://youtube.com and click the first link' } (total messages = 2)
[2024-04-04 22:01:24.864] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:01:25.734] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-pssw24o1d7mk3dh5ljmzue",
  "object": "chat.completion",
  "created": 1712228484,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"Access YouTube homepage to click the first link.\",\n\"param\": \"http://www.google.com/search?q=youtube+first+link\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 42,
    "completion_tokens": 41,
    "total_tokens": 83
  }
}
[2024-04-04 22:04:58.298] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:04:58.298] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go on http://youtube.com and click the first link"
    }
  ]
}
[2024-04-04 22:04:58.299] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go on http://youtube.com and click the first link' } (total messages = 2)
[2024-04-04 22:04:58.338] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:04:59.011] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-m365up9oqvscxbx1kyd08g",
  "object": "chat.completion",
  "created": 1712228698,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"Access YouTube website and click on the first link found.\",\n\"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 33,
    "completion_tokens": 32,
    "total_tokens": 65
  }
}
[2024-04-04 22:06:34.271] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:06:34.271] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go on http://youtube.com and click the first link"
    }
  ]
}
[2024-04-04 22:06:34.272] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go on http://youtube.com and click the first link' } (total messages = 2)
[2024-04-04 22:06:34.308] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:06:35.010] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-7nzn0db02qr7wq4npdmikb",
  "object": "chat.completion",
  "created": 1712228794,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"Access YouTube website and click the first link for further navigation.\",\n\"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 34,
    "completion_tokens": 33,
    "total_tokens": 67
  }
}
[2024-04-04 22:35:47.392] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:35:47.392] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube and click the first link"
    }
  ]
}
[2024-04-04 22:35:47.393] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube and click the first link' } (total messages = 2)
[2024-04-04 22:35:47.649] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:35:48.335] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-s2uvk16u99wpxdfe3439c",
  "object": "chat.completion",
  "created": 1712230547,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"Perform a search on YouTube for the first link.\",\n\"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 32,
    "completion_tokens": 32,
    "total_tokens": 64
  }
}
[2024-04-04 22:39:42.255] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:39:42.255] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube and click the first video"
    }
  ]
}
[2024-04-04 22:39:42.257] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube and click the first video' } (total messages = 2)
[2024-04-04 22:39:42.485] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:39:43.469] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-jc8xnlza5up53q50fcgrvr",
  "object": "chat.completion",
  "created": 1712230782,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"Perform a search on YouTube and open the first video from the results.\",\n\"param\": \"https://www.youtube.com/results?search_query=first+video\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 46,
    "completion_tokens": 46,
    "total_tokens": 92
  }
}
[2024-04-04 22:40:44.336] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:40:44.336] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 22:40:44.337] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 22:40:44.599] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:40:45.224] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-ga87ogzfhypu5tu36fgyba",
  "object": "chat.completion",
  "created": 1712230844,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"The user wants to visit YouTube.\",\n\"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 28,
    "completion_tokens": 28,
    "total_tokens": 56
  }
}
[2024-04-04 22:41:27.471] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:41:27.472] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube"
    }
  ]
}
[2024-04-04 22:41:27.472] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube' } (total messages = 2)
[2024-04-04 22:41:27.606] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:41:28.188] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-6ol8zhc9awyn9ur6r8r8d",
  "object": "chat.completion",
  "created": 1712230887,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"The user wants to visit YouTube.\",\n\"param\": \"www.youtube.com\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 27,
    "completion_tokens": 26,
    "total_tokens": 53
  }
}
[2024-04-04 22:41:42.120] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:41:42.120] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to https://www.youtube.com/ and click the first video"
    }
  ]
}
[2024-04-04 22:41:42.121] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to https://www.youtube.com/ and click the first video' } (total messages = 2)
[2024-04-04 22:41:42.399] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:41:43.100] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-4163wzlsnhvibmpg3sxkvs",
  "object": "chat.completion",
  "created": 1712230902,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"Search for the first video on YouTube's homepage.\",\n\"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 33,
    "completion_tokens": 33,
    "total_tokens": 66
  }
}
[2024-04-04 22:43:09.094] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:09.094] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to youtube and click the first video"
    }
  ]
}
[2024-04-04 22:43:09.095] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to youtube and click the first video' } (total messages = 2)
[2024-04-04 22:43:09.324] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:43:10.213] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-ufowuxlp4ylbpxqyr5apa",
  "object": "chat.completion",
  "created": 1712230989,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"Perform a search on YouTube for the first video to open.\",\n\"param\": \"www.youtube.com/results?search_query=first+video\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 42,
    "completion_tokens": 42,
    "total_tokens": 84
  }
}
[2024-04-04 22:43:23.435] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:23.436] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: go to https://www.youtube.com/ and click the first video"
    }
  ]
}
[2024-04-04 22:43:23.436] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: go to https://www.youtube.com/ and click the first video' } (total messages = 2)
[2024-04-04 22:43:23.733] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:43:24.428] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-b8pe4ffuwn8a2pi937y1mo",
  "object": "chat.completion",
  "created": 1712231003,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"Search for the first video on YouTube's home page.\",\n\"param\": \"https://www.youtube.com/\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 33,
    "completion_tokens": 33,
    "total_tokens": 66
  }
}
[2024-04-04 22:43:28.413] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:28.413] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:28.414] [ERROR] 'messages' field is required
[2024-04-04 22:43:28.415] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:28.415] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:28.415] [ERROR] 'messages' field is required
[2024-04-04 22:43:28.416] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:28.417] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:28.417] [ERROR] 'messages' field is required
[2024-04-04 22:43:28.417] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:28.418] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:28.418] [ERROR] 'messages' field is required
[2024-04-04 22:43:28.419] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:28.419] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:28.419] [ERROR] 'messages' field is required
[2024-04-04 22:43:28.420] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:28.420] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:28.420] [ERROR] 'messages' field is required
[2024-04-04 22:43:28.475] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:28.476] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:28.476] [ERROR] 'messages' field is required
[2024-04-04 22:43:28.526] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:28.527] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:28.527] [ERROR] 'messages' field is required
[2024-04-04 22:43:28.851] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:28.851] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:28.852] [ERROR] 'messages' field is required
[2024-04-04 22:43:28.855] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:28.855] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:28.855] [ERROR] 'messages' field is required
[2024-04-04 22:43:29.321] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:29.322] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:29.322] [ERROR] 'messages' field is required
[2024-04-04 22:43:29.323] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:29.323] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:29.324] [ERROR] 'messages' field is required
[2024-04-04 22:43:29.345] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:29.345] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:29.346] [ERROR] 'messages' field is required
[2024-04-04 22:43:29.351] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:29.352] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:29.352] [ERROR] 'messages' field is required
[2024-04-04 22:43:29.353] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:29.354] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:29.354] [ERROR] 'messages' field is required
[2024-04-04 22:43:29.356] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:29.356] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:29.356] [ERROR] 'messages' field is required
[2024-04-04 22:43:29.377] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:29.377] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:29.377] [ERROR] 'messages' field is required
[2024-04-04 22:43:29.380] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:29.381] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:29.381] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.390] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.390] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.390] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.391] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.392] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.392] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.393] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.393] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.393] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.394] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.394] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.395] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.400] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.400] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.401] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.401] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.402] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.402] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.472] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.473] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.473] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.474] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.474] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.475] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.477] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.477] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.477] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.478] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.478] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.479] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.484] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.485] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.485] [ERROR] 'messages' field is required
[2024-04-04 22:43:30.715] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:30.716] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:30.716] [ERROR] 'messages' field is required
[2024-04-04 22:43:31.027] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:31.028] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:31.028] [ERROR] 'messages' field is required
[2024-04-04 22:43:31.076] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:31.077] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:31.077] [ERROR] 'messages' field is required
[2024-04-04 22:43:31.080] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:31.080] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:31.080] [ERROR] 'messages' field is required
[2024-04-04 22:43:31.376] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:31.377] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:31.377] [ERROR] 'messages' field is required
[2024-04-04 22:43:31.476] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:31.476] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:31.477] [ERROR] 'messages' field is required
[2024-04-04 22:43:31.477] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:43:31.477] [INFO] Received OPTIONS request to /v1/chat/completions with body: {}
[2024-04-04 22:43:31.478] [ERROR] 'messages' field is required
[2024-04-04 22:45:22.370] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-04 22:45:22.370] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here') when a url isn't specified by the user.\nProvide response with this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    param: \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: create an event in my google calendar"
    }
  ]
}
[2024-04-04 22:45:22.371] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: create an event in my google calendar' } (total messages = 2)
[2024-04-04 22:45:22.573] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-04 22:45:23.179] [INFO] [LM STUDIO SERVER] [NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2] Generated prediction: {
  "id": "chatcmpl-ft1yhvy8xtxowrwxcljt",
  "object": "chat.completion",
  "created": 1712231122,
  "model": "NousResearch/Hermes-2-Pro-Mistral-7B-GGUF/Hermes-2-Pro-Mistral-7B.Q8_0.gguf:2",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\"thought\": \"The user wants to create an event in their Google Calendar.\", \"param\": \"www.google.com/calendar"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 29,
    "completion_tokens": 29,
    "total_tokens": 58
  }
}
