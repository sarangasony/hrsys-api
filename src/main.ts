import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { Request, Response } from 'express';
import { AppModule } from './app.module';
import { HttpExceptionFilter } from './common/filters/http-exception.filter';
import { AppLogger } from './common/logger/app.logger';

async function bootstrap() {
  const logger = new AppLogger();
  const app = await NestFactory.create(AppModule, { logger });
  app.setGlobalPrefix('api/v1');
  app.enableCors({ origin: process.env.CORS_ORIGIN ?? 'http://localhost:4200' });
  app.useGlobalPipes(new ValidationPipe({ whitelist: true, transform: true }));
  app.useGlobalFilters(new HttpExceptionFilter(logger));
  app.getHttpAdapter().get('/', (_request: Request, response: Response) => {
    response.json({ service: 'hrsys-api', status: 'ok', api: '/api/v1' });
  });
  app.getHttpAdapter().get('/favicon.ico', (_request: Request, response: Response) => {
    response.status(204).send();
  });
  await app.listen(process.env.PORT ?? 3000);
}

void bootstrap();
