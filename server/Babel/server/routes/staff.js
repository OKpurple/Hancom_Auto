import express from 'express';
import { INVALID_REQUEST, SUCCESS, toRes, dbConnect, query } from '../utils';
const router = express.Router();

router.post('/signin',(req,res)=>{
  let memberid = req.body.memberid;
  let pw = req.body.pw;
  dbConnect(res).then((conn)=>{
    query(conn,res,`SELECT NAME,memberid,team,EMAIL FROM staff WHERE memberid = ? AND pw = ?`,[memberid,pw])
    .then((result)=>{
      if(result.length === 0){
        res.json(INVALID_REQUEST);
      }else{
        res.json(tores(SUCCESS,{
          data : result
        }));
      }
    })
  })
})

router.delete('/logout',(req,res)=>{


})


export default router;
