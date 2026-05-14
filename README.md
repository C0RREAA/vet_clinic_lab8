# VetClinic

A small Ruby on Rails application for managing a veterinary clinic — owners,
their pets, vets, appointments and treatments — built across a series of labs
for UANDES.

## Stack

- Ruby 3.2.2
- Rails 8.1.3
- PostgreSQL
- Bootstrap 5.3 (via CDN)
- Active Storage (pet photos, with image variants via libvips)
- Action Text / Trix (treatment clinical notes)
- Devise (authentication, with role enum)

## System dependencies

### libvips (required)

Pet photo thumbnails are generated through Active Storage variants, which
the `image_processing` gem performs against **libvips**. Without libvips
installed system-wide the image variant calls fail at runtime.

On macOS with Homebrew:

```bash
brew install vips
```

Verify:

```bash
which vips
```

### PostgreSQL

```bash
brew services start postgresql@16
```

If you hit encoding issues creating the dev DB on macOS, use:

```bash
psql -U Pancho -d postgres -c "CREATE DATABASE vet_clinic_development TEMPLATE template0 ENCODING 'UTF8';"
```

## Setup

```bash
bundle install
bin/rails db:setup     # creates DB, loads schema, runs seeds
bin/rails server
```

Then open http://localhost:3000.

## Troubleshooting

### PostgreSQL encoding issue (SQL_ASCII clusters)

If `bin/rails db:create` fails with

```
new encoding (UTF8) is incompatible with the encoding of the template database (SQL_ASCII)
```

create the databases manually using `template0`:

```bash
psql -d postgres <<'SQL'
CREATE DATABASE vet_clinic_development ENCODING 'UTF8' TEMPLATE template0;
CREATE DATABASE vet_clinic_test        ENCODING 'UTF8' TEMPLATE template0;
SQL
bin/rails db:migrate db:seed
```

## Running tests

```bash
bin/rails test
```

## Authentication

Every page except the public landing (the root route, `owners#index`) is
behind a Devise login. Hitting `/pets`, `/vets`, `/appointments`,
`/owners/:id` (etc.) while signed out redirects to `/users/sign_in`.

### Seeded credentials

| Email                  | Password      | Role  |
| ---------------------- | ------------- | ----- |
| `admin@vetclinic.com`  | `password123` | admin |
| `vet@vetclinic.com`    | `password123` | vet   |
| `owner@vetclinic.com`  | `password123` | owner |

Users are created with `find_or_create_by` so `db:seed` can be re-run
without errors.

### Role is server-controlled

The `role` attribute exists on `User` (enum: `owner` / `vet` / `admin`) but
is **not** included in the Devise sign-up or account-edit permitted
parameters. Even if a malicious POST tries to set `user[role]=admin`, Rails'
strong-parameter filtering drops it before assignment. To promote a user,
edit the record from `rails console` or update the seed file.

## Trix sanitization check

Action Text uses Trix and runs incoming HTML through Rails' sanitizer before
rendering. As a quick smoke test, paste the following into a treatment's
clinical-notes field through the UI:

```html
<script>alert(1)</script>
```

When the appointment page is reloaded the `<script>` tag is stripped — the
text is shown as plain content and **no alert fires**. The same goes for
inline event handlers (`onerror=`, `onclick=` …) and `javascript:` URLs.

## Notable lab milestones

- **Lab 3** — initial models, validations, schema.
- **Lab 4** — Bootstrap layout, navbar, index/show views.
- **Lab 5** — enums, scopes, callbacks, eager loading, flash messages.
- **Lab 6** — full CRUD across all resources, nested treatments, error
  partial with `is-invalid` Bootstrap styling.
- **Lab 7** — Active Storage for pet photos (with size/MIME validation and
  thumbnail variants) and Action Text for rich clinical notes on treatments.
- **Lab 8** — Devise authentication: protected resource pages, sign-in /
  sign-up / account-edit views styled to match the rest of the app, a `role`
  enum that the user-facing forms can't touch, and three seeded accounts
  (admin, vet, owner) for quick login testing.
