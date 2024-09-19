Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75500CE8D7D
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0v9y1nB2nSzAuNofLcdX0gaie2kB6xeUib6JuhcrpQ=; b=v81js50Usbd3T0OnP6QVHxpfQw
	sZZB34pB8sqhexKboLx2aWLjYwGY/6rRkuMAFZ+p3jh/F9qjnD/fUodKbwjfZiB8DWH3PzdEXEiog
	mBKMCkxtbXJFR6ZvAgW1pbJR9BXWrw6S1NjYg40/iI6X2z/asfNhUl27b28oS438HhVrEgkZ1PBK8
	Q2EYnwIvIWSA5JliWUyU7MclrZVbOyd01ZmxjJlAPylfb4ScAjFCppRmdKyp8ZAHhApXUqmQF+Ed2
	K3gELKfcXmUB1t2XR24s2ZOgzMjDb7dyotxttDNprpN2tZlbZz0NrAQo/RQaQpqlbxyWInkkyYvHi
	0qWbWBhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXh-0000000AGvK-0XUP;
	Thu, 19 Sep 2024 12:45:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXd-0000000AGsj-2ooT
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:45:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=l0v9y1nB2nSzAuNofLcdX0gaie2kB6xeUib6JuhcrpQ=;
	t=1726749949; x=1727959549; b=OyVxFC0jfjjfhuu6eDOPdB8fwrvlGtcFt0NT9clB2lK8H8O
	Twa0+BU+dtfjfMU07R+vjJ5YGpSdyxq1tgCDJE50tE7JBbmZujo2+IDeOg2HloVSugTekge/KZ3RL
	GaQUn532DXFeu423+jfcvk16DeUhhQl79CRyEKvySI1h7c2CUpcY6lvBCHlUoN6mbbC0XRRTk7hTQ
	A49lVXEdO9u8ALoz6EHY/qMeNHL15jO/0Wa+Xb1aaoaWiEByYHn7pSWr9NfBjylkA7LdxKRolR0bt
	dVS2JkGa7J7TiPA3VUrdEb+8Jx2AQzeuGWTi3YwrjQINfjQNX/Ym8DnztvspQRtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srGXb-000000047AZ-0dMB;
	Thu, 19 Sep 2024 14:45:47 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v9 08/10] um: Discover host_task_size from envp
Date: Thu, 19 Sep 2024 14:45:09 +0200
Message-ID: <20240919124511.282088-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919124511.282088-1-benjamin@sipsolutions.net>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_054549_930904_DD542774 
X-CRM114-Status: GOOD (  33.49  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

When loading the UML binary, the host kernel will place the stack at the
highest possible address. It will then map the program name and
environment variables onto the start of the stack.

As such, an easy way to figure out the host_task_size is to use the
highest pointer to an environment variable as a reference.

Ensure that this works by disabling address layout randomization and
re-executing UML in case it was enabled.

This increases the available TASK_SIZE for 64 bit UML considerably.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v9: Move the implementation as it is architecture independent now
v7: Also use the same logic on 32bit
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/as-layout.h |   2 +-
 arch/um/include/shared/os.h        |   3 -
 arch/um/kernel/um_arch.c           |  21 +++-
 arch/um/os-Linux/main.c            |   9 +-
 arch/x86/um/os-Linux/Makefile      |   2 +-
 arch/x86/um/os-Linux/task_size.c   | 151 -----------------------------
 6 files changed, 29 insertions(+), 159 deletions(-)
 delete mode 100644 arch/x86/um/os-Linux/task_size.c

diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index 06292fca5a4d..b69cb8dcfeed 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -48,7 +48,7 @@ extern unsigned long brk_start;
 extern unsigned long host_task_size;
 extern unsigned long stub_start;
 
-extern int linux_main(int argc, char **argv);
+extern int linux_main(int argc, char **argv, char **envp);
 extern void uml_finishsetup(void);
 
 struct siginfo;
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 9a039d6f1f74..73b5fe1542d2 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -329,9 +329,6 @@ extern int __ignore_sigio_fd(int fd);
 /* tty.c */
 extern int get_pty(void);
 
-/* sys-$ARCH/task_size.c */
-extern unsigned long os_get_top_address(void);
-
 long syscall(long number, ...);
 
 /* irqflags tracing */
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 6f0bedbf048a..285aa6fed188 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -302,7 +302,24 @@ static void parse_cache_line(char *line)
 	}
 }
 
-int __init linux_main(int argc, char **argv)
+static unsigned long get_top_address(char **envp)
+{
+	unsigned long top_addr = (unsigned long) &top_addr;
+	int i;
+
+	/* The earliest variable should be after the program name in ELF */
+	for (i = 0; envp[i]; i++) {
+		if ((unsigned long) envp[i] > top_addr)
+			top_addr = (unsigned long) envp[i];
+	}
+
+	top_addr &= ~(UM_KERN_PAGE_SIZE - 1);
+	top_addr += UM_KERN_PAGE_SIZE;
+
+	return top_addr;
+}
+
+int __init linux_main(int argc, char **argv, char **envp)
 {
 	unsigned long avail, diff;
 	unsigned long virtmem_size, max_physmem;
@@ -324,7 +341,7 @@ int __init linux_main(int argc, char **argv)
 	if (have_console == 0)
 		add_arg(DEFAULT_COMMAND_LINE_CONSOLE);
 
-	host_task_size = os_get_top_address();
+	host_task_size = get_top_address(envp);
 	/* reserve a few pages for the stubs */
 	stub_start = host_task_size - STUB_DATA_PAGES * PAGE_SIZE;
 	/* another page for the code portion */
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index f98ff79cdbf7..9a61b1767795 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -11,6 +11,7 @@
 #include <signal.h>
 #include <string.h>
 #include <sys/resource.h>
+#include <sys/personality.h>
 #include <as-layout.h>
 #include <init.h>
 #include <kern_util.h>
@@ -108,6 +109,12 @@ int __init main(int argc, char **argv, char **envp)
 	char **new_argv;
 	int ret, i, err;
 
+	/* Disable randomization and re-exec if it was changed successfully */
+	ret = personality(PER_LINUX | ADDR_NO_RANDOMIZE);
+	if (ret >= 0 && (ret & (PER_LINUX | ADDR_NO_RANDOMIZE)) !=
+			 (PER_LINUX | ADDR_NO_RANDOMIZE))
+		execve("/proc/self/exe", argv, envp);
+
 	set_stklim();
 
 	setup_env_path();
@@ -140,7 +147,7 @@ int __init main(int argc, char **argv, char **envp)
 #endif
 
 	change_sig(SIGPIPE, 0);
-	ret = linux_main(argc, argv);
+	ret = linux_main(argc, argv, envp);
 
 	/*
 	 * Disable SIGPROF - I have no idea why libc doesn't do this or turn
diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
index 5249bbc30dcd..77a308aaa5ec 100644
--- a/arch/x86/um/os-Linux/Makefile
+++ b/arch/x86/um/os-Linux/Makefile
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-obj-y = registers.o task_size.o mcontext.o
+obj-y = registers.o mcontext.o
 
 obj-$(CONFIG_X86_32) += tls.o
 
diff --git a/arch/x86/um/os-Linux/task_size.c b/arch/x86/um/os-Linux/task_size.c
deleted file mode 100644
index 1dc9adc20b1c..000000000000
--- a/arch/x86/um/os-Linux/task_size.c
+++ /dev/null
@@ -1,151 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <sys/mman.h>
-#include <longjmp.h>
-
-#ifdef __i386__
-
-static jmp_buf buf;
-
-static void segfault(int sig)
-{
-	longjmp(buf, 1);
-}
-
-static int page_ok(unsigned long page)
-{
-	unsigned long *address = (unsigned long *) (page << UM_KERN_PAGE_SHIFT);
-	unsigned long n = ~0UL;
-	void *mapped = NULL;
-	int ok = 0;
-
-	/*
-	 * First see if the page is readable.  If it is, it may still
-	 * be a VDSO, so we go on to see if it's writable.  If not
-	 * then try mapping memory there.  If that fails, then we're
-	 * still in the kernel area.  As a sanity check, we'll fail if
-	 * the mmap succeeds, but gives us an address different from
-	 * what we wanted.
-	 */
-	if (setjmp(buf) == 0)
-		n = *address;
-	else {
-		mapped = mmap(address, UM_KERN_PAGE_SIZE,
-			      PROT_READ | PROT_WRITE,
-			      MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-		if (mapped == MAP_FAILED)
-			return 0;
-		if (mapped != address)
-			goto out;
-	}
-
-	/*
-	 * Now, is it writeable?  If so, then we're in user address
-	 * space.  If not, then try mprotecting it and try the write
-	 * again.
-	 */
-	if (setjmp(buf) == 0) {
-		*address = n;
-		ok = 1;
-		goto out;
-	} else if (mprotect(address, UM_KERN_PAGE_SIZE,
-			    PROT_READ | PROT_WRITE) != 0)
-		goto out;
-
-	if (setjmp(buf) == 0) {
-		*address = n;
-		ok = 1;
-	}
-
- out:
-	if (mapped != NULL)
-		munmap(mapped, UM_KERN_PAGE_SIZE);
-	return ok;
-}
-
-unsigned long os_get_top_address(void)
-{
-	struct sigaction sa, old;
-	unsigned long bottom = 0;
-	/*
-	 * A 32-bit UML on a 64-bit host gets confused about the VDSO at
-	 * 0xffffe000.  It is mapped, is readable, can be reprotected writeable
-	 * and written.  However, exec discovers later that it can't be
-	 * unmapped.  So, just set the highest address to be checked to just
-	 * below it.  This might waste some address space on 4G/4G 32-bit
-	 * hosts, but shouldn't hurt otherwise.
-	 */
-	unsigned long top = 0xffffd000 >> UM_KERN_PAGE_SHIFT;
-	unsigned long test, original;
-
-	printf("Locating the bottom of the address space ... ");
-	fflush(stdout);
-
-	/*
-	 * We're going to be longjmping out of the signal handler, so
-	 * SA_DEFER needs to be set.
-	 */
-	sa.sa_handler = segfault;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_NODEFER;
-	if (sigaction(SIGSEGV, &sa, &old)) {
-		perror("os_get_top_address");
-		exit(1);
-	}
-
-	/* Manually scan the address space, bottom-up, until we find
-	 * the first valid page (or run out of them).
-	 */
-	for (bottom = 0; bottom < top; bottom++) {
-		if (page_ok(bottom))
-			break;
-	}
-
-	/* If we've got this far, we ran out of pages. */
-	if (bottom == top) {
-		fprintf(stderr, "Unable to determine bottom of address "
-			"space.\n");
-		exit(1);
-	}
-
-	printf("0x%lx\n", bottom << UM_KERN_PAGE_SHIFT);
-	printf("Locating the top of the address space ... ");
-	fflush(stdout);
-
-	original = bottom;
-
-	/* This could happen with a 4G/4G split */
-	if (page_ok(top))
-		goto out;
-
-	do {
-		test = bottom + (top - bottom) / 2;
-		if (page_ok(test))
-			bottom = test;
-		else
-			top = test;
-	} while (top - bottom > 1);
-
-out:
-	/* Restore the old SIGSEGV handling */
-	if (sigaction(SIGSEGV, &old, NULL)) {
-		perror("os_get_top_address");
-		exit(1);
-	}
-	top <<= UM_KERN_PAGE_SHIFT;
-	printf("0x%lx\n", top);
-
-	return top;
-}
-
-#else
-
-unsigned long os_get_top_address(void)
-{
-	/* The old value of CONFIG_TOP_ADDR */
-	return 0x7fc0002000;
-}
-
-#endif
-- 
2.46.0


