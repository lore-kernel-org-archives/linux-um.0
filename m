Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8ixc-0007Zm-I3 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:25:20 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1C8ixb-0005j3-Tb for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:25:20 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409181922.19365.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Fwd: [uml-user] Kernel panic: Segfault with no mm &&
	CONFIG_DEBUG_SLAB
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
Date: Sat, 18 Sep 2004 19:22:19 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Could you investigate on this?

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

----------  Forwarded Message  ----------

Subject: [uml-user] Kernel panic: Segfault with no mm && CONFIG_DEBUG_SLAB
Date: Friday 17 September 2004 19:05
From: "Tsillas, Demetrios J" <jtsillas@enterasys.com>
To: <user-mode-linux-user@lists.sourceforge.net>

I'm using skas with a late 2.4 host and a 2.4.26 uml
with recent patch.

I'm running a number of umls on a heavily loaded system
and have run into an interesting problem. For a while I
was running with CONFIG_DEBUG_SLABS turned on and things
looked happy enough.

Recently (in order to squeeze some more speed out of the
setup) I turned off CONFIG_DEBUG_SLAB.

The result is a very consistent kernel panic:

Kernel panic: Segfault with no mm

on two of the umls.

I'm guessing that setting CONFIG_DEBUG_SLAB changes the
way pages are mapped into the kernel's address space and
is hiding some problem.

Any thoughts?


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
