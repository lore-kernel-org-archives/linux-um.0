Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvJsY-00089H-9w for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Feb 2004 09:28:26 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AvJkp-00084A-AE
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Feb 2004 09:20:27 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040223172012.GA29046@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] post-2.6.3 build error
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
Date: Mon, 23 Feb 2004 18:20:12 +0100
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

You might have noticed already that in latest linus tree um doesn't
build any more.  The reason is that sys_sched_setscheduler() is declared
now in linux/sched.h, which conflicts with the declaration in
arch/um/kernel/sys_call_table.c.  As quick+dirty fix I've just commented
the declaration.  It builds now, but gives a warning (which is harmless I
think as the exact type of the function shouldn't matter for the syscall
table).  Anyone has a better/cleaner fix for that?

  Gerd

--- linux-2004-02-22/arch/um/kernel/sys_call_table.c~	2004-02-23 15:39:51.000000000 +0100
+++ linux-2004-02-22/arch/um/kernel/sys_call_table.c	2004-02-23 17:30:16.995802718 +0100
@@ -151,7 +151,7 @@
 extern syscall_handler_t sys_munlockall;
 extern syscall_handler_t sys_sched_setparam;
 extern syscall_handler_t sys_sched_getparam;
-extern syscall_handler_t sys_sched_setscheduler;
+//extern syscall_handler_t sys_sched_setscheduler;
 extern syscall_handler_t sys_sched_getscheduler;
 extern syscall_handler_t sys_sched_get_priority_max;
 extern syscall_handler_t sys_sched_get_priority_min;


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
