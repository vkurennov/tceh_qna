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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE answers (
    id integer NOT NULL,
    body text,
    question_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE answers_id_seq OWNED BY answers.id;


--
-- Name: attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE attachments (
    id integer NOT NULL,
    file character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    attachable_id integer,
    attachable_type character varying
);


--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE attachments_id_seq OWNED BY attachments.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE questions (
    id integer NOT NULL,
    title character varying,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer
);


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY answers ALTER COLUMN id SET DEFAULT nextval('answers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY attachments ALTER COLUMN id SET DEFAULT nextval('attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_answers_on_question_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_answers_on_question_id ON answers USING btree (question_id);


--
-- Name: index_attachments_on_attachable_id_and_attachable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_attachments_on_attachable_id_and_attachable_type ON attachments USING btree (attachable_id, attachable_type);


--
-- Name: index_questions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_questions_on_user_id ON questions USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20151210165957');

INSERT INTO schema_migrations (version) VALUES ('20151214165649');

INSERT INTO schema_migrations (version) VALUES ('20151217125600');

INSERT INTO schema_migrations (version) VALUES ('20151217164022');

INSERT INTO schema_migrations (version) VALUES ('20160114162351');

INSERT INTO schema_migrations (version) VALUES ('20160114162707');

