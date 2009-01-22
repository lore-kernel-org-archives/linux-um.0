Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LQ1UW-0001oH-8j
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 15:29:12 +0000
Received: from ug-out-1314.google.com ([66.249.92.175])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LQ1UT-0000lV-Pn for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 15:29:12 +0000
Received: by ug-out-1314.google.com with SMTP id 36so705843uga.17
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Jan 2009 07:29:08 -0800 (PST)
Message-ID: <497890C2.1040206@gmail.com>
Date: Thu, 22 Jan 2009 16:29:06 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
References: <49773C2E.9090608@gmail.com>
In-Reply-To: <49773C2E.9090608@gmail.com>
Subject: [uml-devel] [PATCH] x86, um: fix EXECUTE_SYSCALL macros
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Roel Kluin wrote:
> When these macros aren't called with regs, e.g. with foo
> this will incorectly expand to foo->foo.gp[*]
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> My other patch should probably as well have been sent to this list:
> http://lkml.org/lkml/2009/1/21/203
> 
there were more

Fix EXECUTE_SYSCALL macros. When called with a variable named other
than regs as second argument, this will result in a build failure.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/um/sys-i386/shared/sysdep/syscalls.h b/arch/um/sys-i386/shared/sysdep/syscalls.h
index 9056981..1cab192 100644
--- a/arch/um/sys-i386/shared/sysdep/syscalls.h
+++ b/arch/um/sys-i386/shared/sysdep/syscalls.h
@@ -17,9 +17,9 @@ extern syscall_handler_t old_mmap_i386;
 
 extern syscall_handler_t *sys_call_table[];
 
-#define EXECUTE_SYSCALL(syscall, regs) \
+#define EXECUTE_SYSCALL(syscall, _regs) \
 	((long (*)(struct syscall_args)) \
-	 (*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
+	 (*sys_call_table[syscall]))(SYSCALL_ARGS(&_regs->regs))
 
 extern long sys_mmap2(unsigned long addr, unsigned long len,
 		      unsigned long prot, unsigned long flags,
diff --git a/arch/um/sys-x86_64/shared/sysdep/syscalls.h b/arch/um/sys-x86_64/shared/sysdep/syscalls.h
index 7cfb0b0..a5be219 100644
--- a/arch/um/sys-x86_64/shared/sysdep/syscalls.h
+++ b/arch/um/sys-x86_64/shared/sysdep/syscalls.h
@@ -15,14 +15,14 @@ typedef long syscall_handler_t(void);
 
 extern syscall_handler_t *sys_call_table[];
 
-#define EXECUTE_SYSCALL(syscall, regs) \
+#define EXECUTE_SYSCALL(syscall, _regs) \
 	(((long (*)(long, long, long, long, long, long)) \
-	  (*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&regs->regs), \
-		 		      UPT_SYSCALL_ARG2(&regs->regs), \
-				      UPT_SYSCALL_ARG3(&regs->regs), \
-				      UPT_SYSCALL_ARG4(&regs->regs), \
-				      UPT_SYSCALL_ARG5(&regs->regs), \
-				      UPT_SYSCALL_ARG6(&regs->regs)))
+	  (*sys_call_table[syscall]))(UPT_SYSCALL_ARG1(&_regs->regs), \
+		 		      UPT_SYSCALL_ARG2(&_regs->regs), \
+				      UPT_SYSCALL_ARG3(&_regs->regs), \
+				      UPT_SYSCALL_ARG4(&_regs->regs), \
+				      UPT_SYSCALL_ARG5(&_regs->regs), \
+				      UPT_SYSCALL_ARG6(&_regs->regs)))
 
 extern long old_mmap(unsigned long addr, unsigned long len,
 		     unsigned long prot, unsigned long flags,


------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
