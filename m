Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23715C531D3
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fK8AonQc9uyAZzxEq8nX0pqRZqtGsR5Oco6Dh8kc9zY=; b=jbLaLfWHDnHbw3eqeRSpJNFHDK
	fq4TlnSarFvSg21qRHUm89NHzjcRocSVINFjBLhBUl1xv3S6NtuKS5ZNJlGj0zAIivVyQNSCAjzxE
	vu0V2TJIe+XAzuv21HTR3qA7y5NcgfIDH1ATEoTtTLSz/QabkfaGgvdNqeC5ljZ26LwPZgWdzCy4g
	cabq/MnQ5AoOc84WmHqbssKqph7t/yEh64xRZUPIH/ZWXiIEwtUFAQlC9RK4ZdikcXvIdodOQkI1G
	wqK2PH2Mz8KnY6+jckvzrPPyApO19kGInAsJtPuvYCQuyay/rzQqDK5UcKy6aS8GH0W0nCuENTkTW
	BfKyAkdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprH-0000000Ds0k-3MNw;
	Thu, 23 Jul 2026 09:36:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprD-0000000DrrD-09Cr
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 09:36:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fK8AonQc9uyAZzxEq8nX0pqRZqtGsR5Oco6Dh8kc9zY=;
	t=1784799406; x=1786009006; b=hrb+QNybDGSEuJnIR3an3KVjmQAT6hlg5TCWb+ikED1JFv2
	yETkuxKrBHyqptdtShm4j7hK9D5dNQ/DE5Tb2PrHEAer+Qb+lApBurp9z4fNLinnq4AcE0LlkYdKq
	6RfvCJgqRPR6D0SIkqg97VgVbWzLfq3GTmCeMdHXslsOI/Kd/XawvPnT/n6UCILeJAmh+O6gqjFMi
	4Tv2BRq3Fm4aLW+oJbFHYSOshQRAOv/GsAzBsN+F7xDtKMrZq55dNbC8dS+Ucm7r/tEM1vDcw7JMh
	0cOOPj5iCz9MWjjgEUO6+SO6ODQ1PBbyt0utDutXrJzdg7YeziVRCxx1XG6yroMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmprA-0000000Aeqq-18Eu;
	Thu, 23 Jul 2026 11:36:44 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	liam@infradead.org,
	ljs@kernel.org,
	Ricardo Koller <ricarkol@google.com>
Subject: [PATCH v2 09/10] um: allow deselecting CONFIG_MMU
Date: Thu, 23 Jul 2026 11:35:50 +0200
Message-ID: <20260723113633.dc6b7df78016.Id9eb1e435a7d9ee75ec3e25db69ed3e8ff202a58@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723093633.140989-12-johannes@sipsolutions.net>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_023647_134985_DED3C662 
X-CRM114-Status: UNSURE (   8.17  )
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

Allow deselecting CONFIG_MMU to build a no-MMU
UML kernel.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
[drop defconfig file, minor adjustments/fixes, rewrite message]
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


