Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6VPL-0002b5-D4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 07:05:03 -0800
Received: from smtp.gentoo.org ([134.68.220.30])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D6VPJ-0008Di-DK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 07:05:03 -0800
Received: from nuthatch.gentoo.osuosl.org ([140.211.166.163]
	helo=nuthatch.gentoo.org) by smtp.gentoo.org with esmtp (Exim 4.42)
	id 1D6VPB-0006SS-SW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 15:04:53 +0000
Received: from apache by nuthatch.gentoo.org with local (Exim 4.43)
	id 1D6VPC-00069N-E2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 15:04:54 +0000
From: bugzilla-daemon@gentoo.org
Message-Id: <E1D6VPC-00069N-E2@nuthatch.gentoo.org>
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
Date: Wed, 02 Mar 2005 15:04:54 +0000
To: user-mode-linux-devel@lists.sourceforge.net

http://bugs.gentoo.org/show_bug.cgi?id=49277





------- Additional Comments From blaisorblade_spam@yahoo.it  2005-03-02 07:04 PST -------
I hope that, but I'm not sure... actually, both 2.6.9 and 2.6.10 were not Good Enough releases.

Well, not that bad (2.6.9 works like a charm on a host < 2.6.9, in most cases); but I feel that in some cases we (UML developers) will still have to do some post-releases little fixes. I've done a lot of them for 2.6.9, I hadn't the time for 2.6.10.

http://www.user-mode-linux.org/~blaisorblade is the site to download them from. If you can include -bs7 inside portage (and add the security updates you want to add) I'd be grateful.



------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
