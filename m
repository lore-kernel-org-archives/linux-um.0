Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsOKH-0003rZ-6H	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 10:13:45 -0700
Received: from smtp.gentoo.org ([134.68.220.30])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DsOKF-00052G-Ri	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 10:13:45 -0700
Received: from nuthatch.gentoo.osuosl.org ([140.211.166.163]
	helo=nuthatch.gentoo.org)	by smtp.gentoo.org with esmtp (Exim 4.43)
	id 1DsOK6-00013M-Dw	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 17:13:34 +0000
Received: from apache by nuthatch.gentoo.org with local (Exim 4.43)
	id 1DsOK5-0001pU-N7	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 17:13:33 +0000
From: bugzilla-daemon@gentoo.org
In-Reply-To: <bug-49277@bugs.gentoo.org>
Message-Id: <E1DsOK5-0001pU-N7@nuthatch.gentoo.org>
Subject: [uml-devel] [Bug 49277] Compile of usermode-sources-2.6.x fails
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
Date: Tue, 12 Jul 2005 17:13:33 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Clear-Text: http://bugs.gentoo.org/show_bug.cgi?id=49277
Secure: https://bugs.gentoo.org/show_bug.cgi?id=49277





------- Additional Comments From blaisorblade_spam@yahoo.it  2005-07-12 10:13 PDT -------
Ok, a couple of notes: 
1) You'll probably like to upgrade your SKAS patch to V8.2 or V9-pre7, since  
they fix an important bug which could affect apps other than UML (difficult to  
trigger since you use NPTL, anyway).  
  
2) With the latest patch for UML on my site, 2.6.12-bs5, you should be able to 
enable TT mode and still get a successful compile, it was tested on FC4. That 
tree will be probably added in portage (see bug #98785). 
 
3) I think that even in past releases UML compiled for NPTL-only systems, if 
enabling SKAS and disabling TT. 

-- 
Configure bugmail: http://bugs.gentoo.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
