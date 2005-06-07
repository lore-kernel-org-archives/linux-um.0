Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfSPw-00009g-Tr	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 17:58:08 -0700
Received: from smtp.gentoo.org ([134.68.220.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DfSPt-0005yR-II
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 17:58:07 -0700
Received: from nuthatch.gentoo.osuosl.org ([140.211.166.163]
	helo=nuthatch.gentoo.org)	by smtp.gentoo.org with esmtp (Exim 4.43)
	id 1DfSPn-0000zx-9b	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 00:57:59 +0000
Received: from apache by nuthatch.gentoo.org with local (Exim 4.43)
	id 1DfSPm-0008Vv-Va	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Jun 2005 00:57:58 +0000
From: bugzilla-daemon@gentoo.org
In-Reply-To: <bug-49277@bugs.gentoo.org>
Message-Id: <E1DfSPm-0008Vv-Va@nuthatch.gentoo.org>
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
Date: Tue, 07 Jun 2005 00:57:58 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Clear-Text: http://bugs.gentoo.org/show_bug.cgi?id=49277
Secure: https://bugs.gentoo.org/show_bug.cgi?id=49277





------- Additional Comments From blaisorblade_spam@yahoo.it  2005-06-06 17:57 PDT -------
Ok, I hope there is still somebody using UML on a NPTL-only system. The 
workaround suggested last time was to avoid enabling CONFIG_MODE_TT; now I 
think I've got over this problem, too. So, when I release 2.6.11.8-bs6 (which 
will happen very shortly, I hope), I'd like to get some testing from you about 
this issue. 
 
Thanks a lot. 

-- 
Configure bugmail: http://bugs.gentoo.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
