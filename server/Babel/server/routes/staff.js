import express from 'express';
import { INVALID_REQUEST, SUCCESS, toRes, dbConnect, query } from '../utils';
const router = express.Router();

router.post('/signin',(req,res)=>{
  console.log("signin");
  let memberid = req.body.memberid;
  let pw = req.body.pw;

  console.log(memberid + " come "+ pw);
  dbConnect(res).then((conn)=>{
    query(conn,res,`SELECT NAME,memberid,team,EMAIL FROM staff WHERE memberid = ? AND pw = ?`,[memberid,pw])
    .then((result)=>{
      conn.release();
      if(result.length === 0){
        res.json(INVALID_REQUEST);
      }else{
        res.json(toRes(SUCCESS,{
          data : result
        }));
      }
    })
  })
})

router.delete('/logout',(req,res)=>{


})

router.get('/',(req,res)=>{
  dbConnect(res).then((conn)=>{
    query(conn,res,
      `select * from users`
    ).then((result)=>{
      res.json(result);
    });
  });
});

export default router;
