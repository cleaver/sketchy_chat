# GenServer Pattern and Process Registry in SketchyChat

## Decoupling Interface and Implementation

SketchyChat follows the pattern described by Dave Thomas (PragDave) in his article [Splitting APIs, Servers, and Implementations in Elixir](https://pragdave.me/thoughts/active/2017-07-13-decoupling-interface-and-implementation-in-elixir.html). This approach separates concerns into three distinct layers:

1. **Implementation Layer** (`Impl` modules)

   - Contains pure business logic
   - Ideally pure functions with no side-effects
   - No GenServer-specific code
   - Easy to test independently
   - Located in `lib/sketchy_chat/domain/*/impl.ex`

2. **Server Layer** (`Server` modules)

   - Implements GenServer behavior
   - Handles process-specific concerns
   - Delegates to implementation layer
   - Located in `lib/sketchy_chat/domain/*/server.ex`

3. **API Layer** (Public modules)
   - Provides clean public interface
   - Hides implementation details
   - Manages process lifecycle
   - Located in `lib/sketchy_chat/domain/*.ex`

### Example Structure

```
lib/sketchy_chat/
└── domain/
    └── chat_room/
        ├── impl.ex      # Business logic
        └── server.ex    # GenServer implementation
    └── chat_room.ex     # Public API
```

## Process Registry

SketchyChat uses Elixir's built-in `Registry` module to manage dynamic process registration and discovery. This allows us to:

- Register chat rooms with unique names
- Look up chat room processes by name
- Handle dynamic process creation and cleanup
- Scale horizontally across nodes

The registry is started as part of the application supervision tree and is used by the chat room modules to manage their lifecycle and discovery.

### Key Benefits

- **Decoupling**: Business logic is separated from process management
- **Testability**: Implementation modules can be tested without GenServer concerns
- **Maintainability**: Clear separation of concerns makes code easier to understand and modify
- **Scalability**: Process registry enables dynamic process management and discovery
- **Flexibility**: Easy to change implementation without affecting the public API
