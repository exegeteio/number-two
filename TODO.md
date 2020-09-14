# TODOs

# WHERE WAS I!?

Next thing we need is Redis!

## The Plan

I'd like to build something similar to [Number One](https://github.com/michaeljolley/number-one), but doing fewer things.

## Features

- On-screen chat log.
- !ask command
- Overlay screen.
  - Each chat message in the top-right.
    - Wishlist!  Timeout progress bar.
  - !ask message in top-left.
    - Triggered by the dashboard.
- Dashboard screen.
  - Current !ask questions by ranking.
    - Link to mark as current question.

### Wishlist Features

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

