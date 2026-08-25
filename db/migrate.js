import 'dotenv/config'; import fs from 'fs'; import pg from 'pg'; import bcrypt from 'bcryptjs';
const {Pool}=pg; const pool=new Pool({connectionString:process.env.DATABASE_URL,ssl:process.env.DATABASE_URL?.includes('localhost')?false:{rejectUnauthorized:false}});
const sql=fs.readFileSync(new URL('./schema.sql',import.meta.url),'utf8');
await pool.query(sql);
const categories=['Moissanitas','Plata 925','Relojes','Carteras y accesorios','Caballero','Regalos','Pandora','Charms','Brazaletes Pandora','Sets Pandora','Anillos Pandora','Separadores Pandora','Zarcillos Pandora'];
for(let i=0;i<categories.length;i++){const name=categories[i],slug=name.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g,'').replace(/[^a-z0-9]+/g,'-').replace(/(^-|-$)/g,'');await pool.query('INSERT INTO categories(name,slug,sort_order) VALUES($1,$2,$3) ON CONFLICT(slug) DO NOTHING',[name,slug,i]);}
const email=process.env.ADMIN_EMAIL||'admin@fossil.local'; const password=process.env.ADMIN_PASSWORD||'CambiaEstaClave'; const hash=await bcrypt.hash(password,12);
await pool.query('INSERT INTO users(name,email,password_hash) VALUES($1,$2,$3) ON CONFLICT(email) DO NOTHING',['Administrador',email,hash]);
const samples=[
['MOI-001','Anillo Solitario Moissanita 1CT','moissanitas','Plata 925 · Moissanita 1CT',165,4,['5','6','7','8']],
['PL-001','Cadena Singapur','plata-925','Plata 925 · 45 cm',28,8,[]],
['PL-002','Argollas de Esfera','plata-925','Plata 925 · 10 mm',35,6,[]],
['FOS-001','Reloj Fossil Machine','relojes','Reloj original',210,2,[]]
];
for(const [sku,name,catSlug,material,price,stock,sizes] of samples){const c=await pool.query('SELECT id FROM categories WHERE slug=$1',[catSlug]);const slug=name.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g,'').replace(/[^a-z0-9]+/g,'-').replace(/(^-|-$)/g,'');await pool.query(`INSERT INTO products(sku,name,slug,category_id,material,price,stock,sizes,featured) VALUES($1,$2,$3,$4,$5,$6,$7,$8,true) ON CONFLICT(sku) DO NOTHING`,[sku,name,slug,c.rows[0]?.id,material,price,stock,sizes]);}
console.log('Base de datos inicializada'); await pool.end();
