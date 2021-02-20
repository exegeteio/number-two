# Number Two
[Number Two](https://2.exegete.me/) is a companion app I made for my Twitch channel. I liked it enough that I thought, "Why not make it available for others?"

## Disclaimer

This is an personal education project.  The goal is to explore aspects of
"Vanilla Rails".  Trying to do things The Rails Way™.  Thus there is a focus
on using the Rails built-in tools, such as:

- Minitest
- ERB
- ActionCable
- StimulusJS
- HOTwire (not *yet* a part of Rails, but[...](https://twitter.com/dhh/status/1341420143239450624?lang=en))

Also, because this is an education project, please make suggestions!  Feedback
is **very** welcome, but please keep the above goals in mind.

## Feature Goals

- [] On-screen chat overlay.
- [] On-screen `!ask` overlay.
	- Anyone in chat can use the `!ask` command to put a question onto the
		presenter's dashboard, where the presenter can "Promote" the question onto
		screen, "Delete" the question, etc.
- [] On-screen `!todo` overlay.
	- Channel owners and moderators can use the `!todo` command to put a task
		onto the presenter's dashboard, where the presenter can "Promote" the task
		onto screen, "Delete" the task, etc.

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

## Stack

Tool | Use | Version
---|---|---
[Ruby](https://docs.ruby-lang.org/en/2.7.0/) | Dynamic programming lang | 2.7.2
[Rails](https://api.rubyonrails.org/) | Web App Framework for Ruby | 6.1.2
[Postgres](https://www.postgresql.org/docs/9.0/index.html) | Relational Database | 9
[NES.css](https://nostalgic-css.github.io/NES.css/) | Retro CSS Framework | 
[Hotwire](https://hotwire.dev/) | HTML Over The wire for DOM manipulation | 
[Docker](https://docs.docker.com/) | Containerized deployment env |
