# Number Two
[Number Two](https://2.exegete.me/) is a companion app I made for my Twitch channel. I liked it enough that I thought, "Why not make it available for others?"

At the moment, the following things work:

Chat overlay with Twitch emotes and user avatars.
!ask command for asking questions.
!todo for adding todos and showing a current todo overlay.

## Stack

Tool | Use | Version
---|---|---
[Ruby](https://docs.ruby-lang.org/en/2.7.0/) | Dynamic programming lang | 2.7.2
[Rails](https://api.rubyonrails.org/) | Web App Framework for Ruby | 6.0.3
[Postgres](https://www.postgresql.org/docs/9.0/index.html) | Relational Database | 9
[NES.css](https://nostalgic-css.github.io/NES.css/) | Retro CSS Framework | 
[Stimulus Reflex](https://docs.stimulusreflex.com/) | Websocket-based front-end framework | 
[Docker](https://docs.docker.com/) | Containerized deployment env |

## Getting Started

There are two recommended ways to get started developing.

### Remote Containers / Dev Containers

The most native-like solution is using 
[Remote Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
/ Dev Containers.  This solution will allow you to use `rails` commands
similar to most guides and tutorials.

After opening the project in Visual Studio Code (with the extension installed)
you will be prompted to "Reopen in Container".  This will build the containers
and start the ansilary services.  To bring up the web server, run:

```sh
rails s
```

This should start the server listening on
[port 3000 of localhost](http://localhost:3000).

### Docker Compose

`docker-compose` offers a low configuration option.  There are a few commands
before starting the server:

- `docker-compose run --rm web yarn install --check-files`
- `docker-compose run --rm web rails db:setup`

Once those are done, you can launch the server with:

```sh
docker-compose up
```

This should start the server listening on
[port 3000 of localhost](http://localhost:3000).

Know that all `rails` and `yarn` commands should be prefixed with
`docker-compose run --rm web`.  As an example, to see the Rails console:

```sh
docker-compose run --rm web rails c
```

## Testing

Testing is provided my Minitest, so to run tests use the Rails built in:

```sh
rails test
```

