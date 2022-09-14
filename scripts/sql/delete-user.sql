/*---------------------------------------------------------------------------
 * written by:		lawrence mcdaniel
 *					https://lawrencemcdaniel.com
 *
 * date:			june-2022
 *
 * usage:			delete a user
 *---------------------------------------------------------------------------*/
SET @username = 'mcdaniel';
use codlp_staging_edx;

DELETE FROM schedules_scheduleexperience
WHERE	(id IN 	(
				select id from (
								SELECT se.id
								FROM schedules_schedule s
									JOIN schedules_scheduleexperience se on (s.id = se.schedule_id)
									JOIN student_courseenrollment c ON (s.enrollment_id = c.id)
									JOIN auth_user u ON (u.id = c.user_id)
								WHERE	(u.username = @username)
                                ) as d
                )
		);

DELETE FROM schedules_schedule
WHERE	(id IN 	(
				select id from (
								SELECT s.id
								FROM schedules_schedule s
									JOIN student_courseenrollment c ON (s.enrollment_id = c.id)
									JOIN auth_user u ON (u.id = c.user_id)
								WHERE	(u.username = @username)
                                ) as d
                )
		);

DELETE FROM student_manualenrollmentaudit
WHERE	(id IN 	(
				select id from (
								SELECT s.id
								FROM student_manualenrollmentaudit s
									JOIN student_courseenrollment c ON (s.enrollment_id = c.id)
									JOIN auth_user u ON (u.id = c.user_id)
								WHERE	(u.username = @username)
                                ) as d
                )
		);


DELETE FROM user_api_usercoursetag
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM user_api_usercoursetag c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);


DELETE FROM courseware_studentmodule
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM courseware_studentmodule c JOIN auth_user u ON (u.id = c.student_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM student_manualenrollmentaudit
WHERE	(id IN 	(
				select id from (
								SELECT s.id FROM student_manualenrollmentaudit s JOIN auth_user u ON (u.id = s.enrolled_by_id) WHERE (u.username = @username)
                                ) as d
                )
		);


DELETE FROM student_courseenrollment
WHERE	(id IN 	(
				select id from (
								SELECT s.id FROM student_courseenrollment s JOIN auth_user u ON (u.id = s.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);



DELETE FROM	auth_registration
WHERE	(id IN 	(
				select id from (
								SELECT r.id FROM auth_registration r JOIN auth_user u ON (u.id = r.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	auth_userprofile
WHERE	(id IN 	(
				select id from (
								SELECT p.id FROM auth_userprofile p JOIN auth_user u ON (u.id = p.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	completion_blockcompletion
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM completion_blockcompletion c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	course_groups_cohortmembership
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM course_groups_cohortmembership c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	course_groups_courseusergroup_users
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM course_groups_courseusergroup_users c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	django_comment_client_role_users
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM django_comment_client_role_users c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	experiments_experimentdata
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM experiments_experimentdata c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	oauth2_provider_refreshtoken
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM oauth2_provider_refreshtoken c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);


DELETE FROM	oauth2_provider_accesstoken
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM oauth2_provider_accesstoken c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	schedules_historicalschedule
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM schedules_historicalschedule c JOIN auth_user u ON (u.id = c.history_user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	social_auth_usersocialauth
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM social_auth_usersocialauth c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	student_anonymoususerid
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM student_anonymoususerid c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	student_courseenrollment_history
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM student_courseenrollment_history c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	student_courseenrollment_history
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM student_courseenrollment_history c JOIN auth_user u ON (u.id = c.history_user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	student_userattribute
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM student_userattribute c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	user_api_userpreference
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM user_api_userpreference c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	verify_student_ssoverification
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM verify_student_ssoverification c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	course_creators_coursecreator
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM course_creators_coursecreator c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	course_overviews_historicalcourseoverview
WHERE	(history_user_id IN 	(
				select history_user_id from (
								SELECT c.history_user_id FROM course_overviews_historicalcourseoverview c JOIN auth_user u ON (u.id = c.history_user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	gcsi_cms_coursechangelog
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM gcsi_cms_coursechangelog c JOIN auth_user u ON (u.id = c.published_by_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	gcsi_cms_coursechangelog
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM gcsi_cms_coursechangelog c JOIN auth_user u ON (u.id = c.edited_by_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	student_courseaccessrole
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM student_courseaccessrole c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	user_tours_usertour
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM user_tours_usertour c JOIN auth_user u ON (u.id = c.user_id) WHERE (u.username = 'Tauriq')
                                ) as d
                )
		);
 

DELETE FROM	auth_user WHERE (username = @username);
