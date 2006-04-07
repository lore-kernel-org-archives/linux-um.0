Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRs0k-0003Go-Gf for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:30 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRs0j-0003Za-0Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:30 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060407143056.19201.63947.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 04/17] uml: request format warnings to GCC for
	appropriate functions
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
Date: Fri, 07 Apr 2006 16:30:57 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Add the format attribute to prototypes so GCC warns about improper usage.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/tt/tt.h     |    3 ++-
 arch/um/include/user.h      |    6 ++++--
 arch/um/include/user_util.h |    3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/tt/tt.h b/arch/um/include/tt/tt.h
index 8085219..acb8356 100644
--- a/arch/um/include/tt/tt.h
+++ b/arch/um/include/tt/tt.h
@@ -19,7 +19,8 @@ extern int fork_tramp(void *sig_stack);
 extern int do_proc_op(void *t, int proc_id);
 extern int tracer(int (*init_proc)(void *), void *sp);
 extern void attach_process(int pid);
-extern void tracer_panic(char *format, ...);
+extern void tracer_panic(char *format, ...)
+	__attribute__ ((format (printf, 1, 2)));
 extern void set_init_pid(int pid);
 extern int set_user_mode(void *task);
 extern void set_tracing(void *t, int tracing);
diff --git a/arch/um/include/user.h b/arch/um/include/user.h
index 91b0ac4..39f8c88 100644
--- a/arch/um/include/user.h
+++ b/arch/um/include/user.h
@@ -6,8 +6,10 @@
 #ifndef __USER_H__
 #define __USER_H__
 
-extern void panic(const char *fmt, ...);
-extern int printk(const char *fmt, ...);
+extern void panic(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
+extern int printk(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
 extern void schedule(void);
 extern void *um_kmalloc(int size);
 extern void *um_kmalloc_atomic(int size);
diff --git a/arch/um/include/user_util.h b/arch/um/include/user_util.h
index fe0c29b..802d784 100644
--- a/arch/um/include/user_util.h
+++ b/arch/um/include/user_util.h
@@ -55,7 +55,8 @@ extern int get_pty(void);
 extern void *um_kmalloc(int size);
 extern int switcheroo(int fd, int prot, void *from, void *to, int size);
 extern void do_exec(int old_pid, int new_pid);
-extern void tracer_panic(char *msg, ...);
+extern void tracer_panic(char *msg, ...)
+	__attribute__ ((format (printf, 1, 2)));
 extern int detach(int pid, int sig);
 extern int attach(int pid);
 extern void kill_child_dead(int pid);


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
