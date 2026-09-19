import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  await prisma.company.upsert({
    where: { code: 'LBC' },
    update: {
      name: 'Lebanon Chef',
      legacyCompanyId: 1,
      address: 'Manual Day 4 seed from SQL Server extract',
      isActive: true,
    },
    create: {
      code: 'LBC',
      name: 'Lebanon Chef',
      legacyCompanyId: 1,
      address: 'Manual Day 4 seed from SQL Server extract',
    },
  });
}

main()
  .finally(async () => {
    await prisma.$disconnect();
  });
