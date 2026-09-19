import { Module } from '@nestjs/common';
import { CompanyController } from './company.controller';
import { CompanyService } from './company.service';
import { DepartmentController } from './department.controller';
import { DepartmentService } from './department.service';

@Module({
  controllers: [CompanyController, DepartmentController],
  providers: [CompanyService, DepartmentService],
})
export class OrgModule {}
