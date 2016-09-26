# Topotal blog API v1
Topotal API v1 interface document written in JSON Hyper Schema draft v4

* [Entry object](#entry-object)
  * [GET /api/v1/entries/](#get-apiv1entries)
  * [GET /api/v1/entries/:id](#get-apiv1entriesid)
  * [POST /api/v1/entries/](#post-apiv1entries)
  * [POST /api/v1/entries/:id](#post-apiv1entriesid)
  * [DELETE /api/v1/entries/:id](#delete-apiv1entriesid)
* [User object](#user-object)
  * [POST /api/v1/users/register](#post-apiv1usersregister)
  * [POST /api/v1/users/login](#post-apiv1userslogin)

## Entry object
A entry object of topotal blog

### Properties
* id
  * Entry id
  * Example: `1`
  * Type: integer
* title
  * Entry title
  * Example: `"Blog title"`
  * Type: string
* content
  * Entry content
  * Example: `"Awesome blog content written in markdown"`
  * Type: string
* eye_catching
  * Entry eye catching
  * Example: `"Awesome blog entry eye catching"`
  * Type: string
* created_at
  * Entry created at
  * Example: `"2012-07-26 01:00:00.000+09:00"`
  * Type: string
  * Format: date-time
* updated_at
  * Entry updated at
  * Example: `"2012-07-26 01:00:00.000+09:00"`
  * Type: string
  * Format: date-time
* publish_date
  * Entry publish time
  * Example: `"2012-07-26 01:00:00.000+09:00"`
  * Type: string
  * Format: date-time

### GET /api/v1/entries/
List exisiting entries

```
GET /api/v1/entries/ HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 1,
    "title": "Blog title",
    "content": "Awesome blog content written in markdown",
    "eye_catching": "Awesome blog entry eye catching",
    "created_at": "2012-07-26 01:00:00.000+09:00",
    "updated_at": "2012-07-26 01:00:00.000+09:00",
    "publish_date": "2012-07-26 01:00:00.000+09:00"
  }
]
```

### GET /api/v1/entries/:id
Information an exisiting entry find by id

```
GET /api/v1/entries/:id HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "title": "Blog title",
  "content": "Awesome blog content written in markdown",
  "eye_catching": "Awesome blog entry eye catching",
  "created_at": "2012-07-26 01:00:00.000+09:00",
  "updated_at": "2012-07-26 01:00:00.000+09:00",
  "publish_date": "2012-07-26 01:00:00.000+09:00"
}
```

### POST /api/v1/entries/
Create a new entry

```
POST /api/v1/entries/ HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "title": "Blog title",
  "content": "Awesome blog content written in markdown",
  "eye_catching": "Awesome blog entry eye catching",
  "created_at": "2012-07-26 01:00:00.000+09:00",
  "updated_at": "2012-07-26 01:00:00.000+09:00",
  "publish_date": "2012-07-26 01:00:00.000+09:00"
}
```

### POST /api/v1/entries/:id
Update an exisiting entry

```
POST /api/v1/entries/:id HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "title": "Blog title",
  "content": "Awesome blog content written in markdown",
  "eye_catching": "Awesome blog entry eye catching",
  "created_at": "2012-07-26 01:00:00.000+09:00",
  "updated_at": "2012-07-26 01:00:00.000+09:00",
  "publish_date": "2012-07-26 01:00:00.000+09:00"
}
```

### DELETE /api/v1/entries/:id
Delete an exisiting entry

```
DELETE /api/v1/entries/:id HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "title": "Blog title",
  "content": "Awesome blog content written in markdown",
  "eye_catching": "Awesome blog entry eye catching",
  "created_at": "2012-07-26 01:00:00.000+09:00",
  "updated_at": "2012-07-26 01:00:00.000+09:00",
  "publish_date": "2012-07-26 01:00:00.000+09:00"
}
```

## User object
A user object for topotal blog

### Properties
* id
  * User id
  * Example: `1`
  * Type: integer
* name
  * User name
  * Example: `"topotan"`
  * Type: string
* access_key
  * Example: `"5bf74f334a53a6636229"`
  * Type: string
  * Pattern: `/[a-z0-9]{10}/`
* access_secret_key
  * Example: `"9bf31d7c631aabf3ed72"`
  * Type: string
  * Pattern: `/[a-z0-9]{10}/`

### POST /api/v1/users/register
User registration

* username
  * Example: `"topotan"`
  * Type: string
* password
  * Example: `"p@ssw0rd"`
  * Type: string

```
POST /api/v1/users/register HTTP/1.1
Content-Type: application/json
Host: api.example.com

{
  "username": "topotan",
  "password": "p@ssw0rd"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "name": "topotan",
  "access_key": "5bf74f334a53a6636229",
  "access_secret_key": "9bf31d7c631aabf3ed72"
}
```

### POST /api/v1/users/login
User information if authenticate

* username
  * Example: `"topotan"`
  * Type: string
* password
  * Example: `"p@ssw0rd"`
  * Type: string

```
POST /api/v1/users/login HTTP/1.1
Content-Type: application/json
Host: api.example.com

{
  "username": "topotan",
  "password": "p@ssw0rd"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "name": "topotan",
  "access_key": "5bf74f334a53a6636229",
  "access_secret_key": "9bf31d7c631aabf3ed72"
}
```

