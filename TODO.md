# TODOs

## The Plan

I'd like to build something similar to [Number One](https://github.com/michaeljolley/number-one), but doing fewer things.

## Features

- [x] On-screen chat log.
- [x] !ask command
- [x] Overlay screen.
  - [x] Each chat message in the top-right.
    - Wishlist!  Timeout progress bar.
  - [x] !ask message in bottom-left;
    - [x] Triggered by the dashboard.
- [x] Dashboard screen.
  - [x] Current !ask questions by ranking.
    - [x] Link to mark as current question.
- !todo command
  - Show current task on the screen.

### Wishlist Features

- [x] Enable emotes in the chat.
- !ask command - enhancement
  - Vote on next question to answer, ala Reddit.
  - Requires a database.
  - Does not need to persist across streams.
- !todo command
  - Show current task on the screen.
  - Require a database of some kind to persist across streams.

## Technology

- Re-learn more about ActionCable.
  - On-screen chat log.
    - Collect chat messages.  IRC Bot?  ComfyJS?  Something.
    - Render HTML at the server, broadcast over ActionCable.
  - Unit tests?
- Learn more about StimulusJS.
  - Unit Tests?
  - On-screen chat log.
    - Collect rendered messages from ActionCable, add to screen list.

