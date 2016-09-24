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

## Run server

```
bundle exec rackup
```
