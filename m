Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDA2L-0006Pq-LZ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Apr 2004 15:36:17 -0700
Received: from alchar.org ([66.92.236.138] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BDA2L-0005LX-Ah for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Apr 2004 15:36:17 -0700
From: Kris Van Hees <aedil@alchar.org>
Message-ID: <20040412183616.B19633@alchar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] UML and 2.6.x
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
Date: Mon, 12 Apr 2004 18:36:16 -0400
To: user-mode-linux-devel@lists.sourceforge.net

I just found out (the hard way) that is seems like UML 2.6.4 cannot be compiled
on a host that is running 2.4.18, because the host-level code (in this case
arch/um/os-Linux/process.c) is depending on things in the installed include
files (unistd.h and the stuff it includes, specifically linux/unistd.h) that
are simply not there (__NR_tkill).  Is this fact documented somewhere that I
overlooked?

	Kris
-- 
Never underestimate a Mage with:
 - the Intelligence to cast Magic Missile,
 - the Constitution to survive the first hit, and
 - the Dexterity to run fast enough to avoid being hit a second time.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
