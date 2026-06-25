/* ============================================================
   MANTRA - Data Layer
   Reemplaza el backend Node.js + PostgreSQL por JSON + localStorage
   ============================================================ */

const DataLayer = (function() {

  // ---- Estado interno ----
  let _db = null;
  let _initialized = false;

  // ---- Utilidades ----
  function _nextId(arr, key) {
    if (!arr || arr.length === 0) return 1;
    return Math.max(...arr.map(r => Number(r[key]) || 0)) + 1;
  }

  function _today() {
    return new Date().toISOString().slice(0, 10);
  }

  function _now() {
    return new Date().toISOString().replace('T', ' ').slice(0, 19);
  }

  function _save(collection) {
    const key = 'mantra_' + collection;
    localStorage.setItem(key, JSON.stringify(_db[collection]));
  }

  function _load(collection) {
    const key = 'mantra_' + collection;
    const stored = localStorage.getItem(key);
    if (stored) {
      try { return JSON.parse(stored); } catch(e) {}
    }
    return null;
  }

  // ---- Inicialización ----
  async function init() {
    if (_initialized) return _db;

    const collections = [
      'usuarios', 'organizadores', 'participantes', 'eventos',
      'categorias', 'evento_categorias', 'asistencias', 'resenas',
      'comentarios_evento', 'publicaciones', 'comentarios_publicacion',
      'likes', 'conversaciones', 'mensajes', 'amistades',
      'notificaciones', 'logros', 'seguidores', 'preferencias'
    ];

    _db = {};

    for (const col of collections) {
      const stored = _load(col);
      if (stored) {
        _db[col] = stored;
      } else {
        try {
          const resp = await fetch(`data/${col}.json`);
          _db[col] = await resp.json();
        } catch(e) {
          console.warn(`No se pudo cargar data/${col}.json`, e);
          _db[col] = [];
        }
      }
    }

    _initialized = true;
    return _db;
  }

  function reset() {
    const collections = [
      'usuarios', 'organizadores', 'participantes', 'eventos',
      'categorias', 'evento_categorias', 'asistencias', 'resenas',
      'comentarios_evento', 'publicaciones', 'comentarios_publicacion',
      'likes', 'conversaciones', 'mensajes', 'amistades',
      'notificaciones', 'logros', 'seguidores', 'preferencias'
    ];
    for (const col of collections) {
      localStorage.removeItem('mantra_' + col);
    }
    _initialized = false;
    _db = null;
  }

  // ============================================================
  //  API: LOGIN
  // ============================================================
  async function login(email, password) {
    await init();
    const user = _db.usuarios.find(u => u.email === email && u.password === password);
    if (!user) return { ok: false, error: 'Correo o contraseña incorrectos.' };

    let rol = 'asistidor';
    if (user.email === 'owner@mantra.com') {
      rol = 'owner';
    } else {
      const esOrg = _db.organizadores.find(o => Number(o.id_usuario) === Number(user.id_usuario));
      rol = esOrg ? 'organizador' : 'asistidor';
    }

    return {
      ok: true,
      usuario: {
        id_usuario: user.id_usuario,
        nombre: user.nombre,
        email: user.email,
        rol: rol,
        solo_lectura: user.solo_lectura || false
      }
    };
  }

  // ============================================================
  //  API: REGISTRO ASISTIDOR
  // ============================================================
  async function registerAsistidor(data) {
    await init();
    const existe = _db.usuarios.find(u => u.email === data.email);
    if (existe) return { ok: false, error: 'Este correo ya está registrado.' };

    const idUsuario = _nextId(_db.usuarios, 'id_usuario');

    _db.usuarios.push({
      id_usuario: idUsuario,
      nombre: data.nombre,
      email: data.email,
      password: data.password,
      edad: parseInt(data.edad) || 0,
      biografia: data.biografia || '',
      foto_perfil: null,
      solo_lectura: false
    });

    _db.participantes.push({
      id_usuario: idUsuario,
      intereses: data.intereses || ''
    });

    _save('usuarios');
    _save('participantes');

    return { ok: true, message: 'Cuenta de asistidor creada correctamente.' };
  }

  // ============================================================
  //  API: REGISTRO ORGANIZADOR
  // ============================================================
  async function registerOrganizador(data) {
    await init();
    const existe = _db.usuarios.find(u => u.email === data.email);
    if (existe) return { ok: false, error: 'Correo ya registrado.' };

    const idUsuario = _nextId(_db.usuarios, 'id_usuario');

    _db.usuarios.push({
      id_usuario: idUsuario,
      nombre: data.nombre,
      email: data.email,
      password: data.password,
      edad: parseInt(data.edad) || 0,
      biografia: data.biografia || '',
      foto_perfil: null,
      solo_lectura: false
    });

    _db.organizadores.push({
      id_usuario: idUsuario,
      reputacion: 0.00
    });

    _save('usuarios');
    _save('organizadores');

    return { ok: true, message: 'Cuenta de organizador creada correctamente.' };
  }

  // ============================================================
  //  API: FEED DE EVENTOS
  // ============================================================
  async function getFeed() {
    await init();
    return _db.eventos.map(e => {
      const ec = _db.evento_categorias.find(c => Number(c.id_evento) === Number(e.id_evento));
      const cat = ec ? _db.categorias.find(c => Number(c.id_categoria) === Number(ec.id_categoria)) : null;
      return {
        id_evento: e.id_evento,
        titulo: e.titulo,
        fecha: e.fecha,
        hora: e.hora,
        calle: e.calle,
        ciudad: e.ciudad,
        imagen_url: e.imagen_url,
        id_organizador: e.id_organizador,
        nombre_cat: cat ? cat.nombre_cat : 'General'
      };
    }).sort((a, b) => (a.fecha || '').localeCompare(b.fecha || ''));
  }

  // ============================================================
  //  API: ASISTENCIA
  // ============================================================
  async function confirmarAsistencia(id_usuario, id_evento) {
    await init();
    const existe = _db.asistencias.find(a =>
      Number(a.id_participante) === Number(id_usuario) &&
      Number(a.id_evento) === Number(id_evento)
    );
    if (!existe) {
      _db.asistencias.push({ id_participante: Number(id_usuario), id_evento: Number(id_evento) });
      _save('asistencias');
    }
    return { ok: true, message: 'Asistencia confirmada.' };
  }

  // ============================================================
  //  API: CREAR EVENTO
  // ============================================================
  async function crearEvento(data, imagenBase64) {
    await init();

    const usuario = _db.usuarios.find(u => Number(u.id_usuario) === Number(data.idOrganizador));
    if (usuario && usuario.solo_lectura) {
      return { ok: false, error: 'Cuenta de demostración. Solo lectura.' };
    }

    const idEvento = _nextId(_db.eventos, 'id_evento');
    const imagen_url = imagenBase64 || null;

    _db.eventos.push({
      id_evento: idEvento,
      titulo: data.titulo,
      fecha: data.fecha,
      hora: data.hora,
      calle: data.calle,
      ciudad: data.ciudad,
      imagen_url: imagen_url,
      id_organizador: Number(data.idOrganizador)
    });

    if (data.id_categoria) {
      _db.evento_categorias.push({
        id_evento: idEvento,
        id_categoria: Number(data.id_categoria)
      });
      _save('evento_categorias');
    }

    _save('eventos');

    return { ok: true, message: 'Evento publicado correctamente.', id_evento: idEvento, imagen_url };
  }

  // ============================================================
  //  API: MIS EVENTOS (ORGANIZADOR)
  // ============================================================
  async function getMisEventos(idOrganizador) {
    await init();
    return _db.eventos
      .filter(e => Number(e.id_organizador) === Number(idOrganizador))
      .map(e => {
        const asistentes = _db.asistencias.filter(a => Number(a.id_evento) === Number(e.id_evento)).length;
        const resenas = _db.resenas.filter(r => Number(r.id_evento) === Number(e.id_evento));
        const promedio = resenas.length > 0
          ? resenas.reduce((s, r) => s + Number(r.calificacion), 0) / resenas.length
          : 0;
        return {
          id_evento: e.id_evento,
          titulo: e.titulo,
          fecha: e.fecha,
          hora: e.hora,
          calle: e.calle,
          ciudad: e.ciudad,
          imagen_url: e.imagen_url,
          asistentes: asistentes,
          promedio_calificacion: promedio
        };
      })
      .sort((a, b) => (b.fecha || '').localeCompare(a.fecha || ''));
  }

  // ============================================================
  //  API: ELIMINAR EVENTO
  // ============================================================
  async function eliminarEvento(idEvento) {
    await init();
    _db.eventos = _db.eventos.filter(e => Number(e.id_evento) !== Number(idEvento));
    _db.asistencias = _db.asistencias.filter(a => Number(a.id_evento) !== Number(idEvento));
    _db.resenas = _db.resenas.filter(r => Number(r.id_evento) !== Number(idEvento));
    _db.comentarios_evento = _db.comentarios_evento.filter(c => Number(c.id_evento) !== Number(idEvento));
    _db.evento_categorias = _db.evento_categorias.filter(ec => Number(ec.id_evento) !== Number(idEvento));
    _save('eventos');
    _save('asistencias');
    _save('resenas');
    _save('comentarios_evento');
    _save('evento_categorias');
    return { ok: true, message: 'Evento eliminado correctamente.' };
  }

  // ============================================================
  //  API: MÉTRICAS ORGANIZADOR
  // ============================================================
  async function getMetricas(id_organizador) {
    await init();
    const eventos = _db.eventos.filter(e => Number(e.id_organizador) === Number(id_organizador));
    const idsEventos = eventos.map(e => Number(e.id_evento));
    const total_eventos = eventos.length;
    const total_asistentes = _db.asistencias.filter(a => idsEventos.includes(Number(a.id_evento))).length;
    const resenas = _db.resenas.filter(r => idsEventos.includes(Number(r.id_evento)));
    const promedio_calificacion = resenas.length > 0
      ? resenas.reduce((s, r) => s + Number(r.calificacion), 0) / resenas.length
      : 0;
    return { total_eventos, total_asistentes, promedio_calificacion };
  }

  // ============================================================
  //  API: RESEÑAS
  // ============================================================
  async function crearResena(data) {
    await init();
    const idResena = _nextId(_db.resenas, 'id_resena');
    _db.resenas.push({
      id_resena: idResena,
      calificacion: Number(data.calificacion),
      comentario: data.comentario,
      fecha_publicacion: _today(),
      id_evento: Number(data.id_evento),
      id_participante: Number(data.id_participante)
    });
    _save('resenas');
    return { ok: true, message: 'Reseña publicada.' };
  }

  async function getResenas(idEvento) {
    await init();
    return _db.resenas
      .filter(r => Number(r.id_evento) === Number(idEvento))
      .map(r => {
        const u = _db.usuarios.find(u => Number(u.id_usuario) === Number(r.id_participante));
        return {
          calificacion: r.calificacion,
          comentario: r.comentario,
          fecha_publicacion: r.fecha_publicacion,
          nombre: u ? u.nombre : 'Anónimo'
        };
      })
      .sort((a, b) => (b.fecha_publicacion || '').localeCompare(a.fecha_publicacion || ''));
  }

  // ============================================================
  //  API: PERFIL
  // ============================================================
  async function getPerfil(idUsuario) {
    await init();
    const u = _db.usuarios.find(u => Number(u.id_usuario) === Number(idUsuario));
    if (!u) return null;
    const p = _db.participantes.find(p => Number(p.id_usuario) === Number(idUsuario));
    const eventosAsistidos = _db.asistencias.filter(a => Number(a.id_participante) === Number(idUsuario)).length;
    const totalResenas = _db.resenas.filter(r => Number(r.id_participante) === Number(idUsuario)).length;
    return {
      id_usuario: u.id_usuario,
      nombre: u.nombre,
      email: u.email,
      biografia: u.biografia,
      foto_perfil: u.foto_perfil,
      intereses: p ? p.intereses : '',
      eventos_asistidos: eventosAsistidos,
      total_resenas: totalResenas
    };
  }

  async function actualizarFotoPerfil(id_usuario, fotoBase64) {
    await init();
    const u = _db.usuarios.find(u => Number(u.id_usuario) === Number(id_usuario));
    if (!u) return { ok: false, error: 'Usuario no encontrado.' };
    u.foto_perfil = fotoBase64;
    _save('usuarios');
    return { ok: true, foto: fotoBase64 };
  }

  async function actualizarPerfil(idUsuario, biografia, intereses) {
    await init();
    const u = _db.usuarios.find(u => Number(u.id_usuario) === Number(idUsuario));
    if (u) {
      u.biografia = biografia;
      _save('usuarios');
    }
    const p = _db.participantes.find(p => Number(p.id_usuario) === Number(idUsuario));
    if (p) {
      p.intereses = intereses;
      _save('participantes');
    }
    return { ok: true, message: 'Perfil actualizado.' };
  }

  async function getActividad(idUsuario) {
    await init();
    const eventos = _db.asistencias
      .filter(a => Number(a.id_participante) === Number(idUsuario))
      .map(a => {
        const e = _db.eventos.find(e => Number(e.id_evento) === Number(a.id_evento));
        return e ? { titulo: e.titulo, fecha: e.fecha, ciudad: e.ciudad, imagen_url: e.imagen_url } : null;
      })
      .filter(Boolean)
      .sort((a, b) => (b.fecha || '').localeCompare(a.fecha || ''))
      .slice(0, 6);

    const resenas = _db.resenas
      .filter(r => Number(r.id_participante) === Number(idUsuario))
      .map(r => {
        const e = _db.eventos.find(e => Number(e.id_evento) === Number(r.id_evento));
        return e ? { calificacion: r.calificacion, comentario: r.comentario, fecha_publicacion: r.fecha_publicacion, titulo: e.titulo } : null;
      })
      .filter(Boolean)
      .sort((a, b) => (b.fecha_publicacion || '').localeCompare(a.fecha_publicacion || ''))
      .slice(0, 6);

    return { eventos, resenas };
  }

  // ============================================================
  //  API: OWNER
  // ============================================================
  async function getOwnerUsuarios() {
    await init();
    return _db.usuarios.map(u => {
      const esOrg = _db.organizadores.find(o => Number(o.id_usuario) === Number(u.id_usuario));
      return {
        id_usuario: u.id_usuario,
        nombre: u.nombre,
        email: u.email,
        es_organizador: !!esOrg
      };
    }).sort((a, b) => a.id_usuario - b.id_usuario);
  }

  // ============================================================
  //  API: SEGUIR ORGANIZADOR
  // ============================================================
  async function seguirOrganizador(id_participante, id_organizador) {
    await init();
    const existe = _db.seguidores.find(s =>
      Number(s.id_participante) === Number(id_participante) &&
      Number(s.id_organizador) === Number(id_organizador)
    );
    if (!existe) {
      _db.seguidores.push({ id_participante: Number(id_participante), id_organizador: Number(id_organizador) });
      _save('seguidores');
    }
    return { ok: true, message: 'Organizador seguido.' };
  }

  async function dejarDeSeguir(id_participante, id_organizador) {
    await init();
    _db.seguidores = _db.seguidores.filter(s =>
      !(Number(s.id_participante) === Number(id_participante) && Number(s.id_organizador) === Number(id_organizador))
    );
    _save('seguidores');
    return { ok: true, message: 'Dejaste de seguir al organizador.' };
  }

  // ============================================================
  //  API: COMENTARIOS DE EVENTO
  // ============================================================
  async function crearComentarioEvento(data) {
    await init();
    const idComentario = _nextId(_db.comentarios_evento, 'id_comentario');
    _db.comentarios_evento.push({
      id_comentario: idComentario,
      comentario: data.comentario,
      fecha_publicacion: _today(),
      id_evento: Number(data.id_evento),
      id_participante: Number(data.id_participante)
    });
    _save('comentarios_evento');
    return { ok: true, message: 'Comentario publicado.' };
  }

  async function getComentariosEvento(idEvento) {
    await init();
    return _db.comentarios_evento
      .filter(c => Number(c.id_evento) === Number(idEvento))
      .map(c => {
        const u = _db.usuarios.find(u => Number(u.id_usuario) === Number(c.id_participante));
        return {
          id_comentario: c.id_comentario,
          comentario: c.comentario,
          fecha_publicacion: c.fecha_publicacion,
          id_usuario: c.id_participante,
          nombre: u ? u.nombre : 'Anónimo',
          foto_perfil: u ? u.foto_perfil : null
        };
      })
      .sort((a, b) => {
        const fc = (b.fecha_publicacion || '').localeCompare(a.fecha_publicacion || '');
        if (fc !== 0) return fc;
        return b.id_comentario - a.id_comentario;
      });
  }

  // ============================================================
  //  API: COMUNIDAD
  // ============================================================
  async function crearPublicacion(data, imagenBase64) {
    await init();
    const idPublicacion = _nextId(_db.publicaciones, 'id_publicacion');
    _db.publicaciones.push({
      id_publicacion: idPublicacion,
      contenido: data.contenido,
      fecha_publicacion: _today(),
      imagen_url: imagenBase64 || null,
      id_usuario: Number(data.id_usuario),
      id_evento: data.id_evento ? Number(data.id_evento) : null
    });
    _save('publicaciones');
    return { ok: true, message: 'Publicación creada.' };
  }

  async function getComunidadFeed() {
    await init();
    return _db.publicaciones
      .map(p => {
        const u = _db.usuarios.find(u => Number(u.id_usuario) === Number(p.id_usuario));
        const esOrg = u ? _db.organizadores.find(o => Number(o.id_usuario) === Number(u.id_usuario)) : null;
        const e = p.id_evento ? _db.eventos.find(ev => Number(ev.id_evento) === Number(p.id_evento)) : null;
        const total_likes = _db.likes.filter(l => Number(l.id_publicacion) === Number(p.id_publicacion)).length;
        return {
          id_publicacion: p.id_publicacion,
          contenido: p.contenido,
          fecha_publicacion: p.fecha_publicacion,
          id_usuario: p.id_usuario,
          imagen_url: p.imagen_url,
          nombre: u ? u.nombre : 'Anónimo',
          foto_perfil: u ? u.foto_perfil : null,
          evento_titulo: e ? e.titulo : null,
          evento_imagen: e ? e.imagen_url : null,
          total_likes: total_likes,
          rol: esOrg ? 'organizador' : 'asistidor'
        };
      })
      .sort((a, b) => b.id_publicacion - a.id_publicacion);
  }

  async function crearComentarioPublicacion(data) {
    await init();
    const idComentario = _nextId(_db.comentarios_publicacion, 'id_comentario');
    _db.comentarios_publicacion.push({
      id_comentario: idComentario,
      comentario: data.comentario,
      fecha_publicacion: _today(),
      id_publicacion: Number(data.id_publicacion),
      id_usuario: Number(data.id_usuario)
    });
    _save('comentarios_publicacion');
    return { ok: true, message: 'Comentario publicado.' };
  }

  async function getComentariosPublicacion(idPublicacion) {
    await init();
    return _db.comentarios_publicacion
      .filter(c => Number(c.id_publicacion) === Number(idPublicacion))
      .map(c => {
        const u = _db.usuarios.find(u => Number(u.id_usuario) === Number(c.id_usuario));
        return {
          id_comentario: c.id_comentario,
          comentario: c.comentario,
          fecha_publicacion: c.fecha_publicacion,
          nombre: u ? u.nombre : 'Anónimo',
          foto_perfil: u ? u.foto_perfil : null,
          id_usuario: c.id_usuario
        };
      })
      .sort((a, b) => b.id_comentario - a.id_comentario);
  }

  // ============================================================
  //  API: LIKES
  // ============================================================
  async function darLike(id_publicacion, id_usuario) {
    await init();
    const existe = _db.likes.find(l =>
      Number(l.id_publicacion) === Number(id_publicacion) &&
      Number(l.id_usuario) === Number(id_usuario)
    );
    if (!existe) {
      _db.likes.push({ id_publicacion: Number(id_publicacion), id_usuario: Number(id_usuario) });
      _save('likes');
    }
    return { ok: true };
  }

  async function quitarLike(id_publicacion, id_usuario) {
    await init();
    _db.likes = _db.likes.filter(l =>
      !(Number(l.id_publicacion) === Number(id_publicacion) && Number(l.id_usuario) === Number(id_usuario))
    );
    _save('likes');
    return { ok: true };
  }

  // ============================================================
  //  API: NOTIFICACIONES
  // ============================================================
  async function getNotificaciones(idUsuario) {
    await init();
    return _db.notificaciones
      .filter(n => Number(n.id_usuario_destino) === Number(idUsuario))
      .sort((a, b) => b.id_notificacion - a.id_notificacion);
  }

  async function marcarNotificacionLeida(id) {
    await init();
    const n = _db.notificaciones.find(n => Number(n.id_notificacion) === Number(id));
    if (n) {
      n.leida = true;
      _save('notificaciones');
    }
    return { ok: true };
  }

  // ============================================================
  //  API: AMIGOS
  // ============================================================
  async function solicitarAmistad(id_usuario_1, id_usuario_2) {
    await init();
    if (Number(id_usuario_1) === Number(id_usuario_2)) {
      return { ok: false, error: 'No puedes agregarte a ti mismo.' };
    }
    const existe = _db.amistades.find(a =>
      (Number(a.id_usuario_1) === Number(id_usuario_1) && Number(a.id_usuario_2) === Number(id_usuario_2)) ||
      (Number(a.id_usuario_1) === Number(id_usuario_2) && Number(a.id_usuario_2) === Number(id_usuario_1))
    );
    if (!existe) {
      _db.amistades.push({
        id_usuario_1: Number(id_usuario_1),
        id_usuario_2: Number(id_usuario_2),
        estado: 'pendiente',
        fecha_solicitud: _today()
      });
      _save('amistades');

      const idNotif = _nextId(_db.notificaciones, 'id_notificacion');
      _db.notificaciones.push({
        id_notificacion: idNotif,
        id_usuario_destino: Number(id_usuario_2),
        mensaje: 'Tienes una nueva solicitud de amistad.',
        leida: false,
        fecha_creacion: _today()
      });
      _save('notificaciones');
    }
    return { ok: true, message: 'Solicitud enviada.' };
  }

  async function aceptarAmistad(id_usuario_1, id_usuario_2) {
    await init();
    const a = _db.amistades.find(a =>
      Number(a.id_usuario_1) === Number(id_usuario_1) &&
      Number(a.id_usuario_2) === Number(id_usuario_2)
    );
    if (a) {
      a.estado = 'aceptada';
      _save('amistades');
    }
    return { ok: true, message: 'Solicitud aceptada.' };
  }

  async function getAmigos(idUsuario) {
    await init();
    const ids = [];
    _db.amistades
      .filter(a => a.estado === 'aceptada' && (Number(a.id_usuario_1) === Number(idUsuario) || Number(a.id_usuario_2) === Number(idUsuario)))
      .forEach(a => {
        const otro = Number(a.id_usuario_1) === Number(idUsuario) ? a.id_usuario_2 : a.id_usuario_1;
        ids.push(otro);
      });
    return _db.usuarios
      .filter(u => ids.includes(u.id_usuario))
      .map(u => ({ id_usuario: u.id_usuario, nombre: u.nombre, foto_perfil: u.foto_perfil }));
  }

  async function getSolicitudesAmistad(idUsuario) {
    await init();
    const solicitudes = _db.amistades.filter(a =>
      Number(a.id_usuario_2) === Number(idUsuario) && a.estado === 'pendiente'
    );
    return solicitudes.map(s => {
      const u = _db.usuarios.find(u => Number(u.id_usuario) === Number(s.id_usuario_1));
      return {
        id_usuario_1: s.id_usuario_1,
        nombre: u ? u.nombre : 'Anónimo',
        foto_perfil: u ? u.foto_perfil : null
      };
    });
  }

  // ============================================================
  //  API: LOGROS
  // ============================================================
  async function revisarLogros(idUsuario) {
    await init();
    const eventos = _db.asistencias.filter(a => Number(a.id_participante) === Number(idUsuario)).length;
    const resenas = _db.resenas.filter(r => Number(r.id_participante) === Number(idUsuario)).length;

    const posibles = [];
    if (eventos >= 1) posibles.push(['Primer evento', 'Asististe a tu primer evento.']);
    if (eventos >= 5) posibles.push(['Explorador MANTRA', 'Has asistido a 5 eventos.']);
    if (resenas >= 1) posibles.push(['Primera reseña', 'Publicaste tu primera reseña.']);

    for (const [nombre, desc] of posibles) {
      const existe = _db.logros.find(l =>
        Number(l.id_usuario) === Number(idUsuario) && l.nombre_logro === nombre
      );
      if (!existe) {
        const idLogro = _nextId(_db.logros, 'id_logro');
        _db.logros.push({
          id_logro: idLogro,
          id_usuario: Number(idUsuario),
          nombre_logro: nombre,
          descripcion: desc,
          fecha_obtenido: _today()
        });
      }
    }
    _save('logros');
    return { ok: true };
  }

  async function getLogros(idUsuario) {
    await init();
    return _db.logros
      .filter(l => Number(l.id_usuario) === Number(idUsuario))
      .sort((a, b) => b.id_logro - a.id_logro);
  }

  // ============================================================
  //  API: USUARIO POR ID
  // ============================================================
  async function getUsuario(id) {
    await init();
    const u = _db.usuarios.find(u => Number(u.id_usuario) === Number(id));
    if (!u) return null;
    return { id_usuario: u.id_usuario, nombre: u.nombre, foto_perfil: u.foto_perfil };
  }

  // ============================================================
  //  API: CHAT
  // ============================================================
  async function iniciarChat(id_usuario_1, id_usuario_2) {
    await init();
    if (Number(id_usuario_1) === Number(id_usuario_2)) {
      return { ok: false, error: 'No puedes iniciar chat contigo mismo.' };
    }
    const existe = _db.conversaciones.find(c =>
      (Number(c.id_usuario_1) === Number(id_usuario_1) && Number(c.id_usuario_2) === Number(id_usuario_2)) ||
      (Number(c.id_usuario_1) === Number(id_usuario_2) && Number(c.id_usuario_2) === Number(id_usuario_1))
    );
    if (existe) {
      return { ok: true, id_conversacion: existe.id_conversacion };
    }
    const idConversacion = _nextId(_db.conversaciones, 'id_conversacion');
    _db.conversaciones.push({
      id_conversacion: idConversacion,
      id_usuario_1: Number(id_usuario_1),
      id_usuario_2: Number(id_usuario_2),
      fecha_creacion: _now()
    });
    _save('conversaciones');
    return { ok: true, id_conversacion: idConversacion };
  }

  async function getConversaciones(idUsuario) {
    await init();
    return _db.conversaciones
      .filter(c => Number(c.id_usuario_1) === Number(idUsuario) || Number(c.id_usuario_2) === Number(idUsuario))
      .map(c => {
        const isUser1 = Number(c.id_usuario_1) === Number(idUsuario);
        const otroId = isUser1 ? c.id_usuario_2 : c.id_usuario_1;
        const otro = _db.usuarios.find(u => Number(u.id_usuario) === Number(otroId));
        const ultimoMsg = _db.mensajes
          .filter(m => Number(m.id_conversacion) === Number(c.id_conversacion))
          .sort((a, b) => (b.fecha_envio || '').localeCompare(a.fecha_envio || ''))[0];
        return {
          id_conversacion: c.id_conversacion,
          fecha_creacion: c.fecha_creacion,
          id_otro_usuario: otroId,
          nombre_otro_usuario: otro ? otro.nombre : 'Anónimo',
          foto_otro_usuario: otro ? otro.foto_perfil : null,
          ultimo_mensaje: ultimoMsg ? ultimoMsg.contenido : null
        };
      })
      .sort((a, b) => (b.fecha_creacion || '').localeCompare(a.fecha_creacion || ''));
  }

  async function getMensajes(idConversacion) {
    await init();
    return _db.mensajes
      .filter(m => Number(m.id_conversacion) === Number(idConversacion))
      .map(m => {
        const u = _db.usuarios.find(u => Number(u.id_usuario) === Number(m.id_emisor));
        return {
          id_mensaje: m.id_mensaje,
          id_conversacion: m.id_conversacion,
          id_emisor: m.id_emisor,
          contenido: m.contenido,
          fecha_envio: m.fecha_envio,
          nombre: u ? u.nombre : 'Anónimo',
          foto_perfil: u ? u.foto_perfil : null
        };
      })
      .sort((a, b) => (a.fecha_envio || '').localeCompare(b.fecha_envio || ''));
  }

  async function enviarMensaje(id_conversacion, id_emisor, contenido) {
    await init();
    if (!contenido || contenido.trim() === '') {
      return { ok: false, error: 'El mensaje está vacío.' };
    }
    const idMensaje = _nextId(_db.mensajes, 'id_mensaje');
    _db.mensajes.push({
      id_mensaje: idMensaje,
      id_conversacion: Number(id_conversacion),
      id_emisor: Number(id_emisor),
      contenido: contenido,
      fecha_envio: _now(),
      leido: false
    });
    _save('mensajes');
    return { ok: true, message: 'Mensaje enviado.' };
  }

  // ============================================================
  //  EXPORTAR API PÚBLICA
  // ============================================================
  return {
    init,
    reset,
    login,
    registerAsistidor,
    registerOrganizador,
    getFeed,
    confirmarAsistencia,
    crearEvento,
    getMisEventos,
    eliminarEvento,
    getMetricas,
    crearResena,
    getResenas,
    getPerfil,
    actualizarFotoPerfil,
    actualizarPerfil,
    getActividad,
    getOwnerUsuarios,
    seguirOrganizador,
    dejarDeSeguir,
    crearComentarioEvento,
    getComentariosEvento,
    crearPublicacion,
    getComunidadFeed,
    crearComentarioPublicacion,
    getComentariosPublicacion,
    darLike,
    quitarLike,
    getNotificaciones,
    marcarNotificacionLeida,
    solicitarAmistad,
    aceptarAmistad,
    getAmigos,
    getSolicitudesAmistad,
    revisarLogros,
    getLogros,
    getUsuario,
    iniciarChat,
    getConversaciones,
    getMensajes,
    enviarMensaje
  };

})();
