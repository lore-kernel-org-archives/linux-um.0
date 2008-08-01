Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KP3Jf-0004i9-QX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 15:41:43 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KP3Jd-0001n9-6m
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 15:41:43 -0700
Date: Fri, 1 Aug 2008 18:41:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080801224128.GA13723@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 7/14] uml: deal with inaccessible address space
	start
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: stable@kernel.org
Cc: Tom Spink <tspink@gmail.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From b66c2383ac68f28dc4a463045dac03e3aaea3e40 Mon Sep 17 00:00:00 2001
From: Tom Spink <tspink@gmail.com>

This patch makes os_get_task_size locate the bottom of the address space,
as well as the top.  This is for systems which put a lower limit on mmap
addresses.  It works by manually scanning pages from zero onwards until a
valid page is found.

Because the bottom of the address space may not be zero, it's not
sufficient to assume the top of the address space is the size of the
address space.  The size is the difference between the top address and
bottom address.

[jdike@addtoit.com: changed the name to reflect that this function is
supposed to return the top of the process address space, not its size and
changed the return value to reflect that.  Also some minor formatting
changes]
Signed-off-by: Tom Spink <tspink@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/um/include/os.h                    |    2 +-
 arch/um/kernel/um_arch.c                |    2 +-
 arch/um/os-Linux/sys-i386/task_size.c   |   38 +++++++++++++++++++++++-------
 arch/um/os-Linux/sys-x86_64/task_size.c |    2 +-
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index 32c799e..2d0a2a6 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -298,6 +298,6 @@ extern int os_arch_prctl(int pid, int code, unsigned long *addr);
 extern int get_pty(void);
 
 /* sys-$ARCH/task_size.c */
-extern unsigned long os_get_task_size(void);
+extern unsigned long os_get_top_address(void);
 
 #endif
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 9cecb42..d1fe222 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -273,7 +273,7 @@ int __init linux_main(int argc, char **argv)
 	if (have_root == 0)
 		add_arg(DEFAULT_COMMAND_LINE);
 
-	host_task_size = os_get_task_size();
+	host_task_size = os_get_top_address();
 	/*
 	 * TASK_SIZE needs to be PGDIR_SIZE aligned or else exit_mmap craps
 	 * out
diff --git a/arch/um/os-Linux/sys-i386/task_size.c b/arch/um/os-Linux/sys-i386/task_size.c
index 48d211b..4d26d5d 100644
--- a/arch/um/os-Linux/sys-i386/task_size.c
+++ b/arch/um/os-Linux/sys-i386/task_size.c
@@ -63,7 +63,7 @@ static int page_ok(unsigned long page)
 	return ok;
 }
 
-unsigned long os_get_task_size(void)
+unsigned long os_get_top_address(void)
 {
 	struct sigaction sa, old;
 	unsigned long bottom = 0;
@@ -76,9 +76,9 @@ unsigned long os_get_task_size(void)
 	 * hosts, but shouldn't hurt otherwise.
 	 */
 	unsigned long top = 0xffffd000 >> UM_KERN_PAGE_SHIFT;
-	unsigned long test;
+	unsigned long test, original;
 
-	printf("Locating the top of the address space ... ");
+	printf("Locating the bottom of the address space ... ");
 	fflush(stdout);
 
 	/*
@@ -88,14 +88,32 @@ unsigned long os_get_task_size(void)
 	sa.sa_handler = segfault;
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags = SA_NODEFER;
-	sigaction(SIGSEGV, &sa, &old);
+	if (sigaction(SIGSEGV, &sa, &old)) {
+		perror("os_get_top_address");
+		exit(1);
+	}
 
-	if (!page_ok(bottom)) {
-		fprintf(stderr, "Address 0x%x no good?\n",
-			bottom << UM_KERN_PAGE_SHIFT);
+	/* Manually scan the address space, bottom-up, until we find
+	 * the first valid page (or run out of them).
+	 */
+	for (bottom = 0; bottom < top; bottom++) {
+		if (page_ok(bottom))
+			break;
+	}
+
+	/* If we've got this far, we ran out of pages. */
+	if (bottom == top) {
+		fprintf(stderr, "Unable to determine bottom of address "
+			"space.\n");
 		exit(1);
 	}
 
+	printf("0x%x\n", bottom << UM_KERN_PAGE_SHIFT);
+	printf("Locating the top of the address space ... ");
+	fflush(stdout);
+
+	original = bottom;
+
 	/* This could happen with a 4G/4G split */
 	if (page_ok(top))
 		goto out;
@@ -110,8 +128,10 @@ unsigned long os_get_task_size(void)
 
 out:
 	/* Restore the old SIGSEGV handling */
-	sigaction(SIGSEGV, &old, NULL);
-
+	if (sigaction(SIGSEGV, &old, NULL)) {
+		perror("os_get_top_address");
+		exit(1);
+	}
 	top <<= UM_KERN_PAGE_SHIFT;
 	printf("0x%x\n", top);
 	fflush(stdout);
diff --git a/arch/um/os-Linux/sys-x86_64/task_size.c b/arch/um/os-Linux/sys-x86_64/task_size.c
index fad6f57..26a0dd1 100644
--- a/arch/um/os-Linux/sys-x86_64/task_size.c
+++ b/arch/um/os-Linux/sys-x86_64/task_size.c
@@ -1,4 +1,4 @@
-unsigned long os_get_task_size(unsigned long shift)
+unsigned long os_get_top_address(unsigned long shift)
 {
 	/* The old value of CONFIG_TOP_ADDR */
 	return 0x7fc0000000;
-- 
1.5.5.1


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
