# 🚀 Guía Rápida - MANTRA

## ✅ Prueba Local

### Opción 1: Abrir directamente
1. Navega a la carpeta del proyecto
2. Abre `index.html` en tu navegador
3. ¡Listo! La aplicación funcionará completamente

### Opción 2: Servidor local (recomendado)
```bash
# Si tienes Python instalado:
python -m http.server 8000

# Si tienes Node.js instalado:
npx serve

# Si tienes PHP instalado:
php -S localhost:8000
```

Luego abre: `http://localhost:8000`

---

## 🔐 Credenciales para Probar

### 👑 Owner (Panel de Control)
```
Email: owner@mantra.com
Password: 123456
```

### 🎤 Organizador (Dashboard)
```
Email: andrea@mantra.com
Password: 123456
```

### 🎟 Asistente (Feed de Eventos)
```
Email: julio@mantra.com
Password: 123456
```

---

## 🌐 Publicar en GitHub Pages

### Paso 1: Crear repositorio en GitHub
1. Ve a https://github.com/new
2. Nombre: `mantra` (o el que prefieras)
3. ✅ Público
4. ❌ NO inicializar con README
5. Click "Create repository"

### Paso 2: Subir archivos
```bash
# En la carpeta del proyecto:
git init
git add .
git commit -m "Versión estática de MANTRA"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/mantra.git
git push -u origin main
```

### Paso 3: Activar GitHub Pages
1. Ve a tu repositorio en GitHub
2. Click en **Settings** (Configuración)
3. En el menú lateral, click en **Pages**
4. En **Source**, selecciona:
   - **Branch:** `main`
   - **Folder:** `/ (root)`
5. Click **Save**

### Paso 4: Acceder a tu sitio
- Espera 1-2 minutos
- Tu sitio estará en: `https://TU_USUARIO.github.io/mantra/`
- ¡Comparte el enlace con tu profesor!

---

## 📋 Funcionalidades para Demostrar

### 1. Login y Registro
- ✅ Login con credenciales de prueba
- ✅ Registro de nuevo asistidor
- ✅ Registro de nuevo organizador

### 2. Feed de Eventos (como asistidor)
- ✅ Ver lista de eventos
- ✅ Confirmar asistencia a evento
- ✅ Dejar reseña con calificación
- ✅ Comentar en evento
- ✅ Seguir organizador

### 3. Comunidad
- ✅ Crear publicación con texto
- ✅ Crear publicación con imagen
- ✅ Dar like a publicaciones
- ✅ Comentar en publicaciones

### 4. Chat
- ✅ Ver conversaciones
- ✅ Enviar mensajes
- ✅ Iniciar chat desde amigos

### 5. Zona Social
- ✅ Ver solicitudes de amistad
- ✅ Aceptar solicitudes
- ✅ Ver notificaciones
- ✅ Marcar notificaciones como leídas
- ✅ Ver logros desbloqueados

### 6. Perfil
- ✅ Ver información del perfil
- ✅ Editar biografía e intereses
- ✅ Subir foto de perfil
- ✅ Ver actividad reciente

### 7. Dashboard Organizador
- ✅ Ver métricas (eventos, asistentes, calificación)
- ✅ Crear nuevo evento con imagen
- ✅ Ver eventos publicados
- ✅ Eliminar eventos

### 8. Panel Owner
- ✅ Ver lista de todos los usuarios
- ✅ Identificar roles (owner, organizador, asistente)

---

## 🎯 Puntos Clave para tu Profesor

### Arquitectura
- **Antes:** Node.js + Express + PostgreSQL + Render + Cloudinary
- **Ahora:** HTML/CSS/JS + JSON + localStorage + GitHub Pages

### Ventajas
1. ✅ Sin costos de hosting
2. ✅ Despliegue permanente en GitHub Pages
3. ✅ Más rápido (todo es local)
4. ✅ Funciona offline una vez cargado
5. ✅ Más fácil de mantener

### Tecnologías
- **Frontend:** HTML5, CSS3, JavaScript ES6+
- **Datos:** JSON + localStorage
- **Hosting:** GitHub Pages
- **Imágenes:** Base64 (convertidas en el navegador)

### Persistencia
- Los datos iniciales vienen de archivos JSON
- Los cambios se guardan en localStorage
- Cada navegador tiene sus propios datos
- Ideal para demostraciones y proyectos académicos

---

## 🐛 Solución de Problemas

### "No carga los eventos"
- Abre la consola del navegador (F12)
- Verifica que no haya errores de CORS
- Si abres directamente el archivo, usa un servidor local

### "Las imágenes no se muestran"
- Las imágenes se guardan en Base64
- Si son muy grandes, pueden exceder el límite de localStorage
- Usa imágenes menores a 500KB

### "Perdí mis datos"
- Los datos se guardan en localStorage
- Si limpias el caché del navegador, se pierden
- Los datos iniciales se recargan automáticamente desde JSON

### "No funciona en GitHub Pages"
- Verifica que activaste GitHub Pages en Settings
- Espera 1-2 minutos después de activar
- Verifica que la URL sea correcta: `https://TU_USUARIO.github.io/mantra/`

---

## 📞 Soporte

Si tienes problemas:
1. Revisa la consola del navegador (F12)
2. Verifica que todos los archivos estén subidos
3. Asegúrate de que GitHub Pages esté activado
4. Revisa el archivo `MIGRACION.md` para más detalles

---

## 📚 Documentación Adicional

- `README.md` - Descripción general del proyecto
- `MIGRACION.md` - Informe detallado de la migración
- `data-layer.js` - Código fuente de la capa de datos
- `data/*.json` - Estructura de datos

---

**¡Buena suerte con tu presentación! 🎉**
