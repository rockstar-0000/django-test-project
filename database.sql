--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

-- Started on 2020-04-13 23:29:56

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
-- TOC entry 209 (class 1259 OID 17306)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 17304)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 208
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- TOC entry 211 (class 1259 OID 17316)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 17314)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 210
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- TOC entry 207 (class 1259 OID 17298)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 17296)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 206
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- TOC entry 213 (class 1259 OID 17324)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17334)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17332)
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 214
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- TOC entry 212 (class 1259 OID 17322)
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 212
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- TOC entry 217 (class 1259 OID 17342)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17340)
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 216
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- TOC entry 222 (class 1259 OID 17445)
-- Name: blog_post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blog_post (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    content text NOT NULL,
    date_posted timestamp with time zone NOT NULL,
    author_id integer NOT NULL
);


ALTER TABLE public.blog_post OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17443)
-- Name: blog_post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blog_post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blog_post_id_seq OWNER TO postgres;

--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 221
-- Name: blog_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blog_post_id_seq OWNED BY public.blog_post.id;


--
-- TOC entry 219 (class 1259 OID 17402)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17400)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 218
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- TOC entry 205 (class 1259 OID 17288)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 17286)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 204
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- TOC entry 203 (class 1259 OID 17277)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 17275)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 202
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- TOC entry 220 (class 1259 OID 17433)
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17551)
-- Name: friendship_block; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friendship_block (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    blocked_id integer NOT NULL,
    blocker_id integer NOT NULL
);


ALTER TABLE public.friendship_block OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17549)
-- Name: friendship_block_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friendship_block_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_block_id_seq OWNER TO postgres;

--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 231
-- Name: friendship_block_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friendship_block_id_seq OWNED BY public.friendship_block.id;


--
-- TOC entry 226 (class 1259 OID 17482)
-- Name: friendship_follow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friendship_follow (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    followee_id integer NOT NULL,
    follower_id integer NOT NULL
);


ALTER TABLE public.friendship_follow OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17480)
-- Name: friendship_follow_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friendship_follow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_follow_id_seq OWNER TO postgres;

--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 225
-- Name: friendship_follow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friendship_follow_id_seq OWNED BY public.friendship_follow.id;


--
-- TOC entry 228 (class 1259 OID 17490)
-- Name: friendship_friend; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friendship_friend (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.friendship_friend OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17488)
-- Name: friendship_friend_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friendship_friend_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_friend_id_seq OWNER TO postgres;

--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 227
-- Name: friendship_friend_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friendship_friend_id_seq OWNED BY public.friendship_friend.id;


--
-- TOC entry 230 (class 1259 OID 17498)
-- Name: friendship_friendshiprequest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friendship_friendshiprequest (
    id integer NOT NULL,
    message text NOT NULL,
    created timestamp with time zone NOT NULL,
    rejected timestamp with time zone,
    viewed timestamp with time zone,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.friendship_friendshiprequest OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17496)
-- Name: friendship_friendshiprequest_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friendship_friendshiprequest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_friendshiprequest_id_seq OWNER TO postgres;

--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 229
-- Name: friendship_friendshiprequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friendship_friendshiprequest_id_seq OWNED BY public.friendship_friendshiprequest.id;


--
-- TOC entry 224 (class 1259 OID 17462)
-- Name: users_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_profile (
    id integer NOT NULL,
    image character varying(100) NOT NULL,
    user_id integer NOT NULL,
    gender character varying(25) NOT NULL
);


ALTER TABLE public.users_profile OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17460)
-- Name: users_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_profile_id_seq OWNER TO postgres;

--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_profile_id_seq OWNED BY public.users_profile.id;


--
-- TOC entry 2784 (class 2604 OID 17309)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- TOC entry 2785 (class 2604 OID 17319)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 2783 (class 2604 OID 17301)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- TOC entry 2786 (class 2604 OID 17327)
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- TOC entry 2787 (class 2604 OID 17337)
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- TOC entry 2788 (class 2604 OID 17345)
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 2791 (class 2604 OID 17448)
-- Name: blog_post id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_post ALTER COLUMN id SET DEFAULT nextval('public.blog_post_id_seq'::regclass);


--
-- TOC entry 2789 (class 2604 OID 17405)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- TOC entry 2782 (class 2604 OID 17291)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- TOC entry 2781 (class 2604 OID 17280)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- TOC entry 2796 (class 2604 OID 17554)
-- Name: friendship_block id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_block ALTER COLUMN id SET DEFAULT nextval('public.friendship_block_id_seq'::regclass);


--
-- TOC entry 2793 (class 2604 OID 17485)
-- Name: friendship_follow id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_follow ALTER COLUMN id SET DEFAULT nextval('public.friendship_follow_id_seq'::regclass);


--
-- TOC entry 2794 (class 2604 OID 17493)
-- Name: friendship_friend id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_friend ALTER COLUMN id SET DEFAULT nextval('public.friendship_friend_id_seq'::regclass);


--
-- TOC entry 2795 (class 2604 OID 17501)
-- Name: friendship_friendshiprequest id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_friendshiprequest ALTER COLUMN id SET DEFAULT nextval('public.friendship_friendshiprequest_id_seq'::regclass);


--
-- TOC entry 2792 (class 2604 OID 17465)
-- Name: users_profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile ALTER COLUMN id SET DEFAULT nextval('public.users_profile_id_seq'::regclass);


--
-- TOC entry 3027 (class 0 OID 17306)
-- Dependencies: 209
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 3029 (class 0 OID 17316)
-- Dependencies: 211
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 3025 (class 0 OID 17298)
-- Dependencies: 207
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add post	7	add_post
26	Can change post	7	change_post
27	Can delete post	7	delete_post
28	Can view post	7	view_post
29	Can add profile	8	add_profile
30	Can change profile	8	change_profile
31	Can delete profile	8	delete_profile
32	Can view profile	8	view_profile
33	Can add Following Relationship	9	add_follow
34	Can change Following Relationship	9	change_follow
35	Can delete Following Relationship	9	delete_follow
36	Can view Following Relationship	9	view_follow
37	Can add Friend	10	add_friend
38	Can change Friend	10	change_friend
39	Can delete Friend	10	delete_friend
40	Can view Friend	10	view_friend
41	Can add Friendship Request	11	add_friendshiprequest
42	Can change Friendship Request	11	change_friendshiprequest
43	Can delete Friendship Request	11	delete_friendshiprequest
44	Can view Friendship Request	11	view_friendshiprequest
45	Can add Blocked Relationship	12	add_block
46	Can change Blocked Relationship	12	change_block
47	Can delete Blocked Relationship	12	delete_block
48	Can view Blocked Relationship	12	view_block
\.


--
-- TOC entry 3031 (class 0 OID 17324)
-- Dependencies: 213
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
11	pbkdf2_sha256$180000$bA3qykZtmKM7$XIZ9oTT3UxreNiYaWIQ0r38LKf7ffCvEbaYGiwC55y0=	2020-04-11 20:55:22-05	f	TestingUser	Test	User	my@email.com	f	t	2020-04-11 15:40:50-05
1	pbkdf2_sha256$180000$LR60hSjzYL7a$a0ZAYVPgJRXtyccTSKf7R+Rlr6ZM0DuHu767u9d8eRw=	2020-04-13 17:14:42.861465-05	t	jgreen44	Jason	Green	jgreen44@asu.edu	t	t	2020-04-10 10:30:15-05
\.


--
-- TOC entry 3033 (class 0 OID 17334)
-- Dependencies: 215
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 3035 (class 0 OID 17342)
-- Dependencies: 217
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- TOC entry 3040 (class 0 OID 17445)
-- Dependencies: 222
-- Data for Name: blog_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blog_post (id, title, content, date_posted, author_id) FROM stdin;
1	First blog post!	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sed sagittis eros. Sed dictum purus sed mollis faucibus. Integer interdum id turpis ac bibendum. Praesent scelerisque nisi ac mauris laoreet maximus fringilla quis velit. Nunc tristique, nisl eu venenatis posuere, elit quam blandit sapien, eu fringilla eros elit id turpis. Nam non justo ut quam tempus dapibus id sit amet massa. Aliquam hendrerit lorem dui, a ullamcorper turpis sagittis at. Morbi ut dui ac tortor finibus sagittis eget vitae magna. Aenean nec scelerisque libero. Suspendisse libero justo, dignissim eget gravida a, tincidunt eu ipsum. Donec ac risus faucibus, tempus ligula vel, semper metus. Sed iaculis eget tellus id rutrum. Praesent id erat in sapien imperdiet rhoncus.\r\n\r\nSuspendisse in ultrices turpis. Morbi congue sem in ligula interdum sagittis. Donec sed neque neque. Nullam volutpat bibendum velit, sit amet euismod eros vestibulum eu. Etiam aliquam dolor nibh, ac ultrices mi pulvinar eu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed maximus laoreet augue, at viverra tellus sollicitudin eget.\r\n\r\nFusce quis luctus tellus. Vivamus suscipit consequat fringilla. Nulla sit amet libero vulputate, aliquam massa eget, aliquet nulla. Donec sed ultrices dolor. Proin aliquam cursus blandit. Nam sed suscipit lorem. Etiam malesuada vulputate justo. Phasellus rutrum lectus id erat imperdiet, vitae pharetra felis finibus. In sodales velit in lobortis posuere. Quisque maximus velit a urna pretium, in egestas leo efficitur.\r\n\r\nNullam varius, mi rutrum bibendum feugiat, nisl ipsum mattis neque, a feugiat ipsum erat ut ante. Duis ultrices consequat risus, at tempor urna egestas eu. Integer varius ornare ipsum, et laoreet quam hendrerit vitae. Etiam nec magna id turpis aliquam condimentum. Praesent ullamcorper orci vitae ornare bibendum. Phasellus id ex accumsan, varius metus feugiat, pellentesque metus. Nullam id pulvinar tellus. Quisque quis accumsan neque. Vestibulum gravida sem ac felis sagittis, eu porta metus ultrices. Nullam non turpis tortor. Donec elit nisl, mattis vitae vestibulum eget, sollicitudin in sapien. In rhoncus tempus ipsum vitae condimentum. Etiam eget pharetra mi, finibus bibendum nisi.\r\n\r\nDonec tincidunt, augue pretium feugiat ultricies, neque tortor dignissim erat, eget mollis lacus nunc laoreet risus. Nunc auctor efficitur risus ut vehicula. Pellentesque feugiat mi at elit dignissim, condimentum porttitor ligula hendrerit. Sed eget placerat arcu, id iaculis risus. Maecenas orci risus, sagittis non neque a, bibendum luctus lorem. Duis ultrices ligula sit amet ex ullamcorper varius. Nunc sagittis semper est a vulputate. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.	2020-04-10 13:37:00-05	1
2	Second Blog Post!	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sed sagittis eros. Sed dictum purus sed mollis faucibus. Integer interdum id turpis ac bibendum. Praesent scelerisque nisi ac mauris laoreet maximus fringilla quis velit. Nunc tristique, nisl eu venenatis posuere, elit quam blandit sapien, eu fringilla eros elit id turpis. Nam non justo ut quam tempus dapibus id sit amet massa. Aliquam hendrerit lorem dui, a ullamcorper turpis sagittis at. Morbi ut dui ac tortor finibus sagittis eget vitae magna. Aenean nec scelerisque libero. Suspendisse libero justo, dignissim eget gravida a, tincidunt eu ipsum. Donec ac risus faucibus, tempus ligula vel, semper metus. Sed iaculis eget tellus id rutrum. Praesent id erat in sapien imperdiet rhoncus.\r\n\r\nSuspendisse in ultrices turpis. Morbi congue sem in ligula interdum sagittis. Donec sed neque neque. Nullam volutpat bibendum velit, sit amet euismod eros vestibulum eu. Etiam aliquam dolor nibh, ac ultrices mi pulvinar eu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed maximus laoreet augue, at viverra tellus sollicitudin eget.\r\n\r\nFusce quis luctus tellus. Vivamus suscipit consequat fringilla. Nulla sit amet libero vulputate, aliquam massa eget, aliquet nulla. Donec sed ultrices dolor. Proin aliquam cursus blandit. Nam sed suscipit lorem. Etiam malesuada vulputate justo. Phasellus rutrum lectus id erat imperdiet, vitae pharetra felis finibus. In sodales velit in lobortis posuere. Quisque maximus velit a urna pretium, in egestas leo efficitur.\r\n\r\nNullam varius, mi rutrum bibendum feugiat, nisl ipsum mattis neque, a feugiat ipsum erat ut ante. Duis ultrices consequat risus, at tempor urna egestas eu. Integer varius ornare ipsum, et laoreet quam hendrerit vitae. Etiam nec magna id turpis aliquam condimentum. Praesent ullamcorper orci vitae ornare bibendum. Phasellus id ex accumsan, varius metus feugiat, pellentesque metus. Nullam id pulvinar tellus. Quisque quis accumsan neque. Vestibulum gravida sem ac felis sagittis, eu porta metus ultrices. Nullam non turpis tortor. Donec elit nisl, mattis vitae vestibulum eget, sollicitudin in sapien. In rhoncus tempus ipsum vitae condimentum. Etiam eget pharetra mi, finibus bibendum nisi.\r\n\r\nDonec tincidunt, augue pretium feugiat ultricies, neque tortor dignissim erat, eget mollis lacus nunc laoreet risus. Nunc auctor efficitur risus ut vehicula. Pellentesque feugiat mi at elit dignissim, condimentum porttitor ligula hendrerit. Sed eget placerat arcu, id iaculis risus. Maecenas orci risus, sagittis non neque a, bibendum luctus lorem. Duis ultrices ligula sit amet ex ullamcorper varius. Nunc sagittis semper est a vulputate. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.	2020-04-10 13:37:36-05	1
6	Blog 04	This is the fourth blog post - updated	2020-04-11 20:41:19.833524-05	1
8	This is a new Blog Post	This is blog post content	2020-04-11 21:09:04.4319-05	11
9	My Updated Post	My first updated post!\r\n\r\nThis is exciting!	2020-04-12 07:20:44.420378-05	1
12	My Updated Post	My first updated post!\r\n\r\nThis is exciting!	2020-04-12 07:28:58.932869-05	1
13	A Second Post	This is a post from a different user...	2020-04-12 07:28:58.998693-05	11
14	Top 5 Programming Lanaguages	Te melius apeirian postulant cum, labitur admodum cu eos! Tollit equidem constituto ut has. Et per ponderum sadipscing, eu vero dolores recusabo nec! Eum quas epicuri at, eam albucius phaedrum ad, no eum probo fierent singulis. Dicat corrumpit definiebas id usu, in facete scripserit eam.\r\n\r\nVim ei exerci nusquam. Agam detraxit an quo? Quo et partem bonorum sensibus, mutat minimum est ad. In paulo essent signiferumque his, quaestio sadipscing theophrastus ad has. Ancillae appareat qualisque ei has, usu ne assum zril disputationi, sed at gloriatur persequeris.	2020-04-12 07:28:58.999662-05	1
15	Sublime Text Tips and Tricks	Ea vix dico modus voluptatibus, mel iudico suavitate iracundia eu. Tincidunt voluptatibus pro eu? Nulla omittam eligendi his ne, suas putant ut pri. Ullum repudiare at duo, ut cum habeo minim laudem, dicit libris antiopam has ut! Ex movet feugait mea, eu vim impetus nostrud cotidieque.\r\n\r\nEi suas similique quo, his simul viris congue ex? Graeci possit in est, ne qui minim delectus invenire. Mei ad error homero maluisset, tacimates assentior per in, vix ut vocent accusata! Mei eu inermis pericula patrioque? Debet denique sea at, ad cibo reformidans theophrastus per, cu inermis maiestatis vim!\r\n\r\nUt odio feugiat voluptua est, euismod volutpat qualisque at sit, has ex dicit ornatus inimicus! Eu ferri laoreet vel, dicat corrumpit dissentias nec in. Illum dissentiunt eam ei, praesent voluptatum pri in? Ius in inani petentium, hinc elitr vivendum an vis, in vero dolores electram ius?	2020-04-12 07:28:59.001658-05	1
16	Best Python IDEs	Elit contentiones nam no, sea ut consul adipiscing. Etiam velit ei usu, sonet clita nonumy eu eum. Usu ea utroque facilisi, cu mel fugit tantas legimus, te vix quem nominavi. Prima deserunt evertitur ne qui, nam reprimique appellantur ne.	2020-04-12 07:28:59.00268-05	1
17	Flask vs Django - Which Is Better?	Ei dicta apeirian deterruisset eam, cu offendit invenire pri, cu possim vivendo vix? Nam nihil evertitur ad, ne vim nonumy legendos iracundia. Vix nulla dolorem intellegebat ea? Te per vide paulo dolor, eum ea erant placerat constituam? Dolores accumsan eum at.\r\n\r\nInteresset consequuntur id vix. Eam id decore latine, iusto imperdiet ei qui. In ludus consul reformidans eam. Nec in recusabo posidonium, cu tantas volumus mnesarchum pro. Nam ut docendi evertitur, possim menandri persecuti ne sed, cum saepe ornatus delenit ei?\r\n\r\nIn mel debet aliquam. In his etiam legere, doming nominavi consetetur has ad, decore reprimique ea usu. Eam magna graeci suavitate cu, facete delenit cum ne. Ponderum evertitur tincidunt ei mel, ius ei stet euismod docendi.	2020-04-12 07:28:59.003675-05	11
18	You Won't Believe These Clickbait Titles!	Cu justo honestatis mel, pro ei appareat mediocrem suavitate. No his omnis ridens. Ludus ornatus voluptatum mei ut, an mentitum noluisse forensibus cum. Eam affert pertinax consequuntur ei, nisl zril meliore te vis? Ad animal persius concludaturque vix, eu graece audiam mel.\r\n\r\nVitae libris mentitum pri in. Cu rebum veritus sea, ex usu consul dolorum, pro tale maluisset consulatu ut. Quo ad clita persius ancillae. Vel illud blandit at, vel eu hinc graeco, usu doctus praesent ea! Vim rebum deserunt ex.\r\n\r\nIus lorem omittam id, est suavitate definitionem ad! Id vim insolens tacimates, pri at decore causae. Ex duo bonorum repudiandae? Vix no vidit facete impedit. An oportere indoctum eam.	2020-04-12 07:28:59.00465-05	11
19	These Beers Will Improve Your Programming	Sanctus senserit vis id, ut eum iuvaret invidunt constituam? Nonumes facilis mei an, ad elit explicari persequeris pri, dico recusabo quo id? At mea lorem repudiandae. Sed causae sensibus forensibus ea, ne ornatus suscipiantur consectetuer mel, affert nostro nominati cu qui. Te sanctus constituto est, corrumpit pertinacia eos et, mei libris persequeris an.\r\n\r\nQuo fuisset sensibus in. Ad est assueverit adversarium, viris aperiri numquam est ad. Pro mediocrem iudicabit ei! Cu aperiam diceret sit.	2020-04-12 07:28:59.00665-05	1
20	List of PyCon 2018 Talks	Has ea verear adolescens, elit justo constituam duo in, vix an copiosae contentiones. Eos persius consequuntur no, esse percipit cum ea, per modus harum praesent at. Et clita delenit luptatum usu? No cum interpretaris concludaturque. Congue pertinax ea mea.\r\n\r\nBrute iracundia philosophia ei quo, nam at adhuc idque, ex dolor homero mei. No mea affert tacimates pertinacia, in maluisset dissentias consectetuer mei, vel no aliquam splendide. In has nobis vocent adipisci? Pri clita delicata in, iusto viris scripserit vim in? Sit in lorem complectitur. Sanctus eloquentiam eum ut, et sumo apeirian mea? Vim te affert populo voluptaria, utinam consul ad duo.	2020-04-12 07:28:59.007642-05	1
21	How Dogs in the Workplace Boosts Productivity	Has ea verear adolescens, elit justo constituam duo in, vix an copiosae contentiones. Eos persius consequuntur no, esse percipit cum ea, per modus harum praesent at. Et clita delenit luptatum usu? No cum interpretaris concludaturque. Congue pertinax ea mea.\r\n\r\nBrute iracundia philosophia ei quo, nam at adhuc idque, ex dolor homero mei. No mea affert tacimates pertinacia, in maluisset dissentias consectetuer mei, vel no aliquam splendide. In has nobis vocent adipisci? Pri clita delicata in, iusto viris scripserit vim in? Sit in lorem complectitur. Sanctus eloquentiam eum ut, et sumo apeirian mea? Vim te affert populo voluptaria, utinam consul ad duo.	2020-04-12 07:28:59.007642-05	1
22	The Best Programming Podcasts	Vidisse malorum platonem vel no. Persecuti adversarium ut sit, quo et stet velit mundi! Id per homero expetenda. Est brute adipisci et!\r\n\r\nLorem aliquip has in, quo debet ceteros sadipscing ne! An sea odio ornatus inermis, an per ipsum persecuti dissentiunt, no mea bonorum pertinacia delicatissimi? Ne sumo diceret mea, percipit repudiare eam no! Pro et lorem accommodare. At eius novum phaedrum mei?\r\n\r\nIgnota conclusionemque mei no, eam ut munere fierent pertinacia. Ea enim insolens gloriatur duo, quis vituperatoribus pro no! Ei sed bonorum reprehendunt, aliquam nominavi his et. Magna decore referrentur id nec. Cum rebum ludus inimicus no, id cum iusto labores maluisset!\r\n\r\nQui no omnis numquam apeirian, et vide interesset cum? Et nec nulla signiferumque. Enim instructior eos ei, solum tollit phaedrum his in? No vix malorum ornatus, cu quo hinc everti iracundia, essent eruditi efficiendi ut nam. Altera saperet usu eu, errem expetenda cu duo. Has dolor splendide et, no mel cibo ancillae voluptatum, mutat antiopam deterruisset ei qui. Dolores scripserit concludaturque est id, ea animal facilisi splendide qui, quo at animal voluptua instructior.\r\n\r\nMeis voluptatum eu eum.	2020-04-12 07:28:59.008639-05	1
23	Tips for Public Speaking	Ex eam doctus accommodare. Ut oratio vivendo intellegebat qui. Ius ne doming petentium. Pri congue delectus ad, accumsan molestiae disputando te mea. Nam case inani eligendi at, per te esse iudico. Feugiat patrioque mei ad, harum mundi adversarium an per!\r\n\r\nAncillae verterem eleifend his at? Nam vidit iusto petentium at, vis nusquam dissentias cu, etiam doctus adversarium eam no. At alterum definiebas efficiantur eos, pro labitur vituperatoribus ne, eu odio legere vim. Ad nec verear appellantur? Ad qui vulputate persequeris.	2020-04-12 07:28:59.010633-05	11
24	Best Programmers Throughout History	Mel nulla legimus senserit id. Vim purto tractatos in, te vix error regione, erant laudem legere an vel. Falli fierent ius ex! In legere iriure est, id vis prima maluisset, purto numquam inimicus ut eos! In duo antiopam salutatus, an vel quodsi virtute definitiones.\r\n\r\nEst te sumo voluptaria, ius no putant argumentum, alienum ocurreret vim cu? Volumus democritum no vel, virtute commune an est. Vel te propriae lobortis rationibus, no eum odio neglegentur? Duo an sumo ignota latine! Nec mazim aperiam percipitur eu, id his dicit omnium.	2020-04-12 07:28:59.011631-05	11
25	How To Create A YouTube Channel	Sit et novum omnes. Nec ea quas minim tractatos, usu in aperiam mentitum necessitatibus, ut omnis equidem moderatius quo. Eos ad putent aeterno praesent. Eos omnium similique id, his accommodare philosophia at. Causae lucilius similique in mea, ut regione tritani voluptatibus mel! At possim offendit eum, aeque denique prodesset pro te?\r\n\r\nAt pro quem laudem. Et agam democritum eos? Ea quod probatus usu, no ferri fabulas cotidieque mei? Numquam nusquam quo in, quo et molestiae complectitur. Nihil semper ei qui.\r\n\r\nModo omnes forensibus duo ex, te est diceret bonorum labores! Magna ponderum eos ea. Cu vim diceret mnesarchum, graeci periculis in vis. Est no iriure suavitate!	2020-04-12 07:28:59.012628-05	11
26	How I Record My Videos	Ad vel possim delicatissimi, delectus detraxit per cu. Ad pri vidit modus altera! In erat complectitur sit, quo no nostro insolens? Aliquam patrioque scribentur quo ad, partem commune eos at. Eius vivendo comprehensam has ne, sea ne eros mazim oratio. Soluta populo te duo, ne pro causae fabulas percipitur, feugiat.	2020-04-12 07:28:59.014623-05	1
27	Python and Physics	Agam mediocritatem sed ex, fabellas recusabo dissentias vix te. No principes consequat inciderint pri, ea mundi affert persecuti mea, ne usu veri regione nostrum! An tibique dissentiet referrentur pro, ridens temporibus eu est! Ius ne omnes affert rationibus, ut detraxit qualisque usu. Accusamus reformidans sea id?\r\n\r\nEu aliquip gloriatur mei. Qui ad sint scripserit? Te instructior definitiones mel, sale mutat everti at his. Ea mea quot recusabo philosophia. Et nam quod adipisci, quo atqui appetere recusabo id, detraxit inimicus vim.	2020-04-12 07:28:59.014623-05	1
28	Just A Few More Healines Should Do It	Duo at tibique commune vulputate, ex facilis tacimates disputationi mei. Mel eu inani prompta labores! Audire omnesque offendit ex eos. An ferri accusata his, vel agam habeo maiestatis ex, eam mutat iisque concludaturque ut. Ut tamquam minimum partiendo vim. An nam vidit doming graecis.\r\n\r\nSingulis abhorreant his in, et altera audiam feugiat mei. Pri eius dolor persequeris id! Nam ea dolorem expetendis, idque everti suscipit qui te, noster repudiare dignissim per ex? No vim iriure tibique comprehensam, per utamur consequat.	2020-04-12 07:28:59.01562-05	1
29	Music To Listen To While Coding	Feugait reprimique eu mel, te eum dico electram. Nam no nemore cotidieque. Vim cu suas atqui dicunt. Id labitur dissentiunt per, ignota maiorum pri no? Clita altera sanctus ex his!\r\n\r\nAt alia electram reprehendunt eam, sea te volumus quaestio. Commodo voluptua senserit ius ne, eu enim disputationi eam? Id pri omnium blandit, nullam denique nec no? Sapientem vituperata sit et, nisl facilisis periculis in est. Elaboraret accommodare id vel? Cibo eripuit ut has, sed cu liber invidunt.\r\n\r\nEi pro vide quas dolorum, sea no fugit sanctus neglegentur. Sit feugait disputationi ne. Id diceret periculis nec, sint nonumes in sea, cum.	2020-04-12 07:28:59.016618-05	1
30	5 Tips for Writing Catchy Headlines	Ea homero possit epicuri est, debitis docendi tacimates cu duo? Ad lorem cetero disputando pri, veniam eruditi tacimates per te.	2020-04-12 07:28:59.017615-05	11
31	The Rise of Data Science	Per omittam placerat at. Eius aeque ei mei. Usu ex partiendo salutandi. Pro illud placerat molestiae ex, habeo vidisse voluptatum cu vel, efficiendi accommodare eum ea! Ne has case minimum facilisis, pertinax efficiendi eu vel!\r\n\r\nEt movet semper assueverit his. Mei at liber vitae. Vix et periculis definiebas, vero falli.	2020-04-12 07:28:59.018613-05	11
32	Best Videos For Learning Python	Mei ei mazim dicunt feugait? Ludus mandamus ne est, per ne iusto facilisis moderatius! Has agam utamur ad! Ius reque aeterno cu, fabellas facilisi repudiare eu sit, te cibo convenire similique est. Ea cum viderer imperdiet liberavisse.\r\n\r\nPro minim iuvaret ad. No nam ornatus principes euripidis, at sale vituperatoribus eos, eros regione scripserit id mea. Has ne inermis nostrum, quo tantas melius dissentias at! Ut vim tibique omnesque. An mel modo ponderum, eum at probo appetere imperdiet? Natum quaeque intellegebat per ex. Cu viris clita sit?\r\n\r\nReque menandri dissentias sed ne, no tota nonumes eos, vix in tempor maiestatis erant.	2020-04-12 07:28:59.019639-05	1
33	Top 10 Python Tips and Tricks	Pro minim iuvaret ad. No nam ornatus principes euripidis, at sale vituperatoribus eos, eros regione scripserit id mea. Has ne inermis nostrum, quo tantas melius dissentias at! Ut vim tibique omnesque. An mel modo ponderum, eum at probo appetere imperdiet? Natum quaeque intellegebat per ex. Cu viris clita sit?\r\n\r\nReque menandri dissentias sed ne, no tota nonumes eos, vix in tempor maiestatis erant.	2020-04-12 07:28:59.020607-05	1
34	Top 5 YouTube Channels For Learning Programming	Quo inani quando ea, mel an vide adversarium suscipiantur. Et dicunt eleifend splendide pro. Nibh animal dolorem vim ex, nec te agam referrentur. Usu admodum ocurreret ne.\r\n\r\nEt dico audire cotidieque sed, cibo latine ut has, an case magna alienum.	2020-04-12 07:28:59.022602-05	11
35	My Latest Updated Post	Erat expetenda definitionem id eos. Semper suscipit eum ut, eum ex nemore copiosae. Nam probatus pertinacia eu! No alii voluptua abhorreant nec, te pro impedit concludaturque, in sea malis torquatos disputationi! Nam te alii nobis ponderum, ei fugit accusamus pro.\r\n\r\nCongue salutandi ex eam! Mei an prima consulatu, erat detracto eu quo? Vim ea esse utinam efficiantur, at noster dicunt.	2020-04-12 07:28:59.023599-05	1
\.


--
-- TOC entry 3037 (class 0 OID 17402)
-- Dependencies: 219
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2020-04-10 12:57:23.443766-05	2	TestUser	1	[{"added": {}}]	4	1
2	2020-04-10 13:37:36.870293-05	1	First blog post!	1	[{"added": {}}]	7	1
3	2020-04-10 13:37:47.710768-05	2	Second Blog Post!	1	[{"added": {}}]	7	1
4	2020-04-10 13:37:57.299214-05	3	Third Blog Post!	1	[{"added": {}}]	7	1
5	2020-04-10 13:38:05.352288-05	4	Fourth Blog Post!	1	[{"added": {}}]	7	1
6	2020-04-11 07:25:37.64456-05	1	jgreen44 Profile	1	[{"added": {}}]	8	1
7	2020-04-11 07:26:25.905478-05	2	TestUser Profile	1	[{"added": {}}]	8	1
8	2020-04-11 07:42:38.771283-05	2	TestUser Profile	3		8	1
9	2020-04-11 07:42:38.789236-05	1	jgreen44 Profile	3		8	1
10	2020-04-11 07:42:49.79863-05	3	jgreen44 Profile	1	[{"added": {}}]	8	1
11	2020-04-11 07:42:56.445319-05	4	TestUser Profile	1	[{"added": {}}]	8	1
12	2020-04-11 07:44:15.179503-05	4	TestUser Profile	3		8	1
13	2020-04-11 07:44:15.183493-05	3	jgreen44 Profile	3		8	1
14	2020-04-11 07:44:38.886143-05	5	jgreen44 Profile	1	[{"added": {}}]	8	1
15	2020-04-11 07:47:35.86919-05	5	jgreen44 Profile	3		8	1
16	2020-04-11 07:47:52.083737-05	6	jgreen44 Profile	1	[{"added": {}}]	8	1
17	2020-04-11 07:48:16.739573-05	6	jgreen44 Profile	3		8	1
18	2020-04-11 07:48:32.76216-05	7	jgreen44 Profile	1	[{"added": {}}]	8	1
19	2020-04-11 07:48:51.060438-05	8	TestUser Profile	1	[{"added": {}}]	8	1
20	2020-04-11 08:15:16.097347-05	9	TestUser02 Profile	1	[{"added": {}}]	8	1
21	2020-04-11 08:22:32.717672-05	9	TestUser02 Profile	3		8	1
22	2020-04-11 08:22:32.720664-05	8	TestUser Profile	3		8	1
23	2020-04-11 08:22:32.72266-05	7	jgreen44 Profile	3		8	1
24	2020-04-11 08:25:12.185135-05	10	jgreen44 Profile	1	[{"added": {}}]	8	1
25	2020-04-11 08:36:35.845864-05	1	jgreen44	2	[{"changed": {"fields": ["First name", "Last name"]}}]	4	1
26	2020-04-11 11:56:11.836079-05	11	SomeUser03 Profile	1	[{"added": {}}]	8	1
27	2020-04-11 12:21:30.411092-05	11	SomeUser03 Profile	3		8	1
28	2020-04-11 12:21:30.417105-05	10	jgreen44 Profile	3		8	1
29	2020-04-11 12:21:58.509977-05	12	jgreen44 Profile	1	[{"added": {}}]	8	1
30	2020-04-11 12:22:05.812829-05	13	SomeUser Profile	1	[{"added": {}}]	8	1
31	2020-04-11 15:39:28.814178-05	14	SomeUser04 Profile	3		8	1
32	2020-04-11 15:39:28.817172-05	13	SomeUser Profile	3		8	1
33	2020-04-11 15:39:28.819164-05	12	jgreen44 Profile	3		8	1
34	2020-04-11 15:39:43.33293-05	7	SomeUser	3		4	1
35	2020-04-11 15:39:43.335951-05	8	SomeUser02	3		4	1
36	2020-04-11 15:39:43.337941-05	9	SomeUser03	3		4	1
37	2020-04-11 15:39:43.351879-05	10	SomeUser04	3		4	1
38	2020-04-11 15:39:43.352876-05	2	TestUser	3		4	1
39	2020-04-11 15:39:43.353874-05	3	TestUser02	3		4	1
40	2020-04-11 15:39:43.354871-05	4	TestUser03	3		4	1
41	2020-04-11 15:39:43.356869-05	5	TestUser05	3		4	1
42	2020-04-11 15:39:43.357865-05	6	TestUser06	3		4	1
43	2020-04-11 16:56:58.916832-05	16	jgreen44 Profile	1	[{"added": {}}]	8	1
44	2020-04-11 20:54:53.069053-05	7	Second users post	1	[{"added": {}}]	7	1
45	2020-04-11 20:55:39.647421-05	11	TestingUser	2	[{"changed": {"fields": ["First name", "Last name"]}}]	4	1
46	2020-04-11 20:56:14.947364-05	15	TestingUser Profile	2	[{"changed": {"fields": ["Image"]}}]	8	1
\.


--
-- TOC entry 3023 (class 0 OID 17288)
-- Dependencies: 205
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	blog	post
8	users	profile
9	friendship	follow
10	friendship	friend
11	friendship	friendshiprequest
12	friendship	block
\.


--
-- TOC entry 3021 (class 0 OID 17277)
-- Dependencies: 203
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-04-10 10:28:36.298624-05
2	auth	0001_initial	2020-04-10 10:28:36.935917-05
3	admin	0001_initial	2020-04-10 10:28:37.978255-05
4	admin	0002_logentry_remove_auto_add	2020-04-10 10:28:38.089927-05
5	admin	0003_logentry_add_action_flag_choices	2020-04-10 10:28:38.102952-05
6	contenttypes	0002_remove_content_type_name	2020-04-10 10:28:38.120842-05
7	auth	0002_alter_permission_name_max_length	2020-04-10 10:28:38.126105-05
8	auth	0003_alter_user_email_max_length	2020-04-10 10:28:38.126105-05
9	auth	0004_alter_user_username_opts	2020-04-10 10:28:38.144109-05
10	auth	0005_alter_user_last_login_null	2020-04-10 10:28:38.153088-05
11	auth	0006_require_contenttypes_0002	2020-04-10 10:28:38.156072-05
12	auth	0007_alter_validators_add_error_messages	2020-04-10 10:28:38.165106-05
13	auth	0008_alter_user_username_max_length	2020-04-10 10:28:38.21794-05
14	auth	0009_alter_user_last_name_max_length	2020-04-10 10:28:38.227908-05
15	auth	0010_alter_group_name_max_length	2020-04-10 10:28:38.236092-05
16	auth	0011_update_proxy_permissions	2020-04-10 10:28:38.236092-05
17	sessions	0001_initial	2020-04-10 10:28:38.320072-05
18	blog	0001_initial	2020-04-10 13:12:59.853514-05
19	users	0001_initial	2020-04-11 07:18:55.391197-05
20	users	0002_auto_20200411_0818	2020-04-11 08:18:37.549818-05
21	users	0003_auto_20200411_0824	2020-04-11 08:24:39.734899-05
22	users	0004_auto_20200411_0837	2020-04-11 08:37:38.078192-05
23	users	0005_auto_20200411_1150	2020-04-11 11:51:04.177999-05
24	users	0006_auto_20200411_1207	2020-04-11 12:08:02.71894-05
25	users	0007_auto_20200411_1230	2020-04-11 12:31:01.470552-05
26	users	0008_auto_20200411_1233	2020-04-11 12:33:50.389802-05
27	users	0009_profile_gender	2020-04-11 15:10:21.067391-05
28	users	0010_remove_profile_gender	2020-04-11 15:15:38.115071-05
29	users	0011_profile_gender	2020-04-11 15:27:35.922721-05
30	users	0012_auto_20200411_1612	2020-04-11 16:12:19.427258-05
31	friendship	0001_initial	2020-04-12 13:15:10.401642-05
32	friendship	0002_block	2020-04-12 13:15:10.685914-05
33	friendship	0003_block_unique_together	2020-04-12 13:15:10.829527-05
34	friendship	0004_auto_20200408_1844	2020-04-12 13:15:10.85845-05
\.


--
-- TOC entry 3038 (class 0 OID 17433)
-- Dependencies: 220
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
tovtqywbkn2xeltebqb69xfui6qbbo2n	ODk3MDQ4ZWUxNDQ2YTk4ZDZiNTYwNzdhYzE0OTE3MzIzM2I5OTg4ZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4NzdlNDA0YjZhMDc3ZWIxNWEzNDgxZDJlOWFhNzdmZWI4Y2JjZGVhIn0=	2020-04-26 16:21:22.779937-05
uecl9zhnt0jglq46j9ptco04ftgfdacs	ODk3MDQ4ZWUxNDQ2YTk4ZDZiNTYwNzdhYzE0OTE3MzIzM2I5OTg4ZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4NzdlNDA0YjZhMDc3ZWIxNWEzNDgxZDJlOWFhNzdmZWI4Y2JjZGVhIn0=	2020-04-27 17:14:43.070521-05
vk7o9o8zd9x7o0muh3gujjzr8me0mkw5	NGQxNjE3MTYwYTU2Y2RkYmNjMGY1NzFkMzcxNGI1NzcwZDA5YTFkNTp7fQ==	2020-04-25 16:56:16.843381-05
j510ulta81axp3y6s17uesk1gh76z5m1	N2I4NmZmOTFlNDRjNjJhNGY3NzI3MDVkNGRkZTJiOGM5ZmJhZThlZDp7Il9hdXRoX3VzZXJfaWQiOiIxMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDUxMTA3MzNkZGYyMGFmNTkwMzI5OGVmZmNkNDYyOTU3ZjJiMjMwNiJ9	2020-04-25 20:55:22.107725-05
\.


--
-- TOC entry 3050 (class 0 OID 17551)
-- Dependencies: 232
-- Data for Name: friendship_block; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friendship_block (id, created, blocked_id, blocker_id) FROM stdin;
\.


--
-- TOC entry 3044 (class 0 OID 17482)
-- Dependencies: 226
-- Data for Name: friendship_follow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friendship_follow (id, created, followee_id, follower_id) FROM stdin;
\.


--
-- TOC entry 3046 (class 0 OID 17490)
-- Dependencies: 228
-- Data for Name: friendship_friend; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friendship_friend (id, created, from_user_id, to_user_id) FROM stdin;
\.


--
-- TOC entry 3048 (class 0 OID 17498)
-- Dependencies: 230
-- Data for Name: friendship_friendshiprequest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friendship_friendshiprequest (id, message, created, rejected, viewed, from_user_id, to_user_id) FROM stdin;
\.


--
-- TOC entry 3042 (class 0 OID 17462)
-- Dependencies: 224
-- Data for Name: users_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_profile (id, image, user_id, gender) FROM stdin;
16	jgreen44/Profile_Pic_accEpWm.jpeg	1	Couple's Account
15	TestingUser/default.jpg	11	Single Female
\.


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 208
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 210
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 206
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 48, true);


--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 214
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 212
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 11, true);


--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 216
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 221
-- Name: blog_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blog_post_id_seq', 36, true);


--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 218
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 46, true);


--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 204
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 12, true);


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 202
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 34, true);


--
-- TOC entry 3081 (class 0 OID 0)
-- Dependencies: 231
-- Name: friendship_block_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friendship_block_id_seq', 1, false);


--
-- TOC entry 3082 (class 0 OID 0)
-- Dependencies: 225
-- Name: friendship_follow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friendship_follow_id_seq', 1, false);


--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 227
-- Name: friendship_friend_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friendship_friend_id_seq', 1, false);


--
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 229
-- Name: friendship_friendshiprequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friendship_friendshiprequest_id_seq', 1, false);


--
-- TOC entry 3085 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_profile_id_seq', 16, true);


--
-- TOC entry 2810 (class 2606 OID 17431)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 2815 (class 2606 OID 17358)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 2818 (class 2606 OID 17321)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2812 (class 2606 OID 17311)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 2805 (class 2606 OID 17349)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 2807 (class 2606 OID 17303)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 2826 (class 2606 OID 17339)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 2829 (class 2606 OID 17373)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 2820 (class 2606 OID 17329)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2832 (class 2606 OID 17347)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2835 (class 2606 OID 17387)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 2823 (class 2606 OID 17425)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 2846 (class 2606 OID 17453)
-- Name: blog_post blog_post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_post
    ADD CONSTRAINT blog_post_pkey PRIMARY KEY (id);


--
-- TOC entry 2838 (class 2606 OID 17411)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 2800 (class 2606 OID 17295)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 2802 (class 2606 OID 17293)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2798 (class 2606 OID 17285)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2842 (class 2606 OID 17440)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 2872 (class 2606 OID 17570)
-- Name: friendship_block friendship_block_blocker_id_blocked_id_e24c5fca_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_block
    ADD CONSTRAINT friendship_block_blocker_id_blocked_id_e24c5fca_uniq UNIQUE (blocker_id, blocked_id);


--
-- TOC entry 2874 (class 2606 OID 17556)
-- Name: friendship_block friendship_block_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_block
    ADD CONSTRAINT friendship_block_pkey PRIMARY KEY (id);


--
-- TOC entry 2854 (class 2606 OID 17512)
-- Name: friendship_follow friendship_follow_follower_id_followee_id_75264015_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_follow
    ADD CONSTRAINT friendship_follow_follower_id_followee_id_75264015_uniq UNIQUE (follower_id, followee_id);


--
-- TOC entry 2856 (class 2606 OID 17487)
-- Name: friendship_follow friendship_follow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_follow
    ADD CONSTRAINT friendship_follow_pkey PRIMARY KEY (id);


--
-- TOC entry 2859 (class 2606 OID 17510)
-- Name: friendship_friend friendship_friend_from_user_id_to_user_id_5aa078c0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_friend
    ADD CONSTRAINT friendship_friend_from_user_id_to_user_id_5aa078c0_uniq UNIQUE (from_user_id, to_user_id);


--
-- TOC entry 2861 (class 2606 OID 17495)
-- Name: friendship_friend friendship_friend_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_friend
    ADD CONSTRAINT friendship_friend_pkey PRIMARY KEY (id);


--
-- TOC entry 2864 (class 2606 OID 17508)
-- Name: friendship_friendshiprequest friendship_friendshipreq_from_user_id_to_user_id_003053a1_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_friendshiprequest
    ADD CONSTRAINT friendship_friendshipreq_from_user_id_to_user_id_003053a1_uniq UNIQUE (from_user_id, to_user_id);


--
-- TOC entry 2867 (class 2606 OID 17506)
-- Name: friendship_friendshiprequest friendship_friendshiprequest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_friendshiprequest
    ADD CONSTRAINT friendship_friendshiprequest_pkey PRIMARY KEY (id);


--
-- TOC entry 2848 (class 2606 OID 17467)
-- Name: users_profile users_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_pkey PRIMARY KEY (id);


--
-- TOC entry 2850 (class 2606 OID 17469)
-- Name: users_profile users_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_user_id_key UNIQUE (user_id);


--
-- TOC entry 2808 (class 1259 OID 17432)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 2813 (class 1259 OID 17369)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 2816 (class 1259 OID 17370)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 2803 (class 1259 OID 17355)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 2824 (class 1259 OID 17385)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- TOC entry 2827 (class 1259 OID 17384)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- TOC entry 2830 (class 1259 OID 17399)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 2833 (class 1259 OID 17398)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 2821 (class 1259 OID 17426)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 2844 (class 1259 OID 17459)
-- Name: blog_post_author_id_dd7a8485; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX blog_post_author_id_dd7a8485 ON public.blog_post USING btree (author_id);


--
-- TOC entry 2836 (class 1259 OID 17422)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 2839 (class 1259 OID 17423)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 2840 (class 1259 OID 17442)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 2843 (class 1259 OID 17441)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 2869 (class 1259 OID 17567)
-- Name: friendship_block_blocked_id_75e16cd7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX friendship_block_blocked_id_75e16cd7 ON public.friendship_block USING btree (blocked_id);


--
-- TOC entry 2870 (class 1259 OID 17568)
-- Name: friendship_block_blocker_id_94707a64; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX friendship_block_blocker_id_94707a64 ON public.friendship_block USING btree (blocker_id);


--
-- TOC entry 2851 (class 1259 OID 17523)
-- Name: friendship_follow_followee_id_3348979c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX friendship_follow_followee_id_3348979c ON public.friendship_follow USING btree (followee_id);


--
-- TOC entry 2852 (class 1259 OID 17524)
-- Name: friendship_follow_follower_id_c10685be; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX friendship_follow_follower_id_c10685be ON public.friendship_follow USING btree (follower_id);


--
-- TOC entry 2857 (class 1259 OID 17535)
-- Name: friendship_friend_from_user_id_f229f783; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX friendship_friend_from_user_id_f229f783 ON public.friendship_friend USING btree (from_user_id);


--
-- TOC entry 2862 (class 1259 OID 17536)
-- Name: friendship_friend_to_user_id_0de15f5e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX friendship_friend_to_user_id_0de15f5e ON public.friendship_friend USING btree (to_user_id);


--
-- TOC entry 2865 (class 1259 OID 17547)
-- Name: friendship_friendshiprequest_from_user_id_bbaf16e8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX friendship_friendshiprequest_from_user_id_bbaf16e8 ON public.friendship_friendshiprequest USING btree (from_user_id);


--
-- TOC entry 2868 (class 1259 OID 17548)
-- Name: friendship_friendshiprequest_to_user_id_51d5a5a2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX friendship_friendshiprequest_to_user_id_51d5a5a2 ON public.friendship_friendshiprequest USING btree (to_user_id);


--
-- TOC entry 2877 (class 2606 OID 17364)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2876 (class 2606 OID 17359)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2875 (class 2606 OID 17350)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2879 (class 2606 OID 17379)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2878 (class 2606 OID 17374)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2881 (class 2606 OID 17393)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2880 (class 2606 OID 17388)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2884 (class 2606 OID 17454)
-- Name: blog_post blog_post_author_id_dd7a8485_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blog_post
    ADD CONSTRAINT blog_post_author_id_dd7a8485_fk_auth_user_id FOREIGN KEY (author_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2882 (class 2606 OID 17412)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2883 (class 2606 OID 17417)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2892 (class 2606 OID 17557)
-- Name: friendship_block friendship_block_blocked_id_75e16cd7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_block
    ADD CONSTRAINT friendship_block_blocked_id_75e16cd7_fk_auth_user_id FOREIGN KEY (blocked_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2893 (class 2606 OID 17562)
-- Name: friendship_block friendship_block_blocker_id_94707a64_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_block
    ADD CONSTRAINT friendship_block_blocker_id_94707a64_fk_auth_user_id FOREIGN KEY (blocker_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2886 (class 2606 OID 17513)
-- Name: friendship_follow friendship_follow_followee_id_3348979c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_follow
    ADD CONSTRAINT friendship_follow_followee_id_3348979c_fk_auth_user_id FOREIGN KEY (followee_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2887 (class 2606 OID 17518)
-- Name: friendship_follow friendship_follow_follower_id_c10685be_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_follow
    ADD CONSTRAINT friendship_follow_follower_id_c10685be_fk_auth_user_id FOREIGN KEY (follower_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2888 (class 2606 OID 17525)
-- Name: friendship_friend friendship_friend_from_user_id_f229f783_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_friend
    ADD CONSTRAINT friendship_friend_from_user_id_f229f783_fk_auth_user_id FOREIGN KEY (from_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2889 (class 2606 OID 17530)
-- Name: friendship_friend friendship_friend_to_user_id_0de15f5e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_friend
    ADD CONSTRAINT friendship_friend_to_user_id_0de15f5e_fk_auth_user_id FOREIGN KEY (to_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2890 (class 2606 OID 17537)
-- Name: friendship_friendshiprequest friendship_friendshi_from_user_id_bbaf16e8_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_friendshiprequest
    ADD CONSTRAINT friendship_friendshi_from_user_id_bbaf16e8_fk_auth_user FOREIGN KEY (from_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2891 (class 2606 OID 17542)
-- Name: friendship_friendshiprequest friendship_friendshi_to_user_id_51d5a5a2_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendship_friendshiprequest
    ADD CONSTRAINT friendship_friendshi_to_user_id_51d5a5a2_fk_auth_user FOREIGN KEY (to_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2885 (class 2606 OID 17470)
-- Name: users_profile users_profile_user_id_2112e78d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_user_id_2112e78d_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2020-04-13 23:29:56

--
-- PostgreSQL database dump complete
--

