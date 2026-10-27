# Webtech Wheelhouse — Workshop Management System

Wheelhouse is a Ruby on Rails application for managing bike repairs, customers, mechanics, and services. It provides both a web UI and a versioned JSON API (`/api/v1`) for external integration.

## Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/tcoz2233/webtech-wheelhouse.git](https://github.com/tcoz2233/webtech-wheelhouse.git)
   cd webtech-wheelhouse
Install dependencies and setup database:

bundle install
bin/rails db:prepare
bin/rails db:seed
Start the development server:

bin/rails server
Access the web application at http://localhost:3000.

Lab 11: Accounts & Authentication
Development Seed Accounts
The application includes pre-configured accounts in development:

Owner: owner@wheelhouse.cl / Password: passwordowner123

Counter: counter@wheelhouse.cl / Password: passwordcounter123

Mechanic: mechanic1@wheelhouse.cl / Password: passwordmechanic1

Orphan Account: orphan@wheelhouse.cl / Password: passwordorphan123

Development Emails
In development, application emails (welcome emails and password resets) are handled locally using letter_opener. When an email is sent, it opens automatically in your browser or can be accessed through the rails mailer previews at http://localhost:3000/rails/mailers.

Lab 10: API Integration & Setup
The application provides a versioned JSON API under /api/v1.

API Local Port: The API runs locally on port 3000 (http://localhost:3000).

Setting Up the API Token
Protected API endpoints require an HTTP Bearer Token stored in Rails encrypted credentials.

Open the credentials editor:

EDITOR="nano" bundle exec rails credentials:edit
Add the token key:

api_bearer_token: "YOUR_SECRET_BEARER_TOKEN"
Example cURL Commands
Public Price List (GET /api/v1/services — No Token Required):

curl -i http://localhost:3000/api/v1/services
Protected Repairs List (GET /api/v1/repairs — Requires Token):

curl -i -H "Authorization: Bearer YOUR_SECRET_BEARER_TOKEN" http://localhost:3000/api/v1/repairs