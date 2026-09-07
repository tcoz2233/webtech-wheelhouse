Markdown
# Wheelhouse Bicycle Shop

Wheelhouse is a web application for a local bicycle repair shop, built using Ruby on Rails and Bootstrap.

## Prerequisites

* Ruby 3.2.0
* Rails 8.1.3
* Node.js (v24+) & NPM
* PostgreSQL running locally with the active user role

## Setup & Running Locally

1. Clone the repository:
   ```bash
   git clone [https://github.com/tcoz2233/webtech-wheelhouse.git](https://github.com/tcoz2233/webtech-wheelhouse.git)
   cd webtech-wheelhouse
Install dependencies:

Bash
bundle install
npm install
Setup database, run migrations, and load seed data:

Bash
bin/rails db:setup
(Note: bin/rails db:setup creates the database, loads db/schema.rb, and runs db/seeds.rb)

Start the development server:

Bash
bin/dev
Open http://localhost:3000 in your browser. Navigating to /services will render the active catalog loaded directly from PostgreSQL.

Documentation
Project planning and architectural documents are located in the docs/ directory:

## Documentation

Project planning and architectural documents are located in the `docs/` directory:
* [User Stories](./docs/user-stories.md)
* [Domain Model](./docs/domain-model.md)