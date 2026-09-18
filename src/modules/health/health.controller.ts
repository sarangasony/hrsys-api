import { Controller, Get } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';

@Controller('health')
export class HealthController {
  constructor(private readonly prisma: PrismaService) {}

  @Get()
  async getHealth() {
    const result = await this.prisma.$queryRaw<{ result: number }[]>`SELECT 1 AS result`;

    return {
      status: 'ok',
      service: 'hrsys-api',
      database: { connected: result[0]?.result === 1, result: result[0]?.result },
      timestamp: new Date().toISOString(),
    };
  }
}
