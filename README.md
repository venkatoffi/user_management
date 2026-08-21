# user_management (Rails)

Rails app for basic user registration and login.

## What it does

- `POST /user` creates a user (expects `name`, `email`, `password`) and responds with JSON.
- `POST /login` authenticates a user (expects `email`, `password`) and responds with a JWT token.
- `GET /` serves a simple HTML page.
- `DELETE /logout` responds with a logout message (no token invalidation is implemented).

## Routes

- `GET /health` -> `200 OK`
- `GET /up` -> Rails health check
- `GET /` -> `UserController#index`
- `POST /user` -> `UserController#create`
- `POST /login` -> `SessionsController#create`
- `DELETE /logout` -> `SessionsController#destroy`

## Requirements

- Ruby on Rails `~> 8.0.2`
- PostgreSQL (configured via `config/database.yml`)
- Bundler dependencies (`bundle install`)

## Setup (local)

1. Install dependencies:
   - `bundle install`
2. Prepare the database:
   - `bin/rails db:prepare`
3. Start the dev server:
   - `bin/dev` (or `bin/rails server`)

## Test suite

Run:
- `bin/rails test`

## Docker

The provided `Dockerfile` is production-oriented and runs:
- `./bin/rails server` via Thruster

Build:
- `docker build -t user_management .`

Run (example):
- `docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value> --name user_management user_management`

## Database schema

The migrations create:
- `users` (`email` is unique, `password_digest` is required)
- `sessions` (`session_id` is unique; stores arbitrary `data`)

## Notes / Known issues (current code)

- `config/application.rb` configures Rails’ `ActiveRecord::SessionStore` to use a table named `legacy_session_table`, but there is no migration for it in this repo. If you see `PG::UndefinedTable` for `legacy_session_table`, you’ll need to create that table (or adjust/remove this session store configuration).
- `SessionsController#create` contains debugging statements (`binding.pry` and `p session`) and uses a placeholder JWT secret string (`'your_secret_key'`). As-is, login will not behave correctly without fixes.
- `UserController#create` currently checks `if user.present?` which will always be truthy for a newly-built `User` object, so the endpoint may always return `409` (“User already registered”).
