# Number Two
[Number Two](https://2.exegete.me/) is a companion app I made for my Twitch channel. I liked it enough that I thought, "Why not make it available for others?"

At the moment, the following things work:

Chat overlay with Twitch emotes and user avatars.
!ask command for asking questions.
!todo for adding todos and showing a current todo overlay.

## Install

I recommend Docker to get up and running quickly.  With `docker` and `docker-compose` installed,
get started by updating your local `yarn` packages:

```sh
$ docker-compose run --rm web yarn install --check-files
```

Then be sure to create and migrate your database:

```sh
$ docker-compose run --rm web rails db:create db:migrate
```

## Stack

Tool | Use | Version
---|---|---
[Ruby](https://docs.ruby-lang.org/en/2.7.0/) | Dynamic programming lang | 2.7.2
[Rails](https://api.rubyonrails.org/) | Web App Framework for Ruby | 6.0.3
[Postgres](https://www.postgresql.org/docs/9.0/index.html) | Relational Database | 9
[NES.css](https://nostalgic-css.github.io/NES.css/) | Retro CSS Framework | 
[Stimulus Reflex](https://docs.stimulusreflex.com/) | Websocket-based front-end framework | 
[Docker](https://docs.docker.com/) | Containerized deployment env |