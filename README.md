# hrsys-api

NestJS API foundation for the HR System rebuild.

## Commands

```powershell
npm install
npm run prisma:generate
npm run prisma:migrate:deploy
npm run prisma:seed
npm run start:dev
```

Health endpoint: `GET http://localhost:3000/api/v1/health`

The health endpoint runs `SELECT 1` through Prisma and reports the database result. PostgreSQL must be running with the values in `.env.example` (the root Docker Compose file provides those defaults).

Authentication is intentionally only a status stub at `GET /api/v1/auth/status`; login is scheduled for Day 7.

## Organization API

- `GET /api/v1/companies?search=lbc&active=true`
- `GET /api/v1/companies/:id`
- `POST /api/v1/companies`
- `PATCH /api/v1/companies/:id`
- `DELETE /api/v1/companies/:id` (soft-deactivates)
- `GET /api/v1/departments?companyId=1&search=operations&active=true`
- `GET /api/v1/departments/:id`
- `POST /api/v1/departments`
- `PATCH /api/v1/departments/:id`
- `DELETE /api/v1/departments/:id` (soft-deactivates)

## OpenAPI

The API uses the Nest 11-compatible Swagger package.

- Swagger UI: [http://localhost:3000/api/docs](http://localhost:3000/api/docs)
- OpenAPI JSON: [http://localhost:3000/api/docs-json](http://localhost:3000/api/docs-json)
