import { AcademicSemester, Prisma } from '@prisma/client';
import { paginationHelpers } from '../../../helpers/paginationHelper';
import { IGenericResponse } from '../../../interfaces/common';
import { IPaginationOptions } from '../../../interfaces/pagination';
import prisma from '../../../shared/prisma';
import { AcademicSemesterSearchAbleFiled } from './academicSemester.constant';
import { IAcademicSemesterFilterRequest } from './academicSemester.interface';

const insertIntoDb = async (
  academicSemesterData: AcademicSemester
): Promise<AcademicSemester> => {
  const res = await prisma.academicSemester.create({
    data: academicSemesterData,
  });

  return res;
};
const getAllFormDB = async (
  filters: IAcademicSemesterFilterRequest,
  pagination: IPaginationOptions
): Promise<IGenericResponse<AcademicSemester[]>> => {
  const { page, limit, skip } =
    paginationHelpers.calculatePagination(pagination);
  const { searchTerm, ...filterData } = filters;

  const andCondition = [];

  /**
   *  Search
   */
  if (searchTerm) {
    andCondition.push({
      OR: AcademicSemesterSearchAbleFiled.map(filed => ({
        [filed]: {
          contains: searchTerm,
          mode: 'insensitive',
        },
      })),
    });
  }
  /**
   *  Search for spacing word or key
   */
  if (Object.keys(filterData)?.length > 0) {
    andCondition?.push({
      AND: Object.keys(filterData)?.map(key => ({
        [key]: {
          equals: (filterData as any)[key],
        },
      })),
    });
  }

  /**
   * where condition search
   */
  const whereCondition: Prisma.AcademicSemesterWhereInput =
    andCondition?.length > 0 ? { AND: andCondition } : {};

  /**
   *  find data
   */

  const result = await prisma.academicSemester.findMany({
    where: whereCondition,
    skip,
    take: limit,
    orderBy: {
      [pagination?.sortBy || 'createdAt']:
        pagination?.sortOrder === 'asc' || pagination?.sortOrder === 'desc'
          ? pagination?.sortOrder
          : 'asc',
    },
  });
  /**
   *  get total semester
   */
  const total = await prisma.academicSemester.count();

  return {
    meta: {
      total: total,
      page,
      limit,
    },
    data: result,
  };
};

const getDataById = async (id: string): Promise<AcademicSemester | null> => {
  const result = await prisma.academicSemester.findUnique({
    where: { id },
  });

  return result;
};

export const AcademicSemesterService = {
  insertIntoDb,
  getAllFormDB,
  getDataById,
};
