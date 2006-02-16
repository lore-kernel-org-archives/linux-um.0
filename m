Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F9lzD-0003BR-VX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Feb 2006 08:28:07 -0800
Received: from smtp.gentoo.org ([134.68.220.30])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F9lzB-00037y-J1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Feb 2006 08:28:08 -0800
Received: from nuthatch.gentoo.osuosl.org ([140.211.166.163]
	helo=nuthatch.gentoo.org) by smtp.gentoo.org with esmtp (Exim 4.54)
	id 1F9lz5-0004jy-Ec for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Feb 2006 16:27:59 +0000
Received: from apache by nuthatch.gentoo.org with local (Exim 4.54)
	id 1F9lz5-000769-7G for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Feb 2006 16:27:59 +0000
In-Reply-To: <bug-111575-25805@http.bugs.gentoo.org/>
From: bugzilla-daemon@gentoo.org
Message-Id: <E1F9lz5-000769-7G@nuthatch.gentoo.org>
Subject: [uml-devel] [Bug 111575] sys-kernel/usermode-sources-2.6.14: kernel
	panic when assigning more than 256M
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
Date: Thu, 16 Feb 2006 16:27:59 +0000
To: user-mode-linux-devel@lists.sourceforge.net


Clear-Text: http://bugs.gentoo.org/show_bug.cgi?id=111575
Secure: https://bugs.gentoo.org/show_bug.cgi?id=111575





------- Comment #23 from blaisorblade_spam@yahoo.it  2006-02-16 08:27 PST -------
> The kernel menuconfig help says: "Normally, this should be set to Y"
Yep, good note; however likely this has already been fixed.


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
