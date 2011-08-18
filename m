Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu80T-0002QJ-J1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:11:57 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu80S-0000Nj-Ta
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:11:57 +0000
Date: Thu, 18 Aug 2011 20:11:49 +0100
MIME-Version: 1.0
Message-Id: <E1Qu80L-00082z-UV@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 77/91] um: fix gcov build breakage
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


a) exports in gmon_syms.c duplicate kernel/gcov/* ones
b) excluding -pg in vdso compile is not enough - -fprofile-arcs
and -ftest-coverage also needs to be excluded

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/kernel/gmon_syms.c |   15 ---------------
 arch/x86/um/vdso/Makefile  |    4 ++--
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/um/kernel/gmon_syms.c b/arch/um/kernel/gmon_syms.c
index 72eccd2..e9bcf247 100644
--- a/arch/um/kernel/gmon_syms.c
+++ b/arch/um/kernel/gmon_syms.c
@@ -7,18 +7,3 @@
 
 extern void __bb_init_func(void *)  __attribute__((weak));
 EXPORT_SYMBOL(__bb_init_func);
-
-/*
- * This is defined (and referred to in profiling stub code) only by some GCC
- * versions in libgcov.
- *
- * Since SuSE backported the fix, we cannot handle it depending on GCC version.
- * So, unconditionally export it. But also give it a weak declaration, which
- * will be overridden by any other one.
- */
-
-extern void __gcov_init(void *) __attribute__((weak));
-EXPORT_SYMBOL(__gcov_init);
-
-extern void __gcov_merge_add(void *) __attribute__((weak));
-EXPORT_SYMBOL(__gcov_merge_add);
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 5dffe6d..6c803ca 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -46,8 +46,8 @@ $(vobjs): KBUILD_CFLAGS += $(CFL)
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
 #
-CFLAGS_REMOVE_vdso-note.o = -pg
-CFLAGS_REMOVE_um_vdso.o = -pg
+CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
+CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
 
 targets += vdso-syms.lds
 obj-$(VDSO64-y)			+= vdso-syms.lds
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

