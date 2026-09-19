import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { CompanyQueryDto } from './dto/company-query.dto';
import { CreateCompanyDto } from './dto/create-company.dto';
import { UpdateCompanyDto } from './dto/update-company.dto';

@Injectable()
export class CompanyService {
  constructor(private readonly prisma: PrismaService) {}

  findAll(query: CompanyQueryDto) {
    const search = query.search?.trim();
    return this.prisma.company.findMany({
      where: {
        ...(query.active === undefined ? {} : { isActive: query.active }),
        ...(search
          ? { OR: [{ code: { contains: search, mode: 'insensitive' } }, { name: { contains: search, mode: 'insensitive' } }] }
          : {}),
      },
      orderBy: { name: 'asc' },
      include: { _count: { select: { departments: true } } },
    });
  }

  findOne(id: number) {
    return this.prisma.company.findUniqueOrThrow({
      where: { id },
      include: { departments: { orderBy: { name: 'asc' } } },
    }).catch(() => {
      throw new NotFoundException(`Company ${id} was not found`);
    });
  }

  create(data: CreateCompanyDto) {
    return this.prisma.company.create({ data });
  }

  update(id: number, data: UpdateCompanyDto) {
    return this.prisma.company.update({ where: { id }, data }).catch(() => {
      throw new NotFoundException(`Company ${id} was not found`);
    });
  }

  remove(id: number) {
    return this.prisma.company.update({ where: { id }, data: { isActive: false } }).catch(() => {
      throw new NotFoundException(`Company ${id} was not found`);
    });
  }
}
