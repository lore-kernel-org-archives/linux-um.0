Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360B6CAC5A5
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sC8Bv+IHsX6wUs//ST+Kb4J52aBiV724ykUwuhZDdgY=; b=vtTpYmf2WPTkWqMa+1WNaSaN5b
	JgzRkF8STzj+fIV03fYN0/txPO00080WVNbsUnmSiTxc9o8+aTe9h3K+ZsFDTWTbtIMhMqT7/lukO
	ugwnvLPbEYXrvv323XCgpKMYK7gC+2Wb+lTDEbNEx4mf68n70SB56O1ozOy3yXxKWcXcx21iOtZsC
	H0ywaoXEtJlaZOim7CLEwBQt6N4IqcxhKm4mbssRW7T/fxQOTL2F3lPfj43UqeKO2GZ7rSi176Db8
	y/qyGHkJEawb907+b6FeKJyalWWuPWcmckskfUJd1yWbQ37IX6YxvcKP8gX+G+uJ6q90ivUn2qQS3
	aBHkKQVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNn-00000000bB0-48Tb;
	Wed, 24 Sep 2025 14:22:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNl-00000000b6m-1iQe
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 14:22:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sC8Bv+IHsX6wUs//ST+Kb4J52aBiV724ykUwuhZDdgY=;
	t=1758723729; x=1759933329; b=k3dfII3oHaIpu+3UbZNNAaJKHJ65c7q3QQpC4C0jp5YB/e4
	2wJ+0XaQNixrEAk5SwnPWy0XdEiue5FwYZvSMeH/844KNpd+jcANpdou2IfXCbkA22Nb6Xpfrhs45
	543GlPsSLQBlYhnbDEhQ1TEnEEX9oK2tuAf+84HiN7Cq4mQ8Ho6qoIOrie1HnyYie4+cSYKGOOof0
	nv+dX02TO0Y7hKKa5zUx/f+Ux/pF/S292IxtTG2jEBPjq0ASLsbs7NvltGi15vghnWXhX4CfdmN0n
	MuKEUJyI/g6AAZmFTT3wUYbNkyvcqEJej0jlOp0RxiL2JzgXEU3UjL36tCl/S1lw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNi-000000090Bz-1RrK;
	Wed, 24 Sep 2025 16:22:07 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 12/12] um: switch ptrace FP register access to nolibc
Date: Wed, 24 Sep 2025 16:20:59 +0200
Message-ID: <20250924142059.527768-13-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_072209_471092_21719B5F 
X-CRM114-Status: GOOD (  12.60  )
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

The registers.c file only contains the routines for floating point
register access in ptrace mode and initial size detection. After the
addition of sys/uio.h and sys/ptrace.h to nolibc it can be moved to use
it by using the sys_ptrace() wrapper.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---
v3:
- Cast argument to (void *)
- Remove unused sys/user.h include which does not exist in nolibc

v2:
- Use new sys_ptrace from nolibc
---
 arch/x86/um/os-Linux/Makefile    |  5 ++++-
 arch/x86/um/os-Linux/registers.c | 20 +++++---------------
 2 files changed, 9 insertions(+), 16 deletions(-)

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
index eb1cdadc8a61..72c7493f3b89 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -7,9 +7,6 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <sys/ptrace.h>
-#ifdef __i386__
-#include <sys/user.h>
-#endif
 #include <longjmp.h>
 #include <sysdep/ptrace_user.h>
 #include <sys/uio.h>
@@ -28,9 +25,7 @@ int get_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return sys_ptrace(PTRACE_GETREGSET, pid, (void *)ptrace_regset, &iov);
 }
 
 int put_fp_registers(int pid, unsigned long *regs)
@@ -40,9 +35,7 @@ int put_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return sys_ptrace(PTRACE_SETREGSET, pid, (void *)ptrace_regset, &iov);
 }
 
 int arch_init_registers(int pid)
@@ -60,9 +53,7 @@ int arch_init_registers(int pid)
 
 	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
 	ptrace_regset = NT_X86_XSTATE;
-	ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-	if (ret)
-		ret = -errno;
+	ret = sys_ptrace(PTRACE_GETREGSET, pid, (void *)ptrace_regset, &iov);
 
 	if (ret == -ENODEV) {
 #ifdef CONFIG_X86_32
@@ -71,9 +62,8 @@ int arch_init_registers(int pid)
 		ptrace_regset = NT_PRFPREG;
 #endif
 		iov.iov_len = 2 * 1024 * 1024;
-		ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-		if (ret)
-			ret = -errno;
+		ret = sys_ptrace(PTRACE_GETREGSET, pid,
+				 (void *)ptrace_regset, &iov);
 	}
 
 	munmap(iov.iov_base, 2 * 1024 * 1024);
-- 
2.51.0


