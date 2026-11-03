# Webtech Wheelhouse — Workshop Management System

Wheelhouse is a Ruby on Rails application for managing bike repairs, customers, mechanics and
services. It has a web UI, with accounts and roles (Lab 11) and authorization with Pundit (Lab 12),
and a versioned JSON API under `/api/v1`.

## Requirements

* Ruby **3.2.0** (see `.ruby-version`)
* PostgreSQL, running locally and accepting connections from your user
* Node.js 18+ and npm (the CSS is built with Sass and Bootstrap)

## Get it running

```bash
git clone https://github.com/tcoz2233/webtech-wheelhouse.git
cd webtech-wheelhouse

bundle install                 # Ruby gems
npm install                    # Bootstrap and Sass

bin/rails db:prepare           # creates the database and loads the schema
bin/rails db:seed              # demo data and accounts (safe to run again)

bin/dev                        # starts the server and the CSS build
```

Open <http://localhost:3000> and sign in with one of the accounts below.

To start again from an empty database: `bin/rails db:reset`.

## Seed accounts

Every account is created by `bin/rails db:seed`. What each role may do is written, action by action,
in [docs/permissions.md](docs/permissions.md).

| Account | Password | Role | What it can do |
|---------|----------|------|----------------|
| `owner@wheelhouse.cl` | `passwordowner123` | Owner | Everything: all repairs (also handed-back ones), customers, bikes, the price list and the staff. See [permissions](docs/permissions.md). |
| `counter@wheelhouse.cl` | `passwordcounter123` | Counter | Takes bikes in and talks to customers: creates, edits and reads customers, bikes and repairs (a handed-back repair only the owner edits); reads services and staff; deletes nothing. See [permissions](docs/permissions.md). |
| `mechanic1@wheelhouse.cl` | `passwordmechanic1` | Mechanic (Pedro) | Reads only the repairs assigned to Pedro and changes their state, diagnosis and photos while not handed back; reads services and staff; no access to customers or bikes. See [permissions](docs/permissions.md). |
| `mechanic2@wheelhouse.cl` | `passwordmechanic2` | Mechanic (Juan) | The same as `mechanic1`, on the repairs assigned to Juan. See [permissions](docs/permissions.md). |
| `orphan@wheelhouse.cl` | `passwordorphan123` | Counter, no staff member | The same as the counter; it belongs to no member of the staff. See [permissions](docs/permissions.md). |
| `orphan.mechanic@wheelhouse.cl` | `passwordorphanmech1` | Mechanic, no staff member | Has no repairs of its own, so it reads none; reads services and staff. See [permissions](docs/permissions.md). |

An account created from the sign-up page has the default role, Counter.

A visitor with no session can read the list and the page of the services, and nothing else.
A request that a role may not make answers `403`.

## Emails in development

Welcome and password-reset emails open in your browser (`letter_opener`), and the mailer previews
are at <http://localhost:3000/rails/mailers>.

## API

The API lives under `/api/v1` on the same port (3000). It is not affected by the roles.

* `GET /api/v1/services` — public price list, no token.
* `GET /api/v1/repairs` — needs the header `Authorization: Bearer <token>`.

The token is read from the encrypted credentials (`api_bearer_token`). The master key is not in the
repository, so on a fresh clone create your own credentials:

```bash
rm config/credentials.yml.enc
EDITOR="nano" bin/rails credentials:edit     # add:  api_bearer_token: "YOUR_SECRET_TOKEN"
```

```bash
curl -i http://localhost:3000/api/v1/services
curl -i -H "Authorization: Bearer YOUR_SECRET_TOKEN" http://localhost:3000/api/v1/repairs
```

## Checks

```bash
bin/rails test      # test suite
bin/brakeman        # security scan, no warnings expected
```