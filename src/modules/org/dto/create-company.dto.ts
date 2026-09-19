import { IsBoolean, IsInt, IsOptional, IsString, MaxLength } from 'class-validator';

export class CreateCompanyDto {
  @IsString()
  @MaxLength(30)
  code!: string;

  @IsString()
  @MaxLength(200)
  name!: string;

  @IsOptional()
  @IsInt()
  legacyCompanyId?: number;

  @IsOptional()
  @IsString()
  @MaxLength(500)
  address?: string;

  @IsOptional()
  @IsString()
  @MaxLength(100)
  etfRegNo?: string;

  @IsOptional()
  @IsString()
  @MaxLength(50)
  sapCode?: string;

  @IsOptional()
  @IsBoolean()
  isActive?: boolean;
}
