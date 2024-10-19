# distroless-nodejs


## Usage

```dockerfile
FROM node:18-slim AS builder

WORKDIR /app

COPY package*.json ./

COPY . .

RUN yarn install


FROM pmoscode/nodejs-18-debug:dev

COPY --chown=nonroot:nonroot --from=builder /app/ ./

CMD [ "app.js" ]
```

# Configuration

## Default

| property             | value             |
|----------------------|-------------------|
| default user / group | nonroot / nonroot |
| working dir          | /app              |
| arch                 | amd64 / arm64     |

## Additional

| property   | value         |
|------------|---------------|
| entrypoint | /usr/bin/node |

## Used packages

- wolfi-base (for debug variant)
- wolfi-baselayout (for nondebug variant)
- nodejs-[18|19|20|21|22]

## Image versioning

| name     | description                     | purpose                           |
|----------|---------------------------------|-----------------------------------|
| "dev"    | Triggered by push or manual run | current development version       |
| "nighly" | Triggered by scheduled run      | Always the latest libs (Wolfi OS) |
| semver   | Triggered by Git tag            | Fixed version (may be outdated)   |
