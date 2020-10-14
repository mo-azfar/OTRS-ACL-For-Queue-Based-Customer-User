# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::System::Ticket::Acl::QueueBasedCustomerUser;

use strict;
use warnings;
use Data::Dumper;

our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::System::Ticket',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(Config Acl)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $_!"
            );
            return;
        }
    }
	
	#$Param{Checks}->{CustomerUser}->{DynamicField_PredefinedQueue}
	
	my $CustomerUserID = $Param{CustomerUserID};
	my $SelectedQueue = $Param{Config}->{SelectedQueueDynamicFieldName};	
	
	return 1 if !defined $Param{Checks}->{CustomerUser}->{'DynamicField_'.$SelectedQueue};
			
	#For generating acl unique name
    my $random = int rand(888);
    my $ACLName = 'ACL_QBCU_'.$CustomerUserID.'_'.$random;
	
	$Param{Acl}->{$ACLName} = {

        # match properties
        Properties => {

            # current ticket match properties
            Frontend => {
                Action => [ 'AgentTicketPhone', 'AgentTicketEmail' ],
            },
			
			CustomerUser => {
                UserLogin => [ $CustomerUserID ],
            },

        },

        # return possible options (white list)
        Possible => {

            # possible ticket options (white list)
            Ticket => {
                Queue => $Param{Checks}->{CustomerUser}->{'DynamicField_'.$SelectedQueue},
            },
        },
    };
			
    return 1;
}

1;
