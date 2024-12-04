Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FA7E7716B
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 07:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eDOWzPW77P+88CGz0zcKpG8Ux5VUjQw+tO7bYBZ27YQ=; b=xhHYGD2il4WiyXASLU4+JnhM7j
	S3ttuRUWRiBqFhFgqlgUUvw6ZBjoBqGH8J9TbbplFrubiQ/86pN6r3adl3JHTyPbbgR/RV5YjMxWb
	+3CXA8pXdCGXyVqxkuRhI80qubYnzaBkW8PN7JSLLKHqOIBkRE4c7OVW+I9i6Xu7FR2Pk5RjNpdQx
	QgJXY/TiaGq1UmFxJMXqF+/hKlP+OgpeaQ2XSKQzO2Yf4PKWcAnDdr2oTOvI1J25jFCIkDM2Eft/m
	hSQmkdsziwtZB0//0iYAoyrEL65Mvv1JopfzkVD369y/bWc/gWk4CjPIRVo5MLKyOpSKLu5guOEWt
	AfNfEzzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIk7n-0000000BmFn-1fxt;
	Wed, 04 Dec 2024 07:48:43 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIk7k-0000000BmDn-1egX
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 07:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=eDOWzPW77P+88CGz0zcKpG8Ux5VUjQw+tO7bYBZ27YQ=; t=1733298519; x=1734508119; 
	b=Vse6WAQJh1ueYfVpfQpS7A/50G10+CBZTqajo5JdPD0xT3f17fbJc3Emcpggw1owZHkbW3tm5Ii
	R26uyuhA9pjV66HGTTvxdGRDiirRhQbBtgYfz3NWhoGPe80DsM3TB7bSmNOXJJjj/iGAPJyjF72dt
	zR/bon/m2HZE7E486jTpq1PPDqoQBP1H0FHotk/Oid1vGDydVp3bY9vPAxGHw7fB6aBrRFVP/aeRo
	rVWXdC/6thypF50wI+luXi/wya7MOX7A7w36osHm/kc5Lk4IlHmFO7sZymZbUuZ8B78bjLo54nG8H
	3FbzPi4QVnaFkLIcP1o4WpFIQZn/QtJrEmfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tIk7g-00000005YZQ-1KeS;
	Wed, 04 Dec 2024 08:48:36 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH] um: add back support for FXSAVE registers
Date: Wed,  4 Dec 2024 08:48:27 +0100
Message-ID: <20241204074827.1582917-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_234840_441127_D1C437C2 
X-CRM114-Status: GOOD (  17.33  )
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

It was reported that qemu may not enable the XSTATE CPU extension, which
is a requirement after commit 3f17fed21491 ("um: switch to regset API
and depend on XSTATE"). Add a fallback to use FXSAVE (FP registers on
x86_64 and XFP on i386) which is just a shorter version of the same
data. The only difference is that the XSTATE magic should not be set in
the signal frame.

Note that this still drops support for the older i386 FP register layout
as supporting this would require more backward compatibility to build a
correct signal frame.

Fixes: 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
Reported-by: SeongJae Park <sj@kernel.org>
Closes: https://lore.kernel.org/r/20241203070218.240797-1-sj@kernel.org
Tested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/os-Linux/registers.c | 21 ++++++++++++++++++---
 arch/x86/um/signal.c             |  5 +++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index 76eaeb93928c..eb1cdadc8a61 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -18,6 +18,7 @@
 #include <registers.h>
 #include <sys/mman.h>
 
+static unsigned long ptrace_regset;
 unsigned long host_fp_size;
 
 int get_fp_registers(int pid, unsigned long *regs)
@@ -27,7 +28,7 @@ int get_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
+	if (ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov) < 0)
 		return -errno;
 	return 0;
 }
@@ -39,7 +40,7 @@ int put_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
+	if (ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov) < 0)
 		return -errno;
 	return 0;
 }
@@ -58,9 +59,23 @@ int arch_init_registers(int pid)
 		return -ENOMEM;
 
 	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
-	ret = ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov);
+	ptrace_regset = NT_X86_XSTATE;
+	ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 	if (ret)
 		ret = -errno;
+
+	if (ret == -ENODEV) {
+#ifdef CONFIG_X86_32
+		ptrace_regset = NT_PRXFPREG;
+#else
+		ptrace_regset = NT_PRFPREG;
+#endif
+		iov.iov_len = 2 * 1024 * 1024;
+		ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
+		if (ret)
+			ret = -errno;
+	}
+
 	munmap(iov.iov_base, 2 * 1024 * 1024);
 
 	host_fp_size = iov.iov_len;
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 75087e85b6fd..ea5b3bcc4245 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -187,7 +187,12 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 	 * Put magic/size values for userspace. We do not bother to verify them
 	 * later on, however, userspace needs them should it try to read the
 	 * XSTATE data. And ptrace does not fill in these parts.
+	 *
+	 * Skip this if we do not have an XSTATE frame.
 	 */
+	if (host_fp_size <= sizeof(to_fp64->fpstate))
+		return 0;
+
 	BUILD_BUG_ON(sizeof(int) != FP_XSTATE_MAGIC2_SIZE);
 #ifdef CONFIG_X86_32
 	__put_user(offsetof(struct _fpstate_32, _fxsr_env) +
-- 
2.47.1


