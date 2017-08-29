import express from 'express';
import bodyParser from 'body-parser';
const app = express();

let port = 3000;







// 라우트 예제입니다.
import api from './routes';
app.use('/api', api);


const server = app.listen(port, () => {
    console.log('Express listening on port', port);
});
