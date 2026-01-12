# api2spec Sinatra Fixture

A sample Sinatra API application for testing api2spec framework detection and route extraction.

## Endpoints

### Health
- `GET /health` - Health check
- `GET /health/ready` - Readiness check

### Users
- `GET /users` - List all users
- `GET /users/:id` - Get user by ID
- `POST /users` - Create a new user
- `PUT /users/:id` - Update a user
- `DELETE /users/:id` - Delete a user
- `GET /users/:user_id/posts` - Get posts for a user

### Posts
- `GET /posts` - List all posts
- `GET /posts/:id` - Get post by ID
- `POST /posts` - Create a new post

## Docker Development

### Build and run the application

```bash
docker compose up --build
```

The API will be available at http://localhost:8080

### Run in development mode (interactive shell)

```bash
docker compose run --rm dev
```

Inside the container, you can run:

```bash
ruby app.rb
```

### Rebuild the container

```bash
docker compose build
```

### Stop all containers

```bash
docker compose down
```

## Local Development (without Docker)

### Install dependencies

```bash
bundle install
```

### Run the application

```bash
ruby app.rb
```

Or using Rack:

```bash
rackup -p 8080
```

## Testing the API

```bash
# Health check
curl http://localhost:8080/health

# List users
curl http://localhost:8080/users

# Get a specific user
curl http://localhost:8080/users/1

# Create a user
curl -X POST http://localhost:8080/users \
  -H "Content-Type: application/json" \
  -d '{"name": "Charlie", "email": "charlie@example.com"}'

# List posts
curl http://localhost:8080/posts
```
