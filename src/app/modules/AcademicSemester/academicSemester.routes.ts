import express from 'express';
import validateRequest from '../../middlewares/validateRequest';
import { AcademicSemesterController } from './academicSemester.controller';
import { AcademicSemesterValidation } from './academicSemester.validation';
const router = express.Router();

router.post(
  '/',
  validateRequest(AcademicSemesterValidation.create),
  AcademicSemesterController.insertIntoDb
);
router.get('/', AcademicSemesterController.getAllFormDb);
router.get('/:id', AcademicSemesterController.getDataById);

export const AcademicSemesterRoutes = router;
