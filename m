Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9722CAC59A
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xO+mVCdWx08eTZ/4OCDNFnsQTwYMKX45MEVddt3khI4=; b=jveijKhQ87aBQuJsIss7OY0Okr
	30loVDA3rBia041mt6xC79cIf6wQBFe+KxkB3bsZ8g/hVWKVL9BNs/RofUVfx/42uMjTuLNZ8FLcQ
	vfJOPVwq1t18euJJuniupU1tNeBgBdq2rvR97yduvAuiU+hynOgB2/BJV2sYnuQ3RiJfry3k8xNb0
	L1L4czJR4rCNGcAREt7fm3ej40R8bvwb45jJibw+xxVImEKRitSgqka7sYHZJ/rUboS38OphPk1Nz
	LmS83JOobE8Go47wvpZVeWwnhQSMHZbN2PfG//7mRHLUnJRGC4Q+npSqDOJV00k9NTY9o83eX9TOp
	EgGSsdvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9n-00000003MR6-2adL;
	Fri, 19 Sep 2025 15:36:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9l-00000003MOD-2nq8
	for linux-um@bombadil.infradead.org;
	Fri, 19 Sep 2025 15:36:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xO+mVCdWx08eTZ/4OCDNFnsQTwYMKX45MEVddt3khI4=; b=YaC/5xouyKV8EvadZkiS80mBBb
	RIkzk18XAr/yaNsnW3EgLTHq2NsGR9ogOP1AMXa3jRAb/DFAgLqOyc98IXBQgSkteaNTvEjYgTsF3
	35ahhlAwPRW/26wR5I1DooNntjTsfT2AcqYrdcXzLFkg/s/qv/4pEN0S3DkIIVPCO/IrbkcUhOSWA
	ZmLMRxfalpxoHcoeiMzlTrKIiQKDjmABRJlhD3MukNl5lZVBFBlZDJZFJrrzSHlnu0rKHpjZDLCxI
	H5akdvjS861hBn3uRGZTpklxE5Mdz6+mRdKsqScgC5wsfY3SO/6ftGyfDDqbyfHMIHorj8lFF6AmH
	jZbDjRtA==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9i-00000007rlN-2x6h
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 15:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xO+mVCdWx08eTZ/4OCDNFnsQTwYMKX45MEVddt3khI4=;
	t=1758296174; x=1759505774; b=nr8KFTL6KG0NeSaaA1RjVcpylPXty7+k3VmYftrA3yC1X8C
	x8GYuafkTmTzPnXOSfx2ZdI4VQnttiqRGmfO3hnC6PnF1432GJWyWpqihB938Uhzw+yJH2NwIPFSs
	67/UD+9Rf15wYOHnqZTprcXrKe8TIindg2eVP/vRIrgRiIVob7Vw2+zaW3NlAVCZWa0NUi+7FSrAo
	61vvV6EzO5CzEkBi0ZfDRcpZT3xa1CvcYlCAsK5MfdH26BQFak45lyw7r+T67uo3RUnmmNVC7xDVe
	EwcYqNeIeYNWBUfpPjRmkU/Bi9CBNe/CjmcXEw1NMN+9uRFRTm9BbhE6sfwCqdew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9f-0000000G6O6-44uB;
	Fri, 19 Sep 2025 17:36:12 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 11/11] um: switch ptrace FP register access to nolibc
Date: Fri, 19 Sep 2025 17:34:20 +0200
Message-ID: <20250919153420.727385-12-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_163614_957001_2A851413 
X-CRM114-Status: GOOD (  11.83  )
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
v2:
- Use new sys_ptrace from nolibc
---
 arch/x86/um/os-Linux/Makefile    |  5 ++++-
 arch/x86/um/os-Linux/registers.c | 16 ++++------------
 2 files changed, 8 insertions(+), 13 deletions(-)

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
index eb1cdadc8a61..e570e29c3d73 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -28,9 +28,7 @@ int get_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return sys_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 }
 
 int put_fp_registers(int pid, unsigned long *regs)
@@ -40,9 +38,7 @@ int put_fp_registers(int pid, unsigned long *regs)
 		.iov_len = host_fp_size,
 	};
 
-	if (ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov) < 0)
-		return -errno;
-	return 0;
+	return sys_ptrace(PTRACE_SETREGSET, pid, ptrace_regset, &iov);
 }
 
 int arch_init_registers(int pid)
@@ -60,9 +56,7 @@ int arch_init_registers(int pid)
 
 	/* GDB has x86_xsave_length, which uses x86_cpuid_count */
 	ptrace_regset = NT_X86_XSTATE;
-	ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-	if (ret)
-		ret = -errno;
+	ret = sys_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 
 	if (ret == -ENODEV) {
 #ifdef CONFIG_X86_32
@@ -71,9 +65,7 @@ int arch_init_registers(int pid)
 		ptrace_regset = NT_PRFPREG;
 #endif
 		iov.iov_len = 2 * 1024 * 1024;
-		ret = ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
-		if (ret)
-			ret = -errno;
+		ret = sys_ptrace(PTRACE_GETREGSET, pid, ptrace_regset, &iov);
 	}
 
 	munmap(iov.iov_base, 2 * 1024 * 1024);
-- 
2.51.0


