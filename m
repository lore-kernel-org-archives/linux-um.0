Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD29C44531
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 18:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QrJKKq615eowMNiqBOwZgz2tTG/RnnXjRQ9K3pWGHbY=; b=C0j4xM+kWUaLNk8IhLeq8vYM5I
	cHiNCiwvqHIsREHgmAZU1gSDTTYbEnJXH4S1Q2/X9HqQ9ZF7Y/HZoIB1ObCv50ye5QMtCNGUg06ns
	wFJppgxWhWpoUMdox1jE0ZctNryjq6DQ/fR5qaEpDo0mniYgvk25eHcPF3OjcOJXbOEUT5y45qHAu
	CGaoIf54gXOIwM5aeG+O1k4yA/pJFlEUX/SoZVzbPgdj3xJWoCPcYXsqm65jsqyDA/N2FPOlwcFzi
	D9C63HcMuoEEcHHk0rJugrMIKD69vR9NSt5z7mPAJt4qvdDreVPjWLI7USGDat1/9Dr2J7asUvZWR
	w4HUzuAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt5I-00000007h8m-1rSP;
	Mon, 20 Jul 2026 18:51:24 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt5A-00000007h19-1kOC
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 18:51:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QrJKKq615eowMNiqBOwZgz2tTG/RnnXjRQ9K3pWGHbY=;
	t=1784573476; x=1785783076; b=mlRMxeZlA4FdoLhLMc0j9fhNW8au9p+684WnEFgkFrF8kd6
	ZFjN4fPcYrKAEcUcRnuL4al/vZHwCbAuqhE/X9n6oMmPbWejxk91e2zEQsc5iAzCGy+/z/WRvPIPc
	agk4PHiwwoW4b23kHxdaRRxuOof6qJDOCEGz25C2ZWy+FDn/xpF2L+JVTwtb7h1JyHlQVjIClM8Ph
	cPg5jAKRd0nBBxAsDWgBKPuOdjPr5PcwIdsvJ4RxJt1KDqu382OV7ZgQ5RhhPHCkP3aSpymcnJDHS
	SRJgfoV6Nc2vHMKmd0ZSwN/EifflZb3JCthU1aR4JmYTUoXrP/9c0oPN2kdulv1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wlt58-0000000GsPP-1PYP;
	Mon, 20 Jul 2026 20:51:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 9/9] um: nommu: plug nommu code into build system
Date: Mon, 20 Jul 2026 20:26:59 +0200
Message-ID: <20260720185103.530603-17-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720185103.530603-11-johannes@sipsolutions.net>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_115116_454707_AC9500EE 
X-CRM114-Status: UNSURE (   8.41  )
X-CRM114-Notice: Please train this message.
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

From: Hajime Tazaki <thehajime@gmail.com>

Add nommu kernel for um build.  defconfig is also provided.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
Link: https://patch.msgid.link/d6057e2fb8584671e259fbc2d94959e2b04117db.1770170302.git.thehajime@gmail.com
[drop defconfig file, minor adjustments/fixes]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index d9541d13d9eb..d17bcdd200c4 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -17,9 +17,9 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_HAS_STRICT_KERNEL_RWX
+	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
 	select HAVE_ARCH_AUDITSYSCALL
-	select HAVE_ARCH_KASAN if X86_64
+	select HAVE_ARCH_KASAN if X86_64 && MMU
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ASM_MODVERSIONS
@@ -37,18 +37,23 @@ config UML
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
-	select HAVE_ARCH_VMAP_STACK
+	select HAVE_ARCH_VMAP_STACK if MMU
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
 	select SPARSE_IRQ
-	select MMU_GATHER_RCU_TABLE_FREE
+	select MMU_GATHER_RCU_TABLE_FREE if MMU
+	select UACCESS_MEMCPY if !MMU
+	select GENERIC_STRNLEN_USER if !MMU
+	select GENERIC_STRNCPY_FROM_USER if !MMU
 
 config MMU
-	bool
+	bool "MMU support"
 	default y
+	help
+	  Turning this off allows a nommu build, say Y.
 
 config UML_DMA_EMULATION
 	bool
@@ -229,8 +234,15 @@ config MAGIC_SYSRQ
 	  The keys are documented in <file:Documentation/admin-guide/sysrq.rst>. Don't say Y
 	  unless you really know what this hack does.
 
+config ARCH_FORCE_MAX_ORDER
+	int "Order of maximal physically contiguous allocations" if EXPERT
+	default "10" if MMU
+	default "16" if !MMU
+
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
+	default 3 if !MMU
+	range 3 10 if !MMU
 	default 2 if 64BIT
 	range 2 10 if 64BIT
 	default 1 if !64BIT
-- 
2.53.0


