Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QjpPC-0003fT-Mf
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:54 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QjpP8-0001Ae-Kg
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:54 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 21 Jul 2011 11:18:29 +0200
Message-Id: <1311239914-8301-5-git-send-email-richard@nod.at>
In-Reply-To: <1311239914-8301-1-git-send-email-richard@nod.at>
References: <1311239914-8301-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 05/10] um: Disable scan_elf_aux() on x86_64
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Reusing the host's vDSO makes only sense on x86_32.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/Makefile  |    4 +++-
 arch/um/os-Linux/elf_aux.c |    7 +------
 arch/um/os-Linux/main.c    |    4 ++++
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index d66f038..b33f4df 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -3,10 +3,12 @@
 # Licensed under the GPL
 #
 
-obj-y = aio.o elf_aux.o execvp.o file.o helper.o irq.o main.o mem.o process.o \
+obj-y = aio.o execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o uaccess.o \
 	umid.o tls.o user_syms.o util.o drivers/ sys-$(SUBARCH)/ skas/
 
+obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
+
 USER_OBJS := $(user-objs-y) aio.o elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
 	tty.o tls.o uaccess.o umid.o util.o
diff --git a/arch/um/os-Linux/elf_aux.c b/arch/um/os-Linux/elf_aux.c
index 608784d..9533237 100644
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -14,16 +14,11 @@
 #include "mem_user.h"
 #include <kern_constants.h>
 
-/* Use the one from the kernel - the host may miss it, if having old headers. */
-#if UM_ELF_CLASS == UM_ELFCLASS32
 typedef Elf32_auxv_t elf_auxv_t;
-#else
-typedef Elf64_auxv_t elf_auxv_t;
-#endif
 
 /* These are initialized very early in boot and never changed */
 char * elf_aux_platform;
-long elf_aux_hwcap;
+extern long elf_aux_hwcap;
 unsigned long vsyscall_ehdr;
 unsigned long vsyscall_end;
 unsigned long __kernel_vsyscall;
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index fb2a97a..8471b81 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -21,6 +21,8 @@
 #define STACKSIZE (8 * 1024 * 1024)
 #define THREAD_NAME_LEN (256)
 
+long elf_aux_hwcap;
+
 static void set_stklim(void)
 {
 	struct rlimit lim;
@@ -143,7 +145,9 @@ int __init main(int argc, char **argv, char **envp)
 	install_fatal_handler(SIGINT);
 	install_fatal_handler(SIGTERM);
 
+#ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
 	scan_elf_aux(envp);
+#endif
 
 	do_uml_initcalls();
 	ret = linux_main(argc, argv);
-- 
1.7.6


------------------------------------------------------------------------------
5 Ways to Improve & Secure Unified Communications
Unified Communications promises greater efficiencies for business. UC can 
improve internal communications as well as offer faster, more efficient ways
to interact with customers and streamline customer service. Learn more!
http://www.accelacomm.com/jaw/sfnl/114/51426253/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

