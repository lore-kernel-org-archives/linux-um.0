Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <400A30CC.20308@lig.net>
From: "Stephen D. Williams" <sdw@lig.net>
MIME-Version: 1.0
References: <4009A583.7070007@lig.net>
	<20040118044551.GB8571@ccure.user-mode-linux.org>
In-Reply-To: <20040118044551.GB8571@ccure.user-mode-linux.org>
Content-Type: multipart/mixed; boundary="------------070900000500000508020803"
Subject: [uml-devel] Re: [uml-user] Dynamic remount with variable COW
	stacking/merging needed, support for snapshot repilication
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
Date: Sun, 18 Jan 2004 02:07:56 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------070900000500000508020803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Yes, but that doesn't meet the key requirement I am proposing: that the 
downtime be limited to a few seconds.  The only potential significant 
downtime with what I am proposing is merging COWs if there was a lot of 
disk I/O during the 'snapshot mode'.  The existing ability is certainly 
useful, but not sufficient to get backups with the least impact to a 
running system.  Snapshot mode is suspend and flush/sync with the 
additional semantics of an automatic temporary push/pop of a COW layer 
on all filesystem images.  The remaining issue of merging COW's could be 
handled by RAID-recovery like gradual merging.

The problem is that if you have gigabytes of filesystem images, it takes 
time to copy them, even if using something like rsync to determine what 
has changed.  It also costs, unless there is a program that determines 
which blocks are actually utilized without reads, to scan zero holes in 
sparse files.

I should have also mentioned that it should be possible to get a 
reliable feed of what blocks, or ranges more likely have changed since a 
certain event.  This would allow very efficient, near-realtime 
replication.  At the very least this could be used in suspend or 
'snapshot mode' for efficiency, but with proper push of blocks, buffer 
visibility, or some kind of write-through notification, synchronization 
could be realtime.

sdw

Jeff Dike wrote:

>On Sat, Jan 17, 2004 at 04:13:39PM -0500, Stephen D. Williams wrote:
>  
>
>>When a UML instance is running a always-on service, such as a web 
>>server, an administrator needs to be able to make live backups, or 
>>replications, of a running system.
>>
>>Can this be done now?  What needs to be added to support it?
>>    
>>
>
>Have you seen the stop, sysrq s, cp, go trick described at 
>http://user-mode-linux.sourceforge.net/mconsole.html ?
>
>				Jeff
>  
>


-- 
swilliams@hpti.com http://www.hpti.com Personal: sdw@lig.net http://sdw.st
Stephen D. Williams 703-724-0118W 703-995-0407Fax 20147-4622 AIM: sdw


--------------070900000500000508020803
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


--------------070900000500000508020803--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
