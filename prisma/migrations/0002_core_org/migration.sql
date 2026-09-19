CREATE TYPE "LookupType" AS ENUM ('TITLE', 'MARITAL', 'BLOOD', 'RELIGION', 'RACE', 'NATIONALITY');

CREATE TABLE "companies" (
  "id" SERIAL NOT NULL,
  "legacy_company_id" INTEGER,
  "code" VARCHAR(30) NOT NULL,
  "name" VARCHAR(200) NOT NULL,
  "address" VARCHAR(500),
  "etf_reg_no" VARCHAR(100),
  "sap_code" VARCHAR(50),
  "level_0_id" INTEGER,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "companies_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "companies_legacy_company_id_key" ON "companies"("legacy_company_id");
CREATE UNIQUE INDEX "companies_code_key" ON "companies"("code");

CREATE TABLE "departments" (
  "id" SERIAL NOT NULL,
  "company_id" INTEGER NOT NULL,
  "legacy_department_id" INTEGER,
  "code" VARCHAR(30) NOT NULL,
  "name" VARCHAR(200) NOT NULL,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "departments_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "departments_company_id_code_key" ON "departments"("company_id", "code");
CREATE INDEX "departments_company_id_name_idx" ON "departments"("company_id", "name");
ALTER TABLE "departments" ADD CONSTRAINT "departments_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE "divisions" (
  "id" SERIAL NOT NULL,
  "company_id" INTEGER NOT NULL,
  "code" VARCHAR(30) NOT NULL,
  "name" VARCHAR(200) NOT NULL,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "divisions_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "divisions_company_id_code_key" ON "divisions"("company_id", "code");
CREATE INDEX "divisions_company_id_name_idx" ON "divisions"("company_id", "name");

CREATE TABLE "sections" (
  "id" SERIAL NOT NULL,
  "company_id" INTEGER NOT NULL,
  "code" VARCHAR(30) NOT NULL,
  "name" VARCHAR(200) NOT NULL,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "sections_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "sections_company_id_code_key" ON "sections"("company_id", "code");
CREATE INDEX "sections_company_id_name_idx" ON "sections"("company_id", "name");

CREATE TABLE "branches" (
  "id" SERIAL NOT NULL,
  "company_id" INTEGER NOT NULL,
  "code" VARCHAR(30) NOT NULL,
  "name" VARCHAR(200) NOT NULL,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "branches_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "branches_company_id_code_key" ON "branches"("company_id", "code");
CREATE INDEX "branches_company_id_name_idx" ON "branches"("company_id", "name");

CREATE TABLE "floors" (
  "id" SERIAL NOT NULL,
  "company_id" INTEGER NOT NULL,
  "code" VARCHAR(30) NOT NULL,
  "name" VARCHAR(200) NOT NULL,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "floors_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "floors_company_id_code_key" ON "floors"("company_id", "code");
CREATE INDEX "floors_company_id_name_idx" ON "floors"("company_id", "name");

CREATE TABLE "job_categories" (
  "id" SERIAL NOT NULL,
  "company_id" INTEGER NOT NULL,
  "code" VARCHAR(30) NOT NULL,
  "name" VARCHAR(200) NOT NULL,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "job_categories_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "job_categories_company_id_code_key" ON "job_categories"("company_id", "code");
CREATE INDEX "job_categories_company_id_name_idx" ON "job_categories"("company_id", "name");

CREATE TABLE "designations" (
  "id" SERIAL NOT NULL,
  "company_id" INTEGER NOT NULL,
  "code" VARCHAR(30) NOT NULL,
  "name" VARCHAR(200) NOT NULL,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "designations_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "designations_company_id_code_key" ON "designations"("company_id", "code");
CREATE INDEX "designations_company_id_name_idx" ON "designations"("company_id", "name");

CREATE TABLE "employment_types" (
  "id" SERIAL NOT NULL,
  "company_id" INTEGER NOT NULL,
  "code" VARCHAR(30) NOT NULL,
  "name" VARCHAR(200) NOT NULL,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "employment_types_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "employment_types_company_id_code_key" ON "employment_types"("company_id", "code");
CREATE INDEX "employment_types_company_id_name_idx" ON "employment_types"("company_id", "name");

CREATE TABLE "countries" (
  "id" SERIAL NOT NULL,
  "code" VARCHAR(10) NOT NULL,
  "name" VARCHAR(150) NOT NULL,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "countries_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "countries_code_key" ON "countries"("code");
CREATE UNIQUE INDEX "countries_name_key" ON "countries"("name");

CREATE TABLE "lookups" (
  "id" SERIAL NOT NULL,
  "type" "LookupType" NOT NULL,
  "code" VARCHAR(30) NOT NULL,
  "label" VARCHAR(150) NOT NULL,
  "sort_order" INTEGER NOT NULL DEFAULT 0,
  "is_active" BOOLEAN NOT NULL DEFAULT true,
  "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT "lookups_pkey" PRIMARY KEY ("id")
);
CREATE UNIQUE INDEX "lookups_type_code_key" ON "lookups"("type", "code");
CREATE INDEX "lookups_type_label_idx" ON "lookups"("type", "label");
