# FOSSIL Store Platform 🖤

Primera base de producción para unir **tienda online + inventario + estadísticas + administración de productos y fotografías**.

## Arquitectura

- **Frontend:** HTML/CSS/JavaScript responsive, optimizado para móvil.
- **Backend:** Node.js + Express.
- **Base de datos:** PostgreSQL en Neon.
- **Hosting:** Render.
- **Fotos:** Cloudinary recomendado para producción; almacenamiento local solo para desarrollo.

> Render tiene un sistema de archivos efímero en la mayoría de sus servicios web. Por eso las fotos de productos deben almacenarse en un servicio persistente como Cloudinary antes de poner la tienda en producción.

## Funciones incluidas

### Tienda
- Catálogo dinámico desde PostgreSQL.
- Colecciones y filtros.
- Carrito de compras.
- Registro de pedidos.
- Descuento automático del inventario al crear un pedido.
- Diseño premium basado en la nueva dirección visual de Fossil.

### Administración
- Inicio de sesión protegido con JWT.
- Crear productos desde la web.
- Subir varias fotografías por producto.
- SKU, precio, material, tallas y descripción.
- Entradas, salidas, ajustes y devoluciones de inventario.
- Dashboard con productos, unidades, valor estimado del inventario y alertas de stock bajo.

### Colección Pandora
La estructura ya incluye las categorías:
- Pandora
- Charms
- Brazaletes Pandora
- Sets Pandora
- Anillos Pandora
- Separadores Pandora
- Zarcillos Pandora

Los productos reales pueden cargarse desde el panel. La plataforma no presupone autenticidad o disponibilidad: esos datos deben ser gestionados por la tienda.

## Desarrollo local

1. Instala dependencias:
```bash
npm install
```
2. Copia `.env.example` a `.env` y configura `DATABASE_URL`.
3. Inicializa la base:
```bash
npm run migrate
```
4. Inicia la app:
```bash
npm run dev
```
5. Abre `http://localhost:10000`.

## Neon

1. Crea un proyecto y una base PostgreSQL.
2. Copia la cadena de conexión en `DATABASE_URL`.
3. Usa SSL (`sslmode=require`).
4. Ejecuta `npm run migrate` una vez o deja que Render lo haga durante el primer deploy.

## Render

1. Sube este proyecto a GitHub.
2. En Render, crea un **Blueprint** desde el repositorio o un Web Service manual.
3. Render detectará `render.yaml`.
4. Configura las variables privadas: `DATABASE_URL`, `ADMIN_EMAIL`, `ADMIN_PASSWORD`, `WHATSAPP_NUMBER` y, para fotos en producción, `CLOUDINARY_URL`.

## Siguiente fase recomendada

1. Migrar todo el catálogo real a productos estructurados.
2. Cargar fotografías profesionales.
3. Configurar el WhatsApp oficial de la tienda.
4. Añadir estados de pedido y panel de ventas.
5. Integrar pagos cuando se decida la pasarela disponible para Venezuela.
6. Añadir códigos QR/código de barras y roles para empleados.
