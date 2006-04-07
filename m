Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRs0j-0003GU-IU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:29 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRs0j-0003Zo-12
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:29 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060407143105.19201.88376.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 07/17] uml: fix "extern-vs-static" proto conflict
	in TLS code
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
Date: Fri, 07 Apr 2006 16:31:05 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Move the prototype from arch-generic to arch-specific includes because on x86_64
these functions are two static inlines.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/kern_util.h  |    4 ----
 include/asm-um/ptrace-i386.h |    3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/kern_util.h b/arch/um/include/kern_util.h
index 4255713..efa3d33 100644
--- a/arch/um/include/kern_util.h
+++ b/arch/um/include/kern_util.h
@@ -117,10 +117,6 @@ extern struct task_struct *get_task(int 
 extern void machine_halt(void);
 extern int is_syscall(unsigned long addr);
 
-extern void arch_switch_to_tt(struct task_struct *from, struct task_struct *to);
-
-extern void arch_switch_to_skas(struct task_struct *from, struct task_struct *to);
-
 extern void free_irq(unsigned int, void *);
 extern int cpu(void);
 
diff --git a/include/asm-um/ptrace-i386.h b/include/asm-um/ptrace-i386.h
index 30656c9..6e2528b 100644
--- a/include/asm-um/ptrace-i386.h
+++ b/include/asm-um/ptrace-i386.h
@@ -56,6 +56,9 @@ extern int do_get_thread_area_tt(struct 
 extern int arch_switch_tls_skas(struct task_struct *from, struct task_struct *to);
 extern int arch_switch_tls_tt(struct task_struct *from, struct task_struct *to);
 
+extern void arch_switch_to_tt(struct task_struct *from, struct task_struct *to);
+extern void arch_switch_to_skas(struct task_struct *from, struct task_struct *to);
+
 static inline int do_get_thread_area(struct user_desc *info)
 {
 	return CHOOSE_MODE_PROC(do_get_thread_area_tt, do_get_thread_area_skas, info);


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
