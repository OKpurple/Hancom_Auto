import express from 'express';
import { INVALID_REQUEST, SUCCESS, toRes, dbConnect, query } from '../utils';
const router = express.Router();


router.post('/',(req,res)=>{
  let classfication = req.body.classfication;
  let product = req.body.product;
  let step1 = req.body.step1;
  let step2 = req.body.step2;
  let step3 = req.body.step3;

  let memberid = req.body.memberid;
  let startDate = req.body.startDate;
  let endDate = req.body.endDate;
  dbConnect(res).then((conn)=>{
    query(conn,res,
      `INSERT INTO auto_plan_result
      (Classification,Product,Test_Plan_Step1,Test_Plan_Step2,Test_Plan_Step3,Registrant,start_date,end_date )
      VALUES(?,?,?,?,?,?,?,?)`,
      [
        classfication,
        product,
        step1,
        step2,
        step3,
        memberid,
        startDate,
        endDate
      ]).then((result)=>{
        conn.release();
        res.json(SUCCESS);
    });
  });
});

router.get('/:id/:page',(req,res)=>{
  let memberid = req.params.id;
  let _page = req.params.page;
  let page = _page*10;
  let nextPage = `http://211.253.8.229:8080/api/autoplanesult/`+memberid+`/`+(_page+1);
  dbConnect(res).then((conn)=>{
    query(conn,res,`
      SELECT * FROM auto_plan_result
      WHERE Registrant = ?
      ORDER BY test_plan_uuid DESC
      LIMIT ?,10;
    `,[
      memberid,
      page
    ])
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

router.get('/:id',(req,res)=>{
  let memberid = req.params.id;
  let nextPage = `http://211.253.8.229:8080/api/autoplanesult/`+memberid+`/1`;
  
  dbConnect(res).then((conn)=>{
    query(conn,res,`
      SELECT * FROM auto_plan_result
      WHERE Registrant = ?
      ORDER BY test_plan_uuid DESC
      LIMIT 0,10;
    `,[memberid])
    .then((result)=>{
      conn.release();
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
