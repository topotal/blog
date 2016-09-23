# Topotal blog API v1
Topotal API v1 interface document written in JSON Hyper Schema draft v4

* [User object](#user-object)
  * [POST /api/v1/users/register](#post-apiv1usersregister)
  * [POST /api/v1/users/login](#post-apiv1userslogin)

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

