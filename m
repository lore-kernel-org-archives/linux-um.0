Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYMUc-0002AK-DJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 07:59:32 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KYMUa-0001p3-O2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 07:59:30 -0700
Date: Wed, 27 Aug 2008 10:59:09 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080827145909.GA9308@c2.user-mode-linux.org>
References: <48995D1A.6030203@meduna.org> <489AC525.3060305@meduna.org>
	<489AE6DD.2000200@meduna.org> <489C3D9B.7070605@meduna.org>
	<20080825215124.GB12626@c2.user-mode-linux.org>
	<48B3AED8.5040904@meduna.org>
	<20080826174600.GA24342@c2.user-mode-linux.org>
	<48B44658.8010403@meduna.org>
	<20080826184425.GA18462@c2.user-mode-linux.org>
	<48B450C7.9090906@meduna.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48B450C7.9090906@meduna.org>
Subject: Re: [uml-devel] FP registers corruption
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
To: Stanislav Meduna <stano@meduna.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Aug 26, 2008 at 08:51:51PM +0200, Stanislav Meduna wrote:
>> You can work around this by putting a 0 into /proc/sys/vm/mmap_min_addr.
>
> Permission denied here - looks quite hard readonly on this kernel
> even for root.

Hmmm.  The actual fix is below,

       	   	      	 Jeff

-- 
Work email - jdike at linux dot intel dot com


commit 40fb16a360d9c6459afee91dc793c1e3374feb94
Author: Tom Spink <tspink@gmail.com>
Date:   Thu Jun 5 22:46:12 2008 -0700

    uml: deal with inaccessible address space start
    
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

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index e2716ac..db5be46 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -299,6 +299,6 @@ extern int os_arch_prctl(int pid, int code, unsigned long *addr);
 extern int get_pty(void);
 
 /* sys-$ARCH/task_size.c */
-extern unsigned long os_get_task_size(void);
+extern unsigned long os_get_top_address(void);
 
 #endif
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 9db85b2..8d84250 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -274,7 +274,7 @@ int __init linux_main(int argc, char **argv)
 	if (have_root == 0)
 		add_arg(DEFAULT_COMMAND_LINE);
 
-	host_task_size = os_get_task_size();
+	host_task_size = os_get_top_address();
 	/*
 	 * TASK_SIZE needs to be PGDIR_SIZE aligned or else exit_mmap craps
 	 * out
diff --git a/arch/um/os-Linux/sys-i386/task_size.c b/arch/um/os-Linux/sys-i386/task_size.c
index ccb49b0..be04c1e 100644
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
@@ -89,16 +89,31 @@ unsigned long os_get_task_size(void)
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags = SA_NODEFER;
 	if (sigaction(SIGSEGV, &sa, &old)) {
-		perror("os_get_task_size");
+		perror("os_get_top_address");
 		exit(1);
 	}
 
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
@@ -114,7 +129,7 @@ unsigned long os_get_task_size(void)
 out:
 	/* Restore the old SIGSEGV handling */
 	if (sigaction(SIGSEGV, &old, NULL)) {
-		perror("os_get_task_size");
+		perror("os_get_top_address");
 		exit(1);
 	}
 	top <<= UM_KERN_PAGE_SHIFT;
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

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
