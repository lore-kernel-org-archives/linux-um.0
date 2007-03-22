Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HUPqk-0003Kb-1m for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 09:09:14 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HUPqg-0001oB-6D
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 09:09:13 -0700
Date: Thu, 22 Mar 2007 12:06:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070322160649.GA7027@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 7/7 ] UML - Add missing __init declarations
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

The build started finding calls from non-init to init functions.
These are just cases of init functions not being properly marked, so
this patch fixes that.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/mem.c        |    2 +-
 arch/um/os-Linux/main.c     |    2 +-
 arch/um/os-Linux/mem.c      |    9 +++++----
 arch/um/os-Linux/process.c  |    5 +++--
 arch/um/os-Linux/start_up.c |    4 ++--
 5 files changed, 12 insertions(+), 10 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/mem.c	2007-03-20 21:36:47.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/mem.c	2007-03-20 21:37:11.000000000 -0400
@@ -217,7 +217,7 @@ static void __init fixaddr_user_init( vo
 #endif
 }
 
-void paging_init(void)
+void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES], vaddr;
 	int i;
Index: linux-2.6.21-mm/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/main.c	2007-03-20 21:36:47.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/main.c	2007-03-20 21:37:21.000000000 -0400
@@ -120,7 +120,7 @@ extern int uml_exitcode;
 
 extern void scan_elf_aux( char **envp);
 
-int main(int argc, char **argv, char **envp)
+int __init main(int argc, char **argv, char **envp)
 {
 	char **new_argv;
 	int ret, i, err;
Index: linux-2.6.21-mm/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/mem.c	2007-03-20 21:36:47.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/mem.c	2007-03-20 21:37:34.000000000 -0400
@@ -164,7 +164,8 @@ found:
  * (file: kernel/tt/ptproxy/proxy.c, proc: start_debugger).
  * So it isn't 'static' yet.
  */
-int make_tempfile(const char *template, char **out_tempname, int do_unlink)
+int __init make_tempfile(const char *template, char **out_tempname,
+			 int do_unlink)
 {
 	char *tempname;
 	int fd;
@@ -205,7 +206,7 @@ out:
  * This proc is used in start_up.c
  * So it isn't 'static'.
  */
-int create_tmp_file(unsigned long long len)
+int __init create_tmp_file(unsigned long long len)
 {
 	int fd, err;
 	char zero;
@@ -241,7 +242,7 @@ int create_tmp_file(unsigned long long l
 	return fd;
 }
 
-int create_mem_file(unsigned long long len)
+int __init create_mem_file(unsigned long long len)
 {
 	int err, fd;
 
@@ -256,7 +257,7 @@ int create_mem_file(unsigned long long l
 }
 
 
-void check_tmpexec(void)
+void __init check_tmpexec(void)
 {
 	void *addr;
 	int err, fd = create_tmp_file(UM_KERN_PAGE_SIZE);
Index: linux-2.6.21-mm/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/process.c	2007-03-20 21:36:47.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/process.c	2007-03-20 21:37:43.000000000 -0400
@@ -21,6 +21,7 @@
 #include "skas_ptrace.h"
 #include "kern_constants.h"
 #include "uml-config.h"
+#include "init.h"
 
 #define ARBITRARY_ADDR -1
 #define FAILURE_PID    -1
@@ -192,7 +193,7 @@ int os_unmap_memory(void *addr, int len)
 #define MADV_REMOVE KERNEL_MADV_REMOVE
 #endif
 
-int os_drop_memory(void *addr, int length)
+int __init os_drop_memory(void *addr, int length)
 {
 	int err;
 
@@ -202,7 +203,7 @@ int os_drop_memory(void *addr, int lengt
 	return err;
 }
 
-int can_drop_memory(void)
+int __init can_drop_memory(void)
 {
 	void *addr;
 	int fd, ok = 0;
Index: linux-2.6.21-mm/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/start_up.c	2007-03-20 21:36:47.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/start_up.c	2007-03-20 21:37:57.000000000 -0400
@@ -329,7 +329,7 @@ static void __init check_ptrace(void)
 
 extern void check_tmpexec(void);
 
-static void check_coredump_limit(void)
+static void __init check_coredump_limit(void)
 {
 	struct rlimit lim;
 	int err = getrlimit(RLIMIT_CORE, &lim);
@@ -350,7 +350,7 @@ static void check_coredump_limit(void)
 	else printf("%lu\n", lim.rlim_max);
 }
 
-void os_early_checks(void)
+void __init os_early_checks(void)
 {
 	/* Print out the core dump limits early */
 	check_coredump_limit();

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
