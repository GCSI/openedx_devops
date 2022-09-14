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

DELETE FROM codlp_staging_edx.schedules_scheduleexperience
WHERE	(id IN 	(
				select id from (
								SELECT se.id
								FROM codlp_staging_edx.schedules_schedule s
									JOIN codlp_staging_edx.schedules_scheduleexperience se on (s.id = se.schedule_id)
									JOIN codlp_staging_edx.student_courseenrollment c ON (s.enrollment_id = c.id)
									JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id)
								WHERE	(u.username = @username)
                                ) as d
                )
		);

DELETE FROM codlp_staging_edx.schedules_schedule
WHERE	(id IN 	(
				select id from (
								SELECT s.id
								FROM codlp_staging_edx.schedules_schedule s
									JOIN codlp_staging_edx.student_courseenrollment c ON (s.enrollment_id = c.id)
									JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id)
								WHERE	(u.username = @username)
                                ) as d
                )
		);

DELETE FROM codlp_staging_edx.student_manualenrollmentaudit
WHERE	(id IN 	(
				select id from (
								SELECT s.id
								FROM codlp_staging_edx.student_manualenrollmentaudit s
									JOIN codlp_staging_edx.student_courseenrollment c ON (s.enrollment_id = c.id)
									JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id)
								WHERE	(u.username = @username)
                                ) as d
                )
		);


DELETE FROM codlp_staging_edx.user_api_usercoursetag
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.user_api_usercoursetag c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);


DELETE FROM codlp_staging_edx.courseware_studentmodule
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.courseware_studentmodule c JOIN codlp_staging_edx.auth_user u ON (u.id = c.student_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM codlp_staging_edx.student_manualenrollmentaudit
WHERE	(id IN 	(
				select id from (
								SELECT s.id FROM codlp_staging_edx.student_manualenrollmentaudit s JOIN codlp_staging_edx.auth_user u ON (u.id = s.enrolled_by_id) WHERE (u.username = @username)
                                ) as d
                )
		);


DELETE FROM codlp_staging_edx.student_courseenrollment
WHERE	(id IN 	(
				select id from (
								SELECT s.id FROM codlp_staging_edx.student_courseenrollment s JOIN codlp_staging_edx.auth_user u ON (u.id = s.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);



DELETE FROM	codlp_staging_edx.auth_registration
WHERE	(id IN 	(
				select id from (
								SELECT r.id FROM codlp_staging_edx.auth_registration r JOIN codlp_staging_edx.auth_user u ON (u.id = r.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.auth_userprofile
WHERE	(id IN 	(
				select id from (
								SELECT p.id FROM codlp_staging_edx.auth_userprofile p JOIN codlp_staging_edx.auth_user u ON (u.id = p.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.completion_blockcompletion
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.completion_blockcompletion c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.course_groups_cohortmembership
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.course_groups_cohortmembership c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.course_groups_courseusergroup_users
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.course_groups_courseusergroup_users c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.django_comment_client_role_users
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.django_comment_client_role_users c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.experiments_experimentdata
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.experiments_experimentdata c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.oauth2_provider_refreshtoken
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.oauth2_provider_refreshtoken c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);


DELETE FROM	codlp_staging_edx.oauth2_provider_accesstoken
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.oauth2_provider_accesstoken c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.schedules_historicalschedule
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.schedules_historicalschedule c JOIN codlp_staging_edx.auth_user u ON (u.id = c.history_user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.social_auth_usersocialauth
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.social_auth_usersocialauth c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.student_anonymoususerid
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.student_anonymoususerid c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.student_courseenrollment_history
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.student_courseenrollment_history c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.student_courseenrollment_history
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.student_courseenrollment_history c JOIN codlp_staging_edx.auth_user u ON (u.id = c.history_user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.student_userattribute
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.student_userattribute c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.user_api_userpreference
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.user_api_userpreference c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.verify_student_ssoverification
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.verify_student_ssoverification c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.course_creators_coursecreator
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.course_creators_coursecreator c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.course_overviews_historicalcourseoverview
WHERE	(history_user_id IN 	(
				select history_user_id from (
								SELECT c.history_user_id FROM codlp_staging_edx.course_overviews_historicalcourseoverview c JOIN codlp_staging_edx.auth_user u ON (u.id = c.history_user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.gcsi_cms_coursechangelog
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.gcsi_cms_coursechangelog c JOIN codlp_staging_edx.auth_user u ON (u.id = c.published_by_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.gcsi_cms_coursechangelog
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.gcsi_cms_coursechangelog c JOIN codlp_staging_edx.auth_user u ON (u.id = c.edited_by_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.student_courseaccessrole
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.student_courseaccessrole c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = @username)
                                ) as d
                )
		);

DELETE FROM	codlp_staging_edx.user_tours_usertour
WHERE	(id IN 	(
				select id from (
								SELECT c.id FROM codlp_staging_edx.user_tours_usertour c JOIN codlp_staging_edx.auth_user u ON (u.id = c.user_id) WHERE (u.username = 'Tauriq')
                                ) as d
                )
		);
 

DELETE FROM	codlp_staging_edx.auth_user WHERE (username = @username);
