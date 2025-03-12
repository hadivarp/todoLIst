# Todo API

A RESTful API for managing todo tasks built with Ruby on Rails. This application provides a complete backend solution for a todo application with user authentication, task management, and category organization.

## Features

- **User Authentication**: Secure signup, login, and logout functionality using JWT tokens
- **Task Management**: Create, read, update, and delete tasks
- **Task Categorization**: Organize tasks by categories
- **Task Prioritization**: Set priority levels (low, medium, high)
- **Task Status Tracking**: Track task status (pending, in progress, completed)
- **Soft Delete**: Tasks are soft-deleted with timestamp

## Tech Stack

- **Ruby on Rails**: Web application framework
- **JWT**: JSON Web Tokens for authentication
- **SQLite**: Database (for development)
- **Rack CORS**: Cross-Origin Resource Sharing support
- **BCrypt**: Secure password hashing

## API Endpoints

### Authentication

- `POST /signup`: Register a new user
- `POST /login`: Authenticate a user and receive a JWT token
- `POST /logout`: Logout a user

### Tasks

- `GET /api/v1/tasks`: Get all tasks for the authenticated user
- `GET /api/v1/tasks/:id`: Get a specific task
- `POST /api/v1/tasks`: Create a new task
- `PUT /api/v1/tasks/:id`: Update an existing task
- `DELETE /api/v1/tasks/:id`: Soft delete a task

### Categories

- `GET /api/v1/categories`: Get all categories for the authenticated user
- `GET /api/v1/categories/:id`: Get a specific category
- `POST /api/v1/categories`: Create a new category
- `PUT /api/v1/categories/:id`: Update an existing category
- `DELETE /api/v1/categories/:id`: Delete a category

### Users

- `GET /api/v1/users`: Get all users
- `GET /api/v1/users/:id`: Get a specific user
- `PUT /api/v1/users/:id`: Update a user
- `DELETE /api/v1/users/:id`: Delete a user

## Getting Started

### Prerequisites

- Ruby 3.x
- Rails 7.x
- SQLite3

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/todo.git
   cd todo

### Install dependencies

```bash
bundle install
```

### Set up the database

```bash
rails db:create
rails db:migrate
```

### Start the server

```bash
rails server
```

The API will be available at http://localhost:3000

Docker Support
This application includes Docker support for easy deployment:

```bash
docker build -t todo-api .
docker run -p 3000:3000 todo-api
```  

API Usage Examples
Register a new user

```bash
curl -X POST http://localhost:3000/signup \
  -H "Content-Type: application/json" \
  -d '{"authentication": {"username": "user1", "email": "user1@example.com", "password": "password123"}}'
```

Login

```bash
curl -X POST http://localhost:3000/login \
  -H "Content-Type: application/json" \
  -d '{"email": "user1@example.com", "password": "password123"}'
```

Create a task

```bash
curl -X POST http://localhost:3000/api/v1/tasks \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{"title": "Complete project", "description": "Finish the Rails project", "priority": "high", "status": "pending", "due_date": "2023-12-31"}'
```


### License
This project is licensed under the MIT License - see the LICENSE file for details.

### Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

