Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAvEE-0003hG-R4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 11:27:50 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DAvEA-0006Ni-Kf for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 11:27:50 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Fixing the __gcov_init problem
References: <200503130654.j2D6rrAM005199@ccure.user-mode-linux.org>
In-Reply-To: <200503130654.j2D6rrAM005199@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wLeNCxC95IjK8CB"
Message-Id: <200503142016.00634.blaisorblade@yahoo.it>
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
Date: Mon, 14 Mar 2005 20:16:00 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Adrian Bunk <bunk@stusta.de>

--Boundary-00=_wLeNCxC95IjK8CB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 13 March 2005 07:53, Jeff Dike wrote:
> OK, below is my latest attempt at getting this right.  It provides a weak
> definition of __gcov_init for gcc's that don't generate it, while gcc's
> that do will have their's override this one.
The obtained code by this patch is a bit of a mess... plus there is a bunch of 
other problems (I've posted another mail with the description of the 
problems).
The patch below is a partial solution to all them...
> The patch is against -bk8.
>
>     Jeff


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_wLeNCxC95IjK8CB
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-real-fix-gcov-symbols.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-real-fix-gcov-symbols.patch"


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Anton Altaparmakov <aia21@cam.ac.uk>

Correctly export __gcov_init for cases where it's needed, by adding a weak
definition for the case when GCC does not define this symbol and letting it
being overriden by the real definition when GCC defines it (recent ones).

Can't be implemented as a test on GCC version because SuSE has a crippled GCC,
declared as 3.3.4 but having a lot of backported features.

Also, since gcc 3.4.3 requires profiling options even during linking, avoid
adding profiling options for compilation of userspace utilities (where they
are not needed). And add profiling options to final link stage.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Makefile               |    6 +++++-
 linux-2.6.11-paolo/arch/um/Makefile-skas          |   10 ++++++----
 linux-2.6.11-paolo/arch/um/kernel/gmon_syms.c     |   17 +++++++++++------
 linux-2.6.11-paolo/arch/um/sys-i386/util/Makefile |    4 ++--
 linux-2.6.11-paolo/arch/um/util/Makefile          |    4 ++--
 5 files changed, 26 insertions(+), 15 deletions(-)

diff -puN arch/um/kernel/gmon_syms.c~uml-real-fix-gcov-symbols arch/um/kernel/gmon_syms.c
--- linux-2.6.11/arch/um/kernel/gmon_syms.c~uml-real-fix-gcov-symbols	2005-03-13 20:47:53.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/gmon_syms.c	2005-03-13 20:47:53.000000000 +0100
@@ -5,14 +5,19 @@
 
 #include "linux/module.h"
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
-	(__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
-extern void __gcov_init(void *);
-EXPORT_SYMBOL(__gcov_init);
-#else
 extern void __bb_init_func(void *);
 EXPORT_SYMBOL(__bb_init_func);
-#endif
+
+/* This is defined (and referred to in profiling stub code) only by some GCC
+ * versions in libgcov.
+ *
+ * Since SuSE backported the fix, we cannot handle it depending on GCC version.
+ * So, unconditinally export it. But also give it a weak definition, which will
+ * be overriden by any other one.
+ */
+
+extern void __gcov_init(void *) __attribute__((weak));
+EXPORT_SYMBOL(__gcov_init);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -puN arch/um/util/Makefile~uml-real-fix-gcov-symbols arch/um/util/Makefile
--- linux-2.6.11/arch/um/util/Makefile~uml-real-fix-gcov-symbols	2005-03-13 20:47:53.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/util/Makefile	2005-03-13 20:47:53.000000000 +0100
@@ -4,5 +4,5 @@ always			:= $(hostprogs-y)
 mk_task-objs		:= mk_task_user.o mk_task_kern.o
 mk_constants-objs	:= mk_constants_user.o mk_constants_kern.o
 
-HOSTCFLAGS_mk_task_kern.o	:= $(CFLAGS) $(CPPFLAGS)
-HOSTCFLAGS_mk_constants_kern.o	:= $(CFLAGS) $(CPPFLAGS)
+HOSTCFLAGS_mk_task_kern.o	:= $(CFLAGS_noprof) $(CPPFLAGS)
+HOSTCFLAGS_mk_constants_kern.o	:= $(CFLAGS_noprof) $(CPPFLAGS)
diff -puN arch/um/Makefile~uml-real-fix-gcov-symbols arch/um/Makefile
--- linux-2.6.11/arch/um/Makefile~uml-real-fix-gcov-symbols	2005-03-13 20:47:53.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile	2005-03-13 20:47:53.000000000 +0100
@@ -65,6 +65,10 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
 CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
+#XXX: Avoid compiling userspace utilities with profiling. Kludgy, but going away soon.
+CFLAGS_noprof := $(patsubst -fprofile-arcs -ftest-coverage,,$(patsubst -pg,,$(CFLAGS)))
+USER_CFLAGS_noprof := $(patsubst -fprofile-arcs -ftest-coverage,,$(patsubst -pg,,$(USER_CFLAGS)))
+
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
@@ -199,4 +203,4 @@ $(ARCH_DIR)/util: scripts_basic $(SYS_DI
 $(ARCH_DIR)/kernel/skas/util: scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=$@
 
-export SUBARCH USER_CFLAGS OS
+export SUBARCH USER_CFLAGS OS CFLAGS_noprof USER_CFLAGS_noprof
diff -puN arch/um/sys-i386/util/Makefile~uml-real-fix-gcov-symbols arch/um/sys-i386/util/Makefile
--- linux-2.6.11/arch/um/sys-i386/util/Makefile~uml-real-fix-gcov-symbols	2005-03-13 20:47:53.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/sys-i386/util/Makefile	2005-03-13 20:47:53.000000000 +0100
@@ -4,5 +4,5 @@ always		:= $(hostprogs-y)
 
 mk_thread-objs	:= mk_thread_kern.o mk_thread_user.o
 
-HOSTCFLAGS_mk_thread_kern.o	:= $(CFLAGS) $(CPPFLAGS)
-HOSTCFLAGS_mk_thread_user.o	:= $(USER_CFLAGS)
+HOSTCFLAGS_mk_thread_kern.o	:= $(CFLAGS_noprof) $(CPPFLAGS)
+HOSTCFLAGS_mk_thread_user.o	:= $(USER_CFLAGS_noprof)
diff -puN arch/um/Makefile-skas~uml-real-fix-gcov-symbols arch/um/Makefile-skas
--- linux-2.6.11/arch/um/Makefile-skas~uml-real-fix-gcov-symbols	2005-03-13 20:48:03.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile-skas	2005-03-13 20:50:36.000000000 +0100
@@ -3,10 +3,12 @@
 # Licensed under the GPL
 #
 
-PROFILE += -pg
+GPROF_OPT += -pg
+GCOV_OPT += -fprofile-arcs -ftest-coverage
 
-CFLAGS-$(CONFIG_GCOV) += -fprofile-arcs -ftest-coverage
-CFLAGS-$(CONFIG_GPROF) += $(PROFILE)
-LINK-$(CONFIG_GPROF) += $(PROFILE)
+CFLAGS-$(CONFIG_GCOV) += $(GCOV_OPT)
+CFLAGS-$(CONFIG_GPROF) += $(GPROF_OPT)
+LINK-$(CONFIG_GCOV) += $(GCOV_OPT)
+LINK-$(CONFIG_GPROF) += $(GPROF_OPT)
 
 GEN_HEADERS += $(ARCH_DIR)/include/skas_ptregs.h
_

--Boundary-00=_wLeNCxC95IjK8CB--





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
