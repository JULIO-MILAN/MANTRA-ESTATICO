--
-- PostgreSQL database dump
--

\restrict 8Z4CjfJH4RN5lAf9RXydBxl33hE8uIUhc5snfnR9Z6cwUdmcgOh7Tmm9vWTJhrR

-- Dumped from database version 17.10 (Debian 17.10-1.pgdg12+1)
-- Dumped by pg_dump version 18.2

-- Started on 2026-06-24 16:42:49

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: mantra_3z8k_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO mantra_3z8k_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 16879)
-- Name: amistad; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.amistad (
    id_usuario_1 integer NOT NULL,
    id_usuario_2 integer NOT NULL,
    estado character varying(20),
    fecha_solicitud date
);


ALTER TABLE public.amistad OWNER TO mantra_3z8k_user;

--
-- TOC entry 224 (class 1259 OID 16752)
-- Name: asistencia; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.asistencia (
    id_participante integer NOT NULL,
    id_evento integer NOT NULL
);


ALTER TABLE public.asistencia OWNER TO mantra_3z8k_user;

--
-- TOC entry 221 (class 1259 OID 16720)
-- Name: categoria; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    nombre_cat character varying(100) NOT NULL
);


ALTER TABLE public.categoria OWNER TO mantra_3z8k_user;

--
-- TOC entry 226 (class 1259 OID 16785)
-- Name: comentario_evento; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.comentario_evento (
    id_comentario integer NOT NULL,
    comentario text,
    fecha_publicacion date,
    id_evento integer,
    id_participante integer
);


ALTER TABLE public.comentario_evento OWNER TO mantra_3z8k_user;

--
-- TOC entry 229 (class 1259 OID 16834)
-- Name: comentario_publicacion; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.comentario_publicacion (
    id_comentario integer NOT NULL,
    comentario text,
    fecha_publicacion date,
    id_publicacion integer,
    id_usuario integer
);


ALTER TABLE public.comentario_publicacion OWNER TO mantra_3z8k_user;

--
-- TOC entry 234 (class 1259 OID 16906)
-- Name: conversacion; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.conversacion (
    id_conversacion integer NOT NULL,
    id_usuario_1 integer,
    id_usuario_2 integer,
    fecha_creacion timestamp without time zone
);


ALTER TABLE public.conversacion OWNER TO mantra_3z8k_user;

--
-- TOC entry 222 (class 1259 OID 16725)
-- Name: evento; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.evento (
    id_evento integer NOT NULL,
    titulo character varying(150) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    calle character varying(200),
    ciudad character varying(100),
    imagen_url text,
    id_organizador integer NOT NULL
);


ALTER TABLE public.evento OWNER TO mantra_3z8k_user;

--
-- TOC entry 223 (class 1259 OID 16737)
-- Name: evento_categoria; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.evento_categoria (
    id_evento integer NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE public.evento_categoria OWNER TO mantra_3z8k_user;

--
-- TOC entry 230 (class 1259 OID 16851)
-- Name: like_publicacion; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.like_publicacion (
    id_publicacion integer NOT NULL,
    id_usuario integer NOT NULL
);


ALTER TABLE public.like_publicacion OWNER TO mantra_3z8k_user;

--
-- TOC entry 233 (class 1259 OID 16894)
-- Name: logro_usuario; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.logro_usuario (
    id_logro integer NOT NULL,
    id_usuario integer,
    nombre_logro character varying(100),
    descripcion text,
    fecha_obtenido date
);


ALTER TABLE public.logro_usuario OWNER TO mantra_3z8k_user;

--
-- TOC entry 235 (class 1259 OID 16921)
-- Name: mensaje; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.mensaje (
    id_mensaje integer NOT NULL,
    id_conversacion integer,
    id_emisor integer,
    contenido text,
    fecha_envio timestamp without time zone,
    leido boolean DEFAULT false
);


ALTER TABLE public.mensaje OWNER TO mantra_3z8k_user;

--
-- TOC entry 231 (class 1259 OID 16866)
-- Name: notificacion; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.notificacion (
    id_notificacion integer NOT NULL,
    id_usuario_destino integer,
    mensaje text,
    leida boolean DEFAULT false,
    fecha_creacion date
);


ALTER TABLE public.notificacion OWNER TO mantra_3z8k_user;

--
-- TOC entry 220 (class 1259 OID 16709)
-- Name: organizador; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.organizador (
    id_usuario integer NOT NULL,
    reputacion numeric(4,2) DEFAULT 0
);


ALTER TABLE public.organizador OWNER TO mantra_3z8k_user;

--
-- TOC entry 219 (class 1259 OID 16697)
-- Name: participante; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.participante (
    id_usuario integer NOT NULL,
    intereses text
);


ALTER TABLE public.participante OWNER TO mantra_3z8k_user;

--
-- TOC entry 217 (class 1259 OID 16470)
-- Name: preferencia; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.preferencia (
    id_participante integer NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE public.preferencia OWNER TO mantra_3z8k_user;

--
-- TOC entry 228 (class 1259 OID 16817)
-- Name: publicacion_comunidad; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.publicacion_comunidad (
    id_publicacion integer NOT NULL,
    contenido text,
    fecha_publicacion date,
    imagen_url text,
    id_usuario integer,
    id_evento integer
);


ALTER TABLE public.publicacion_comunidad OWNER TO mantra_3z8k_user;

--
-- TOC entry 225 (class 1259 OID 16767)
-- Name: resena; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.resena (
    id_resena integer NOT NULL,
    calificacion integer,
    comentario text,
    fecha_publicacion date,
    id_evento integer,
    id_participante integer,
    CONSTRAINT resena_calificacion_check CHECK (((calificacion >= 1) AND (calificacion <= 5)))
);


ALTER TABLE public.resena OWNER TO mantra_3z8k_user;

--
-- TOC entry 227 (class 1259 OID 16802)
-- Name: seguidor_organizador; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.seguidor_organizador (
    id_participante integer NOT NULL,
    id_organizador integer NOT NULL
);


ALTER TABLE public.seguidor_organizador OWNER TO mantra_3z8k_user;

--
-- TOC entry 218 (class 1259 OID 16688)
-- Name: usuario; Type: TABLE; Schema: public; Owner: mantra_3z8k_user
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(120) NOT NULL,
    password character varying(255) NOT NULL,
    edad integer,
    biografia text,
    foto_perfil text,
    solo_lectura boolean DEFAULT false
);


ALTER TABLE public.usuario OWNER TO mantra_3z8k_user;

--
-- TOC entry 3517 (class 0 OID 16879)
-- Dependencies: 232
-- Data for Name: amistad; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.amistad (id_usuario_1, id_usuario_2, estado, fecha_solicitud) FROM stdin;
2	4	aceptada	2026-07-01
2	5	aceptada	2026-07-02
4	6	aceptada	2026-07-03
5	7	pendiente	2026-07-04
\.


--
-- TOC entry 3509 (class 0 OID 16752)
-- Dependencies: 224
-- Data for Name: asistencia; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.asistencia (id_participante, id_evento) FROM stdin;
2	1
2	2
2	5
4	1
4	3
5	2
5	6
6	5
7	6
8	7
9	4
10	10
\.


--
-- TOC entry 3506 (class 0 OID 16720)
-- Dependencies: 221
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.categoria (id_categoria, nombre_cat) FROM stdin;
1	Fiestas
2	Conciertos
3	Festivales
4	Antros
5	After Party
6	Networking
7	Universitarios
8	VIP
\.


--
-- TOC entry 3511 (class 0 OID 16785)
-- Dependencies: 226
-- Data for Name: comentario_evento; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.comentario_evento (id_comentario, comentario, fecha_publicacion, id_evento, id_participante) FROM stdin;
1	¿Hay código de vestimenta?	2026-07-02	1	2
2	Yo también voy	2026-07-03	1	4
3	Va a estar increíble	2026-07-04	2	5
\.


--
-- TOC entry 3514 (class 0 OID 16834)
-- Dependencies: 229
-- Data for Name: comentario_publicacion; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.comentario_publicacion (id_comentario, comentario, fecha_publicacion, id_publicacion, id_usuario) FROM stdin;
\.


--
-- TOC entry 3519 (class 0 OID 16906)
-- Dependencies: 234
-- Data for Name: conversacion; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.conversacion (id_conversacion, id_usuario_1, id_usuario_2, fecha_creacion) FROM stdin;
1	2	4	2026-06-22 21:18:12.133818
2	2	5	2026-06-22 21:18:12.133818
\.


--
-- TOC entry 3507 (class 0 OID 16725)
-- Dependencies: 222
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.evento (id_evento, titulo, fecha, hora, calle, ciudad, imagen_url, id_organizador) FROM stdin;
1	Neon Party CDMX	2026-07-10	22:00:00	Reforma 100	Ciudad de México	\N	3
2	Summer Festival	2026-07-15	18:00:00	Parque Bicentenario	Ciudad de México	\N	3
3	Noche Reggaeton	2026-07-20	23:00:00	Zona Rosa	Ciudad de México	\N	6
4	Pool Party VIP	2026-07-25	14:00:00	Bosques	Ciudad de México	\N	9
5	After Techno	2026-08-01	01:00:00	Polanco	Ciudad de México	\N	3
6	Festival Eclipse	2026-08-08	19:00:00	Foro Sol	Ciudad de México	\N	10
7	White Party	2026-08-15	21:00:00	Santa Fe	Ciudad de México	\N	6
8	Noche Latina	2026-08-22	22:30:00	Coyoacán	Ciudad de México	\N	9
9	Urban Beats	2026-09-01	17:00:00	Fundidora	Monterrey	\N	3
10	Fiesta Universitaria	2026-09-10	20:00:00	Centro	Puebla	\N	10
11	ENANITOS FEST	2026-06-18	19:07:00	ssqjnehuwd	AJSJKA	https://res.cloudinary.com/dkrubq7db/image/upload/v1782169541/mantra/eventos/ngpkvbyicn61utgcqrow.jpg	6
\.


--
-- TOC entry 3508 (class 0 OID 16737)
-- Dependencies: 223
-- Data for Name: evento_categoria; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.evento_categoria (id_evento, id_categoria) FROM stdin;
1	1
2	3
3	2
4	8
5	5
6	3
7	8
8	2
9	3
10	7
11	2
\.


--
-- TOC entry 3515 (class 0 OID 16851)
-- Dependencies: 230
-- Data for Name: like_publicacion; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.like_publicacion (id_publicacion, id_usuario) FROM stdin;
1	4
1	5
1	6
2	2
2	5
3	7
4	8
5	2
\.


--
-- TOC entry 3518 (class 0 OID 16894)
-- Dependencies: 233
-- Data for Name: logro_usuario; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.logro_usuario (id_logro, id_usuario, nombre_logro, descripcion, fecha_obtenido) FROM stdin;
\.


--
-- TOC entry 3520 (class 0 OID 16921)
-- Dependencies: 235
-- Data for Name: mensaje; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.mensaje (id_mensaje, id_conversacion, id_emisor, contenido, fecha_envio, leido) FROM stdin;
1	1	2	¿Vas a la Neon Party?	2026-06-22 21:18:20.095867	t
2	1	4	Sí claro	2026-06-22 21:18:20.095867	t
3	2	2	Nos vemos en Summer Festival	2026-06-22 21:18:20.095867	f
\.


--
-- TOC entry 3516 (class 0 OID 16866)
-- Dependencies: 231
-- Data for Name: notificacion; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.notificacion (id_notificacion, id_usuario_destino, mensaje, leida, fecha_creacion) FROM stdin;
1	2	Tienes una nueva amistad	f	2026-06-22
2	4	Nuevo comentario en tu publicación	f	2026-06-22
3	5	Nuevo mensaje recibido	f	2026-06-22
\.


--
-- TOC entry 3505 (class 0 OID 16709)
-- Dependencies: 220
-- Data for Name: organizador; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.organizador (id_usuario, reputacion) FROM stdin;
1	5.00
3	4.90
6	4.70
9	4.80
10	4.60
12	0.00
\.


--
-- TOC entry 3504 (class 0 OID 16697)
-- Dependencies: 219
-- Data for Name: participante; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.participante (id_usuario, intereses) FROM stdin;
2	Electrónica, Festivales
4	Reggaeton, Antros
5	Festivales
6	DJ, Música
7	Conciertos
8	EDM
9	Eventos VIP
10	Fiestas
11	
\.


--
-- TOC entry 3502 (class 0 OID 16470)
-- Dependencies: 217
-- Data for Name: preferencia; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.preferencia (id_participante, id_categoria) FROM stdin;
1	1
1	2
2	3
2	10
3	2
3	5
4	4
4	7
5	6
5	1
6	1
7	7
8	1
9	5
10	2
11	1
12	3
\.


--
-- TOC entry 3513 (class 0 OID 16817)
-- Dependencies: 228
-- Data for Name: publicacion_comunidad; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.publicacion_comunidad (id_publicacion, contenido, fecha_publicacion, imagen_url, id_usuario, id_evento) FROM stdin;
1	¿Quién irá a Neon Party?	2026-07-01	\N	2	1
2	Summer Festival promete mucho 🔥	2026-07-05	\N	4	2
3	Ya tengo mis boletos	2026-07-15	\N	5	6
4	Nos vemos en White Party	2026-08-01	\N	7	7
5	Latino Night se ve brutal	2026-08-05	\N	8	8
6	husjajas	2026-06-22	https://res.cloudinary.com/dkrubq7db/image/upload/v1782163444/mantra/comunidad/xttfxwrzeuqixd0jurkr.jpg	11	\N
7	husjajas	2026-06-22	https://res.cloudinary.com/dkrubq7db/image/upload/v1782163444/mantra/comunidad/uzlj6cxjsesinudbozax.jpg	11	\N
8	pruena	2026-06-22	https://res.cloudinary.com/dkrubq7db/image/upload/v1782163465/mantra/comunidad/kwrobhxj8b0v0turf8py.png	11	\N
\.


--
-- TOC entry 3510 (class 0 OID 16767)
-- Dependencies: 225
-- Data for Name: resena; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.resena (id_resena, calificacion, comentario, fecha_publicacion, id_evento, id_participante) FROM stdin;
1	5	La mejor fiesta del año	2026-07-11	1	2
2	4	Muy buen ambiente	2026-07-16	2	5
3	5	Excelente organización	2026-08-02	5	6
4	5	Increíble experiencia	2026-08-09	6	7
5	4	Muy recomendable	2026-09-11	10	10
\.


--
-- TOC entry 3512 (class 0 OID 16802)
-- Dependencies: 227
-- Data for Name: seguidor_organizador; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.seguidor_organizador (id_participante, id_organizador) FROM stdin;
\.


--
-- TOC entry 3503 (class 0 OID 16688)
-- Dependencies: 218
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: mantra_3z8k_user
--

COPY public.usuario (id_usuario, nombre, email, password, edad, biografia, foto_perfil, solo_lectura) FROM stdin;
1	Owner MANTRA	owner@mantra.com	123456	30	Administrador	\N	f
2	Julio Milan	julio@mantra.com	123456	21	Me gustan las fiestas electrónicas	\N	f
3	Andrea Ruiz	andrea@mantra.com	123456	22	Organizadora de eventos	\N	f
4	Carlos Pérez	carlos@mantra.com	123456	23	Fan del reggaeton	\N	f
5	Fernanda Soto	fernanda@mantra.com	123456	21	Siempre buscando festivales	\N	f
6	Luis Torres	luis@mantra.com	123456	24	DJ amateur	\N	f
7	Sofía Morales	sofia@mantra.com	123456	22	Me encantan los conciertos	\N	f
8	Miguel Herrera	miguel@mantra.com	123456	25	Fan de la música electrónica	\N	f
9	Valeria Díaz	valeria@mantra.com	123456	21	Organizadora de experiencias VIP	\N	f
10	Ricardo López	ricardo@mantra.com	123456	27	Promotor de eventos	\N	f
11	Milan Ewok	milan.ewok@gmail.com	Julio121086	22	Cuenta de prueba	\N	t
12	User Organizador	user5@example.com	pass5	25	Cuenta organizador de prueba	\N	t
\.


--
-- TOC entry 3323 (class 2606 OID 16883)
-- Name: amistad amistad_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.amistad
    ADD CONSTRAINT amistad_pkey PRIMARY KEY (id_usuario_1, id_usuario_2);


--
-- TOC entry 3307 (class 2606 OID 16756)
-- Name: asistencia asistencia_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT asistencia_pkey PRIMARY KEY (id_participante, id_evento);


--
-- TOC entry 3301 (class 2606 OID 16724)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);


--
-- TOC entry 3311 (class 2606 OID 16791)
-- Name: comentario_evento comentario_evento_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.comentario_evento
    ADD CONSTRAINT comentario_evento_pkey PRIMARY KEY (id_comentario);


--
-- TOC entry 3317 (class 2606 OID 16840)
-- Name: comentario_publicacion comentario_publicacion_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.comentario_publicacion
    ADD CONSTRAINT comentario_publicacion_pkey PRIMARY KEY (id_comentario);


--
-- TOC entry 3327 (class 2606 OID 16910)
-- Name: conversacion conversacion_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.conversacion
    ADD CONSTRAINT conversacion_pkey PRIMARY KEY (id_conversacion);


--
-- TOC entry 3305 (class 2606 OID 16741)
-- Name: evento_categoria evento_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT evento_categoria_pkey PRIMARY KEY (id_evento, id_categoria);


--
-- TOC entry 3303 (class 2606 OID 16731)
-- Name: evento evento_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 3319 (class 2606 OID 16855)
-- Name: like_publicacion like_publicacion_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.like_publicacion
    ADD CONSTRAINT like_publicacion_pkey PRIMARY KEY (id_publicacion, id_usuario);


--
-- TOC entry 3325 (class 2606 OID 16900)
-- Name: logro_usuario logro_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.logro_usuario
    ADD CONSTRAINT logro_usuario_pkey PRIMARY KEY (id_logro);


--
-- TOC entry 3329 (class 2606 OID 16928)
-- Name: mensaje mensaje_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.mensaje
    ADD CONSTRAINT mensaje_pkey PRIMARY KEY (id_mensaje);


--
-- TOC entry 3321 (class 2606 OID 16873)
-- Name: notificacion notificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_pkey PRIMARY KEY (id_notificacion);


--
-- TOC entry 3299 (class 2606 OID 16714)
-- Name: organizador organizador_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.organizador
    ADD CONSTRAINT organizador_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 3297 (class 2606 OID 16703)
-- Name: participante participante_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.participante
    ADD CONSTRAINT participante_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 3291 (class 2606 OID 16474)
-- Name: preferencia preferencia_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.preferencia
    ADD CONSTRAINT preferencia_pkey PRIMARY KEY (id_participante, id_categoria);


--
-- TOC entry 3315 (class 2606 OID 16823)
-- Name: publicacion_comunidad publicacion_comunidad_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.publicacion_comunidad
    ADD CONSTRAINT publicacion_comunidad_pkey PRIMARY KEY (id_publicacion);


--
-- TOC entry 3309 (class 2606 OID 16774)
-- Name: resena resena_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.resena
    ADD CONSTRAINT resena_pkey PRIMARY KEY (id_resena);


--
-- TOC entry 3313 (class 2606 OID 16806)
-- Name: seguidor_organizador seguidor_organizador_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.seguidor_organizador
    ADD CONSTRAINT seguidor_organizador_pkey PRIMARY KEY (id_participante, id_organizador);


--
-- TOC entry 3293 (class 2606 OID 16696)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 3295 (class 2606 OID 16694)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 3350 (class 2606 OID 16884)
-- Name: amistad amistad_id_usuario_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.amistad
    ADD CONSTRAINT amistad_id_usuario_1_fkey FOREIGN KEY (id_usuario_1) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3351 (class 2606 OID 16889)
-- Name: amistad amistad_id_usuario_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.amistad
    ADD CONSTRAINT amistad_id_usuario_2_fkey FOREIGN KEY (id_usuario_2) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3335 (class 2606 OID 16762)
-- Name: asistencia asistencia_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT asistencia_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento);


--
-- TOC entry 3336 (class 2606 OID 16757)
-- Name: asistencia asistencia_id_participante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.asistencia
    ADD CONSTRAINT asistencia_id_participante_fkey FOREIGN KEY (id_participante) REFERENCES public.participante(id_usuario);


--
-- TOC entry 3339 (class 2606 OID 16792)
-- Name: comentario_evento comentario_evento_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.comentario_evento
    ADD CONSTRAINT comentario_evento_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento);


--
-- TOC entry 3340 (class 2606 OID 16797)
-- Name: comentario_evento comentario_evento_id_participante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.comentario_evento
    ADD CONSTRAINT comentario_evento_id_participante_fkey FOREIGN KEY (id_participante) REFERENCES public.participante(id_usuario);


--
-- TOC entry 3345 (class 2606 OID 16841)
-- Name: comentario_publicacion comentario_publicacion_id_publicacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.comentario_publicacion
    ADD CONSTRAINT comentario_publicacion_id_publicacion_fkey FOREIGN KEY (id_publicacion) REFERENCES public.publicacion_comunidad(id_publicacion) ON DELETE CASCADE;


--
-- TOC entry 3346 (class 2606 OID 16846)
-- Name: comentario_publicacion comentario_publicacion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.comentario_publicacion
    ADD CONSTRAINT comentario_publicacion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3353 (class 2606 OID 16911)
-- Name: conversacion conversacion_id_usuario_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.conversacion
    ADD CONSTRAINT conversacion_id_usuario_1_fkey FOREIGN KEY (id_usuario_1) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3354 (class 2606 OID 16916)
-- Name: conversacion conversacion_id_usuario_2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.conversacion
    ADD CONSTRAINT conversacion_id_usuario_2_fkey FOREIGN KEY (id_usuario_2) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3333 (class 2606 OID 16747)
-- Name: evento_categoria evento_categoria_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT evento_categoria_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria) ON DELETE CASCADE;


--
-- TOC entry 3334 (class 2606 OID 16742)
-- Name: evento_categoria evento_categoria_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.evento_categoria
    ADD CONSTRAINT evento_categoria_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento) ON DELETE CASCADE;


--
-- TOC entry 3332 (class 2606 OID 16732)
-- Name: evento evento_id_organizador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_id_organizador_fkey FOREIGN KEY (id_organizador) REFERENCES public.organizador(id_usuario);


--
-- TOC entry 3347 (class 2606 OID 16856)
-- Name: like_publicacion like_publicacion_id_publicacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.like_publicacion
    ADD CONSTRAINT like_publicacion_id_publicacion_fkey FOREIGN KEY (id_publicacion) REFERENCES public.publicacion_comunidad(id_publicacion) ON DELETE CASCADE;


--
-- TOC entry 3348 (class 2606 OID 16861)
-- Name: like_publicacion like_publicacion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.like_publicacion
    ADD CONSTRAINT like_publicacion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3352 (class 2606 OID 16901)
-- Name: logro_usuario logro_usuario_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.logro_usuario
    ADD CONSTRAINT logro_usuario_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3355 (class 2606 OID 16929)
-- Name: mensaje mensaje_id_conversacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.mensaje
    ADD CONSTRAINT mensaje_id_conversacion_fkey FOREIGN KEY (id_conversacion) REFERENCES public.conversacion(id_conversacion) ON DELETE CASCADE;


--
-- TOC entry 3356 (class 2606 OID 16934)
-- Name: mensaje mensaje_id_emisor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.mensaje
    ADD CONSTRAINT mensaje_id_emisor_fkey FOREIGN KEY (id_emisor) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3349 (class 2606 OID 16874)
-- Name: notificacion notificacion_id_usuario_destino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_id_usuario_destino_fkey FOREIGN KEY (id_usuario_destino) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3331 (class 2606 OID 16715)
-- Name: organizador organizador_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.organizador
    ADD CONSTRAINT organizador_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 3330 (class 2606 OID 16704)
-- Name: participante participante_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.participante
    ADD CONSTRAINT participante_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 3343 (class 2606 OID 16829)
-- Name: publicacion_comunidad publicacion_comunidad_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.publicacion_comunidad
    ADD CONSTRAINT publicacion_comunidad_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento);


--
-- TOC entry 3344 (class 2606 OID 16824)
-- Name: publicacion_comunidad publicacion_comunidad_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.publicacion_comunidad
    ADD CONSTRAINT publicacion_comunidad_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3337 (class 2606 OID 16775)
-- Name: resena resena_id_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.resena
    ADD CONSTRAINT resena_id_evento_fkey FOREIGN KEY (id_evento) REFERENCES public.evento(id_evento);


--
-- TOC entry 3338 (class 2606 OID 16780)
-- Name: resena resena_id_participante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.resena
    ADD CONSTRAINT resena_id_participante_fkey FOREIGN KEY (id_participante) REFERENCES public.participante(id_usuario);


--
-- TOC entry 3341 (class 2606 OID 16812)
-- Name: seguidor_organizador seguidor_organizador_id_organizador_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.seguidor_organizador
    ADD CONSTRAINT seguidor_organizador_id_organizador_fkey FOREIGN KEY (id_organizador) REFERENCES public.organizador(id_usuario);


--
-- TOC entry 3342 (class 2606 OID 16807)
-- Name: seguidor_organizador seguidor_organizador_id_participante_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mantra_3z8k_user
--

ALTER TABLE ONLY public.seguidor_organizador
    ADD CONSTRAINT seguidor_organizador_id_participante_fkey FOREIGN KEY (id_participante) REFERENCES public.participante(id_usuario);


--
-- TOC entry 2116 (class 826 OID 16391)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO mantra_3z8k_user;


--
-- TOC entry 2118 (class 826 OID 16393)
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO mantra_3z8k_user;


--
-- TOC entry 2117 (class 826 OID 16392)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO mantra_3z8k_user;


--
-- TOC entry 2115 (class 826 OID 16390)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO mantra_3z8k_user;


-- Completed on 2026-06-24 16:43:01

--
-- PostgreSQL database dump complete
--

\unrestrict 8Z4CjfJH4RN5lAf9RXydBxl33hE8uIUhc5snfnR9Z6cwUdmcgOh7Tmm9vWTJhrR

