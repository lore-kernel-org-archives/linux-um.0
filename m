Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FagDH-00011G-10 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 14:45:51 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FagDH-0005uJ-4r for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 14:45:51 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FagDF-0000NG-MO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 14:45:51 -0700
Message-Id: <200605012046.k41KkURr005868@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] UML - Change timer initialization
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
Date: Mon, 01 May 2006 16:46:29 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This is definite 2.6.17 material...

As of rc3-mm1, inet_init, which schedules, is called before the UML timer_init,
which sets up the timer.  The result is the interval timers being manipulated
before the appropriate signal handlers are established, causing unhandled
timers.

This is fixed by making timer_init be called earlier.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/kernel/time_kern.c	2006-03-23 16:40:20.000000000 -0500
+++ linux-2.6.17-mm/arch/um/kernel/time_kern.c	2006-05-01 17:34:41.000000000 -0400
@@ -209,4 +209,4 @@ int __init timer_init(void)
 	return(0);
 }
 
-__initcall(timer_init);
+arch_initcall(timer_init);



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
