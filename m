Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dq6ed-0002eO-Ii	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jul 2005 02:57:19 -0700
Received: from smtp.gentoo.org ([134.68.220.30])
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1Dq6ec-00086a-HY	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jul 2005 02:57:19 -0700
Received: from nuthatch.gentoo.osuosl.org ([140.211.166.163]
	helo=nuthatch.gentoo.org)	by smtp.gentoo.org with esmtp (Exim 4.43)
	id 1Dq6eV-000589-Tr	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jul 2005 09:57:11 +0000
Received: from apache by nuthatch.gentoo.org with local (Exim 4.43)
	id 1Dq6eV-0000Bp-Fl	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jul 2005 09:57:11 +0000
From: bugzilla-daemon@gentoo.org
In-Reply-To: <bug-49277@bugs.gentoo.org>
Message-Id: <E1Dq6eV-0000Bp-Fl@nuthatch.gentoo.org>
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
Date: Wed, 06 Jul 2005 09:57:11 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Clear-Text: http://bugs.gentoo.org/show_bug.cgi?id=49277
Secure: https://bugs.gentoo.org/show_bug.cgi?id=49277





------- Additional Comments From dsd@gentoo.org  2005-07-06 02:57 PDT -------
usermode-sources-2.6.12 is in portage. Please test it (see comment #51) as it
should solve the NPTL issues.

-- 
Configure bugmail: http://bugs.gentoo.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
