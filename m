Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@oracle.com>) id 1b496l-0001LP-Om
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 15:46:31 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b496i-0006RU-Vj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 15:46:31 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Sat, 21 May 2016 17:46:10 +0200
Message-Id: <1463845570-17487-1-git-send-email-vegard.nossum@oracle.com>
Subject: [uml-devel] [PATCH v2] um: support kcov
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
To: Richard Weinberger <richard@nod.at>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>, Vegard Nossum <vegard.nossum@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, Thomas Meyer <thomas@m3y3r.de>

This adds support for kcov to UML.

There is a small problem where UML will randomly segfault during boot;
this is because current_thread_info() occasionally returns an invalid
(non-NULL) pointer and we try to dereference it in
__sanitizer_cov_trace_pc(). I consider this a bug in UML itself and this
patch merely exposes it.

[v2: disable instrumentation in UML-specific code]

Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 arch/um/Kconfig.common    | 1 +
 arch/um/kernel/Makefile   | 5 +++++
 arch/um/os-Linux/Makefile | 3 +++
 arch/x86/um/vdso/Makefile | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index cc00134..64c1d46 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -1,6 +1,7 @@
 config UML
 	bool
 	default y
+	select ARCH_HAS_KCOV
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_UID16
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index a6a5e42..2f36d51 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -3,6 +3,11 @@
 # Licensed under the GPL
 #
 
+# Don't instrument UML-specific code; without this, we may crash when
+# accessing the instrumentation buffer for the first time from the
+# kernel.
+KCOV_INSTRUMENT                := n
+
 CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
                         -DELF_ARCH=$(LDS_ELF_ARCH)	\
                         -DELF_FORMAT=$(LDS_ELF_FORMAT)	\
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 08ff509..ada473b 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -3,6 +3,9 @@
 # Licensed under the GPL
 #
 
+# Don't instrument UML-specific code
+KCOV_INSTRUMENT                := n
+
 obj-y = aio.o execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
 	umid.o user_syms.o util.o drivers/ skas/
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 6c803ca..d72dec4 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -2,6 +2,9 @@
 # Building vDSO images for x86.
 #
 
+# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
+KCOV_INSTRUMENT                := n
+
 VDSO64-y		:= y
 
 vdso-install-$(VDSO64-y)	+= vdso.so
-- 
1.9.1


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

