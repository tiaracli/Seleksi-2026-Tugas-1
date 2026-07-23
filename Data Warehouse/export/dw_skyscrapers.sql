--
-- PostgreSQL database dump
--

\restrict v4qVv8OPbwaBJhL2hg6fAg80rpMScEOe2nEaIPiV03ercRFD6ymvBvTAaYLDebj

-- Dumped from database version 14.23 (Homebrew)
-- Dumped by pg_dump version 14.23 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dim_cities; Type: TABLE; Schema: public; Owner: tiaraclianta
--

CREATE TABLE public.dim_cities (
    city_id integer,
    city_name character varying(100)
);


ALTER TABLE public.dim_cities OWNER TO tiaraclianta;

--
-- Name: dim_functions; Type: TABLE; Schema: public; Owner: tiaraclianta
--

CREATE TABLE public.dim_functions (
    function_id integer NOT NULL,
    function_name character varying(100)
);


ALTER TABLE public.dim_functions OWNER TO tiaraclianta;

--
-- Name: dim_functions_function_id_seq; Type: SEQUENCE; Schema: public; Owner: tiaraclianta
--

CREATE SEQUENCE public.dim_functions_function_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dim_functions_function_id_seq OWNER TO tiaraclianta;

--
-- Name: dim_functions_function_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tiaraclianta
--

ALTER SEQUENCE public.dim_functions_function_id_seq OWNED BY public.dim_functions.function_id;


--
-- Name: dim_materials; Type: TABLE; Schema: public; Owner: tiaraclianta
--

CREATE TABLE public.dim_materials (
    material_id integer NOT NULL,
    material_name character varying(100)
);


ALTER TABLE public.dim_materials OWNER TO tiaraclianta;

--
-- Name: dim_materials_material_id_seq; Type: SEQUENCE; Schema: public; Owner: tiaraclianta
--

CREATE SEQUENCE public.dim_materials_material_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dim_materials_material_id_seq OWNER TO tiaraclianta;

--
-- Name: dim_materials_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tiaraclianta
--

ALTER SEQUENCE public.dim_materials_material_id_seq OWNED BY public.dim_materials.material_id;


--
-- Name: fact_buildings; Type: TABLE; Schema: public; Owner: tiaraclianta
--

CREATE TABLE public.fact_buildings (
    building_id integer,
    city_id integer,
    material_id integer,
    function_id integer,
    completion_year integer,
    height_m double precision,
    height_ft double precision,
    floors integer
);


ALTER TABLE public.fact_buildings OWNER TO tiaraclianta;

--
-- Name: dim_functions function_id; Type: DEFAULT; Schema: public; Owner: tiaraclianta
--

ALTER TABLE ONLY public.dim_functions ALTER COLUMN function_id SET DEFAULT nextval('public.dim_functions_function_id_seq'::regclass);


--
-- Name: dim_materials material_id; Type: DEFAULT; Schema: public; Owner: tiaraclianta
--

ALTER TABLE ONLY public.dim_materials ALTER COLUMN material_id SET DEFAULT nextval('public.dim_materials_material_id_seq'::regclass);


--
-- Data for Name: dim_cities; Type: TABLE DATA; Schema: public; Owner: tiaraclianta
--

COPY public.dim_cities (city_id, city_name) FROM stdin;
1	Dubai
2	Kuala Lumpur
3	Shanghai
4	Mecca
5	Shenzhen
6	Seoul
7	New York City
8	Guangzhou
9	Tianjin
10	Beijing
11	Taipei
12	Hong Kong
13	Wuhan
14	St. Petersburg
15	Ho Chi Minh City
16	Changsha
17	Suzhou
18	Nanjing
19	Chicago
20	Dongguan
21	Kuwait City
22	Busan
23	Ningbo
24	Nanning
25	Guiyang
26	Cairo
\.


--
-- Data for Name: dim_functions; Type: TABLE DATA; Schema: public; Owner: tiaraclianta
--

COPY public.dim_functions (function_id, function_name) FROM stdin;
1	Hotel / Office
2	Hotel / Residential / Office
3	Residential / Office
4	Hotel / Residential / Office / Retail
5	Office / Residential / Hotel
6	Hotel / Serviced Apartments / Office
7	Residential / Hotel
8	Hotel / Residential
9	Residential
10	Hotel / Office / Serviced Apartments
11	Office
12	Serviced Apartments / Hotel / Retail
13	Residential / Retail
\.


--
-- Data for Name: dim_materials; Type: TABLE DATA; Schema: public; Owner: tiaraclianta
--

COPY public.dim_materials (material_id, material_name) FROM stdin;
1	Composite
2	Concrete-Steel Composite
3	All-Concrete
4	All-Steel
5	Steel Over Concrete
\.


--
-- Data for Name: fact_buildings; Type: TABLE DATA; Schema: public; Owner: tiaraclianta
--

COPY public.fact_buildings (building_id, city_id, material_id, function_id, completion_year, height_m, height_ft, floors) FROM stdin;
3	3	2	1	2015	632	2073	128
12	3	2	1	2008	492	1614	101
13	12	2	1	2010	484	1588	108
19	16	2	1	2018	452	1483	94
23	18	2	1	2010	450	1476	66
26	5	2	1	2011	442	1449	98
27	8	2	1	2010	439	1439	101
35	3	2	1	1999	421	1380	88
36	18	2	1	2025	417	1367	88
42	24	2	1	2020	403	1321	86
43	25	2	1	2020	401	1316	79
50	5	2	1	2020	388	1273	80
24	13	2	2	2019	443	1454	88
41	23	2	2	2025	409	1342	80
44	26	2	2	2024	394	1292	77
8	8	1	2	2016	530	1739	111
49	5	2	3	2022	388	1274	70
6	6	2	4	2017	555	1819	123
1	1	5	5	2010	828	2717	163
2	2	2	6	2023	679	2227	118
9	9	2	6	2019	530	1739	97
14	13	2	6	2023	476	1560	101
31	1	3	7	2017	425	1394	101
32	19	3	7	2009	423	1389	98
40	22	3	8	2019	412	1350	101
17	15	2	8	2018	461	1513	81
28	7	5	9	2021	435	1428	84
37	1	5	9	2012	413	1356	101
30	7	3	9	2015	426	1397	85
47	1	3	9	2012	23	1287	88
22	17	2	10	2019	450	1476	95
25	19	4	11	1974	442	1451	108
38	21	3	11	2011	413	1354	80
5	5	2	11	2017	599	1965	115
7	7	2	11	2014	541	1776	94
10	10	2	11	2018	528	1731	109
16	14	2	11	2019	462	1516	87
18	2	2	11	2019	454	1488	95
20	2	2	11	1998	452	1483	88
21	2	2	11	1998	452	1483	88
29	7	2	11	2020	427	1401	62
33	7	2	11	2025	423	1388	61
34	20	2	11	2021	423	1386	85
39	12	2	11	2003	412	1352	88
46	5	2	11	2018	393	1288	68
48	8	2	11	1996	390	1280	80
11	11	1	11	2004	508	1667	101
45	5	1	11	2025	393	1289	77
4	4	5	12	2012	601	1972	120
15	7	3	13	2020	472	1550	98
\.


--
-- Name: dim_functions_function_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tiaraclianta
--

SELECT pg_catalog.setval('public.dim_functions_function_id_seq', 13, true);


--
-- Name: dim_materials_material_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tiaraclianta
--

SELECT pg_catalog.setval('public.dim_materials_material_id_seq', 5, true);


--
-- Name: dim_functions dim_functions_function_name_key; Type: CONSTRAINT; Schema: public; Owner: tiaraclianta
--

ALTER TABLE ONLY public.dim_functions
    ADD CONSTRAINT dim_functions_function_name_key UNIQUE (function_name);


--
-- Name: dim_functions dim_functions_pkey; Type: CONSTRAINT; Schema: public; Owner: tiaraclianta
--

ALTER TABLE ONLY public.dim_functions
    ADD CONSTRAINT dim_functions_pkey PRIMARY KEY (function_id);


--
-- Name: dim_materials dim_materials_material_name_key; Type: CONSTRAINT; Schema: public; Owner: tiaraclianta
--

ALTER TABLE ONLY public.dim_materials
    ADD CONSTRAINT dim_materials_material_name_key UNIQUE (material_name);


--
-- Name: dim_materials dim_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: tiaraclianta
--

ALTER TABLE ONLY public.dim_materials
    ADD CONSTRAINT dim_materials_pkey PRIMARY KEY (material_id);


--
-- PostgreSQL database dump complete
--

\unrestrict v4qVv8OPbwaBJhL2hg6fAg80rpMScEOe2nEaIPiV03ercRFD6ymvBvTAaYLDebj

