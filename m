Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF48C44520
	for <linux-um@archiver.kernel.org>; Mon, 20 Jul 2026 18:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ebM2hxl5cBO1Xh1N3Z3sOTd/f7PELgwvm/5UN/+/D4M=; b=ZjsNZE12e+nZG5LOSaMBElrRpw
	fbeyykF+2+X7B6p+PReoVV5ipdCqaCpIMrO9QOgPh1rxvjCzImN2F5f3H8/oRdUZTZ0t5HKaG6Yze
	xW8i2HHW9SzB6OeRx4TFgeOllEnHYBE9lU1l8JRgvxdmKHR62SWh+jhzDmDVOHEybrjGnHQLKwQlM
	GhTJiMraAPhdYkSCYCIp1wDEDNMMt6xq2Lxy1aIeT3zI+vYG9xLIEFjbav1WInqQRU9/V1mNjfIkv
	+LfrzAcWMg0wkWXSEIeJIkToWk+k+F+x9JS+PHqD1/kQ9+zn88ht6asG8QA2pqRMFF2qyLq86Fu4e
	/HflpZMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt5D-00000007h4I-28ca;
	Mon, 20 Jul 2026 18:51:19 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlt59-00000007h0v-2hQa
	for linux-um@lists.infradead.org;
	Mon, 20 Jul 2026 18:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ebM2hxl5cBO1Xh1N3Z3sOTd/f7PELgwvm/5UN/+/D4M=;
	t=1784573475; x=1785783075; b=gaTqVtNXOrjdq2hK1OZMvNVcb986pFck4vo9OLP7uHjEedM
	qUdVO7TEvGqLzVXgn43LRx9MBg0WB08lzIU88eSZSyIw0ipEY83j4HRT9IqOXJ1dah6xDTZQvMkws
	uk6PfjnfyJJMgk3k9+J1IFtd9iKlmrnKPEkLtilwxzAHB6J/QCb028a2UGCjXp5NIS4rnBZ3koMzO
	i0OFEsXkI1Zw9V5mhx8rbshIUFugaYyVDTkjvpiRTbfJ9nprEmxgBLiDeKWNRMZb05xDMqXSGBoya
	ozf7rhvR4xqEmd495zJcIN7Tz1CRNqsiTFNPQ+hAjKpMAIR0L7oUgCKL48QRelLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wlt52-0000000GsPP-3OjR;
	Mon, 20 Jul 2026 20:51:08 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	Kees Cook <kees@kernel.org>
Subject: [RFC PATCH 1/9] x86/um: nommu: elf loader for fdpic
Date: Mon, 20 Jul 2026 20:26:51 +0200
Message-ID: <20260720185103.530603-12-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720185103.530603-11-johannes@sipsolutions.net>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_115115_979728_103421CE 
X-CRM114-Status: GOOD (  14.32  )
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

As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
loader, FDPIC ELF loader.  In this commit, we added necessary
definitions in the arch, as UML has not been used so far.  It also
updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.

Acked-by: Kees Cook <kees@kernel.org>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
Link: https://patch.msgid.link/fa22ec46b0d78df65a005d4a33d05edebbbd381d.1770170302.git.thehajime@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/mmu.h            | 5 +++++
 arch/um/include/asm/ptrace-generic.h | 6 ++++++
 arch/x86/um/asm/elf.h                | 8 ++++++--
 fs/Kconfig.binfmt                    | 2 +-
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 07d48738b402..82a919132aff 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -21,6 +21,11 @@ typedef struct mm_context {
 	spinlock_t sync_tlb_lock;
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long   exec_fdpic_loadmap;
+	unsigned long   interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 86d74f9d33cf..62e9916078ec 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -29,6 +29,12 @@ struct pt_regs {
 
 #define PTRACE_OLDSETOPTIONS 21
 
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+#define PTRACE_GETFDPIC		31
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
+#endif
+
 struct task_struct;
 
 extern long subarch_ptrace(struct task_struct *child, long request,
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 22d0111b543b..388fe669886c 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -9,6 +9,7 @@
 #include <skas.h>
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS  0
 
 #ifdef CONFIG_X86_32
 
@@ -158,8 +159,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 extern unsigned long um_vdso_addr;
 #define AT_SYSINFO_EHDR 33
-#define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
-
+#define ARCH_DLINFO						\
+do {								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr);		\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, 0);			\
+} while (0)
 #endif
 
 typedef unsigned long elf_greg_t;
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 1949e25c7741..0a92bebd5f75 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
+	depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.53.0


