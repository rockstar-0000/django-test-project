-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               PostgreSQL 12.3, compiled by Visual C++ build 1914, 64-bit
-- Server OS:                    
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES  */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping data for table public.auth_group: 0 rows
/*!40000 ALTER TABLE "auth_group" DISABLE KEYS */;
/*!40000 ALTER TABLE "auth_group" ENABLE KEYS */;

-- Dumping data for table public.auth_group_permissions: 0 rows
/*!40000 ALTER TABLE "auth_group_permissions" DISABLE KEYS */;
/*!40000 ALTER TABLE "auth_group_permissions" ENABLE KEYS */;

-- Dumping data for table public.auth_permission: 84 rows
/*!40000 ALTER TABLE "auth_permission" DISABLE KEYS */;
INSERT INTO "auth_permission" ("id", "name", "content_type_id", "codename") VALUES
	(1, 'Can add comment', 1, 'add_comment'),
	(2, 'Can change comment', 1, 'change_comment'),
	(3, 'Can delete comment', 1, 'delete_comment'),
	(4, 'Can view comment', 1, 'view_comment'),
	(5, 'Can add post', 2, 'add_post'),
	(6, 'Can change post', 2, 'change_post'),
	(7, 'Can delete post', 2, 'delete_post'),
	(8, 'Can view post', 2, 'view_post'),
	(9, 'Can add vote', 3, 'add_vote'),
	(10, 'Can change vote', 3, 'change_vote'),
	(11, 'Can delete vote', 3, 'delete_vote'),
	(12, 'Can view vote', 3, 'view_vote'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add conversation', 5, 'add_conversation'),
	(18, 'Can change conversation', 5, 'change_conversation'),
	(19, 'Can delete conversation', 5, 'delete_conversation'),
	(20, 'Can view conversation', 5, 'view_conversation'),
	(21, 'Can add friendship', 6, 'add_friendship'),
	(22, 'Can change friendship', 6, 'change_friendship'),
	(23, 'Can delete friendship', 6, 'delete_friendship'),
	(24, 'Can view friendship', 6, 'view_friendship'),
	(25, 'Can add review content', 7, 'add_reviewcontent'),
	(26, 'Can change review content', 7, 'change_reviewcontent'),
	(27, 'Can delete review content', 7, 'delete_reviewcontent'),
	(28, 'Can view review content', 7, 'view_reviewcontent'),
	(29, 'Can add Verification Code', 8, 'add_verificationcode'),
	(30, 'Can change Verification Code', 8, 'change_verificationcode'),
	(31, 'Can delete Verification Code', 8, 'delete_verificationcode'),
	(32, 'Can view Verification Code', 8, 'view_verificationcode'),
	(33, 'Can add verification', 9, 'add_verification'),
	(34, 'Can change verification', 9, 'change_verification'),
	(35, 'Can delete verification', 9, 'delete_verification'),
	(36, 'Can view verification', 9, 'view_verification'),
	(37, 'Can add status', 10, 'add_status'),
	(38, 'Can change status', 10, 'change_status'),
	(39, 'Can delete status', 10, 'delete_status'),
	(40, 'Can view status', 10, 'view_status'),
	(41, 'Can add socket', 11, 'add_socket'),
	(42, 'Can change socket', 11, 'change_socket'),
	(43, 'Can delete socket', 11, 'delete_socket'),
	(44, 'Can view socket', 11, 'view_socket'),
	(45, 'Can add review', 12, 'add_review'),
	(46, 'Can change review', 12, 'change_review'),
	(47, 'Can delete review', 12, 'delete_review'),
	(48, 'Can view review', 12, 'view_review'),
	(49, 'Can add profile', 13, 'add_profile'),
	(50, 'Can change profile', 13, 'change_profile'),
	(51, 'Can delete profile', 13, 'delete_profile'),
	(52, 'Can view profile', 13, 'view_profile'),
	(53, 'Can add notification', 14, 'add_notification'),
	(54, 'Can change notification', 14, 'change_notification'),
	(55, 'Can delete notification', 14, 'delete_notification'),
	(56, 'Can view notification', 14, 'view_notification'),
	(57, 'Can add message', 15, 'add_message'),
	(58, 'Can change message', 15, 'change_message'),
	(59, 'Can delete message', 15, 'delete_message'),
	(60, 'Can view message', 15, 'view_message'),
	(61, 'Can add address', 16, 'add_address'),
	(62, 'Can change address', 16, 'change_address'),
	(63, 'Can delete address', 16, 'delete_address'),
	(64, 'Can view address', 16, 'view_address'),
	(65, 'Can add log entry', 17, 'add_logentry'),
	(66, 'Can change log entry', 17, 'change_logentry'),
	(67, 'Can delete log entry', 17, 'delete_logentry'),
	(68, 'Can view log entry', 17, 'view_logentry'),
	(69, 'Can add permission', 18, 'add_permission'),
	(70, 'Can change permission', 18, 'change_permission'),
	(71, 'Can delete permission', 18, 'delete_permission'),
	(72, 'Can view permission', 18, 'view_permission'),
	(73, 'Can add group', 19, 'add_group'),
	(74, 'Can change group', 19, 'change_group'),
	(75, 'Can delete group', 19, 'delete_group'),
	(76, 'Can view group', 19, 'view_group'),
	(77, 'Can add content type', 20, 'add_contenttype'),
	(78, 'Can change content type', 20, 'change_contenttype'),
	(79, 'Can delete content type', 20, 'delete_contenttype'),
	(80, 'Can view content type', 20, 'view_contenttype'),
	(81, 'Can add session', 21, 'add_session'),
	(82, 'Can change session', 21, 'change_session'),
	(83, 'Can delete session', 21, 'delete_session'),
	(84, 'Can view session', 21, 'view_session');
/*!40000 ALTER TABLE "auth_permission" ENABLE KEYS */;

-- Dumping data for table public.blog_comment: 0 rows
/*!40000 ALTER TABLE "blog_comment" DISABLE KEYS */;
/*!40000 ALTER TABLE "blog_comment" ENABLE KEYS */;

-- Dumping data for table public.blog_post: 0 rows
/*!40000 ALTER TABLE "blog_post" DISABLE KEYS */;
/*!40000 ALTER TABLE "blog_post" ENABLE KEYS */;

-- Dumping data for table public.blog_vote: 0 rows
/*!40000 ALTER TABLE "blog_vote" DISABLE KEYS */;
/*!40000 ALTER TABLE "blog_vote" ENABLE KEYS */;

-- Dumping data for table public.django_admin_log: 0 rows
/*!40000 ALTER TABLE "django_admin_log" DISABLE KEYS */;
/*!40000 ALTER TABLE "django_admin_log" ENABLE KEYS */;

-- Dumping data for table public.django_content_type: 0 rows
/*!40000 ALTER TABLE "django_content_type" DISABLE KEYS */;
INSERT INTO "django_content_type" ("id", "app_label", "model") VALUES
	(1, 'blog', 'comment'),
	(2, 'blog', 'post'),
	(3, 'blog', 'vote'),
	(4, 'users', 'user'),
	(5, 'users', 'conversation'),
	(6, 'users', 'friendship'),
	(7, 'users', 'reviewcontent'),
	(8, 'users', 'verificationcode'),
	(9, 'users', 'verification'),
	(10, 'users', 'status'),
	(11, 'users', 'socket'),
	(12, 'users', 'review'),
	(13, 'users', 'profile'),
	(14, 'users', 'notification'),
	(15, 'users', 'message'),
	(16, 'users', 'address'),
	(17, 'admin', 'logentry'),
	(18, 'auth', 'permission'),
	(19, 'auth', 'group'),
	(20, 'contenttypes', 'contenttype'),
	(21, 'sessions', 'session');
/*!40000 ALTER TABLE "django_content_type" ENABLE KEYS */;

-- Dumping data for table public.django_migrations: 0 rows
/*!40000 ALTER TABLE "django_migrations" DISABLE KEYS */;
INSERT INTO "django_migrations" ("id", "app", "name", "applied") VALUES
	(1, 'contenttypes', '0001_initial', '2020-05-16 13:53:05.000414-05'),
	(2, 'contenttypes', '0002_remove_content_type_name', '2020-05-16 13:53:05.007411-05'),
	(3, 'auth', '0001_initial', '2020-05-16 13:53:05.026434-05'),
	(4, 'auth', '0002_alter_permission_name_max_length', '2020-05-16 13:53:05.050411-05'),
	(5, 'auth', '0003_alter_user_email_max_length', '2020-05-16 13:53:05.054414-05'),
	(6, 'auth', '0004_alter_user_username_opts', '2020-05-16 13:53:05.058411-05'),
	(7, 'auth', '0005_alter_user_last_login_null', '2020-05-16 13:53:05.061431-05'),
	(8, 'auth', '0006_require_contenttypes_0002', '2020-05-16 13:53:05.063435-05'),
	(9, 'auth', '0007_alter_validators_add_error_messages', '2020-05-16 13:53:05.067411-05'),
	(10, 'auth', '0008_alter_user_username_max_length', '2020-05-16 13:53:05.08444-05'),
	(11, 'auth', '0009_alter_user_last_name_max_length', '2020-05-16 13:53:05.088413-05'),
	(12, 'auth', '0010_alter_group_name_max_length', '2020-05-16 13:53:05.099439-05'),
	(13, 'auth', '0011_update_proxy_permissions', '2020-05-16 13:53:05.10244-05'),
	(14, 'users', '0001_initial', '2020-05-16 13:53:05.264554-05'),
	(15, 'admin', '0001_initial', '2020-05-16 13:53:05.35482-05'),
	(16, 'admin', '0002_logentry_remove_auto_add', '2020-05-16 13:53:05.371849-05'),
	(17, 'admin', '0003_logentry_add_action_flag_choices', '2020-05-16 13:53:05.382819-05'),
	(18, 'blog', '0001_initial', '2020-05-16 13:53:05.404823-05'),
	(19, 'blog', '0002_auto_20200516_1353', '2020-05-16 13:53:05.458819-05'),
	(20, 'sessions', '0001_initial', '2020-05-16 13:53:05.474843-05');
/*!40000 ALTER TABLE "django_migrations" ENABLE KEYS */;

-- Dumping data for table public.django_session: 0 rows
/*!40000 ALTER TABLE "django_session" DISABLE KEYS */;
INSERT INTO "django_session" ("session_key", "session_data", "expire_date") VALUES
	('c7mzuuajo2lgsv3kbyz946bxuonys3hq', 'MTQ5NzI0MzE3YWJhMTk3NmI1NTAyMDBkMjU2MmZhMTNmYmQ1MTdjMzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNDM0M2ZkNjUwYzM0NDkzNTg3MGIyYmYwZThhNDI0NmYyMjgyNGQwIn0=', '2020-05-30 13:53:45.649581-05');
/*!40000 ALTER TABLE "django_session" ENABLE KEYS */;

-- Dumping data for table public.users_address: 0 rows
/*!40000 ALTER TABLE "users_address" DISABLE KEYS */;
INSERT INTO "users_address" ("id", "timestamp", "last_timestamp", "city", "state", "zip", "country", "user_id") VALUES
	(1, 1589655249, 1589655249, 'Tuscaloosa', 'AL', '35404', 'US', 1);
/*!40000 ALTER TABLE "users_address" ENABLE KEYS */;

-- Dumping data for table public.users_conversation: 0 rows
/*!40000 ALTER TABLE "users_conversation" DISABLE KEYS */;
/*!40000 ALTER TABLE "users_conversation" ENABLE KEYS */;

-- Dumping data for table public.users_conversation_users: 0 rows
/*!40000 ALTER TABLE "users_conversation_users" DISABLE KEYS */;
/*!40000 ALTER TABLE "users_conversation_users" ENABLE KEYS */;

-- Dumping data for table public.users_friendship: 0 rows
/*!40000 ALTER TABLE "users_friendship" DISABLE KEYS */;
INSERT INTO "users_friendship" ("id") VALUES
	(1),
	(2);
/*!40000 ALTER TABLE "users_friendship" ENABLE KEYS */;

-- Dumping data for table public.users_message: 0 rows
/*!40000 ALTER TABLE "users_message" DISABLE KEYS */;
/*!40000 ALTER TABLE "users_message" ENABLE KEYS */;

-- Dumping data for table public.users_notification: 0 rows
/*!40000 ALTER TABLE "users_notification" DISABLE KEYS */;
/*!40000 ALTER TABLE "users_notification" ENABLE KEYS */;

-- Dumping data for table public.users_profile: 0 rows
/*!40000 ALTER TABLE "users_profile" DISABLE KEYS */;
INSERT INTO "users_profile" ("id", "timestamp", "last_timestamp", "image", "first_name", "last_name", "his_age", "her_age", "bio", "interests", "kik", "account_type", "user_id") VALUES
	(1, 1589655249, 1589655249, 'Capture_mziQWt9.PNG', 'FnameUser1', 'LnameUser1', '18', '27', 'this is my bio', 'this is my interests text', 'KikUser1', 'sm', 1);
/*!40000 ALTER TABLE "users_profile" ENABLE KEYS */;

-- Dumping data for table public.users_review: 0 rows
/*!40000 ALTER TABLE "users_review" DISABLE KEYS */;
/*!40000 ALTER TABLE "users_review" ENABLE KEYS */;

-- Dumping data for table public.users_reviewcontent: 0 rows
/*!40000 ALTER TABLE "users_reviewcontent" DISABLE KEYS */;
/*!40000 ALTER TABLE "users_reviewcontent" ENABLE KEYS */;

-- Dumping data for table public.users_socket: 0 rows
/*!40000 ALTER TABLE "users_socket" DISABLE KEYS */;
/*!40000 ALTER TABLE "users_socket" ENABLE KEYS */;

-- Dumping data for table public.users_status: 0 rows
/*!40000 ALTER TABLE "users_status" DISABLE KEYS */;
INSERT INTO "users_status" ("id", "timestamp", "last_timestamp", "relationship", "friendship_id", "user_id") VALUES
	(1, 1341231, 3123123, 'friends', 1, 1),
	(2, 1312321, 13132123, 'friends', 1, 2);
/*!40000 ALTER TABLE "users_status" ENABLE KEYS */;

-- Dumping data for table public.users_user: 0 rows
/*!40000 ALTER TABLE "users_user" DISABLE KEYS */;
INSERT INTO "users_user" ("id", "password", "last_login", "is_superuser", "username", "first_name", "last_name", "email", "is_staff", "is_active", "date_joined", "is_verified") VALUES
	(1, 'pbkdf2_sha256$180000$hal3n1emIz4o$H8hgNgQu+BYB7WG4/r0STjT3miVpihUfKDJ6SO7D24E=', '2020-05-16 13:53:45.648556-05', 'false', 'user1', '', '', 'user1@aim.com', 'false', 'true', '2020-05-16 13:53:45.512559-05', 'true'),
	(2, 'pbkdf2_sha256$180000$hal3n1emIz4o$H8hgNgQu+BYB7WG4/r0STjT3miVpihUfKDJ6SO7D24E=', '2020-05-16 13:53:45.648556-05', 'false', 'user2', ' ', ' ', 'user2@aim.com', 'false', 'true', '2020-05-16 13:53:45.512559-05', 'true'),
	(3, 'pbkdf2_sha256$180000$hal3n1emIz4o$H8hgNgQu+BYB7WG4/r0STjT3miVpihUfKDJ6SO7D24E=', '2020-05-16 13:53:45.648556-05', 'false', 'user3', ' ', ' ', 'user3@aim.com', 'false', 'true', '2020-05-16 13:53:45.512559-05', 'true'),
	(4, 'pbkdf2_sha256$180000$hal3n1emIz4o$H8hgNgQu+BYB7WG4/r0STjT3miVpihUfKDJ6SO7D24E=', '2020-05-16 13:53:45.648556-05', 'false', 'user4', ' ', ' ', 'user4@aim.com', 'false', 'true', '2020-05-16 13:53:45.512559-05', 'true'),
	(5, 'pbkdf2_sha256$180000$hal3n1emIz4o$H8hgNgQu+BYB7WG4/r0STjT3miVpihUfKDJ6SO7D24E=', '2020-05-16 13:53:45.648556-05', 'false', 'user5', '  ', ' ', 'user5@aim.com', 'false', 'true', '2020-05-16 13:53:45.512559-05', 'true'),
	(6, 'pbkdf2_sha256$180000$hal3n1emIz4o$H8hgNgQu+BYB7WG4/r0STjT3miVpihUfKDJ6SO7D24E=', '2020-05-16 13:53:45.648556-05', 'false', 'user6', ' ', ' ', 'user6@aim.com', 'false', 'true', '2020-05-16 13:53:45.512559-05', 'true');
/*!40000 ALTER TABLE "users_user" ENABLE KEYS */;

-- Dumping data for table public.users_user_groups: 0 rows
/*!40000 ALTER TABLE "users_user_groups" DISABLE KEYS */;
/*!40000 ALTER TABLE "users_user_groups" ENABLE KEYS */;

-- Dumping data for table public.users_user_user_permissions: 0 rows
/*!40000 ALTER TABLE "users_user_user_permissions" DISABLE KEYS */;
/*!40000 ALTER TABLE "users_user_user_permissions" ENABLE KEYS */;

-- Dumping data for table public.users_verification: 0 rows
/*!40000 ALTER TABLE "users_verification" DISABLE KEYS */;
INSERT INTO "users_verification" ("id", "timestamp", "last_timestamp", "status", "verification_image", "user_id") VALUES
	(1, 1589655249, 1589655249, '', 'Capture_vMEVrRA.PNG', 1),
	(2, 1589655249, 1589655249, ' ', 'Capture_vMEVrRA.PNG', 2),
	(3, 1589655249, 1589655249, ' ', 'Capture_vMEVrRA.PNG', 3),
	(4, 1589655249, 1589655249, ' ', 'Capture_vMEVrRA.PNG', 4),
	(5, 1589655249, 1589655249, ' ', 'Capture_vMEVrRA.PNG', 5),
	(6, 1589655249, 1589655249, ' ', 'Capture_vMEVrRA.PNG', 6);
/*!40000 ALTER TABLE "users_verification" ENABLE KEYS */;

-- Dumping data for table public.verification_code: 0 rows
/*!40000 ALTER TABLE "verification_code" DISABLE KEYS */;
INSERT INTO "verification_code" ("id", "code", "created_at", "valid_until", "phone", "phone_verified", "user_id_id") VALUES
	(1, '61722', 1589655432, 1589659032, '111-222-333', 'true', 1),
	(2, '61722', 1589655432, 1589659032, '111-222-333', 'true', 2),
	(3, '61722', 1589655432, 1589659032, '111-222-333', 'true', 3),
	(4, '61722', 1589655432, 1589659032, '111-222-333', 'true', 4),
	(5, '61722', 1589655432, 1589659032, '111-222-333', 'true', 5),
	(6, '61722', 1589655432, 1589659032, '111-222-333', 'true', 6);
/*!40000 ALTER TABLE "verification_code" ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
