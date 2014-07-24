#
# TestRail API binding for Python (API v2, available since TestRail 3.0)
#
# Learn more:
#
# http://docs.gurock.com/testrail-api2/start
# http://docs.gurock.com/testrail-api2/accessing
#
#
package TestRail;
use strict;

use JSON;
use LWP::UserAgent;
use HTTP::Request;
use JSON;
use MIME::Base64;

	sub new {
		my $class = shift;
		my $self  = {  };         # allocate new hash for object
		bless($self, $class);
		return $self;
	}

	 #
	 #Get/Set url
	 #
	 #Returns/sets the user used for authenticating the API requests.
	 #
	sub get_url {	
		my $self      = shift;
		return $self->{url};
	}

	sub set_url
	{
		my $self      = shift;
		my $base_url = shift;
		$base_url .= '/' if $base_url !~ /\/$/;
		$self->{url} = $base_url . 'index.php?/api/v2/';
	}
	
	 #
	 #Get/Set User
	 #
	 #Returns/sets the user used for authenticating the API requests.
	 #
	sub get_user {	
		my $self      = shift;
		return $self->{user};
	}

	sub set_user
	{
		my $self      = shift;
		$self->{user} = shift;

	}

	 #
	 # Get/Set Password
	 #
	 # Returns/sets the password used for authenticating the API requests.
	 #
	sub get_password
	{
		my $self = shift;
		return $self->{password};

	}

	sub set_password
	{
		my $self      = shift;
		$self->{password} = shift;
	}
		
		#
		# Send Get
		#
		# Issues a GET request (read) against the API and returns the result
		# (as Ruby hash).
		#
		# Arguments:
		#
		# uri                 The API method to call including parameters
		#                     (e.g. get_case/1)
		#
		
		sub send_get {
			my ($self, $uri) = @_;
			return send_request($self, 'GET', $uri);
		}
		
		#
		# Send POST
		#
		# Issues a POST request (write) against the API and returns the result
		# (as Ruby hash).
		#
		# Arguments:
		#
		# uri                 The API method to call including parameters
		#                     (e.g. add_case/1)
		# data                The data to submit as part of the request (as
		#                     Ruby hash, strings must be UTF-8 encoded)
		#
		sub send_post {
			my ($self, $uri, $data) = @_;
			return send_request($self, 'POST', $uri, $data);
		}
		
		sub send_request {
			my ($self, $method, $uri, $data) = @_;			
			my $request = HTTP::Request->new( $method, $self->{url} . $uri );
			$request->header("Content-Type"=>"application/json");
			my $encoded = encode_base64("$self->{user}:$self->{password}");
			$request->header("Authorization"=>"Basic $encoded");
			if($method eq 'POST') {
				$request->content(encode_json($data));
			}
			my $ua = LWP::UserAgent->new;
			my $response = $ua->request($request);
			if ($response->is_success) {
				my $result = decode_json($response->decoded_content);			
				return $result;
			}
			else {
				print STDERR $response->status_line, "\n";
				return undef;
			}
	
		}
		
		1;