-- CreateTable
CREATE TABLE "acadmic_semester" (
    "id" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "startMonth" TEXT NOT NULL,
    "endMonth" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "acadmic_semester_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "acadmic_faculty" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "acadmic_faculty_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "acadmic_department" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "acadmicFacultyId" TEXT NOT NULL,

    CONSTRAINT "acadmic_department_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "students" (
    "id" TEXT NOT NULL,
    "studentId" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "middelName" TEXT NOT NULL,
    "profileImage" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "contactNo" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "bloodGroup" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "acadmicSemesterId" TEXT NOT NULL,
    "acadmicDepartmentId" TEXT,
    "acadmicFacultyId" TEXT,

    CONSTRAINT "students_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "faculties" (
    "id" TEXT NOT NULL,
    "facultyId" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "middelName" TEXT NOT NULL,
    "profileImage" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "contactNo" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "bloodGroup" TEXT NOT NULL,
    "designation" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "acadmicDepartmentId" TEXT,
    "acadmicFacultyId" TEXT,

    CONSTRAINT "faculties_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "acadmic_department" ADD CONSTRAINT "acadmic_department_acadmicFacultyId_fkey" FOREIGN KEY ("acadmicFacultyId") REFERENCES "acadmic_faculty"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_acadmicSemesterId_fkey" FOREIGN KEY ("acadmicSemesterId") REFERENCES "acadmic_semester"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_acadmicDepartmentId_fkey" FOREIGN KEY ("acadmicDepartmentId") REFERENCES "acadmic_department"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_acadmicFacultyId_fkey" FOREIGN KEY ("acadmicFacultyId") REFERENCES "acadmic_faculty"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "faculties" ADD CONSTRAINT "faculties_acadmicDepartmentId_fkey" FOREIGN KEY ("acadmicDepartmentId") REFERENCES "acadmic_department"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "faculties" ADD CONSTRAINT "faculties_acadmicFacultyId_fkey" FOREIGN KEY ("acadmicFacultyId") REFERENCES "acadmic_faculty"("id") ON DELETE SET NULL ON UPDATE CASCADE;
