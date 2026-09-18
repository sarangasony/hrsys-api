# hrsys-api

NestJS API foundation for the HR System rebuild.

## Commands

```powershell
npm install
npm run prisma:generate
npm run prisma:migrate:deploy
npm run start:dev
```

Health endpoint: `GET http://localhost:3000/api/v1/health`

The health endpoint runs `SELECT 1` through Prisma and reports the database result. PostgreSQL must be running with the values in `.env.example` (the root Docker Compose file provides those defaults).

Authentication is intentionally only a status stub at `GET /api/v1/auth/status`; login is scheduled for Day 7.
