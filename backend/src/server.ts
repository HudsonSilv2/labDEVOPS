import { createServer } from 'node:http';
import { Pool } from 'pg';

const pool = new Pool({
  host: process.env.DB_HOST || 'banco',
  user: process.env.DB_USER || 'aluno',
  password: process.env.DB_PASSWORD || 'senha123',
  database: process.env.DB_NAME || 'atividade',
  port: 5432,
});

createServer(async (req, res) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');

  if (req.method !== 'GET' || req.url !== '/api/status') {
    res.writeHead(404);
    res.end(JSON.stringify({ erro: 'Rota não encontrada' }));
    return;
  }

  try {
    await pool.query('SELECT 1');
    res.writeHead(200);
    res.end(JSON.stringify({ backend: 'online', banco: 'conectado' }));
  } catch (error) {
    console.error('Falha na conexão com o banco:', error);
    res.writeHead(503);
    res.end(JSON.stringify({ backend: 'online', banco: 'indisponível' }));
  }
}).listen(3000, '0.0.0.0', () => {
  console.log('Backend disponível na porta 3000');
});
