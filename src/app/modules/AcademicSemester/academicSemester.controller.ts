import { AcademicSemester } from '@prisma/client';
import { NextFunction, Request, Response } from 'express';
import httpStatus from 'http-status';
import pick from '../../../shared/pick';
import sendResponse from '../../../shared/sendResponse';
import { AcademicSemesterFilterAbleFiled } from './academicSemester.constant';
import { AcademicSemesterService } from './academicSemester.service';

const insertIntoDb = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const result = await AcademicSemesterService.insertIntoDb(req?.body);
    sendResponse<AcademicSemester>(res, {
      statusCode: httpStatus.OK,
      success: true,
      message: 'Create Academic Semester successfully!',
      data: result,
    });
  } catch (error) {
    next(error);
  }
};
const getAllFormDb = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const filters = pick(req?.query, AcademicSemesterFilterAbleFiled);
    const pagination = pick(req?.query, [
      'limit',
      'page',
      'sortBy',
      'sortOrder',
    ]);

    const result = await AcademicSemesterService.getAllFormDB(
      filters,
      pagination
    );
    sendResponse<AcademicSemester[]>(res, {
      statusCode: httpStatus.OK,
      success: true,
      message: 'Academic Semester data get successfully!',
      meta: result?.meta,
      data: result?.data,
    });
  } catch (error) {
    next(error);
  }
};

const getDataById = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const result = await AcademicSemesterService.getDataById(req?.params?.id);
    sendResponse<AcademicSemester>(res, {
      statusCode: httpStatus.OK,
      success: true,
      message: 'Get Academic Semester info successfully!',
      data: result,
    });
  } catch (error) {
    next(error);
  }
};

export const AcademicSemesterController = {
  insertIntoDb,
  getAllFormDb,
  getDataById,
};
