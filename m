Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyEmy-0005V4-0T for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 12:47:48 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EyEmw-0005E8-N4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Jan 2006 12:47:48 -0800
Message-Id: <200601152139.k0FLdsTv027758@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 11/11] UML - TT mode softint fixes
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
Date: Sun, 15 Jan 2006 16:39:54 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Some fixes to make softints work in tt mode.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/time_kern.c	2006-01-06 21:49:51.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/time_kern.c	2006-01-06 22:06:42.000000000 -0500
@@ -187,8 +187,9 @@ void timer_handler(int sig, union uml_pt
 {
 	local_irq_disable();
 	irq_enter();
-	update_process_times(CHOOSE_MODE(user_context(UPT_SP(regs)),
-					 (regs)->skas.is_user));
+	update_process_times(CHOOSE_MODE(
+	                     (UPT_SC(regs) && user_context(UPT_SP(regs))),
+			     (regs)->skas.is_user));
 	irq_exit();
 	local_irq_enable();
 	if(current_thread->cpu == 0)
Index: linux-2.6.15-mm/arch/um/kernel/tt/trap_user.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/trap_user.c	2006-01-06 21:46:18.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/tt/trap_user.c	2006-01-06 22:06:42.000000000 -0500
@@ -18,7 +18,7 @@ void sig_handler_common_tt(int sig, void
 {
 	struct sigcontext *sc = sc_ptr;
 	struct tt_regs save_regs, *r;
-	int save_errno = errno, is_user;
+	int save_errno = errno, is_user = 0;
 	void (*handler)(int, union uml_pt_regs *);
 
 	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
@@ -35,7 +35,8 @@ void sig_handler_common_tt(int sig, void
                 GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
         }
 	save_regs = *r;
-	is_user = user_context(SC_SP(sc));
+	if (sc)
+		is_user = user_context(SC_SP(sc));
 	r->sc = sc;
 	if(sig != SIGUSR2) 
 		r->syscall = -1;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
