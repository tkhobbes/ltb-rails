# LTB-Rails

LTB-Rails ("Lustige Taschenbücher on Rails") is an application that lets you manage your collection of Lustige Taschenbücher (LTB) and other Disney comics.

It can store stories and their artists (drawings, text) as well as the publications in which the stories appeared. Data can be scraped from [inducks.org](https://inducks.org).

The main purpose of the application is to enable printouts of little "inlay" papers that detail stories in any given publication and their authors. The original idea was conceived because the authors, pencillers and drawers of the stories are not given credit in the LTBs themselves.

# Installation

## Prerequisites

### Ruby Version

The app was developed using Ruby 3.2.1. I don't think it uses anything particular to that version, so I assume that any version >=3 works fine.

### Rails Version

The app was developed using Rails 7.0.4 with jsbundling-rails, css-bundling-rails (and CSS Framework Bulma), and Propshaft. It will NOT work on Rails <7.

### Database

The app uses a PostgreSQL database.

### Environment Variables

The following environment variables are used:

#### PostgreSQL configuration

- POSTGRESQL_DEV_PORT
- POSTGRESQL_DEV_PASSWORD
- POSTGRESQL_DEV_USER

## Installation steps

There are no special installation steps required at this point. Just clone the repository and set it up as any other Rails app.

# Dependencies used

## Gems

- Countries
- Country-Select
- i18n-Country-Translations
- Pagy
- Devise
- Down

## Javascript

- Bulma-extensions

## Other

# Testing

For testing, RSpec with FactoryBot and Faker is used.

# Credits

## ENUM translations

Found a solution here: https://www.kostolansky.sk/posts/localize-rails-enums
