Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C0kNX-0001Nk-4u for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Aug 2004 10:19:07 -0700
Received: from web12504.mail.yahoo.com ([216.136.173.196])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C0kNW-0002gI-PI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Aug 2004 10:19:07 -0700
Message-ID: <20040827171904.42460.qmail@web12504.mail.yahoo.com>
From: Sam T Sander <ssander@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-226190498-1093627144=:41765"
Subject: [uml-devel] fixing ptrace for ARM
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
Date: Fri, 27 Aug 2004 10:19:04 -0700 (PDT)
To: user-mode-linux-devel@lists.sourceforge.net

--0-226190498-1093627144=:41765
Content-Type: text/plain; charset=us-ascii

As a first step toward porting UML to ARM, I need to fix ptrace to modify system call numbers.  Unfortunately, I don't know where to start.  Can anyone point me in the right direction? Has anyone looked into this for ARM or any of the other ports?  What was changed in the X86 ptrace to fix it?
 
Thanks,
Sam
 
 

		
---------------------------------
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
--0-226190498-1093627144=:41765
Content-Type: text/html; charset=us-ascii

<DIV>As a first step toward porting UML to ARM, I need to fix ptrace to modify system call numbers.&nbsp; Unfortunately, I don't know where to start.&nbsp; Can anyone point me in the right direction? Has anyone looked into this for ARM or any of the other ports?&nbsp; What was changed in the X86 ptrace to fix it?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks,</DIV>
<DIV>Sam</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV><p>
		<hr size=1>Do you Yahoo!?<br>
<a href="http://us.rd.yahoo.com/mail_us/taglines/10/*http://promotions.yahoo.com/new_mail/static/efficiency.html">New and Improved Yahoo! Mail</a> - Send 10MB messages!
--0-226190498-1093627144=:41765--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
