Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez0Zw-00060j-K5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 15:49:32 -0800
Received: from smtp.gentoo.org ([134.68.220.30])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez0Zv-0005qY-EU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 15:49:32 -0800
Received: from nuthatch.gentoo.osuosl.org ([140.211.166.163]
	helo=nuthatch.gentoo.org) by smtp.gentoo.org with esmtp (Exim 4.54)
	id 1Ez0Zp-00001e-FX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 23:49:25 +0000
Received: from apache by nuthatch.gentoo.org with local (Exim 4.54)
	id 1Ez0Zp-0000X6-72 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 23:49:25 +0000
In-Reply-To: <bug-111575-25805@http.bugs.gentoo.org/>
From: bugzilla-daemon@gentoo.org
Message-Id: <E1Ez0Zp-0000X6-72@nuthatch.gentoo.org>
Subject: [uml-devel] [Bug 111575] sys-kernel/usermode-sources-2.6.14: kernel
	panic
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
Date: Tue, 17 Jan 2006 23:49:25 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Clear-Text: http://bugs.gentoo.org/show_bug.cgi?id=111575
Secure: https://bugs.gentoo.org/show_bug.cgi?id=111575


blaisorblade_spam@yahoo.it changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |user-mode-linux-
                   |                            |devel@lists.sourceforge.net




------- Comment #14 from blaisorblade_spam@yahoo.it  2006-01-17 15:49 PST -------
The only setting in the .config which is untested is:

CONFIG_MPENTIUMM=y

give a try to CONFIG_M386. Also, test disabling CONFIG_MODE_TT to see if it
helps.

Additionally, since the problem is with mem=256M, I would check the first entry
in this FAQ. The error message is different, but that could be due to internal
changes in UML, but I would still check that.

http://uml.harlowhill.com/index.php/Troubleshooting#probsrunning

Somebody: please append "when assigning more than 256M" to the subject.


-- 
Configure bugmail: http://bugs.gentoo.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
