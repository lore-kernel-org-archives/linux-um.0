Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkRRl-0000kE-Cl	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:56:37 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DkRRi-0000I1-L1	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:56:37 -0700
Message-Id: <200506201851.j5KIpHig008488@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/8] UML - Fix timer initialization
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
Date: Mon, 20 Jun 2005 14:51:17 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

In skas mode, the call to uml_idle_timer permanently shut off the
virtual timer, resulting in no timer ticks to anything but the idle
thread.  This is likely the cause of the soft lockups that are seen 
sporadically in recent UMLs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/process_kern.c	2005-06-20 12:02:19.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/process_kern.c	2005-06-20 12:06:08.000000000 -0400
@@ -169,7 +169,7 @@ int current_pid(void)
 
 void default_idle(void)
 {
-	uml_idle_timer();
+	CHOOSE_MODE(uml_idle_timer(), (void) 0);
 
 	atomic_inc(&init_mm.mm_count);
 	current->mm = &init_mm;
Index: linux-2.6.12/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/process_kern.c	2005-06-20 12:02:32.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/process_kern.c	2005-06-20 12:06:08.000000000 -0400
@@ -180,7 +180,6 @@ int start_uml_skas(void)
 	start_userspace(0);
 
 	init_new_thread_signals(1);
-	uml_idle_timer();
 
 	init_task.thread.request.u.thread.proc = start_kernel_proc;
 	init_task.thread.request.u.thread.arg = NULL;



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
