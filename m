Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahgs0-00071u-6g for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 19:11:32 -0800
Received: from 66-95-121-230.client.dsl.net ([66.95.121.230] helo=mail.lig.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahgrz-0001AD-SH for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2004 19:11:32 -0800
Message-ID: <4008A7DF.6000308@lig.net>
From: "Stephen D. Williams" <sdw@lig.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090905030008070606020502"
Subject: [uml-devel] What is the most up to date, least crashing kernel+patch?
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
Date: Fri, 16 Jan 2004 22:11:27 -0500
To: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------090905030008070606020502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I would like 2.6.1 as a UML kernel along with support for >512 UML ram 
and preferrably modules.  What is the best I can get right now?

I'm running Gerd/SuSE's 2.6.0-test9, but I'm having severe problems with 
periodic crashes.  These appear to be preceded by a 'do_io' error on 
/dev/hdb, but I've bumped all ulimits to large levels, including max 
files (100000).  (There seems to be conflicting notes about whether I 
need a modified glibc or headers updated and the host kernel 
recompiled.)  The system runs well for a while and then just disappears.

I've had trouble compiling with some of the recent 2.6.0/2.6.1 patches 
and I need clarification.

I have noticed that paging an executable (like Python) in takes much 
more time that it would natively and that large amounts of disk I/O is 
slow.  Where is the bottleneck for this and what can be done about it?  
(I realized that the virtual layering is going to cost some.)

Thanks
sdw

-- 
swilliams@hpti.com http://www.hpti.com Personal: sdw@lig.net http://sdw.st
Stephen D. Williams 703-724-0118W 703-995-0407Fax 20147-4622 AIM: sdw



--------------090905030008070606020502
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


--------------090905030008070606020502--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
