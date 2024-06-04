# Lila: Your AI Music Teacher!

[Demo link](https://www.youtube.com/watch?v=9XOOs6h54hQ)

## What it does

Our project teaches about Music, and has 2 main functionalities: 1) Curious about the intricacies of Musical Theory? Don't worry, It teaches the user about the specifics of Western Musical Theory. To make the learn fun, it incorporates things like asking a quiz, after the lessons, and giving achievement points and so.

2) Ever playing the Piano alone and wondered if you are going wrong? One of its features we are most proud of is the ability to identify notes: simply play a tune, record it and send it to the app, and it will analyze and identify the notes for you, helping you perfect your notes.

![Alt_text](https://raw.githubusercontent.com/sanjaybhat2004/AI_Music_Teacher/newest_branch/demo_images/homepage.png)

## How we built it

We used the combination of Vertex AI Agents, Flutter to make the app.

We believe that LLM's are a great technology. However coupled with Agents and Data Stores and Tools, that's when we can witness the actual power of LLM's. This is when the LLM gets the abilities to be just more than an conversational partner, and do things for you.

In Vertex AI we used the features as follows:

- Agents: We made a default agent, which starts the conversation with the User. Then we made 3 other agents, The Theory Teaching Agent, the Quiz Master Agent, and the Note Detecting Agent. We made these agents to help the LLM segregate the work, and improve the accuracy of the results of each of these subtasks. This also fine-tune the Agents, allowing us to get better results for the user.

- Data Stores: We gathered resources from various sources from the internet and books on Music Theory and made 3 Data Stores each for the specific agent. We used techniques like chunking and the Layout Parser so that the model can access the data in better ways.

- Personalization: We also provided the Agent with the goals of being Energetic and Funny, so as to make learning process more fun. We also provided the Agent with examples, to improve its accuracy.

- We used the FFT (Fast Fourier Transform) algorithm, to find out the indiviual notes being played. This algorithm picks out the frequency which occurs the most in the given piece of audio. We deployed the note detector as a Google Cloud function.

## Challenges we ran into

1) Making the Front End: when this hackathon came out we decided this was a good opportunity to do something in Flutter and learn by making something. As all of us were inexperienced with Flutter Development we sometimes got stuck in the middle, but however due to extensive documentation available on flutter packages and resources available on the internet we found our way through.

2) Getting the model to understand for finer responses: We experienced many cases where the model was not able to fine its responses for the question, despite it being available in the Data Store. We solved this by increasing the number of chunks and making the text in a way more suitable to retrieval by the LLM.

3) Breaking the audio file into separate pieces to be processed: One of the biggest challenges was to find out heuristics, to find out the places where to break the given audio file containing many notes, so that we can get separate audio files to be processed by the note detector. This is an ongoing research domain, so we had to find out heuristics good enough for our usecase.

![Alt_text](https://raw.githubusercontent.com/sanjaybhat2004/AI_Music_Teacher/newest_branch/demo_images/note_separation.png)

## Accomplishments that we're proud of

We are happy we were able to complete the goals of our project and help more people learn Music. We hope that new generation of Musicians take advantage of this solution built by us. People need not fear about learning Music theory any longer.

## What we learned

As we built this app, we ourselves also learned more about Music Theory. We also learned how to make Flutter apps, as well as how to use Vertex AI Agent to make conversational chat bots. We learnt how to take advantage Vertex AI tools and Vertex AI Data stores, to make the process simpler. We also learned about Digital Signal Processing, and how you can use the FFT algorithm to process pieces of sound.
![Alt_text](https://raw.githubusercontent.com/sanjaybhat2004/AI_Music_Teacher/newest_branch/demo_images/chatpage.png)

## What's next for Lila, your AI Music Teacher


We plan to expand the app to support additional musical instruments beyond piano. We will release the app in Play Store in order for people to learn Music. This is our way of making sure that other don't face the challenges we did.

Built With
- Dart
- Firebase
- Flutter
- Github
- Python
- Vertex AI

Submitted to

    Google Cloud Vertex AI Agent Builder Hackathon

Devpost link: [link](https://devpost.com/software/lila-your-ai-music-teacher)
    
## Members:
- Sanjay Bhat
- Smit Rathod
- Alen Basil Thelappilly

