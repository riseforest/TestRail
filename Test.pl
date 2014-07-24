#
# TestRail API binding for Python (API v2, available since TestRail 3.0)
#
# Learn more:
#
# http://docs.gurock.com/testrail-api2/start
# http://docs.gurock.com/testrail-api2/accessing
#
#
use strict;
use lib 'E:\\';
use TestRail;
#my $url = 'https://mcbu-jira.wyse.com/testrail/';
#my $user = 'sewang';
#my $password = 'password2@';

#initialize($url);
#my $js = send_get('get_tests/6545');
#my $js->{'title'} = "helloword!";
#my $res = send_post('get_run/5409', $js);

		my $obj = TestRail->new( );
		$obj->set_url('https://mcbu-jira.wyse.com/testrail/');
		$obj->set_password('password2@');
		$obj->set_user('sewang');
		my $js = $obj->send_get('get_tests/6545');
		print $js;