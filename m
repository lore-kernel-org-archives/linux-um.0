Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5QLI-0007Pw-Bw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 07:56:08 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5QLG-0002U6-Qu for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 07:56:08 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.58.0409091046350.2824@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Kernel stack overflow
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
Date: Thu, 9 Sep 2004 10:52:16 -0400 (EDT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

Good morning, Jeff,
	The whoopis VM on Zaphod crashed this morning with this on the 
console:

whoopis login: Kernel panic: Kernel stack overflow

	The kernel completely went away, no coredump.

Linux whoopis.com 2.6.6-1um #1 Wed May 26 03:06:23 EDT 2004 i686 i686 i386 
GNU/Linux

	I realize I should upgrade, just wanted to pass this one along in 
case it hadn't been seen before.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "5) what are people like spaf/chris rouland/lance then?
a) THEY ARE THE ENEMY. WHITEHATS = ENEMY."
        -- http://www.blackhatbloc.org/phrack/texts/faq1.txt
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
