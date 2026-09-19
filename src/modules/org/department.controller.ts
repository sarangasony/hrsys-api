import { Body, Controller, Delete, Get, Param, ParseIntPipe, Patch, Post, Query } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { DepartmentService } from './department.service';
import { CreateDepartmentDto } from './dto/create-department.dto';
import { DepartmentQueryDto } from './dto/department-query.dto';
import { UpdateDepartmentDto } from './dto/update-department.dto';

@ApiTags('departments')
@Controller('departments')
export class DepartmentController {
  constructor(private readonly service: DepartmentService) {}

  @Get()
  findAll(@Query() query: DepartmentQueryDto) { return this.service.findAll(query); }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) { return this.service.findOne(id); }

  @Post()
  create(@Body() body: CreateDepartmentDto) { return this.service.create(body); }

  @Patch(':id')
  update(@Param('id', ParseIntPipe) id: number, @Body() body: UpdateDepartmentDto) { return this.service.update(id, body); }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) { return this.service.remove(id); }
}
