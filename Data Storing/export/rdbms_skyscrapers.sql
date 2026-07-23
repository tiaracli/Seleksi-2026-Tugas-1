--
-- PostgreSQL database dump
--

\restrict RmG0dSE2vmHUChrkwUFI9Wbl0oOYeEuhqkxTRLfIt58ItkiI4uN5maxKtLjvbmk

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
-- Name: buildings; Type: TABLE; Schema: public; Owner: tiaraclianta
--

CREATE TABLE public.buildings (
    building_id integer NOT NULL,
    name character varying(255) NOT NULL,
    city_id integer,
    completion_year integer,
    height_m double precision,
    height_ft double precision,
    floors integer,
    function character varying(100),
    material character varying(100)
);


ALTER TABLE public.buildings OWNER TO tiaraclianta;

--
-- Name: cities; Type: TABLE; Schema: public; Owner: tiaraclianta
--

CREATE TABLE public.cities (
    city_id integer NOT NULL,
    city_name character varying(100) NOT NULL
);


ALTER TABLE public.cities OWNER TO tiaraclianta;

--
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: tiaraclianta
--

COPY public.buildings (building_id, name, city_id, completion_year, height_m, height_ft, floors, function, material) FROM stdin;
1	Burj Khalifa	1	2010	828	2717	163	Office / Residential / Hotel	Steel Over Concrete
2	Merdeka 118	2	2023	679	2227	118	Hotel / Serviced Apartments / Office	Concrete-Steel Composite
3	Shanghai Tower	3	2015	632	2073	128	Hotel / Office	Concrete-Steel Composite
4	Makkah Royal Clock Tower	4	2012	601	1972	120	Serviced Apartments / Hotel / Retail	Steel Over Concrete
5	Ping An Finance Center	5	2017	599	1965	115	Office	Concrete-Steel Composite
6	Lotte World Tower	6	2017	555	1819	123	Hotel / Residential / Office / Retail	Concrete-Steel Composite
7	One World Trade Center	7	2014	541	1776	94	Office	Concrete-Steel Composite
8	Guangzhou CTF Finance Centre	8	2016	530	1739	111	Hotel / Residential / Office	Composite
9	Tianjin CTF Finance Centre	9	2019	530	1739	97	Hotel / Serviced Apartments / Office	Concrete-Steel Composite
10	CITIC Tower	10	2018	528	1731	109	Office	Concrete-Steel Composite
11	TAIPEI 101	11	2004	508	1667	101	Office	Composite
12	Shanghai World Financial Center	3	2008	492	1614	101	Hotel / Office	Concrete-Steel Composite
13	International Commerce Centre	12	2010	484	1588	108	Hotel / Office	Concrete-Steel Composite
14	Wuhan Greenland Center	13	2023	476	1560	101	Hotel / Serviced Apartments / Office	Concrete-Steel Composite
15	Central Park Tower	7	2020	472	1550	98	Residential / Retail	All-Concrete
16	Lakhta Center	14	2019	462	1516	87	Office	Concrete-Steel Composite
17	Vincom Landmark 81	15	2018	461	1513	81	Hotel / Residential	Concrete-Steel Composite
18	The Exchange 106	2	2019	454	1488	95	Office	Concrete-Steel Composite
19	Changsha IFS Tower T1	16	2018	452	1483	94	Hotel / Office	Concrete-Steel Composite
20	Petronas Twin Tower 1	2	1998	452	1483	88	Office	Concrete-Steel Composite
21	Petronas Twin Tower 2	2	1998	452	1483	88	Office	Concrete-Steel Composite
22	Suzhou IFS	17	2019	450	1476	95	Hotel / Office / Serviced Apartments	Concrete-Steel Composite
23	Zifeng Tower	18	2010	450	1476	66	Hotel / Office	Concrete-Steel Composite
24	Wuhan Tower	13	2019	443	1454	88	Hotel / Residential / Office	Concrete-Steel Composite
25	Willis Tower	19	1974	442	1451	108	Office	All-Steel
26	KK100	5	2011	442	1449	98	Hotel / Office	Concrete-Steel Composite
27	Guangzhou International Finance Center	8	2010	439	1439	101	Hotel / Office	Concrete-Steel Composite
28	111 West 57th Street	7	2021	435	1428	84	Residential	Steel Over Concrete
29	One Vanderbilt Avenue	7	2020	427	1401	62	Office	Concrete-Steel Composite
30	432 Park Avenue	7	2015	426	1397	85	Residential	All-Concrete
31	Marina 101	1	2017	425	1394	101	Residential / Hotel	All-Concrete
32	Trump International Hotel & Tower	19	2009	423	1389	98	Residential / Hotel	All-Concrete
33	JPMorganChase Tower	7	2025	423	1388	61	Office	Concrete-Steel Composite
34	Minying International Trade Center T2	20	2021	423	1386	85	Office	Concrete-Steel Composite
35	Jin Mao Tower	3	1999	421	1380	88	Hotel / Office	Concrete-Steel Composite
36	Zijin Financial Building	18	2025	417	1367	88	Hotel / Office	Concrete-Steel Composite
37	Princess Tower	1	2012	413	1356	101	Residential	Steel Over Concrete
38	Al Hamra Tower	21	2011	413	1354	80	Office	All-Concrete
39	Two International Finance Centre	12	2003	412	1352	88	Office	Concrete-Steel Composite
40	LCT The Sharp Landmark Tower	22	2019	412	1350	101	Hotel / Residential	All-Concrete
41	Ningbo Center Tower 1	23	2025	409	1342	80	Hotel / Residential / Office	Concrete-Steel Composite
42	Guangxi China Resources Tower	24	2020	403	1321	86	Hotel / Office	Concrete-Steel Composite
43	Guiyang International Financial Center T1	25	2020	401	1316	79	Hotel / Office	Concrete-Steel Composite
44	Iconic Tower	26	2024	394	1292	77	Hotel / Residential / Office	Concrete-Steel Composite
45	China Merchants Bank Global Headquarters Main Tower	5	2025	393	1289	77	Office	Composite
46	China Resources Tower	5	2018	393	1288	68	Office	Concrete-Steel Composite
47	23 Marina	1	2012	23	1287	88	Residential	All-Concrete
48	CITIC Plaza	8	1996	390	1280	80	Office	Concrete-Steel Composite
49	CITYMARK CENTRE	5	2022	388	1274	70	Residential / Office	Concrete-Steel Composite
50	Shum Yip Upperhills Tower 1	5	2020	388	1273	80	Hotel / Office	Concrete-Steel Composite
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: tiaraclianta
--

COPY public.cities (city_id, city_name) FROM stdin;
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
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: tiaraclianta
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (building_id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: tiaraclianta
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- Name: idx_buildings_city_id; Type: INDEX; Schema: public; Owner: tiaraclianta
--

CREATE INDEX idx_buildings_city_id ON public.buildings USING btree (city_id);


--
-- Name: idx_buildings_floors; Type: INDEX; Schema: public; Owner: tiaraclianta
--

CREATE INDEX idx_buildings_floors ON public.buildings USING btree (floors DESC);


--
-- Name: idx_buildings_height_year; Type: INDEX; Schema: public; Owner: tiaraclianta
--

CREATE INDEX idx_buildings_height_year ON public.buildings USING btree (height_m, completion_year);


--
-- Name: buildings buildings_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tiaraclianta
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id);


--
-- PostgreSQL database dump complete
--

\unrestrict RmG0dSE2vmHUChrkwUFI9Wbl0oOYeEuhqkxTRLfIt58ItkiI4uN5maxKtLjvbmk

