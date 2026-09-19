import { IsBoolean, IsInt, IsOptional, IsString, MaxLength } from 'class-validator';

export class CreateDepartmentDto {
  @IsInt()
  companyId!: number;

  @IsString()
  @MaxLength(30)
  code!: string;

  @IsString()
  @MaxLength(200)
  name!: string;

  @IsOptional()
  @IsInt()
  legacyDepartmentId?: number;

  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}
