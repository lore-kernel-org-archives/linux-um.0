Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <4009A583.7070007@lig.net>
From: "Stephen D. Williams" <sdw@lig.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030206040508010004010806"
Subject: [uml-devel] Dynamic remount with variable COW stacking/merging needed,
	support for snapshot repilication
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 17 Jan 2004 16:13:39 -0500
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------030206040508010004010806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When a UML instance is running a always-on service, such as a web 
server, an administrator needs to be able to make live backups, or 
replications, of a running system.

This can be done using LVM snapshots, although that is not always 
appropriate for just this feature. A UML instance can be paused and then 
restarted, but this can cause severe delays while large partitions are 
replicated.

The COW ability is a great basis for an ideal solution, but I believe we 
need to identify and implement some additional features.

What I propose as a useful solution is:

A UML instance mounts filesystems directly or based on a COW image.
When an administrator invokes a console snapshot mode, the UML instance 
causes a quick freeze, new delta COWs to be created and stacked on 
existing mounts, then resumes.
When the administrator completes whatever snapshot backup is needed, 
they invoke a console unsnapshot command which pauses the instance, 
merges the delta COWs, remounts the original images with updates, and 
resumes.

This relies on COW stacking, which I saw was added in a patch last year 
and I assume is still present.
The downtime for the instance would be measured in seconds generally.

Can this be done now?  What needs to be added to support it?

sdw

-- 
swilliams@hpti.com http://www.hpti.com Personal: sdw@lig.net http://sdw.st
Stephen D. Williams 703-724-0118W 703-995-0407Fax 20147-4622 AIM: sdw



--------------030206040508010004010806
Content-Type: text/x-vcard; charset=utf8;
 name="sdw.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sdw.vcf"

begin:vcard
fn:Stephen Williams
n:Williams;Stephen
email;internet:sdw@lig.net
tel;work:703-724-0118
tel;fax:703-995-0407
tel;pager:sdwpage@lig.net
tel;home:703-729-5405
tel;cell:703-371-9362
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------030206040508010004010806--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
