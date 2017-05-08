Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1d7obH-0000Uh-C5
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2017 19:45:43 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d7obF-0004rS-Mf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2017 19:45:43 +0000
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
	<20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
	<d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
	<76397EFF-15DB-4F55-B402-DBE7BA1FB02D@m3y3r.de>
	<3f832424-0ae6-1009-cf87-c94794e919ef@nod.at>
	<0419DC3A-B4B7-4005-B068-EF0583433B92@m3y3r.de>
	<D39536F2-909A-40FB-B47F-44A31C56D286@m3y3r.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <66f46b90-6312-449f-2c52-d12fc53f18f6@nod.at>
Date: Mon, 8 May 2017 21:45:34 +0200
MIME-Version: 1.0
In-Reply-To: <D39536F2-909A-40FB-B47F-44A31C56D286@m3y3r.de>
Content-Type: multipart/mixed; boundary="------------73027EAA296B5E597BAADD54"
Subject: Re: [uml-devel] [uml-user]  UML on WSL
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------73027EAA296B5E597BAADD54
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Thomas,

Can you please give the attached patch a try?

Thanks,
//richard

--------------73027EAA296B5E597BAADD54
Content-Type: text/x-patch;
	name="0001-um-Drop-PTRACE_OLDSETOPTIONS-usage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-um-Drop-PTRACE_OLDSETOPTIONS-usage.patch"

>>From b64c967e3960eff33e96f7dcff261635fffeb504 Mon Sep 17 00:00:00 2001
From: Richard Weinberger <richard@nod.at>
Date: Mon, 8 May 2017 21:43:27 +0200
Subject: [PATCH] um: Drop PTRACE_OLDSETOPTIONS usage

IMHO in 2017 can assume that nobody uses UML on a 2.4 host.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/shared/ptrace_user.h | 20 --------------------
 arch/um/os-Linux/skas/process.c      |  8 ++++----
 arch/um/os-Linux/start_up.c          |  8 ++++----
 3 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/arch/um/include/shared/ptrace_user.h b/arch/um/include/shared/ptrace_user.h
index 56b2f284b108..0f954eee8523 100644
--- a/arch/um/include/shared/ptrace_user.h
+++ b/arch/um/include/shared/ptrace_user.h
@@ -21,26 +21,6 @@ extern int ptrace_setregs(long pid, unsigned long *regs_in);
 #define PTRACE_SYSEMU_SINGLESTEP 32
 #endif
 
-/* On architectures, that started to support PTRACE_O_TRACESYSGOOD
- * in linux 2.4, there are two different definitions of
- * PTRACE_SETOPTIONS: linux 2.4 uses 21 while linux 2.6 uses 0x4200.
- * For binary compatibility, 2.6 also supports the old "21", named
- * PTRACE_OLDSETOPTION. On these architectures, UML always must use
- * "21", to ensure the kernel runs on 2.4 and 2.6 host without
- * recompilation. So, we use PTRACE_OLDSETOPTIONS in UML.
- * We also want to be able to build the kernel on 2.4, which doesn't
- * have PTRACE_OLDSETOPTIONS. So, if it is missing, we declare
- * PTRACE_OLDSETOPTIONS to be the same as PTRACE_SETOPTIONS.
- *
- * On architectures, that start to support PTRACE_O_TRACESYSGOOD on
- * linux 2.6, PTRACE_OLDSETOPTIONS never is defined, and also isn't
- * supported by the host kernel. In that case, our trick lets us use
- * the new 0x4200 with the name PTRACE_OLDSETOPTIONS.
- */
-#ifndef PTRACE_OLDSETOPTIONS
-#define PTRACE_OLDSETOPTIONS PTRACE_SETOPTIONS
-#endif
-
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 23025d645160..4bed32df0af6 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -283,10 +283,10 @@ int start_userspace(unsigned long stub_stack)
 		goto out_kill;
 	}
 
-	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL,
+	if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
-		printk(UM_KERN_ERR "start_userspace : PTRACE_OLDSETOPTIONS "
+		printk(UM_KERN_ERR "start_userspace : PTRACE_SETOPTIONS "
 		       "failed, errno = %d\n", errno);
 		goto out_kill;
 	}
@@ -501,10 +501,10 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 		goto out_kill;
 	}
 
-	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL,
+	if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
 		   (void *)PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
-		printk(UM_KERN_ERR "copy_context_skas0 : PTRACE_OLDSETOPTIONS "
+		printk(UM_KERN_ERR "copy_context_skas0 : PTRACE_SETOPTIONS "
 		       "failed, errno = %d\n", errno);
 		goto out_kill;
 	}
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 22a358ef1b0c..f96b0964e603 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -205,9 +205,9 @@ static void __init check_sysemu(void)
 	non_fatal("Checking advanced syscall emulation patch for ptrace...");
 	pid = start_ptraced_child();
 
-	if ((ptrace(PTRACE_OLDSETOPTIONS, pid, 0,
+	if ((ptrace(PTRACE_SETOPTIONS, pid, 0,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0))
-		fatal_perror("check_sysemu: PTRACE_OLDSETOPTIONS failed");
+		fatal_perror("check_sysemu: PTRACE_SETOPTIONS failed");
 
 	while (1) {
 		count++;
@@ -263,9 +263,9 @@ static void __init check_ptrace(void)
 	non_fatal("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child();
 
-	if ((ptrace(PTRACE_OLDSETOPTIONS, pid, 0,
+	if ((ptrace(PTRACE_SETOPTIONS, pid, 0,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0))
-		fatal_perror("check_ptrace: PTRACE_OLDSETOPTIONS failed");
+		fatal_perror("check_ptrace: PTRACE_SETOPTIONS failed");
 
 	while (1) {
 		if (ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
-- 
2.12.0


--------------73027EAA296B5E597BAADD54
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--------------73027EAA296B5E597BAADD54
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------73027EAA296B5E597BAADD54--


