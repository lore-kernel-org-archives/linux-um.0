Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1751441AbZCHHYj@vger.kernel.org>
Date: Sun, 8 Mar 2009 15:24:43 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: [trivial Patch] uml: improve error messages
Message-ID: <20090308072443.GB30016@hack.private>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


These error messages are from check_sysemu(), not check_ptrace().

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>

---
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 183db26..02ee9ad 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -244,7 +244,7 @@ static void __init check_sysemu(void)
 
 	if ((ptrace(PTRACE_OLDSETOPTIONS, pid, 0,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0))
-		fatal_perror("check_ptrace: PTRACE_OLDSETOPTIONS failed");
+		fatal_perror("check_sysemu: PTRACE_OLDSETOPTIONS failed");
 
 	while (1) {
 		count++;
@@ -252,12 +252,12 @@ static void __init check_sysemu(void)
 			goto fail;
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 		if (n < 0)
-			fatal_perror("check_ptrace : wait failed");
+			fatal_perror("check_sysemu: wait failed");
 
 		if (WIFSTOPPED(status) &&
 		    (WSTOPSIG(status) == (SIGTRAP|0x80))) {
 			if (!count) {
-				non_fatal("check_ptrace : SYSEMU_SINGLESTEP "
+				non_fatal("check_sysemu: SYSEMU_SINGLESTEP "
 					  "doesn't singlestep");
 				goto fail;
 			}
@@ -271,7 +271,7 @@ static void __init check_sysemu(void)
 		else if (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP))
 			count++;
 		else {
-			non_fatal("check_ptrace : expected SIGTRAP or "
+			non_fatal("check_sysemu: expected SIGTRAP or "
 				  "(SIGTRAP | 0x80), got status = %d\n",
 				  status);
 			goto fail;

 
