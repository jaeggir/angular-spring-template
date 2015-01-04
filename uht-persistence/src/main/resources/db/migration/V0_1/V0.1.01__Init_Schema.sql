--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: update_last_modified_column(); Type: FUNCTION; Schema: public; Owner: uht
--

CREATE FUNCTION update_last_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN NEW.lastModified := current_timestamp; RETURN NEW; END; $$;

ALTER FUNCTION public.update_last_modified_column() OWNER TO uht;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: t_news; Type: TABLE; Schema: public; Owner: uht; Tablespace: 
--

CREATE TABLE t_news (
    uuid character varying(255) NOT NULL,
    datecreated timestamp without time zone DEFAULT now(),
    lastmodified timestamp without time zone,
    content text NOT NULL,
    publishdate timestamp without time zone,
    title character varying(255) NOT NULL,
    visible boolean NOT NULL,
    user_uuid character varying(255) NOT NULL
);


ALTER TABLE public.t_news OWNER TO uht;

--
-- Name: t_user; Type: TABLE; Schema: public; Owner: uht; Tablespace: 
--

CREATE TABLE t_user (
    uuid character varying(255) NOT NULL,
    datecreated timestamp without time zone DEFAULT now(),
    lastmodified timestamp without time zone,
    email character varying(255) NOT NULL,
    firstname character varying(255) NOT NULL,
    lastlogindate timestamp without time zone,
    lastname character varying(255) NOT NULL,
    login character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    enabled boolean NOT NULL
);


ALTER TABLE public.t_user OWNER TO uht;

--
-- Name: t_user_authority; Type: TABLE; Schema: public; Owner: uht; Tablespace: 
--

CREATE TABLE t_user_authority (
    user_uuid character varying(255) NOT NULL,
    authority character varying(255)
);


ALTER TABLE public.t_user_authority OWNER TO uht;

--
-- Name: t_news_pkey; Type: CONSTRAINT; Schema: public; Owner: uht; Tablespace: 
--

ALTER TABLE ONLY t_news
    ADD CONSTRAINT t_news_pkey PRIMARY KEY (uuid);


--
-- Name: t_user_pkey; Type: CONSTRAINT; Schema: public; Owner: uht; Tablespace: 
--


ALTER TABLE ONLY t_user
    ADD CONSTRAINT t_user_pkey PRIMARY KEY (uuid);

--
-- Name: update_modtime; Type: TRIGGER; Schema: public; Owner: uht
--

CREATE TRIGGER update_modtime BEFORE INSERT OR UPDATE ON t_news FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();


--
-- Name: update_modtime; Type: TRIGGER; Schema: public; Owner: uht
--

CREATE TRIGGER update_modtime BEFORE INSERT OR UPDATE ON t_user FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();


--
-- Name: uk_sa4df0alibrd29bxd4c9e5371; Type: CONSTRAINT; Schema: public; Owner: uht; Tablespace: 
--

ALTER TABLE ONLY t_user
    ADD CONSTRAINT uk_sa4df0alibrd29bxd4c9e5371 UNIQUE (login);


--
-- Name: fk_7o2kjeaecihcwod4tv783all5; Type: FK CONSTRAINT; Schema: public; Owner: uht
--

ALTER TABLE ONLY t_user_authority
    ADD CONSTRAINT fk_7o2kjeaecihcwod4tv783all5 FOREIGN KEY (user_uuid) REFERENCES t_user(uuid);


--
-- Name: fk_rtsqhn334mrptd2fughbb2yks; Type: FK CONSTRAINT; Schema: public; Owner: uht
--

ALTER TABLE ONLY t_news
    ADD CONSTRAINT fk_rtsqhn334mrptd2fughbb2yks FOREIGN KEY (user_uuid) REFERENCES t_user(uuid);


--
-- PostgreSQL database dump complete
--

