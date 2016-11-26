# Blog

[![wercker status](https://app.wercker.com/status/a05e6eacc8d687b706137654d2e99369/s/master "wercker status")](https://app.wercker.com/project/byKey/a05e6eacc8d687b706137654d2e99369)

## Setup

```
bundle install --without production
```

```
npm install
```

## Generate assets

```
npm run build
```

## Generate schema and API document

- JSON Schema

```
bundle exec rake schema:dump > docs/schema.json
```

- API Document

```
bundle exec rake schema:doc > docs/schema.md
```

## DB Create/Migration

- DB Create

```
bundle exec rake db:create
```

- DB Migration

```
bundle exec rake db:migrate
```

## Run server

```
JWT_SECRET="yoursecret" JWT_ISSUER="blog.topotal.com"  bundle exec rackup
```

## Run test

```
bundle exec rake spec
```
