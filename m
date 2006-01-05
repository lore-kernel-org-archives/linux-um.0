Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EudKM-0006zG-6T for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jan 2006 14:11:22 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EudKL-0001uN-Kr
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jan 2006 14:11:22 -0800
Message-Id: <200601052303.k05N3aB6010886@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/4] UML - whitespace cleanup
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
Date: Thu, 05 Jan 2006 18:03:36 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This fixes some mangled whitespace added by the earlier trap_user.c patch.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/os-Linux/skas/trap.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/skas/trap.c	2006-01-05 16:20:31.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/skas/trap.c	2006-01-05 17:07:57.000000000 -0500
@@ -34,11 +34,11 @@ void sig_handler_common_skas(int sig, vo
 	r = &TASK_REGS(get_current())->skas;
 	save_user = r->is_user;
 	r->is_user = 0;
-        if ( sig == SIGFPE || sig == SIGSEGV ||
-             sig == SIGBUS || sig == SIGILL ||
-             sig == SIGTRAP ) {
-                GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
-        }
+	if ( sig == SIGFPE || sig == SIGSEGV ||
+	     sig == SIGBUS || sig == SIGILL ||
+	     sig == SIGTRAP ) {
+		GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
+	}
 
 	change_sig(SIGUSR1, 1);
 
@@ -60,8 +60,8 @@ extern int ptrace_faultinfo;
 void user_signal(int sig, union uml_pt_regs *regs, int pid)
 {
 	void (*handler)(int, union uml_pt_regs *);
-        int segv = ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) ||
-                    (sig == SIGILL) || (sig == SIGTRAP));
+	int segv = ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) ||
+		    (sig == SIGILL) || (sig == SIGTRAP));
 
 	if (segv)
 		get_skas_faultinfo(pid, &regs->skas.faultinfo);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
