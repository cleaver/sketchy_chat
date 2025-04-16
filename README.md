# SketchyChat

![SketchyChat](sketchychat.png)

SketchyChat is a real-time chat application built with Phoenix LiveView. It allows users to create and join chat rooms with unique names, and communicate in real-time with other users.

## Features

- Real-time messaging using Phoenix PubSub
- Unique chat room names using short code generation
- Simple and intuitive interface
- Built with Phoenix LiveView for real-time updates
- Scalable architecture using GenServer and Registry

## Why is it Sketchy?

SketchyChat lives up to its name for a few reasons:

- **Somewhat Anonymous**: The application doesn't log messages or store them in a database. All messages are lost once the server is shut down.
- **In-Memory Only**: Everything is stored in memory using GenServer and Registry, which means all messages and chat rooms disappear when the server restarts.
- **Not Production-Ready**: While the application uses Phoenix LiveView and PubSub for real-time communication, it wasn't designed with scalability in mind. It's more of a proof-of-concept than a production-ready chat application.
- **No Persistence**: There's no message history, no user authentication, and no way to recover lost messages - making it perfect for sketchy individuals who want to keep their conversations temporary.

## Getting Started

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Architecture

- [GenServer Pattern and Process Registry](docs/genserver_pattern.md) - Learn about the application's architecture and how it uses GenServers and Registry for process management.

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
