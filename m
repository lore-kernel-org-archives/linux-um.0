Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CyzqY-0006Sf-LF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Feb 2005 13:58:06 -0800
Received: from smtp.gentoo.org ([156.56.111.197])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CyzqV-0006M1-3A
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Feb 2005 13:58:06 -0800
Received: from nuthatch.gentoo.osuosl.org ([140.211.166.163]
	helo=nuthatch.gentoo.org) by smtp.gentoo.org with esmtp (Exim 4.42)
	id 1CyzqT-0004tX-VG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Feb 2005 21:58:02 +0000
Received: from apache by nuthatch.gentoo.org with local (Exim 4.42)
	id 1CyzqT-00064s-Mn for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Feb 2005 21:58:01 +0000
From: bugzilla-daemon@gentoo.org
Message-Id: <E1CyzqT-00064s-Mn@nuthatch.gentoo.org>
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
Date: Wed, 09 Feb 2005 21:58:01 +0000
To: user-mode-linux-devel@lists.sourceforge.net

http://bugs.gentoo.org/show_bug.cgi?id=49277





------- Additional Comments From blaisorblade_spam@yahoo.it  2005-02-09 13:58 PST -------
Yes, upgrading would partially help. Alternatively, using a non-NPTL glibc is a workaround (but things get slower); using the latest, ~x86 glibc, built without the nptlonly flag, makes sure that UML is linked against a non-NPTL glibc, so this is also a workaround.

In short, see my previous message, and note that the previous official source (Jeff Dike) for the portage releases has stopped doing releases, since main work happens onto vanilla kernels (UML has been merged into vanilla Linux, finally). He now only maintains a development tree (http://user-mode-linux.sourceforge.net/patches.html, if you want, but it's for development).

Both the 2.6.9-bs6 patchset (which I maintain and is very stable, see at http://www.user-mode-linux.org/~blaisorblade/) and the vanilla 2.6.10 Linux kernel (with a bit of other problems, which are fixed in the upcoming vanilla 2.6.11) have the (partial) fix included: they work if you compile a SKAS-only UML (enable CONFIG_SKAS and disable CONFIG_TT).

Everything fails to compile if you have a NPTL glibc in /lib (necessary condition to experience the bug) and UML is statically linked, i.e. you enable also TT mode or explicitly request static linking (which is implied by TT mode).

For this configuration, no workaround exists at the moment, nor I know anyone who knows enough about linking scripts and glibc details to fix it.
And note that enabling TT mode is required to run UML onto a vanilla Linux kernel as host system; with the SKAS patch on the host it is possible to run a UML built with only SKAS mode enabled and TT mode disabled.

* Why wasn't the portage tree not updated (I guess):
The reason is that while previously UML was a separate patch to apply to a vanilla tarball, while starting from 2.6.9 UML has been merged in mainline so a vanilla kernel (should) compile. However, a vanilla 2.6.9 kernel tarball contains the whole UML architecture, but has these problems (they were discovered and fixed later).

I release (when needed) a patchset (the -bb/-bs one) against vanilla kernels, however, for further UML fixes. "When needed" means that if the mainline release is good, and no important fixes are written, or if my time is short, I don't do a release.

Possibly including it inside the portage tree would be good (as usermode-bb-sources, if you want). I both use a Gentoo system and maintain that patchset, so if you want I can help for this.



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
