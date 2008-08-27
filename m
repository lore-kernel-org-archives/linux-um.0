Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYP4k-0006fw-F0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 10:44:58 -0700
Received: from mail-gx0-f19.google.com ([209.85.217.19])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYP4j-0007rd-Ru
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 10:44:58 -0700
Received: by gxk12 with SMTP id 12so4129324gxk.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 27 Aug 2008 10:44:52 -0700 (PDT)
Message-ID: <ea9232d10808271044y6b4af1bfv872bf7f9e50dbb68@mail.gmail.com>
Date: Wed, 27 Aug 2008 19:44:52 +0200
From: "Karol Swietlicki" <magotari@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] Removing an unused variable in ptrace.c
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This patch cleans up an usused variable in ptrace.c.
Compile tested.

Karol Swietlicki

Signed-off-by: Karol Swietlicki <magotari@gmail.com>
---
--- linux-2.6.27-rc1-mm1.orig/arch/um/kernel/ptrace.c	2008-08-27
19:20:13.000000000 +0200
+++ linux-2.6.27-rc1-mm1/arch/um/kernel/ptrace.c	2008-08-27
19:05:34.000000000 +0200
@@ -225,8 +225,7 @@ long arch_ptrace(struct task_struct *chi
 	return ret;
 }

-static void send_sigtrap(struct task_struct *tsk, struct uml_pt_regs *regs,
-		  int error_code)
+static void send_sigtrap(struct task_struct *tsk, struct uml_pt_regs *regs)
 {
 	struct siginfo info;

@@ -264,7 +263,7 @@ void syscall_trace(struct uml_pt_regs *r

 	/* Fake a debug trap */
 	if (is_singlestep)
-		send_sigtrap(current, regs, 0);
+		send_sigtrap(current, regs);

 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
