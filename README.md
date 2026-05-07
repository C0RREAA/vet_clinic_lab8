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

## Running tests

```bash
bin/rails test
```

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
