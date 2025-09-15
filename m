Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E88CAC594
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EzGYOyHyBK8XRCpIi1QlHK5VKphrWANC8ROrsS0E19Q=; b=AF8mECEyZya+V7Ey5Pdj70vHUY
	xOIMtHOoLn30/8Cpa6hrNtODsUkfT9G7+M115tYg/eMlPqwPCV5OlknFPp4j6rutLjzfnKQPGmZWW
	UAUp5C/RTEGJAJY0ffRP8reH4swHCljEKtz0leSxxJGVgZRMfsO6+xUf94//OLcm7wUqkbvNWLTw6
	ZFJY0CfRVGig1QztAsfFLIcXgN+jYG7XSetW+P+sm7NHeZPVa75UysPyMW6GjHxP9qnQHMI3WVCk3
	Ca06slOVEop3naSuhzliay626pHDOc8YXgBwGWLHyVNlTrVyjqtKSRXxSbaLorh4+c2FtzT+te5W5
	dUyvgd6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XT-000000031uP-2xYS;
	Mon, 15 Sep 2025 07:22:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XR-000000031pU-0DRI
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:22:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EzGYOyHyBK8XRCpIi1QlHK5VKphrWANC8ROrsS0E19Q=;
	t=1757920932; x=1759130532; b=RsKNS3GH7PccjG1xJpJKvhlmcg5NYmdgd+m/0Yb8q9nio8S
	JyCehY4mZS4GbTPbowtQoWW7EBYH/6WHmbt1Udqe59Sj12KltMs/8T2JVrBOOyvaAU/aJP8eUN4gP
	ykj8/LgARBuUjnufjd1QuU/Pf+qxtRcjl5T47EgCSyQyeTlV5ubhVGZdISZXxnVyCUCD0a66pm1/Z
	b79eEJnzExjc1FA/7hHZIUKHAmlQ8XI5Zk3QVHWmfd2wwRWyKy/XQOhxkedpUWTgQmJ+/NXdQT8PR
	QlUQV8gOzOxX9J+iadStfpo+Qb2yDG5ZaGuSzFUSirXcguwUqSGy8M1FGkUeorcw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XO-00000005w6o-0YuW;
	Mon, 15 Sep 2025 09:22:10 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 9/9] um: switch ptrace FP register access to nolibc
Date: Mon, 15 Sep 2025 09:11:15 +0200
Message-ID: <20250915071115.1429196-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_002213_097591_BD7CA76B 
X-CRM114-Status: GOOD (  11.53  )
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

The registers.c file only contain the routines for floating point
register access in ptrace mode and initial size detection. The file can
be moved over to nolibc by replacing the ptrace libc call with a simple
wrapper that does a direct syscall.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/os-Linux/Makefile    |  5 ++++-
 arch/x86/um/os-Linux/registers.c | 22 ++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
index 77a308aaa5ec..d37320430822 100644
--- a/arch/x86/um/os-Linux/Makefile
+++ b/arch/x86/um/os-Linux/Makefile
@@ -3,10 +3,13 @@
 # Licensed under the GPL
 #
 
-obj-y = registers.o mcontext.o
+obj-y = mcontext.o
 
 obj-$(CONFIG_X86_32) += tls.o
 
 USER_OBJS := $(obj-y)
 
+obj-y += registers.o
+NOLIBC_OBJS := registers.o
+
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index eb1cdadc8a61..55bce0d3f5d2 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -6,18 +6,20 @@
 
 #include <errno.h>
 #include <stdlib.h>
-#include <sys/ptrace.h>
+#include <linux/ptrace.h>
 #ifdef __i386__
 #include <sys/user.h>
 #endif
 #include <longjmp.h>
 #include <sysdep/ptrace_user.h>
-#include <sys/uio.h>
+#include <linux/uio.h>
 #include <asm/sigcontext.h>
 #include <linux/elf.h>
 #include <registers.h>
 #include <sys/mman.h>
 
+#define my_ptrace(...) my_syscall4(__NR_ptrace, __VA_ARGS__)
+
 static unsigned long ptrace_regset;
 unsigned long host_fp_size;
 
@@ -28,9 +30,7 @@ int get_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return my_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 }
 
 int put_fp_registers(int pid, unsigned long *regs)
@@ -40,9 +40,7 @@ int put_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return my_ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov);
 }
 
 int arch_init_registers(int pid)
@@ -60,9 +58,7 @@ int arch_init_registers(int pid)
 
 	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
 	ptrace_regset = NT_X86_XSTATE;
-	ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-	if (ret)
-		ret = -errno;
+	ret = my_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 
 	if (ret == -ENODEV) {
 #ifdef CONFIG_X86_32
@@ -71,9 +67,7 @@ int arch_init_registers(int pid)
 		ptrace_regset = NT_PRFPREG;
 #endif
 		iov.iov_len = 2 * 1024 * 1024;
-		ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-		if (ret)
-			ret = -errno;
+		ret = my_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 	}
 
 	munmap(iov.iov_base, 2 * 1024 * 1024);
-- 
2.51.0


