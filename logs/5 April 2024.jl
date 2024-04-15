[2024-04-05 15:13:03.431] [INFO] [LM STUDIO SERVER] Verbose server logs are DISABLED
[2024-04-05 15:13:03.435] [INFO] [LM STUDIO SERVER] Success! HTTP server listening on port 1234
[2024-04-05 15:13:03.435] [INFO] [LM STUDIO SERVER] Supported endpoints:
[2024-04-05 15:13:03.435] [INFO] [LM STUDIO SERVER] ->	GET  http://localhost:1234/v1/models
[2024-04-05 15:13:03.435] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/chat/completions
[2024-04-05 15:13:03.435] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/completions
[2024-04-05 15:13:03.436] [INFO] [LM STUDIO SERVER] Model loaded: LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf
[2024-04-05 15:13:03.436] [INFO] [LM STUDIO SERVER] Logs are saved into C:\tmp\lmstudio-server-log.txt
[2024-04-05 15:13:29.483] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:29.484] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here')\nProvide response with this JSON schema:\n{\n    \"thought\": \"one sentence rationale\",\n    \"param\": \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: google tech and click first link"
    }
  ]
}
[2024-04-05 15:13:29.486] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: google tech and click first link' } (total messages = 2)
[2024-04-05 15:13:29.672] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:30.967] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-at590b92ajpcgtryk9nhj",
  "object": "chat.completion",
  "created": 1712290409,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest information on technology from Google, we can perform a search query and click on the first result.\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 55,
    "completion_tokens": 55,
    "total_tokens": 110
  }
}
[2024-04-05 15:13:32.731] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:32.732] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object]\nWe currently just tried to execute step of the plan:\n  1\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:32.733] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:32.734] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object]\nWe currently just tried to execute step of the plan:\n  1\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:32.734] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:32.735] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:33.388] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:33.743] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:33.744] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object]\nWe currently just tried to execute step of the plan:\n  1\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:33.745] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:33.745] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object]\nWe currently just tried to execute step of the plan:\n  1\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:33.747] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:33.747] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:34.762] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:34.762] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object]\nWe currently just tried to execute step of the plan:\n  1\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:34.764] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:34.765] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object]\nWe currently just tried to execute step of the plan:\n  1\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:34.766] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:34.766] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:35.135] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-oyr8v913yqgdvfyhfgo4r",
  "object": "chat.completion",
  "created": 1712290412,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 77,
    "completion_tokens": 77,
    "total_tokens": 154
  }
}
[2024-04-05 15:13:35.173] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:36.047] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:36.048] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  2\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:36.051] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:36.961] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-drtnosinpkzaimqlcd2o",
  "object": "chat.completion",
  "created": 1712290412,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 78,
    "completion_tokens": 77,
    "total_tokens": 155
  }
}
[2024-04-05 15:13:36.962] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:36.963] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  2\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:36.968] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:37.001] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:38.809] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-bq2pwzksehe9tar0en4lfg",
  "object": "chat.completion",
  "created": 1712290413,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 78,
    "completion_tokens": 77,
    "total_tokens": 155
  }
}
[2024-04-05 15:13:38.810] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:38.811] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  3\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:38.814] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:38.847] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:40.763] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-875dv371xree9bm5qg7szf",
  "object": "chat.completion",
  "created": 1712290413,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 78,
    "completion_tokens": 77,
    "total_tokens": 155
  }
}
[2024-04-05 15:13:40.764] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:40.764] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  3\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:40.768] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:40.803] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:42.688] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-h3h1vvr1ktq6m7dty05rqu",
  "object": "chat.completion",
  "created": 1712290414,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 78,
    "completion_tokens": 77,
    "total_tokens": 155
  }
}
[2024-04-05 15:13:42.689] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:42.690] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  3\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:42.693] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:42.726] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:44.558] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-axwasijgj7fypjt7vn90ym",
  "object": "chat.completion",
  "created": 1712290414,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 78,
    "completion_tokens": 77,
    "total_tokens": 155
  }
}
[2024-04-05 15:13:44.560] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:44.560] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  3\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:44.563] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:45.282] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:47.193] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-t67kta9nmcz1cxwydvtjs",
  "object": "chat.completion",
  "created": 1712290416,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 77,
    "completion_tokens": 77,
    "total_tokens": 154
  }
}
[2024-04-05 15:13:47.194] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:47.194] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  3\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:47.198] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:47.230] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:49.470] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-z70u0448dnafsxkvyh2kn",
  "object": "chat.completion",
  "created": 1712290416,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 78,
    "completion_tokens": 77,
    "total_tokens": 155
  }
}
[2024-04-05 15:13:49.472] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:49.472] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  3\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:49.476] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:50.267] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:52.022] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-6l4jqkslg3cxkidmee7wpr",
  "object": "chat.completion",
  "created": 1712290418,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 77,
    "completion_tokens": 77,
    "total_tokens": 154
  }
}
[2024-04-05 15:13:52.023] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:52.024] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  4\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:52.028] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:52.060] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:53.971] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-krps81olznh5rlm1w1aeh",
  "object": "chat.completion",
  "created": 1712290420,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 78,
    "completion_tokens": 77,
    "total_tokens": 155
  }
}
[2024-04-05 15:13:53.973] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:53.973] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  4\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:53.977] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:54.008] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:55.798] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-0uo9mhbq05qhmq3z10lwvue",
  "object": "chat.completion",
  "created": 1712290422,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 78,
    "completion_tokens": 77,
    "total_tokens": 155
  }
}
[2024-04-05 15:13:55.799] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:55.799] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  4\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:55.803] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:55.842] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:56.571] [INFO] [LM STUDIO SERVER] Stopping server..
[2024-04-05 15:13:56.571] [INFO] [LM STUDIO SERVER] Server stopped
[2024-04-05 15:13:56.572] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-80wfmu53sa1zmhbhzwbiv",
  "object": "chat.completion",
  "created": 1712290427,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
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
[2024-04-05 15:13:56.573] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-ve33gka7fkrsrhnsd5y3s",
  "object": "chat.completion",
  "created": 1712290429,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
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
[2024-04-05 15:13:56.573] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-e77vd0m54gru3778h0wm5",
  "object": "chat.completion",
  "created": 1712290432,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
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
[2024-04-05 15:13:56.574] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-62hhabwyln8lc4av4a628",
  "object": "chat.completion",
  "created": 1712290433,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
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
[2024-04-05 15:13:56.574] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-rvs2ckf9qrbt8hi67mftv",
  "object": "chat.completion",
  "created": 1712290435,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
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
[2024-04-05 15:13:56.576] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:56.576] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  4\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:56.577] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:56.577] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  5\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:56.578] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:56.578] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  5\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:56.579] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:56.579] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  7\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:56.580] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:56.580] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  7\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:56.583] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:56.583] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:56.583] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:56.584] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:56.584] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:56.600] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-ms4k08l3iv5v0vhr638kq",
  "object": "chat.completion",
  "created": 1712290424,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 28,
    "completion_tokens": 27,
    "total_tokens": 55
  }
}
[2024-04-05 15:13:56.601] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:56.601] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  7\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:56.605] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:57.301] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:13:59.164] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-rurnxqvuyktanfkzuzxz",
  "object": "chat.completion",
  "created": 1712290436,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 77,
    "completion_tokens": 77,
    "total_tokens": 154
  }
}
[2024-04-05 15:13:59.165] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:13:59.165] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  7\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:13:59.169] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:13:59.902] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:14:01.720] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-j97a73x739t6ys11vw64kk",
  "object": "chat.completion",
  "created": 1712290436,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 77,
    "completion_tokens": 77,
    "total_tokens": 154
  }
}
[2024-04-05 15:14:01.721] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:14:01.721] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  8\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:14:01.725] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:14:01.756] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 15:14:03.428] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-nrbgnnej589sjywtnvkb",
  "object": "chat.completion",
  "created": 1712290436,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "{\n\"thought\": \"To find the latest technology news, we will search for relevant articles and sources using Google's search engine.\",\n\"action\": \"NAVURL\",\n\"ariaLabel\": \"Search for latest technology news\",\n\"param\": \"https://www.google.com/search?q=latest+technology+news\"\n}\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 78,
    "completion_tokens": 77,
    "total_tokens": 155
  }
}
[2024-04-05 15:14:03.429] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 15:14:03.430] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.google.com/search?q=latest+technology+news\"\nyou originally came up with the plan:\n  [object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object],[object Object]\nWe currently just tried to execute step of the plan:\n  8\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    thought: \"one sentence rationale\",\n    action: \"NAVURL\" | \"CLICKBTN\" | \"INPUT\" | \"SELECT\" | \"WAITLOAD\" ,\n    ariaLabel: \"labelName\",\n    param?: \"url\" | \"inputOption\" | \"inputText\"\n}\nONLY use the following user provided nodes aria-labels:\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Clear\"},{\"role\":\"button\",\"ariaLabel\":\"Search by voice\"},{\"role\":\"button\",\"ariaLabel\":\"Search by image\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Delete\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Report inappropriate predictions\"},{\"role\":\"button\",\"ariaLabel\":\"See more\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Google apps\"},{\"role\":\"button\",\"ariaLabel\":\"Google Account: Arash  \\n(yspdev@gmail.com)\"},{\"role\":\"button\",\"ariaLabel\":\"More\"},{\"role\":\"button\",\"ariaLabel\":\"Tools\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"SafeSearch\"},{\"role\":\"button\",\"ariaLabel\":\"Any time\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Go\"},{\"role\":\"INPUT\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"All results\"},{\"role\":\"button\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Delete last 15 mins\"},{\"role\":\"button\",\"ariaLabel\":\"Send feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"What technology is trending right now?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the newest form of technology?\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Where can I find the latest tech news?\"},{\"role\":\"button\",\"ariaLabel\":\"What is the fastest growing technology in the world today?\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"Feedback\"},{\"role\":\"button\",\"ariaLabel\":\"About this result\"},{\"role\":\"button\",\"ariaLabel\":\"More results\"},{\"role\":\"button\",\"ariaLabel\":\"Try again\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"close\"},{\"role\":\"button\",\"ariaLabel\":\"Red Hill, Australian Capital Territory - Based on your places (Home)\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"\"},{\"role\":\"button\",\"ariaLabel\":\"Update locationCan't update your locationLearn moreUpdating location…\"},{\"role\":\"button\",\"ariaLabel\":\"Learn more\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 15:14:03.433] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Clear"},{"role":"button","ariaLabel":"Search by voice"},{"role... (truncated in these logs)' } (total messages = 2)
[2024-04-05 15:14:04.041] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 17:06:40.955] [INFO] [LM STUDIO SERVER] Verbose server logs are DISABLED
[2024-04-05 17:06:40.959] [INFO] [LM STUDIO SERVER] Success! HTTP server listening on port 1234
[2024-04-05 17:06:40.959] [INFO] [LM STUDIO SERVER] Supported endpoints:
[2024-04-05 17:06:40.959] [INFO] [LM STUDIO SERVER] ->	GET  http://localhost:1234/v1/models
[2024-04-05 17:06:40.959] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/chat/completions
[2024-04-05 17:06:40.959] [INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/completions
[2024-04-05 17:06:40.960] [INFO] [LM STUDIO SERVER] Model loaded: LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf
[2024-04-05 17:06:40.960] [INFO] [LM STUDIO SERVER] Logs are saved into C:\tmp\lmstudio-server-log.txt
[2024-04-05 17:06:50.646] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 17:06:50.647] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-3.5-turbo-1106",
  "stop": "}",
  "temperature": 0.2,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.\nThis should be either the absolute URL given\nOR a google search URL ('www.google.com/search?q=your+search+here')\nProvide response with this JSON schema:\n{\n    \"thought\": \"one sentence rationale\",\n    \"param\": \"url\"\n}\n"
    },
    {
      "role": "user",
      "content": "user prompt: find a cat video on youtube"
    }
  ]
}
[2024-04-05 17:06:50.649] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'user prompt: find a cat video on youtube' } (total messages = 2)
[2024-04-05 17:06:50.842] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 17:06:52.063] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-pokx30pkanfxam7dllbxyn",
  "object": "chat.completion",
  "created": 1712297210,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": " {\n    \"thought\": \"To find a cat video on YouTube, we can use the YouTube search function to look for popular and relevant videos.\",\n    \"param\": \"https://www.youtube.com/results?search_query=cat+videos\"\n"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 58,
    "completion_tokens": 58,
    "total_tokens": 116
  }
}
[2024-04-05 17:06:55.056] [INFO] [LM STUDIO SERVER] Processing queued request...
[2024-04-05 17:06:55.057] [INFO] Received POST request to /v1/chat/completions with body: {
  "model": "gpt-4-1106-preview",
  "seed": 1,
  "temperature": 0,
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "you are an expert web browsing AI. you were given the original goal prompt:\"https://www.youtube.com/results?search_query=cat+videos\"\nyou originally came up with the plan:\n  [object Object]\nWe currently just tried to execute step of the plan:\n  1\nprovide the next step of the plan to successfully achieve the goal.\nthe response should be in this JSON schema:\n{\n    \"thought\": \"one sentence rationale\",\n    \"action\": \"CLICKBTN\" | \"WAITLOAD\" ,\n    \"ariaLabel\": \"ariaLabelValue\",\n}\nmake sure to use an EXACT aria label from the list of user provided labels\n"
    },
    {
      "role": "user",
      "content": "nodes: [{\"role\":\"button\",\"ariaLabel\":\"Close player\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"\\n    \\n  \"},{\"role\":\"button\",\"ariaLabel\":\"\\n          \\n        \"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Expand\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Collapse\"},{\"role\":\"button\",\"ariaLabel\":\"\\n      \\n      \\n    \"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Back\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Guide\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Skip navigation\"},{\"role\":\"INPUT\",\"ariaLabel\":\"Search\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Clear search query\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"button\",\"ariaLabel\":\"\\n      \\n      \\n      \\n        Search\\n      \\n    \"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search with your voice\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Create\"},{\"role\":\"button\",\"ariaLabel\":\"3\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Notifications\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Account menu\"},{\"role\":\"button\",\"ariaLabel\":\"Guide\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Previous\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Next\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search filters\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"More actions\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Next\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"More actions\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Next\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Action menu\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Playlist\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Show cards\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"More\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Tap to unmute\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Play\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Cancel\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Confirm\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Watch later\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Share\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Copy link\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Close\"},{\"role\":\"button\",\"ariaLabel\":\"Play from this position\"},{\"role\":\"button\",\"ariaLabel\":\"Exit precise seeking\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Play (k)\"},{\"role\":\"button\",\"ariaLabel\":\"Next (SHIFT+n)\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Live\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"•\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"•\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Scroll for details\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Subtitles/closed captions unavailable\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Settings\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Miniplayer (i)\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Theater mode (t)\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Play on TV\"},{\"role\":\"button\",\"ariaLabel\":\" \"},{\"role\":\"button\",\"ariaLabel\":\" \"},{\"role\":\"button\",\"ariaLabel\":\" \"},{\"role\":\"button\",\"ariaLabel\":\" \"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Collapse\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Playlist\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Search\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Show cards\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"More\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Tap to unmute\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Play\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Cancel autoplay\"},{\"role\":\"button\",\"ariaLabel\":\"Play next video\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Previous\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Next\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Skip ahead to live broadcast.\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Subtitles/closed captions unavailable\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Watch later\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Share\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Copy link\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Close\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Stop live playback\"},{\"role\":\"button\",\"ariaLabel\":\"Next\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Skip ahead to live broadcast.\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"•\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"•\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Subtitles/closed captions unavailable\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Settings\"},{\"role\":\"BUTTON\",\"ariaLabel\":\"Theater mode\"},{\"role\":\"DIV\",\"ariaLabel\":\"Thinking...\"}]"
    }
  ]
}
[2024-04-05 17:06:55.060] [INFO] [LM STUDIO SERVER] Last message: { role: 'user', content: 'nodes: [{"role":"button","ariaLabel":"Close player"},{"role":"BUTTON","ariaLabel":"\n    \n  "},{"ro... (truncated in these logs)' } (total messages = 2)
[2024-04-05 17:06:55.799] [INFO] [LM STUDIO SERVER] Accumulating tokens ... (stream = false)
[2024-04-05 17:06:58.295] [INFO] [LM STUDIO SERVER] [LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf] Generated prediction: {
  "id": "chatcmpl-9x40mf2y8ycubyd8mgb7hl",
  "object": "chat.completion",
  "created": 1712297215,
  "model": "LoneStriker/Starling-LM-7B-beta-GGUF/Starling-LM-7B-beta-Q8_0.gguf",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": " {\n    \"thought\": \"To find relevant cat videos, we should first click on the search button to initiate the search and then use the provided filters and options to refine our results.\",\n    \"action\": \"CLICKBTN\",\n    \"ariaLabel\": \"Search\"\n}\n\nIn this step, we will click on the \"Search\" button with an aria-label of \"Search\" to initiate the search for cat videos. This will bring up a list of relevant results that we can then further refine using filters and options available in the interface."
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 121,
    "completion_tokens": 121,
    "total_tokens": 242
  }
}