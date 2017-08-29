import express from 'express';
import staff from './staff';
import autoPlanResult from './auto_plan_result';
const router = express.Router();


router.use('/staff',staff);
router.use('/autoplanresult',autoPlanResult)
export default router;
