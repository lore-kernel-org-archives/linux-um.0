Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCky0-0004oi-LO for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 12:54:40 -0800
Received: from smtp.gentoo.org ([134.68.220.30])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DCky0-0004QA-1u
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 12:54:40 -0800
Received: from nuthatch.gentoo.osuosl.org ([140.211.166.163]
	helo=nuthatch.gentoo.org) by smtp.gentoo.org with esmtp (Exim 4.43)
	id 1DCkxs-00006Z-Da for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 20:54:32 +0000
Received: from apache by nuthatch.gentoo.org with local (Exim 4.43)
	id 1DCkxr-0008AC-Oe for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 20:54:31 +0000
From: bugzilla-daemon@gentoo.org
Message-Id: <E1DCkxr-0008AC-Oe@nuthatch.gentoo.org>
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
Date: Sat, 19 Mar 2005 20:54:31 +0000
To: user-mode-linux-devel@lists.sourceforge.net

http://bugs.gentoo.org/show_bug.cgi?id=49277





------- Additional Comments From rockoo@gmail.com  2005-03-19 12:54 PST -------
overhere the gentoo-source.11-r3 as host and gentoo-source.11-r4 as uml works fine

what about a skas-patched-host-kernel? a use-flag for gentoo-sources/usermode-sources?

Portage 2.0.51.19 (default-linux/x86/2004.3, gcc-3.3.5, glibc-2.3.4.20041102-r1, 2.6.11-gentoo-r3 i686)
=================================================================
System uname: 2.6.11-gentoo-r3 i686 Intel(R) Pentium(R) 4 CPU 1.80GHz
Gentoo Base System version 1.4.16
Python:              dev-lang/python-2.3.4-r1 [2.3.4 (#1, Feb 28 2005, 13:40:03)]
distcc 2.16 i686-pc-linux-gnu (protocols 1 and 2) (default port 3632) [enabled]
ccache version 2.4 [enabled]
dev-lang/python:     2.3.4-r1
sys-devel/autoconf:  2.13, 2.59-r6
sys-devel/automake:  1.8.5-r3, 1.4_p6, 1.5, 1.7.9-r1, 1.6.3, 1.9.4
sys-devel/binutils:  2.15.92.0.2-r1
sys-devel/libtool:   1.5.10-r4
virtual/os-headers:  2.4.22-r1
ACCEPT_KEYWORDS="x86"
AUTOCLEAN="yes"
CFLAGS="-mcpu=pentium4 -O3 -pipe"
CHOST="i686-pc-linux-gnu"




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
