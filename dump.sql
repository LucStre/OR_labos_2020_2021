--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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
-- Name: actor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actor (
    actorid integer NOT NULL,
    name character varying NOT NULL,
    surname character varying NOT NULL,
    middlename character varying,
    birthdate date NOT NULL,
    birthplace character varying NOT NULL,
    height numeric NOT NULL,
    marriage boolean NOT NULL,
    children integer NOT NULL,
    siblings integer NOT NULL,
    startyear integer NOT NULL,
    favfood character varying,
    favcolor character varying,
    favbook character varying
);


ALTER TABLE public.actor OWNER TO postgres;

--
-- Name: actor_actorid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actor_actorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actor_actorid_seq OWNER TO postgres;

--
-- Name: actor_actorid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actor_actorid_seq OWNED BY public.actor.actorid;


--
-- Name: acts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acts (
    filmid integer NOT NULL,
    actorid integer NOT NULL
);


ALTER TABLE public.acts OWNER TO postgres;

--
-- Name: award; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.award (
    awardid integer NOT NULL,
    awardname character varying NOT NULL,
    awardfor character varying,
    year integer NOT NULL,
    rolein character varying,
    actorid integer NOT NULL
);


ALTER TABLE public.award OWNER TO postgres;

--
-- Name: award_awardid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.award_awardid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.award_awardid_seq OWNER TO postgres;

--
-- Name: award_awardid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.award_awardid_seq OWNED BY public.award.awardid;


--
-- Name: film; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.film (
    filmid integer NOT NULL,
    name character varying NOT NULL,
    director character varying NOT NULL,
    year integer NOT NULL
);


ALTER TABLE public.film OWNER TO postgres;

--
-- Name: film_filmid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.film_filmid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.film_filmid_seq OWNER TO postgres;

--
-- Name: film_filmid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.film_filmid_seq OWNED BY public.film.filmid;


--
-- Name: actor actorid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor ALTER COLUMN actorid SET DEFAULT nextval('public.actor_actorid_seq'::regclass);


--
-- Name: award awardid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award ALTER COLUMN awardid SET DEFAULT nextval('public.award_awardid_seq'::regclass);


--
-- Name: film filmid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film ALTER COLUMN filmid SET DEFAULT nextval('public.film_filmid_seq'::regclass);


--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actor (actorid, name, surname, middlename, birthdate, birthplace, height, marriage, children, siblings, startyear, favfood, favcolor, favbook) FROM stdin;
1	Chris	Hemsworth	\N	1983-08-11	Australia	1.9	t	3	2	2002	pizza	black	Lord of the Rings
2	Emily	Blunt	Olivia Leah	1983-02-23	England	1.71	t	2	3	2001	lasagna	black	To Kill a Mockingbird
3	Meryl	Streep	Louise	1949-06-22	USA	1.68	t	4	2	1977	chicken pot pie with black truffles	pink	Heartburn
6	Cate	Blanchett	Élise	1969-05-14	Australia	1.74	t	4	2	1996	cheese and vegemite on toast	persian blue	The Uses of Enchantment: The Meaning and Importance of Fairy Tales
7	Orlando	Bloom	\N	1977-01-13	UK	1.8	f	2	3	1994	steaks, seafood and lamb	dark orchid	The fountainhead
8	Johnny	Depp	Christopher	1963-06-09	USA	1.78	t	2	3	1984	mexican	black	Ulysses
9	Leonardo	DiCaprio	Wilhelm	1974-11-11	UK	1.83	t	0	1	1988	pupusas	dark green	The Garden of Eden
10	Benedict	Cumberbatch	\N	1976-07-19	USA	1.83	t	3	1	2001	tapas	blue	Sherlock Holmes' Rediscovered Railway Stories
11	George	Clooney	\N	1961-05-06	USA	1.8	t	2	1	1978	steak	black	Leo Tolstoy's War and Peace
12	Jennifer	Lawrence	Shrader	1990-08-15	USA	1.75	t	0	2	2006	chili pizza sandwich	gold	The Other Boleyn Girl
13	Zoe	Saldana	\N	1978-06-19	USA	1.7	t	3	3	2000	chinese	blue	The Brief Wondrous Life of Oscar Wao
5	Helena	Bonham Carter	\N	1966-05-26	USA	1.57	t	2	1	1983	italian cuisine	red	The Heart and The Bottle
4	Emma	Watson	Charlotte Duerre	1990-04-15	France	1.65	f	0	4	1999	mexican	light blue	The Little Prince
\.


--
-- Data for Name: acts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.acts (filmid, actorid) FROM stdin;
1	1
1	2
87	6
87	9
3	1
4	1
5	1
6	1
7	1
8	1
9	1
10	2
11	2
12	2
13	2
14	2
15	2
2	3
13	3
14	3
10	3
16	3
17	3
30	3
31	3
32	3
33	3
34	3
35	3
22	4
23	4
24	4
25	4
26	4
27	4
28	4
29	4
36	4
37	4
38	4
13	5
14	5
15	5
16	5
17	5
18	5
19	5
20	5
21	5
26	5
27	5
28	5
29	5
32	5
39	6
40	6
41	6
42	6
43	6
44	6
45	6
46	6
6	6
20	6
21	6
39	7
40	7
41	7
42	7
43	7
44	7
47	7
48	7
49	7
50	7
51	7
52	7
53	7
47	8
48	8
49	8
50	8
54	8
55	8
56	8
57	8
18	8
17	8
58	9
59	9
60	9
61	9
62	9
63	9
64	9
65	10
42	10
43	10
44	10
7	10
6	10
3	10
4	10
5	10
76	11
77	11
78	11
79	11
80	11
66	12
67	12
68	12
69	12
70	12
71	12
72	12
73	12
74	12
75	12
81	13
82	13
83	13
84	13
85	13
86	13
47	13
8	13
7	13
4	13
3	13
\.


--
-- Data for Name: award; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.award (awardid, awardname, awardfor, year, rolein, actorid) FROM stdin;
1	Australian Star of the Year	\N	2016	\N	1
2	CinemaCon Award	Male Star of Tomorrow	2011	\N	1
3	Huading Award	Best Global Actor in a Motion Picture	2015	Thor: The Dark World	1
4	People's Choice Award	Favorite Action Movie Star	2020	Extraction	1
5	Teen Choice Award	Choice Movie Actor: Sci-Fi	2018	Thor: Ragnarok	1
6	Saturn Award	Best Supporting Actress	2012	The Adjustment Bureau 	2
7	EDA Female Focus Award	Kick Ass Award for Best Female Action Star	2015	Edge of Tomorrow	2
8	Britannia Award	British Artist of the Year	2009	\N	2
9	Oscar	Best Performance by an Actress in a Leading Role	2012	The Iron Lady	3
10	Oscar	Best Actress in a Leading Role	1983	Sophie's Choice	3
11	Oscar	Best Actress in a Leading Role	1980	Kramer vs. Kramer	3
12	Primetime Emmy	Outstanding Narrator	2017	Five Came Back	3
13	Primetime Emmy	Outstanding Lead Actress in a Miniseries or a Movie	2004	Angels in America	3
14	BAFTA Film Award	Best Leading Actress	2012	The Iron Lady	3
15	AACTA International Award	Best Actress	2017	The Iron Lady	3
16	Britannia Award	British Artist of the Year	2014	\N	4
17	MTV Movie + TV Award	Best Actor in a Movie	2017	Beauty and the Beast	4
18	National Movie Award	Best Performance by a Female	2007	Harry Potter and the Order of the Phoenix	4
19	People's Choice Award	Favorite Dramatic Movie Actress	2013	\N	4
20	Britannia Award	British Artist of the Year	2011	\N	5
21	CinEuphoria	Best Supporting Actress - Audience Award	2011	Alice in Wonderland	5
22	Empire Award	Best British Actress	2000	Fight Club	5
23	Hollywood Film Award	Supporting Actress of the Year	2010	\N	5
24	Emmy	Best Performance by an Actress	2010	Enid	5
25	Oscar	Best Performance by an Actress in a Leading Role	2014	Blue Jasmine	6
26	Oscar	Best Performance by an Actress in a Supporting Role	2013	The Aviator	6
27	BAFTA Film Award	Best Leading Actress	2014	Blue Jasmine	6
28	ACCA	Best Cast Ensemble	2001	The Lord of the Rings: The Fellowship of the Ring	6
29	Britannia Award	Stanley Kubrick Britannia Award for Excellence in Film	2018	\N	6
30	ACCA	Best Cast Ensemble	2003	The Lord of the Rings: The Return of the King	7
31	Empire Award	Best Debut	2002	The Lord of the Rings: The Fellowship of the Ring	7
32	EFA People's Choice Award	Best European Actor	2005	Kingdom of Heaven	7
33	Huading Award	Best Global Actor in a Motion Picture	2014	The Hobbit: The Desolation of Smaug	7
34	MTV Movie Award	Best Fight	2014	The Hobbit: The Desolation of Smaug	7
35	ACCA	Best Actor in a Leading Role	2003	Pirates of the Caribbean: The Curse of the Black Pearl	8
36	Empire Award	Best Actor	2006	Charlie and the Chocolate Factory	8
37	Golden Globe	Best Performance by an Actor in a Motion Picture - Comedy or Musical	2008	Sweeney Todd: The Demon Barber of Fleet Street	8
38	Golden Schmoes	Favorite Celebrity of the Year	2007	\N	8
39	Jupiter Award	Best International Actor	2007	Pirates of the Caribbean: Dead Man's Chest	8
40	Oscar	Best Performance by an Actor in a Leading Role	2016	The Revenant	9
41	BAFTA Film Award	Best Leading Actor	2016	The Revenant	9
42	Silver Berlin Bear	Best Actor	1997	Romeo + Juliet	9
43	Blockbuster Entertainment Award	Favorite Actor - Drama	1998	Titanic	9
44	Primetime Emmy	Outstanding Lead Actor in a Miniseries or a Movie	2014	Sherlock	10
45	BAFTA TV Award	Best Leading Actor	2019	Patrick Melrose	10
46	Variety Award	\N	2014	\N	10
47	Dagger	Best Leading Actor	2012	Sherlock	10
48	Oscar	Best Motion Picture of the Year	2013	Argo	11
49	Oscar	Best Performance by an Actor in a Supporting Role	2006	Syriana	11
50	AACTA International Award	Best Screenplay	2012	The Ides of March	11
51	Saturn Award	Best Actor	1996	From Dusk Till Dawn	11
52	Oscar	Best Performance by an Actress in a Leading Role	2013	Silver Linings Playbook	12
53	BAFTA Film Award	Best Supporting Actress	2014	American Hustle	12
54	Saturn Award	Best Actress	2013	The Hunger Games	12
55	EDA Female Focus Award	Kick Ass Award for Best Female Action Star	2013	The Hunger Games	12
56	ACCA	Best Actress in a Leading Role	2012	Silver Linings Playbook	12
57	Saturn Award	Best Actress	2010	Avatar	13
58	DFCS Award	Best Ensemble	2014	Guardians of the Galaxy	13
59	Huading Award	Best Global Supporting Actress in a Motion Picture	2014	Star Trek Into Darkness	13
60	Teen Choice Award	Choice Movie Actress: Sci-Fi	2017	Guardians of the Galaxy Vol. 2	13
\.


--
-- Data for Name: film; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.film (filmid, name, director, year) FROM stdin;
1	The Huntsman: Winter's War	Cedric Nicolas-Troyan	2016
2	Mamma Mia	Phyllida Lloyd	2008
3	Avengers: Endgame	Anthony Russo, Joe Russo	2019
4	Avengers: Infinity War	Anthony Russo, Joe Russo	2018
5	Doctor Strange	Scott Derrickson	2016
6	Thor: Ragnarok	Taika Waititi	2017
7	Star Trek Into Darkness	J.J. Abrams	2013
8	Star Trek	J.J. Abrams	2009
9	Thor	Kenneth Branagh	2011
10	Mary Poppins Returns	Rob Marshall	2018
11	A Quiet Place	John Krasinski	2018
12	The Girl on the Train	Tate Taylor	2016
13	Into the Woods	Rob Marshall	2014
14	The Devil Wears Prada	David Frankel	2006
15	The Young Victoria	Jean-Marc Vallée	2009
16	Enola Holmes	Harry Bradbeer	2020
17	Alice in Wonderland	Tim Burton	2010
18	Charlie and the Chocolate Factory	Tim Burton	2005
19	Fight Club	David Fincher	1999
20	Ocean's Eight	Gary Ross	2018
21	Cinderella	Kenneth Branagh	2015
22	Harry Potter and the Philosopher's Stone	Chris Columbus	2001
23	Harry Potter and the Chamber of Secrets	Chris Columbus	2002
24	Harry Potter and the Prisoner of Azkaban	Alfonso Cuarón	2004
25	Harry Potter and the Goblet of Fire	Mike Newell	2005
26	Harry Potter and the Order of the Phoenix	David Yates	2007
27	Harry Potter and the Half-Blood Prince	David Yates	2009
28	Harry Potter and the Deathly Hallows – Part 1	David Yates	2010
29	Harry Potter and the Deathly Hallows – Part 2	David Yates	2011
30	Little Women	Greta Gerwig	2019
31	Mamma Mia! Here We Go Again	Ol Parker	2018
32	Suffragette	Sarah Gavron	2015
33	The Iron Lady	Phyllida Lloyd	2011
34	Julie & Julia	Nora Ephron	2009
35	It's Complicated	Nancy Meyers	2009
36	Beauty and the Beast	Bill Condon	2017
37	Noah	Darren Aronofsky	2014
38	The Circle	James Ponsoldt	2017
39	The Lord of the Rings: The Fellowship of the Ring	Peter Jackson	2001
40	The Lord of the Rings: The Two Towers	Peter Jackson	2002
41	The Lord of the Rings: The Return of the King	Peter Jackson	2003
42	The Hobbit: An Unexpected Journey	Peter Jackson	2012
43	The Hobbit: The Desolation of Smaug	Peter Jackson	2013
44	The Hobbit: The Battle of the Five Armies	Peter Jackson	2014
45	Indiana Jones and the Kingdom of the Crystal Skull	Steven Spielberg	2008
46	Robin Hood	Ridley Scott	2010
47	Pirates of the Caribbean: The Curse of the Black Pearl	Gore Verbinski	2003
48	Pirates of the Caribbean: Dead Man's Chest	Gore Verbinski	2006
49	Pirates of the Caribbean: At World's End	Gore Verbinski	2007
50	Pirates of the Caribbean: Dead Men Tell No Tales	Joachim Rønning, Espen Sandberg	2017
51	Kingdom of Heaven	Ridley Scott	20005
52	Romeo and Juliet	Don Roy King	2014
53	Troy	Wolfgang Petersen	2004
54	Dark Shadows	Tim Burton	2012
55	Don Juan DeMarco	Jeremy Leven	1994
56	The Tourist	Florian Henckel von Donnersmarck	2010
57	Pirates of the Caribbean: On Stranger Tides	Rob Marshall	2011
58	Romeo + Juliet	Baz Luhrmann	1996
59	Titanic	James Cameron	1997
60	Catch Me If You Can	Steven Spielberg	2002
61	Shutter Island	Martin Scorsese	2010
62	Inception	Christopher Nolan	2010
63	The Great Gatsby	Baz Luhrmann	2013
64	The Revenant	Alejandro G. Iñárritu	2015
65	The Imitation Game	Morten Tyldum	2014
66	The Hunger Games	Gary Ross	2012
67	The Hunger Games: Catching Fire	Francis Lawrence	2013
68	The Hunger Games: Mockingjay - Part 1	Francis Lawrence	2014
69	The Hunger Games: Mockingjay - Part 2	Francis Lawrence	2015
70	X-Men: First Class	Matthew Vaughn	2011
71	X-Men: Days of Future Past	Bryan Singer	2014
72	X-Men: Apocalypse	Bryan Singer	20186
73	X-Men: Dark Phoenix	Simon Kinberg	2019
74	Joy	David O. Russell	2015
75	Passengers	Morten Tyldum	2016
76	Ocean's Eleven	Steven Soderbergh	2001
77	Ocean's Twelve	Steven Soderbergh	2004
78	Ocean's Thirteen	Steven Soderbergh	2007
79	Gravity	Alfonso Cuarón	2013
80	Intolerable Cruelty	Joel Coen, Ethan Coen	2003
81	Star Trek Beyond	Justin Lin	2016
82	Guardians of the Galaxy	James Gunn	2014
83	Guardians of the Galaxy Vol. 2	James Gunn	2017
84	Avatar	James Cameron	2009
85	Death at a Funeral	Neil LaBute	2010
86	The Terminal	Steven Spielberg	2004
87	The Aviator	Martin Scorsese	2014
\.


--
-- Name: actor_actorid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actor_actorid_seq', 13, true);


--
-- Name: award_awardid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.award_awardid_seq', 60, true);


--
-- Name: film_filmid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.film_filmid_seq', 87, true);


--
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actorid);


--
-- Name: acts acts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acts
    ADD CONSTRAINT acts_pkey PRIMARY KEY (filmid, actorid);


--
-- Name: award award_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award
    ADD CONSTRAINT award_pkey PRIMARY KEY (awardid);


--
-- Name: film film_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (filmid);


--
-- Name: acts acts_actorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acts
    ADD CONSTRAINT acts_actorid_fkey FOREIGN KEY (actorid) REFERENCES public.actor(actorid);


--
-- Name: acts acts_filmid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acts
    ADD CONSTRAINT acts_filmid_fkey FOREIGN KEY (filmid) REFERENCES public.film(filmid);


--
-- Name: award award_actorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award
    ADD CONSTRAINT award_actorid_fkey FOREIGN KEY (actorid) REFERENCES public.actor(actorid);


--
-- PostgreSQL database dump complete
--

