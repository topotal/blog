# Topotal blog API v1
Topotal API v1 interface document written in JSON Hyper Schema draft v4

* [Entry object](#entry-object)
  * [GET /api/v1/entries](#get-apiv1entries)
  * [GET /api/v1/entries/:id](#get-apiv1entriesid)
  * [POST /api/v1/entries](#post-apiv1entries)
  * [POST /api/v1/entries/:id](#post-apiv1entriesid)
  * [DELETE /api/v1/entries/:id](#delete-apiv1entriesid)
* [Image object](#image-object)
  * [GET /api/v1/images](#get-apiv1images)
  * [GET /api/v1/images/:id](#get-apiv1imagesid)
  * [POST /api/v1/images](#post-apiv1images)
  * [POST /api/v1/images/:id](#post-apiv1imagesid)
  * [DELETE /api/v1/images/:id](#delete-apiv1imagesid)
* [User object](#user-object)
  * [POST /api/v1/users/register](#post-apiv1usersregister)
  * [POST /api/v1/users/login](#post-apiv1userslogin)
* [UserProfile object](#userprofile-object)
  * [GET /api/v1/user_profiles](#get-apiv1user_profiles)
  * [POST /api/v1/user_profiles](#post-apiv1user_profiles)
  * [PATCH /api/v1/user_profiles](#patch-apiv1user_profiles)

## Entry object
A entry object of topotal blog. All APIs requirements token with `Authorization: Bearer` HTTP header.

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
* eye_catch_image_url
  * Entry eye-catching image url
  * Example: `"Awesome blog entry eye-catching image url"`
  * Type: string
* created_at
  * Entry created at
  * Example: `"2012-07-26T01:00:00+09:00"`
  * Type: string
  * Format: date-time
* updated_at
  * Entry updated at
  * Example: `"2012-07-26T01:00:00+09:00"`
  * Type: string
  * Format: date-time
* publish_date
  * Entry publish time
  * Example: `"2012-07-26T01:00:00+09:00"`
  * Type: string
  * Format: date-time
* published
  * Entry is published
  * Example: `true`
  * Type: boolean
* author
  * Entry author name
  * Example: `"topotan"`
  * Type: string

### GET /api/v1/entries
List exisiting entries

* page
  * Example: `1`
  * Type: string
  * Pattern: `/[0-9]+/`

```
GET /api/v1/entries?page=1 HTTP/1.1
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
    "eye_catch_image_url": "Awesome blog entry eye-catching image url",
    "created_at": "2012-07-26T01:00:00+09:00",
    "updated_at": "2012-07-26T01:00:00+09:00",
    "publish_date": "2012-07-26T01:00:00+09:00",
    "published": true,
    "author": "topotan"
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
  "eye_catch_image_url": "Awesome blog entry eye-catching image url",
  "created_at": "2012-07-26T01:00:00+09:00",
  "updated_at": "2012-07-26T01:00:00+09:00",
  "publish_date": "2012-07-26T01:00:00+09:00",
  "published": true,
  "author": "topotan"
}
```

### POST /api/v1/entries
Create a new entry

* title
  * Example: `"Awesome blog title"`
  * Type: string
* eye_catch_image_url
  * Example: `"Awesome blog eye-catching image url"`
  * Type: string
* content
  * Example: `"Awesome blog content written in markdown"`
  * Type: string
* publish_date
  * Example: `"2012-07-26T01:00:00+09:00"`
* published
  * Example: `"true"`
  * Type: boolean

```
POST /api/v1/entries HTTP/1.1
Content-Type: application/json
Host: api.example.com

{
  "title": "Awesome blog title",
  "eye_catch_image_url": "Awesome blog eye-catching image url",
  "content": "Awesome blog content written in markdown",
  "publish_date": "2012-07-26T01:00:00+09:00",
  "published": "true"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "title": "Blog title",
  "content": "Awesome blog content written in markdown",
  "eye_catch_image_url": "Awesome blog entry eye-catching image url",
  "created_at": "2012-07-26T01:00:00+09:00",
  "updated_at": "2012-07-26T01:00:00+09:00",
  "publish_date": "2012-07-26T01:00:00+09:00",
  "published": true,
  "author": "topotan"
}
```

### POST /api/v1/entries/:id
Update an exisiting entry

* title
  * Example: `"Awesome blog title"`
  * Type: string
* eye_catch_image_url
  * Example: `"Awesome blog eye-catching image url"`
  * Type: string
* content
  * Example: `"Awesome blog content written in markdown"`
  * Type: string
* publish_date
  * Example: `"2012-07-26T01:00:00+09:00"`
* published
  * Example: `"true"`
  * Type: boolean

```
POST /api/v1/entries/:id HTTP/1.1
Content-Type: application/json
Host: api.example.com

{
  "title": "Awesome blog title",
  "eye_catch_image_url": "Awesome blog eye-catching image url",
  "content": "Awesome blog content written in markdown",
  "publish_date": "2012-07-26T01:00:00+09:00",
  "published": "true"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "title": "Blog title",
  "content": "Awesome blog content written in markdown",
  "eye_catch_image_url": "Awesome blog entry eye-catching image url",
  "created_at": "2012-07-26T01:00:00+09:00",
  "updated_at": "2012-07-26T01:00:00+09:00",
  "publish_date": "2012-07-26T01:00:00+09:00",
  "published": true,
  "author": "topotan"
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
  "eye_catch_image_url": "Awesome blog entry eye-catching image url",
  "created_at": "2012-07-26T01:00:00+09:00",
  "updated_at": "2012-07-26T01:00:00+09:00",
  "publish_date": "2012-07-26T01:00:00+09:00",
  "published": true,
  "author": "topotan"
}
```

## Image object
A image object of topotal blog. All APIs requirements token with `Authorization: Bearer` HTTP header.

### Properties
* id
  * image id
  * Example: `1`
  * Type: integer
* url
  * Image url path
  * Example: `"attachments/34729b87cd54/store/aa08886e1e3/image.jpeg"`
  * Type: string
* image_id
  * image data id
  * Example: `"8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9"`
  * Type: string
* image_content_type
  * Image content type
  * Example: `"image/jpeg"`
  * Type: string

### GET /api/v1/images
List exisiting images

* page
  * Example: `1`
  * Type: string
  * Pattern: `/[0-9]+/`

```
GET /api/v1/images?page=1 HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 1,
    "url": "attachments/34729b87cd54/store/aa08886e1e3/image.jpeg",
    "image_id": "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9",
    "image_content_type": "image/jpeg"
  }
]
```

### GET /api/v1/images/:id
Information an exisiting image find by id

```
GET /api/v1/images/:id HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "url": "attachments/34729b87cd54/store/aa08886e1e3/image.jpeg",
  "image_id": "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9",
  "image_content_type": "image/jpeg"
}
```

### POST /api/v1/images
Create a new image

* content
  * Example: `"data:image/jpeg;base64,base64encodedstring......"`
  * Type: string

```
POST /api/v1/images HTTP/1.1
Content-Type: application/json
Host: api.example.com

{
  "content": "data:image/jpeg;base64,base64encodedstring......"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "url": "attachments/34729b87cd54/store/aa08886e1e3/image.jpeg",
  "image_id": "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9",
  "image_content_type": "image/jpeg"
}
```

### POST /api/v1/images/:id
Update an exisiting image

* content
  * Example: `"data:image/jpeg;base64,base64encodedstring......"`
  * Type: string

```
POST /api/v1/images/:id HTTP/1.1
Content-Type: application/json
Host: api.example.com

{
  "content": "data:image/jpeg;base64,base64encodedstring......"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "url": "attachments/34729b87cd54/store/aa08886e1e3/image.jpeg",
  "image_id": "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9",
  "image_content_type": "image/jpeg"
}
```

### DELETE /api/v1/images/:id
Delete an exisiting image

```
DELETE /api/v1/images/:id HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "url": "attachments/34729b87cd54/store/aa08886e1e3/image.jpeg",
  "image_id": "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9",
  "image_content_type": "image/jpeg"
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

### POST /api/v1/users/register
User registration

* name
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
  "name": "topotan",
  "password": "p@ssw0rd"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "token": "secret.token.issued-by-topotal"
}
```

### POST /api/v1/users/login
User information if authenticate

* name
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
  "name": "topotan",
  "password": "p@ssw0rd"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "token": "secret.token.issued-by-topotal"
}
```

## UserProfile object
A user profile object for topotal blog

### Properties
* id
  * User profile id
  * Example: `1`
  * Type: integer
* screen_name
  * Screen name
  * Example: `"Topotan da Silva Santos Júnior"`
  * Type: string
* description
  * User description
  * Example: `"Topotan"`
  * Type: string
* image_url
  * Image url path
  * Example: `"attachments/34729b87cd54/store/aa08886e1e3/image.jpeg"`
  * Type: string
* image_id
  * Image id
  * Example: `"8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9"`
  * Type: string
* image_content_type
  * Image content type
  * Example: `"image/jpeg"`
  * Type: string

### GET /api/v1/user_profiles
A user profile

```
GET /api/v1/user_profiles HTTP/1.1
Host: api.example.com
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "screen_name": "Topotan da Silva Santos Júnior",
  "description": "Topotan",
  "image_url": "attachments/34729b87cd54/store/aa08886e1e3/image.jpeg",
  "image_id": "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9",
  "image_content_type": "image/jpeg"
}
```

### POST /api/v1/user_profiles
User profile registration

* screen_name
  * Example: `"Topotan da Silva Santos Júnior"`
  * Type: string
* description
  * Example: `"Super awesome bot"`
  * Type: string
* content
  * Example: `"data:image/jpeg;base64,base64encodedstring......"`
  * Type: string

```
POST /api/v1/user_profiles HTTP/1.1
Content-Type: application/json
Host: api.example.com

{
  "screen_name": "Topotan da Silva Santos Júnior",
  "description": "Super awesome bot",
  "content": "data:image/jpeg;base64,base64encodedstring......"
}
```

```
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "screen_name": "Topotan da Silva Santos Júnior",
  "description": "Topotan",
  "image_url": "attachments/34729b87cd54/store/aa08886e1e3/image.jpeg",
  "image_id": "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9",
  "image_content_type": "image/jpeg"
}
```

### PATCH /api/v1/user_profiles
User profile update

* screen_name
  * Example: `"Topotan da Silva Santos Júnior"`
  * Type: string
* description
  * Example: `"Super awesome bot"`
  * Type: string
* content
  * Example: `"data:image/jpeg;base64,base64encodedstring......"`
  * Type: string

```
PATCH /api/v1/user_profiles HTTP/1.1
Content-Type: application/json
Host: api.example.com

{
  "screen_name": "Topotan da Silva Santos Júnior",
  "description": "Super awesome bot",
  "content": "data:image/jpeg;base64,base64encodedstring......"
}
```

```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "screen_name": "Topotan da Silva Santos Júnior",
  "description": "Topotan",
  "image_url": "attachments/34729b87cd54/store/aa08886e1e3/image.jpeg",
  "image_id": "8eb279187aba5d5196e40661e0833c777a69f6443f2aed5ae7056201abf9",
  "image_content_type": "image/jpeg"
}
```

