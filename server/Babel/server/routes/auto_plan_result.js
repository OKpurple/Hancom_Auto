import express from 'express';
import { INVALID_REQUEST, SUCCESS, toRes, dbConnect, query } from '../utils';
const router = express.Router();

router.get('/:id/:page',(req,res)=>{
  let memberid = req.params.id;
  let _page = req.params.page;
  let page = _page*10;
  let nextPage = `http://211.253.8.229:8080/api/autoplanesult/`+memberid+`/`+(_page+1);
  dbConnect(res).then((conn)=>{
    query(conn,res,`
      SELECT * FROM auto_plan_result
      WHERE Registrant = ?
      ORDER BY start_date
      LIMIT ?,10;
    `,[memberid, page])
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

router.get('/:id',(req,res)=>{
  let memberid = req.params.id;
  let nextPage = `http://211.253.8.229:8080/api/autoplanesult/`+memberid+`/1`;
  console.log(nextPage);
  dbConnect(res).then((conn)=>{
    query(conn,res,`
      SELECT * FROM auto_plan_result
      WHERE Registrant = ?
      ORDER BY start_date
      LIMIT 0,10;
    `,[memberid])
    .then((result)=>{
      if(result.length === 0){
        res.json(INVALID_REQUEST);
      }else{
        res.json(toRes(SUCCESS,{
          data : result,
          next : nextPage
        }));
      }
    })
  })
})



export default router;
