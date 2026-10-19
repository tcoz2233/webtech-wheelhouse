# Webtech Wheelhouse — Workshop Management System

Wheelhouse is a Ruby on Rails application for managing bike repairs, customers, mechanics, and services. It provides both a web UI and a versioned JSON API (`/api/v1`) for external integration.

## Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/tcoz2233/webtech-wheelhouse.git](https://github.com/tcoz2233/webtech-wheelhouse.git)
   cd webtech-wheelhouse
Install dependencies and setup database:

Bash
bundle install
bin/rails db:prepare
# or for a full seed reset:
bin/rails db:reset
Start the development server:

Bash
bin/rails server
Access the web application at http://localhost:3000.

Lab 10: API Integration & Setup
The application provides a versioned JSON API under /api/v1.

API Base URL: Runs locally on port 3000 (http://localhost:3000/api/v1).

Setting Up the API Token
Protected API endpoints require an HTTP Bearer Token stored in Rails encrypted credentials.

Open the credentials editor:

Bash
EDITOR="nano" bundle exec rails credentials:edit
Add the token key:

YAML
api_bearer_token: "YOUR_SECRET_BEARER_TOKEN"
Example cURL Commands
Public Price List (GET /api/v1/services — No Token Required):

Bash
curl -i http://localhost:3000/api/v1/services
Protected Repairs List (GET /api/v1/repairs — Requires Token):

Bash
curl -i -H "Authorization: Bearer YOUR_SECRET_BEARER_TOKEN" http://localhost:3000/api/v1/repairs