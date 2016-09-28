# Blog

## Setup

```
bundle install
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
