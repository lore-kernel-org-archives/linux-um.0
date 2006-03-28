Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOO7z-0004PE-9y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 16:01:35 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FOO7y-0003GJ-MP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 16:01:35 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060328235700.13838.39297.stgit@zion.home.lan>
In-Reply-To: <20060328235442.13838.26861.stgit@zion.home.lan>
References: <20060328235442.13838.26861.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 5/7] uml - tls support: hack to make it compile on
	any host
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
Date: Wed, 29 Mar 2006 01:57:00 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Copy the definition of struct user_desc (with another name) for use by userspace
sources (where we use the host headers, and we can't be sure about their
content) to make sure UML compiles.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h                |    7 ++++---
 arch/um/include/sysdep-i386/tls.h   |   28 ++++++++++++++++++++++++++++
 arch/um/include/sysdep-x86_64/tls.h |   29 +++++++++++++++++++++++++++++
 arch/um/os-Linux/tls.c              |   15 +++++++--------
 4 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index 90869a7..b14d403 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -13,6 +13,7 @@
 #include "kern_util.h"
 #include "skas/mm_id.h"
 #include "irq_user.h"
+#include "sysdep/tls.h"
 
 #define OS_TYPE_FILE 1 
 #define OS_TYPE_DIR 2 
@@ -236,10 +237,10 @@ extern int helper_wait(int pid);
 
 
 /* tls.c */
-extern int os_set_thread_area(void *data, int pid);
-extern int os_get_thread_area(void *data, int pid);
-/* umid.c */
+extern int os_set_thread_area(user_desc_t *info, int pid);
+extern int os_get_thread_area(user_desc_t *info, int pid);
 
+/* umid.c */
 extern int umid_file_name(char *name, char *buf, int len);
 extern int set_umid(char *name);
 extern char *get_umid(void);
diff --git a/arch/um/include/sysdep-i386/tls.h b/arch/um/include/sysdep-i386/tls.h
new file mode 100644
index 0000000..938f953
--- /dev/null
+++ b/arch/um/include/sysdep-i386/tls.h
@@ -0,0 +1,28 @@
+#ifndef _SYSDEP_TLS_H
+#define _SYSDEP_TLS_H
+
+# ifndef __KERNEL__
+
+/* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
+ * may be named user_desc (but in 2.4 and in header matching its API was named
+ * modify_ldt_ldt_s). */
+
+typedef struct um_dup_user_desc {
+	unsigned int  entry_number;
+	unsigned int  base_addr;
+	unsigned int  limit;
+	unsigned int  seg_32bit:1;
+	unsigned int  contents:2;
+	unsigned int  read_exec_only:1;
+	unsigned int  limit_in_pages:1;
+	unsigned int  seg_not_present:1;
+	unsigned int  useable:1;
+} user_desc_t;
+
+# else /* __KERNEL__ */
+
+#  include <asm/ldt.h>
+typedef struct user_desc user_desc_t;
+
+# endif /* __KERNEL__ */
+#endif /* _SYSDEP_TLS_H */
diff --git a/arch/um/include/sysdep-x86_64/tls.h b/arch/um/include/sysdep-x86_64/tls.h
new file mode 100644
index 0000000..35f19f2
--- /dev/null
+++ b/arch/um/include/sysdep-x86_64/tls.h
@@ -0,0 +1,29 @@
+#ifndef _SYSDEP_TLS_H
+#define _SYSDEP_TLS_H
+
+# ifndef __KERNEL__
+
+/* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
+ * may be named user_desc (but in 2.4 and in header matching its API was named
+ * modify_ldt_ldt_s). */
+
+typedef struct um_dup_user_desc {
+	unsigned int  entry_number;
+	unsigned int  base_addr;
+	unsigned int  limit;
+	unsigned int  seg_32bit:1;
+	unsigned int  contents:2;
+	unsigned int  read_exec_only:1;
+	unsigned int  limit_in_pages:1;
+	unsigned int  seg_not_present:1;
+	unsigned int  useable:1;
+	unsigned int  lm:1;
+} user_desc_t;
+
+# else /* __KERNEL__ */
+
+#  include <asm/ldt.h>
+typedef struct user_desc user_desc_t;
+
+# endif /* __KERNEL__ */
+#endif /* _SYSDEP_TLS_H */
diff --git a/arch/um/os-Linux/tls.c b/arch/um/os-Linux/tls.c
index 63dfcf7..642db55 100644
--- a/arch/um/os-Linux/tls.c
+++ b/arch/um/os-Linux/tls.c
@@ -1,6 +1,7 @@
 #include <errno.h>
 #include <sys/ptrace.h>
 #include <asm/ldt.h>
+#include "sysdep/tls.h"
 #include "uml-config.h"
 
 /* TLS support - we basically rely on the host's one.*/
@@ -18,9 +19,8 @@
 #define PTRACE_SET_THREAD_AREA 26
 #endif
 
-int os_set_thread_area(void *data, int pid)
+int os_set_thread_area(user_desc_t *info, int pid)
 {
-	struct user_desc *info = data;
 	int ret;
 
 	ret = ptrace(PTRACE_SET_THREAD_AREA, pid, info->entry_number,
@@ -32,9 +32,8 @@ int os_set_thread_area(void *data, int p
 
 #ifdef UML_CONFIG_MODE_SKAS
 
-int os_get_thread_area(void *data, int pid)
+int os_get_thread_area(user_desc_t *info, int pid)
 {
-	struct user_desc *info = data;
 	int ret;
 
 	ret = ptrace(PTRACE_GET_THREAD_AREA, pid, info->entry_number,
@@ -49,10 +48,10 @@ int os_get_thread_area(void *data, int p
 #ifdef UML_CONFIG_MODE_TT
 #include "linux/unistd.h"
 
-_syscall1(int, get_thread_area, struct user_desc *, u_info);
-_syscall1(int, set_thread_area, struct user_desc *, u_info);
+_syscall1(int, get_thread_area, user_desc_t *, u_info);
+_syscall1(int, set_thread_area, user_desc_t *, u_info);
 
-int do_set_thread_area_tt(struct user_desc *info)
+int do_set_thread_area_tt(user_desc_t *info)
 {
 	int ret;
 
@@ -63,7 +62,7 @@ int do_set_thread_area_tt(struct user_de
 	return ret;
 }
 
-int do_get_thread_area_tt(struct user_desc *info)
+int do_get_thread_area_tt(user_desc_t *info)
 {
 	int ret;
 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
