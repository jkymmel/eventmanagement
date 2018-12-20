--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: d_aeg; Type: DOMAIN; Schema: public; Owner: t155407
--

CREATE DOMAIN public.d_aeg AS timestamp without time zone NOT NULL DEFAULT LOCALTIMESTAMP(0)
	CONSTRAINT chk_d_aeg CHECK (((VALUE >= '2010-01-01 00:00:00'::timestamp without time zone) AND (VALUE <= '2099-01-01 23:59:59'::timestamp without time zone)));


--
-- Name: d_kood; Type: DOMAIN; Schema: public; Owner: t155407
--

CREATE DOMAIN public.d_kood AS character(3) NOT NULL
	CONSTRAINT chk_kood_ei_koosne_tyhikutest_pole_tyhi CHECK ((VALUE !~ '^[[:space:]]*$'::text));


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: amet; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.amet (
    amet_kood public.d_kood NOT NULL,
    nimetus character varying(63) NOT NULL,
    kirjeldus text
);

--
-- Name: asukoht; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.asukoht (
    asukoht_kood public.d_kood NOT NULL,
    aadress character varying(255) NOT NULL,
    nimetus character varying(63) NOT NULL
);

--
-- Name: isik; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.isik (
    isik_id integer NOT NULL,
    e_meil character varying(254) NOT NULL,
    isikukood character varying(63) NOT NULL,
    isikukoodi_riik character(3) NOT NULL,
    parool character varying(50) NOT NULL,
    eesnimi character varying(255) NOT NULL,
    perenimi character varying(255),
    elukoht character varying(255),
    synni_kp date NOT NULL,
    reg_aeg public.d_aeg DEFAULT LOCALTIMESTAMP NOT NULL,
    isiku_seisundi_liik_kood smallint DEFAULT 1 NOT NULL,
    CONSTRAINT chk_isik_elukoht_ei_koosne_tyhikutest_pole_tyhi CHECK (((elukoht)::text !~ '^[[:space:]]*$'::text)),
    CONSTRAINT chk_isik_email_ainult_lubatud_sumbolid CHECK (((e_meil)::text ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'::text)),
    CONSTRAINT chk_isik_isikukood_eesti_isikukood CHECK (((NOT (isikukoodi_riik = 'EST'::bpchar)) OR ((isikukood)::text ~ '^([3-6]{1}[[:digit:]]{2}[0-1]{1}[[:digit:]]{1}[0-3]{1}[[:digit:]]{5})$'::text))),
    CONSTRAINT chk_isik_synni_kp_on_suurem_vordne_kui_1900_01_01 CHECK ((synni_kp >= '1900-01-01'::date)),
    CONSTRAINT chk_isik_synni_kp_pole_suurem_vordne_tanasest_kuupaevast CHECK ((synni_kp <= CURRENT_DATE))
);

--
-- Name: isiku_seisundi_liik; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.isiku_seisundi_liik (
    isiku_seisundi_liik_kood smallint NOT NULL,
    nimetus character varying(63) NOT NULL
);

--
-- Name: kliendi_seisundi_liik; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.kliendi_seisundi_liik (
    kliendi_seisundi_liik_kood smallint NOT NULL,
    nimetus character varying(63) NOT NULL
);

--
-- Name: klient; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.klient (
    isik_id integer NOT NULL,
    kliendi_seisundi_liik_kood smallint DEFAULT 1 NOT NULL,
    on_nous_tylitamisega boolean DEFAULT false NOT NULL
);

--
-- Name: riik; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.riik (
    riik_kood public.d_kood NOT NULL,
    nimetus character varying(63) NOT NULL,
    CONSTRAINT chk_riik_kood_ainult_3_suurt_tahed CHECK (((riik_kood)::bpchar ~ '[A-Z][A-Z][A-Z]'::text))
);

--
-- Name: seq_isik_isik_id; Type: SEQUENCE; Schema: public; Owner: t164024
--

CREATE SEQUENCE public.seq_isik_isik_id
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seq_isik_isik_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: t164024
--

ALTER SEQUENCE public.seq_isik_isik_id OWNED BY public.isik.isik_id;


--
-- Name: yritus; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.yritus (
    yritus_id integer NOT NULL,
    nimi character varying(63) NOT NULL,
    asukoht_kood public.d_kood NOT NULL,
    algus_aeg public.d_aeg NOT NULL,
    lopp_aeg timestamp with time zone,
    kirjeldus text NOT NULL,
    piletite_arv integer,
    yrituse_seisundi_liik_kood smallint DEFAULT 1 NOT NULL,
    reg_aeg public.d_aeg DEFAULT LOCALTIMESTAMP NOT NULL,
    looja_id integer NOT NULL,
    CONSTRAINT chk_yritus_algus_aeg_vahemik_2010_2100 CHECK ((((algus_aeg)::timestamp without time zone >= '2010-01-01 02:00:00+02'::timestamp with time zone) AND ((algus_aeg)::timestamp without time zone < '2100-01-02 02:00:00+02'::timestamp with time zone))),
    CONSTRAINT chk_yritus_kirjeldus_ei_koosne_tyhikutest_pole_tyhi CHECK ((kirjeldus !~ '^[[:space:]]*$'::text)),
    CONSTRAINT chk_yritus_lopp_aeg_suurem_vordne_algus_aeg CHECK ((lopp_aeg >= (algus_aeg)::timestamp without time zone)),
    CONSTRAINT chk_yritus_lopp_aeg_vahemik_2010_2100 CHECK (((lopp_aeg >= '2010-01-01 02:00:00+02'::timestamp with time zone) AND (lopp_aeg < '2100-01-02 02:00:00+02'::timestamp with time zone))),
    CONSTRAINT chk_yritus_nimi_ei_koosne_tyhikutest_pole_tyhi CHECK (((nimi)::text !~ '^[[:space:]]*$'::text)),
    CONSTRAINT chk_yritus_piletite_arv_positiivne CHECK ((piletite_arv > 0)),
    CONSTRAINT chk_yritus_reg_aeg_pole_suurem_tanasest_kuupaevast CHECK (((reg_aeg)::timestamp without time zone <= LOCALTIMESTAMP))
);

--
-- Name: seq_yritus_yritus_id; Type: SEQUENCE; Schema: public; Owner: t164024
--

CREATE SEQUENCE public.seq_yritus_yritus_id
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- Name: seq_yritus_yritus_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: t164024
--

ALTER SEQUENCE public.seq_yritus_yritus_id OWNED BY public.yritus.yritus_id;


--
-- Name: tootaja; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.tootaja (
    isik_id integer NOT NULL,
    amet_kood public.d_kood NOT NULL,
    tootaja_seisundi_liik_kood smallint DEFAULT 1 NOT NULL,
    juhendaja_id integer
);


--
-- Name: tootaja_seisundi_liik; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.tootaja_seisundi_liik (
    tootaja_seisundi_liik_kood smallint NOT NULL,
    nimetus character varying(63) NOT NULL
);

--
-- Name: yrituse_kategooria; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.yrituse_kategooria (
    yrituse_kategooria_kood public.d_kood NOT NULL,
    nimetus character varying(63) NOT NULL,
    yrituse_kategooria_tyyp_kood public.d_kood NOT NULL,
    CONSTRAINT chk_yrituse_kategooria_kood_ei_koosne_tyhikutest_pole_tyhi CHECK (((yrituse_kategooria_kood)::bpchar !~ '^[[:space:]]*$'::text))
);

--
-- Name: yrituse_kategooria_omamine; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.yrituse_kategooria_omamine (
    yritus_id integer NOT NULL,
    yrituse_kategooria_kood public.d_kood NOT NULL
);

--
-- Name: yrituse_kategooria_tyyp; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.yrituse_kategooria_tyyp (
    yrituse_kategooria_tyyp_kood public.d_kood NOT NULL,
    nimetus character varying(63) NOT NULL,
    CONSTRAINT chk_yrituse_kategooria_tyyp_kood_ei_koosne_tyhikutest_pole_tyhi CHECK (((yrituse_kategooria_tyyp_kood)::bpchar !~ '^[[:space:]]*$'::text))
);

--
-- Name: yrituse_seisundi_liik; Type: TABLE; Schema: public; Owner: t164024
--

CREATE TABLE public.yrituse_seisundi_liik (
    yrituse_seisundi_liik_kood smallint NOT NULL,
    nimetus character varying(63) NOT NULL
);



--
-- Data for Name: amet; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.amet (amet_kood, nimetus, kirjeldus) FROM stdin;
FIJ	Finantsjuht	Juhib ja koordineerib ettevõtete eelarvete koostamise protsessi ning kontrollib sellest kinnipidamist.
JUH	Juhataja	Juhib ettevõte tööd; kinnitab olulised otsused; on kõige kõrgem positsioon ettevõttes.
KLH	Klassifikaatorite haldur	Vastutab, et andbaasis oleksid klassifikaatorid alati asja- ja ajakohased. Redigeerib ja krrastab vajadusel andmeid.
PEJ	Personalijuht	Vastutab ettevõtte sisemise tööjõu olukorra analüüsi ja tööks vajaminevate töötajate sisemise ja välise värbamise korraldamine. Hoolitseb töötajate heaolu eest.
TAV	Tavatöötaja	Täidab talle määratud tööülesandeid.
TUJ	Turundusjuht	Juhib ettevõtte toodete/teenustega seotud turundus- või müügiprotsessi.
VAH	Varade haldur	Jälgib ettevõtte varade olukorda ja liikumist. Hoolitseb uute tellimuste ning vara transposrdi korraldamise eest.
YRH	Ürituste haldur	Vastutab ürituste korraldamis eprotsessi, nend etoimumise ja nendega seotud andmete korrashoiu eest.
\.


--
-- Data for Name: asukoht; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.asukoht (asukoht_kood, aadress, nimetus) FROM stdin;
1  	Narva mnt 95, 10127 Tallinn	Tallinna Lauluväljak
2  	Paldiski mnt 104b, 13522 Tallinn	Saku Suurhall
3  	Ehitajate tee 5, 12616 Tallinn	Tallinna Tehnikaülikool
\.


--
-- Data for Name: isik; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.isik (isik_id, e_meil, isikukood, isikukoodi_riik, parool, eesnimi, perenimi, elukoht, synni_kp, reg_aeg, isiku_seisundi_liik_kood) FROM stdin;
9	mari@maasikas.ee	49612120226	EST	parool	Mari	Maasikas	Tallinn	1996-12-12	2018-11-13 14:27:18.530221	1
10	paul@jaaguarivaruosad.ee	39710120226	EST	parool	Raul	Paatpalu	Tallinn	1997-10-12	2018-11-13 14:32:48.679927	1
\.


--
-- Data for Name: isiku_seisundi_liik; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.isiku_seisundi_liik (isiku_seisundi_liik_kood, nimetus) FROM stdin;
1	Elus
2	Surnud
\.


--
-- Data for Name: kliendi_seisundi_liik; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.kliendi_seisundi_liik (kliendi_seisundi_liik_kood, nimetus) FROM stdin;
1	Aktiivne
2	Mitteaktiivne
3	Mustas nimekirjas
\.


--
-- Data for Name: klient; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.klient (isik_id, kliendi_seisundi_liik_kood, on_nous_tylitamisega) FROM stdin;
10	1	f
\.


--
-- Data for Name: riik; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.riik (riik_kood, nimetus) FROM stdin;
EST	Eesti
\.


--
-- Data for Name: tootaja; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.tootaja (isik_id, amet_kood, tootaja_seisundi_liik_kood, juhendaja_id) FROM stdin;
9	JUH	1	\N
\.


--
-- Data for Name: tootaja_seisundi_liik; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) FROM stdin;
1	Tööl
2	Katseajal
3	Puhkusel
4	Haige
5	Lapsepuhkusel
6	Lahkunud
7	Vallandatud
\.


--
-- Data for Name: yritus; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.yritus (yritus_id, nimi, asukoht_kood, algus_aeg, lopp_aeg, kirjeldus, piletite_arv, yrituse_seisundi_liik_kood, reg_aeg, looja_id) FROM stdin;
4	IT-ametitepäev	3  	2018-11-14 12:00:00	\N	Erinevad IT-valdkonna inimesed tulevad ja tutvustavad tudengitele oma ameteid	\N	1	2018-11-12 12:00:00	9
5	Tudengibaar	3  	2018-11-24 20:00:00	\N	Pamöllu	\N	1	2018-11-13 15:08:28.26487	9
\.


--
-- Data for Name: yrituse_kategooria; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.yrituse_kategooria (yrituse_kategooria_kood, nimetus, yrituse_kategooria_tyyp_kood) FROM stdin;
A1 	Kontsert	A
A2 	Festival	A
A3 	Sport	A
B1 	Noored	B
B2 	Õpilased	B
B3 	Sportlased	B
C1 	Suur	C
C2 	Väike	C
D1 	Pidulik	D
\.


--
-- Data for Name: yrituse_kategooria_omamine; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.yrituse_kategooria_omamine (yritus_id, yrituse_kategooria_kood) FROM stdin;
4	B1
\.


--
-- Data for Name: yrituse_kategooria_tyyp; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.yrituse_kategooria_tyyp (yrituse_kategooria_tyyp_kood, nimetus) FROM stdin;
A  	Liik
B  	Sihtgrupp
C  	Suurus
D  	Stiil
\.


--
-- Data for Name: yrituse_seisundi_liik; Type: TABLE DATA; Schema: public; Owner: t164024
--

COPY public.yrituse_seisundi_liik (yrituse_seisundi_liik_kood, nimetus) FROM stdin;
1	Ootel
2	Aktiivne
3	Mitteaktiivne
4	Lõpetatud
\.


--
-- Name: seq_isik_isik_id; Type: SEQUENCE SET; Schema: public; Owner: t164024
--

SELECT pg_catalog.setval('public.seq_isik_isik_id', 10, true);


--
-- Name: seq_yritus_yritus_id; Type: SEQUENCE SET; Schema: public; Owner: t164024
--

SELECT pg_catalog.setval('public.seq_yritus_yritus_id', 5, true);



--
-- Name: isik isik_id; Type: DEFAULT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.isik ALTER COLUMN isik_id SET DEFAULT nextval('public.seq_isik_isik_id'::regclass);


--
-- Name: yritus yritus_id; Type: DEFAULT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yritus ALTER COLUMN yritus_id SET DEFAULT nextval('public.seq_yritus_yritus_id'::regclass);

--
-- Name: amet ak_amet_nimetus; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.amet
    ADD CONSTRAINT ak_amet_nimetus UNIQUE (nimetus);


--
-- Name: asukoht ak_asukoht_nimetus; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.asukoht
    ADD CONSTRAINT ak_asukoht_nimetus UNIQUE (nimetus);


--
-- Name: isik ak_emeil; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.isik
    ADD CONSTRAINT ak_emeil UNIQUE (e_meil);


--
-- Name: isiku_seisundi_liik ak_isiku_seisundi_liik_nimetus; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.isiku_seisundi_liik
    ADD CONSTRAINT ak_isiku_seisundi_liik_nimetus UNIQUE (nimetus);


--
-- Name: isik ak_isikukood_riik; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.isik
    ADD CONSTRAINT ak_isikukood_riik UNIQUE (isikukood, isikukoodi_riik);


--
-- Name: kliendi_seisundi_liik ak_kliendi_seisundi_liik_nimetus; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.kliendi_seisundi_liik
    ADD CONSTRAINT ak_kliendi_seisundi_liik_nimetus UNIQUE (nimetus);


--
-- Name: yritus ak_nimi_asukoht_algus; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yritus
    ADD CONSTRAINT ak_nimi_asukoht_algus UNIQUE (nimi, algus_aeg, asukoht_kood);


--
-- Name: riik ak_riik_nimetus; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.riik
    ADD CONSTRAINT ak_riik_nimetus UNIQUE (nimetus);


--
-- Name: tootaja_seisundi_liik ak_tootaja_seisundi_liik_nimetus; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.tootaja_seisundi_liik
    ADD CONSTRAINT ak_tootaja_seisundi_liik_nimetus UNIQUE (nimetus);


--
-- Name: yrituse_kategooria ak_yrituse_kategooria_nimetus_yrituse_kategooria_tyyp; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yrituse_kategooria
    ADD CONSTRAINT ak_yrituse_kategooria_nimetus_yrituse_kategooria_tyyp UNIQUE (nimetus, yrituse_kategooria_tyyp_kood);


--
-- Name: yrituse_kategooria_tyyp ak_yrituse_kategooria_tyyp_nimetus; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yrituse_kategooria_tyyp
    ADD CONSTRAINT ak_yrituse_kategooria_tyyp_nimetus UNIQUE (nimetus);


--
-- Name: yrituse_seisundi_liik ak_yrituse_seisundi_liik_nimetus; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yrituse_seisundi_liik
    ADD CONSTRAINT ak_yrituse_seisundi_liik_nimetus UNIQUE (nimetus);


--
-- Name: amet pk_amet; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.amet
    ADD CONSTRAINT pk_amet PRIMARY KEY (amet_kood);


--
-- Name: asukoht pk_asukoht; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.asukoht
    ADD CONSTRAINT pk_asukoht PRIMARY KEY (asukoht_kood);


--
-- Name: isik pk_isik; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.isik
    ADD CONSTRAINT pk_isik PRIMARY KEY (isik_id);


--
-- Name: isiku_seisundi_liik pk_isiku_seisundi_liik; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.isiku_seisundi_liik
    ADD CONSTRAINT pk_isiku_seisundi_liik PRIMARY KEY (isiku_seisundi_liik_kood);


--
-- Name: kliendi_seisundi_liik pk_kliendi_seisundi_liik; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.kliendi_seisundi_liik
    ADD CONSTRAINT pk_kliendi_seisundi_liik PRIMARY KEY (kliendi_seisundi_liik_kood);


--
-- Name: klient pk_klient; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.klient
    ADD CONSTRAINT pk_klient PRIMARY KEY (isik_id);


--
-- Name: riik pk_riik; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.riik
    ADD CONSTRAINT pk_riik PRIMARY KEY (riik_kood);


--
-- Name: tootaja pk_tootaja; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.tootaja
    ADD CONSTRAINT pk_tootaja PRIMARY KEY (isik_id);


--
-- Name: tootaja_seisundi_liik pk_tootaja_seisundi_liik; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.tootaja_seisundi_liik
    ADD CONSTRAINT pk_tootaja_seisundi_liik PRIMARY KEY (tootaja_seisundi_liik_kood);


--
-- Name: yritus pk_yritus; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yritus
    ADD CONSTRAINT pk_yritus PRIMARY KEY (yritus_id);


--
-- Name: yrituse_kategooria pk_yrituse_kategooria; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yrituse_kategooria
    ADD CONSTRAINT pk_yrituse_kategooria PRIMARY KEY (yrituse_kategooria_kood);


--
-- Name: yrituse_kategooria_omamine pk_yrituse_kategooria_omamine; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yrituse_kategooria_omamine
    ADD CONSTRAINT pk_yrituse_kategooria_omamine PRIMARY KEY (yritus_id, yrituse_kategooria_kood);


--
-- Name: yrituse_kategooria_tyyp pk_yrituse_kategooria_tyyp; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yrituse_kategooria_tyyp
    ADD CONSTRAINT pk_yrituse_kategooria_tyyp PRIMARY KEY (yrituse_kategooria_tyyp_kood);


--
-- Name: yrituse_seisundi_liik pk_yrituse_seisundi_liik; Type: CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yrituse_seisundi_liik
    ADD CONSTRAINT pk_yrituse_seisundi_liik PRIMARY KEY (yrituse_seisundi_liik_kood);


--
-- Name: ixfk_isik_isiku_seisundi_liik; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_isik_isiku_seisundi_liik ON public.isik USING btree (isiku_seisundi_liik_kood);


--
-- Name: ixfk_isik_perenimi_eesnimi; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_isik_perenimi_eesnimi ON public.isik USING btree (perenimi, eesnimi);


--
-- Name: ixfk_isikukood_riik; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_isikukood_riik ON public.isik USING btree (isikukood, isikukoodi_riik);


--
-- Name: ixfk_klient_isik; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_klient_isik ON public.klient USING btree (isik_id);


--
-- Name: ixfk_klient_kliendi_seisundi_liik; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_klient_kliendi_seisundi_liik ON public.klient USING btree (kliendi_seisundi_liik_kood);


--
-- Name: ixfk_tootaja_amet; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_tootaja_amet ON public.tootaja USING btree (amet_kood);


--
-- Name: ixfk_tootaja_isik; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_tootaja_isik ON public.tootaja USING btree (isik_id);


--
-- Name: ixfk_tootaja_tootaja; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_tootaja_tootaja ON public.tootaja USING btree (juhendaja_id);


--
-- Name: ixfk_tootaja_tootaja_seisundi_liik; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_tootaja_tootaja_seisundi_liik ON public.tootaja USING btree (tootaja_seisundi_liik_kood);


--
-- Name: ixfk_yritus_asukoht; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_yritus_asukoht ON public.yritus USING btree (asukoht_kood);


--
-- Name: ixfk_yritus_tootaja; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_yritus_tootaja ON public.yritus USING btree (looja_id);


--
-- Name: ixfk_yritus_yrituse_seisundi_liik; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_yritus_yrituse_seisundi_liik ON public.yritus USING btree (yrituse_seisundi_liik_kood);


--
-- Name: ixfk_yrituse_kategooria_omamine_yritus; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_yrituse_kategooria_omamine_yritus ON public.yrituse_kategooria_omamine USING btree (yritus_id);


--
-- Name: ixfk_yrituse_kategooria_omamine_yrituse_kategooria; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_yrituse_kategooria_omamine_yrituse_kategooria ON public.yrituse_kategooria_omamine USING btree (yrituse_kategooria_kood);


--
-- Name: ixfk_yrituse_kategooria_yrituse_kategooria_tyyp; Type: INDEX; Schema: public; Owner: t164024
--

CREATE INDEX ixfk_yrituse_kategooria_yrituse_kategooria_tyyp ON public.yrituse_kategooria USING btree (yrituse_kategooria_tyyp_kood);


--
-- Name: isik fk_isik_isiku_seisundi_liik; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.isik
    ADD CONSTRAINT fk_isik_isiku_seisundi_liik FOREIGN KEY (isiku_seisundi_liik_kood) REFERENCES public.isiku_seisundi_liik(isiku_seisundi_liik_kood) ON UPDATE CASCADE;


--
-- Name: isik fk_isik_riik; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.isik
    ADD CONSTRAINT fk_isik_riik FOREIGN KEY (isikukoodi_riik) REFERENCES public.riik(riik_kood) ON UPDATE CASCADE;


--
-- Name: klient fk_klient_isik; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.klient
    ADD CONSTRAINT fk_klient_isik FOREIGN KEY (isik_id) REFERENCES public.isik(isik_id) ON DELETE CASCADE;


--
-- Name: klient fk_klient_klient_seisundi_liik; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.klient
    ADD CONSTRAINT fk_klient_klient_seisundi_liik FOREIGN KEY (kliendi_seisundi_liik_kood) REFERENCES public.kliendi_seisundi_liik(kliendi_seisundi_liik_kood) ON UPDATE CASCADE;


--
-- Name: tootaja fk_tootaja_amet; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.tootaja
    ADD CONSTRAINT fk_tootaja_amet FOREIGN KEY (amet_kood) REFERENCES public.amet(amet_kood) ON UPDATE CASCADE;


--
-- Name: tootaja fk_tootaja_isik; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.tootaja
    ADD CONSTRAINT fk_tootaja_isik FOREIGN KEY (isik_id) REFERENCES public.isik(isik_id) ON DELETE CASCADE;


--
-- Name: tootaja fk_tootaja_tootaja; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.tootaja
    ADD CONSTRAINT fk_tootaja_tootaja FOREIGN KEY (juhendaja_id) REFERENCES public.tootaja(isik_id) ON UPDATE CASCADE;


--
-- Name: tootaja fk_tootaja_tootaja_seisundi_liik; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.tootaja
    ADD CONSTRAINT fk_tootaja_tootaja_seisundi_liik FOREIGN KEY (tootaja_seisundi_liik_kood) REFERENCES public.tootaja_seisundi_liik(tootaja_seisundi_liik_kood) ON UPDATE CASCADE;


--
-- Name: yritus fk_yritus_asukoht; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yritus
    ADD CONSTRAINT fk_yritus_asukoht FOREIGN KEY (asukoht_kood) REFERENCES public.asukoht(asukoht_kood) ON UPDATE CASCADE;


--
-- Name: yritus fk_yritus_tootaja; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yritus
    ADD CONSTRAINT fk_yritus_tootaja FOREIGN KEY (looja_id) REFERENCES public.isik(isik_id);


--
-- Name: yritus fk_yritus_yrituse_seisundi_liik; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yritus
    ADD CONSTRAINT fk_yritus_yrituse_seisundi_liik FOREIGN KEY (yrituse_seisundi_liik_kood) REFERENCES public.yrituse_seisundi_liik(yrituse_seisundi_liik_kood) ON UPDATE CASCADE;


--
-- Name: yrituse_kategooria_omamine fk_yrituse_kategooria_omamine_yrituse; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yrituse_kategooria_omamine
    ADD CONSTRAINT fk_yrituse_kategooria_omamine_yrituse FOREIGN KEY (yritus_id) REFERENCES public.yritus(yritus_id) ON DELETE CASCADE;


--
-- Name: yrituse_kategooria_omamine fk_yrituse_kategooria_omamine_yrituse_kategooria; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yrituse_kategooria_omamine
    ADD CONSTRAINT fk_yrituse_kategooria_omamine_yrituse_kategooria FOREIGN KEY (yrituse_kategooria_kood) REFERENCES public.yrituse_kategooria(yrituse_kategooria_kood) ON DELETE CASCADE;


--
-- Name: yrituse_kategooria fk_yrituse_kategooria_yrituse_kategooria_tyyp; Type: FK CONSTRAINT; Schema: public; Owner: t164024
--

ALTER TABLE ONLY public.yrituse_kategooria
    ADD CONSTRAINT fk_yrituse_kategooria_yrituse_kategooria_tyyp FOREIGN KEY (yrituse_kategooria_tyyp_kood) REFERENCES public.yrituse_kategooria_tyyp(yrituse_kategooria_tyyp_kood) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--
