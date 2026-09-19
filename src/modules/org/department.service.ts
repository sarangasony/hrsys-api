import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../../prisma/prisma.service';
import { CreateDepartmentDto } from './dto/create-department.dto';
import { DepartmentQueryDto } from './dto/department-query.dto';
import { UpdateDepartmentDto } from './dto/update-department.dto';

@Injectable()
export class DepartmentService {
  constructor(private readonly prisma: PrismaService) {}

  findAll(query: DepartmentQueryDto) {
    const search = query.search?.trim();
    return this.prisma.department.findMany({
      where: {
        ...(query.companyId === undefined ? {} : { companyId: query.companyId }),
        ...(query.active === undefined ? {} : { isActive: query.active }),
        ...(search
          ? { OR: [{ code: { contains: search, mode: 'insensitive' } }, { name: { contains: search, mode: 'insensitive' } }] }
          : {}),
      },
      orderBy: { name: 'asc' },
      include: { company: { select: { id: true, code: true, name: true } } },
    });
  }

  findOne(id: number) {
    return this.prisma.department.findUniqueOrThrow({
      where: { id },
      include: { company: { select: { id: true, code: true, name: true } } },
    }).catch(() => {
      throw new NotFoundException(`Department ${id} was not found`);
    });
  }

  create(data: CreateDepartmentDto) {
    return this.prisma.department.create({ data });
  }

  update(id: number, data: UpdateDepartmentDto) {
    return this.prisma.department.update({ where: { id }, data }).catch(() => {
      throw new NotFoundException(`Department ${id} was not found`);
    });
  }

  remove(id: number) {
    return this.prisma.department.update({ where: { id }, data: { isActive: false } }).catch(() => {
      throw new NotFoundException(`Department ${id} was not found`);
    });
  }
}
