# 🎉 MANTRA - Plataforma Inteligente de Gestión de Eventos y Comunidad

## 📖 Descripción General

MANTRA es una plataforma web diseñada para conectar personas a través de eventos, intereses y comunidades digitales. El sistema permite a los usuarios descubrir actividades relevantes según sus preferencias, interactuar con otros participantes y establecer conexiones mediante herramientas sociales integradas.

La propuesta surge a partir de la necesidad de contar con una solución que centralice la organización de eventos y facilite la interacción entre asistentes y organizadores dentro de un mismo entorno digital. A diferencia de las plataformas tradicionales de eventos, MANTRA incorpora funcionalidades sociales como comunidades, publicaciones y mensajería, permitiendo que la experiencia del usuario continúe antes, durante y después de cada evento.

Dentro de la plataforma existen dos perfiles principales: organizadores y asistentes. Los organizadores pueden crear eventos, administrar información relacionada con sus actividades, monitorear la participación de los usuarios y gestionar su reputación mediante las reseñas recibidas. Por otro lado, los asistentes pueden explorar eventos personalizados, registrarse en actividades de interés, compartir experiencias con la comunidad y comunicarse directamente con otros usuarios.

---

## 🚀 Versión Estática para GitHub Pages

Esta versión del proyecto ha sido migrada a una arquitectura completamente estática, eliminando las dependencias de:
- ❌ Backend Node.js/Express
- ❌ Base de datos PostgreSQL
- ❌ Servicio de hosting Render
- ❌ Servicio de imágenes Cloudinary

Ahora funciona 100% en el navegador usando:
- ✅ HTML/CSS/JavaScript puro
- ✅ Archivos JSON como base de datos
- ✅ localStorage para persistencia de cambios
- ✅ GitHub Pages como hosting gratuito y permanente

---

## 🎯 Objetivo General

Diseñar e implementar una plataforma digital para la gestión inteligente de eventos denominada MANTRA, capaz de conectar organizadores y asistentes mediante herramientas de administración, comunicación e interacción social, apoyándose en una base de datos relacional segura, consistente y escalable.

---

# 🛠️ Tecnologías Implementadas

### Frontend
- HTML5
- CSS3
- JavaScript (ES6+)
- Bootstrap

### Almacenamiento
- Archivos JSON (datos iniciales)
- localStorage (persistencia de cambios)

### Hosting
- GitHub Pages

---

# ⚙️ Funcionalidades Principales

## 👤 Gestión de Usuarios

- Registro de usuarios (asistidor y organizador).
- Inicio de sesión.
- Gestión de perfil (foto, biografía, intereses).
- Diferenciación entre asistentes, organizadores y owner.

## 🎉 Gestión de Eventos

- Creación de eventos con imagen promocional.
- Eliminación de eventos.
- Consulta de eventos en feed.
- Clasificación por categorías.
- Confirmación de asistencia.

## ⭐ Sistema de Reseñas

- Calificación de eventos (1-5 estrellas).
- Comentarios de participantes.
- Cálculo de reputación de organizadores.

## 🤝 Comunidad

- Publicaciones entre usuarios (texto e imagen).
- Compartir experiencias.
- Sistema de likes.
- Comentarios en publicaciones.

## 💬 Chat

- Comunicación directa entre usuarios.
- Mensajería privada.
- Interacción entre asistentes y organizadores.

## 👥 Zona Social

- Sistema de amistad con solicitudes.
- Notificaciones en tiempo real.
- Sistema de logros.
- Seguir a organizadores.

## 📊 Dashboard de Organizador

- Administración de eventos.
- Visualización de estadísticas.
- Gestión de asistentes.
- Control de publicaciones.

---

# 🗄️ Estructura de Datos

La estructura de datos se organiza en archivos JSON dentro de la carpeta `data/`:

| Archivo | Descripción |
|---------|-------------|
| `usuarios.json` | Usuarios del sistema |
| `organizadores.json` | Perfiles de organizador |
| `participantes.json` | Perfiles de asistente |
| `eventos.json` | Eventos publicados |
| `categorias.json` | Categorías de eventos |
| `evento_categorias.json` | Relación eventos-categorías |
| `asistencias.json` | Confirmaciones de asistencia |
| `resenas.json` | Reseñas de eventos |
| `comentarios_evento.json` | Comentarios en eventos |
| `publicaciones.json` | Publicaciones de comunidad |
| `comentarios_publicacion.json` | Comentarios en publicaciones |
| `likes.json` | Likes en publicaciones |
| `conversaciones.json` | Conversaciones de chat |
| `mensajes.json` | Mensajes de chat |
| `amistades.json` | Relaciones de amistad |
| `notificaciones.json` | Notificaciones del sistema |
| `logros.json` | Logros de usuarios |
| `seguidores.json` | Seguidores de organizadores |
| `preferencias.json` | Preferencias de usuarios |

---

# 🔐 Credenciales de Prueba

## Owner (Administrador)
- **Email:** owner@mantra.com
- **Password:** 123456

## Organizadores
- **Email:** andrea@mantra.com / **Password:** 123456
- **Email:** valeria@mantra.com / **Password:** 123456
- **Email:** ricardo@mantra.com / **Password:** 123456

## Asistentes
- **Email:** julio@mantra.com / **Password:** 123456
- **Email:** carlos@mantra.com / **Password:** 123456
- **Email:** fernanda@mantra.com / **Password:** 123456

---

# 📱 Capturas de Pantalla

<details>
<summary><b>🖼️ Ver capturas de pantalla</b></summary>

<br>

<table>
<tr>
<td align="center">
<b>Landing Page</b><br><br>
<img src="capturas/landing.png" width="450">
</td>

<td align="center">
<b>Feed de Eventos</b><br><br>
<img src="capturas/feed-eventos.png" width="450">
</td>
</tr>

<tr>
<td align="center">
<b>Dashboard Organizador</b><br><br>
<img src="capturas/dashborad-organizador.png" width="450">
</td>

<td align="center">
<b>Comunidad</b><br><br>
<img src="capturas/comunidad.png" width="450">
</td>
</tr>

<tr>
<td align="center">
<b>Chat</b><br><br>
<img src="capturas/chat.png" width="450">
</td>

<td align="center">
<b>Perfil</b><br><br>
<img src="capturas/perfil.png" width="450">
</td>
</tr>
</table>

</details>

---

# 🎥 Entrevista

📄 Documento de entrevista:

[Ver Entrevista](Entrevista_MANTRA.pdf)

---

# 👨‍💻 Autores

**Julio Milan y Armenta Misael**

Proyecto desarrollado para la asignatura de Bases de Datos.

---

# 📚 Conclusiones

El desarrollo de MANTRA permitió aplicar de manera integral los conceptos fundamentales de análisis, diseño e implementación de bases de datos relacionales. Durante el proyecto se construyó un sistema capaz de gestionar usuarios, eventos, comunidades, reseñas y comunicaciones entre participantes, manteniendo siempre la integridad y seguridad de la información.

La migración a una arquitectura estática demuestra la versatilidad del proyecto, permitiendo su despliegue en GitHub Pages sin dependencia de servidores backend, manteniendo toda la funcionalidad original mediante el uso de JSON y localStorage.

---

# 🚀 Despliegue en GitHub Pages

1. Sube este repositorio a GitHub.
2. Ve a **Settings** → **Pages**.
3. En **Source**, selecciona la rama `main` y carpeta `/ (root)`.
4. Guarda los cambios.
5. Tu sitio estará disponible en `https://tu-usuario.github.io/mantra/`

---

# 🔄 Arquitectura del Proyecto

```
mantra/
├── data/                    # Archivos JSON con datos iniciales
│   ├── usuarios.json
│   ├── eventos.json
│   ├── categorias.json
│   └── ... (19 archivos JSON)
├── data-layer.js           # Capa de datos (reemplaza backend)
├── index.html              # Landing page + Login
├── feed-eventos.html       # Feed de eventos
├── comunidad.html          # Comunidad
├── chat.html               # Chat
├── social.html             # Zona social
├── perfil.html             # Perfil de usuario
├── dashboard-organizador.html  # Dashboard organizador
├── usuario-db.html         # Panel de owner
├── registro-asistidor.html # Registro asistidor
├── registro-organizador.html   # Registro organizador
└── README.md               # Este archivo
```

---

# 📝 Notas sobre la Migración

Esta versión estática mantiene todas las funcionalidades del proyecto original:

- **Login simulado:** Los usuarios se validan contra `data/usuarios.json`
- **Persistencia:** Los cambios se guardan en `localStorage` del navegador
- **Imágenes:** Se convierten a Base64 y se almacenan localmente
- **Sin backend:** Toda la lógica se ejecuta en el navegador mediante `data-layer.js`

⚠️ **Importante:** Los datos se reinician si el usuario limpia el localStorage del navegador. Para una versión con persistencia real, se recomienda usar Firebase, Supabase o similar.
