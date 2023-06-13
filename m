Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20A2C001B0
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:MIME-Version:References:Subject:Cc
	:To:From:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=D9piyQ+XsHApHTAMQ946HzUKvi5H9dV/cIG/iT89coU=; b=qngz4FqumbqloO
	phIi89eshcQ3FYNJ/gNsWCVcdp697MQRmfRzcshrTFaXlxQ/y2PNOU6z6DE5Q2cNeH48LsZCHbMNW
	ce0W1fQIkMkaUyD7nhX7shrjXL2fWNMTg8nx0Iwolaw3qodgjn5PtwFQxZZdzQImdvFasirp6hnGf
	SmKrFpX4BwSXmGFlVQRNJ26a9j4szeBFF7hIgCo9rXM6OkN595nRifwPgPj7bGkwyxGa8w0MnLuDv
	Qmawa2Qf0s/Rx+NtDsdUyzzaOIIVPJy3ntxU3ZjiHzy/v9Gsmtfs9N+Aed9SrTMVzkZTuAX/Q6Rzw
	02wFO1x226bik6+UEJEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dch-009S5f-17;
	Tue, 13 Jun 2023 23:40:27 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Dby-009RRy-2Z;
	Tue, 13 Jun 2023 23:39:53 +0000
Message-ID: <20230613224545.670360645@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686699581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lNQFIv9giVxLbCumZPShd6fBwItl7AKDfIjQdD1B1ok=;
	b=NhwOjp0vdKWOrteRuFiTOkExTiGFZ+1X3uZu8Sf9fdyrIPm2q/gN4MmPHkCZJSMuDFIyau
	62b1YEZwJdmoo/8iAGDMB+f2rfpJWTxhz280VlrOWuVI8kMlClaNhFnA/HnrvxfThhq2Y7
	LrmEMnVJ5d25Djkc3MZjVW/Fmz2axOYQ++mr4C8i7V8xhsVuiDO0UcuAgoIZ2LkpjNgGiP
	7dqi2bz7PCyBpzzyh/htAgssbDnwJDTyEbGU2gqgSCoXYtobvOXRW69yEXXCETLnzJzHvQ
	dbG14Dx6omVuOO5nyZKPQvEOw9jwwdikXGwasbUA2D71OPAp4CjnptBqSSwaHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686699581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lNQFIv9giVxLbCumZPShd6fBwItl7AKDfIjQdD1B1ok=;
	b=gfCfRi6taulCsvO42taqM4pd4hXtC0EjIZYTeRqyo9lKyT8xnwcJ0CXF+9O/JENzPKmB+i
	pT1TJrwh+wATGyAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-um@lists.infradead.org,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Chris Zankel <chris@zankel.net>
Subject: [patch 13/17] init, x86: Move mem_encrypt_init() into
 arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 01:39:41 +0200 (CEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_163943_168363_BD3C8101 
X-CRM114-Status: GOOD (  12.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Invoke the X86ism mem_encrypt_init() from X86 arch_cpu_finalize_init() and
remove the weak fallback from the core code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h |    7 ++++---
 arch/x86/kernel/cpu/common.c       |   11 +++++++++++
 init/main.c                        |   13 -------------
 3 files changed, 15 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,6 +51,8 @@ void __init mem_encrypt_free_decrypted_m
 
 void __init sev_es_init_vc_handling(void);
 
+void __init mem_encrypt_init(void);
+
 #define __bss_decrypted __section(".bss..decrypted")
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
@@ -83,13 +85,12 @@ early_set_mem_enc_dec_hypercall(unsigned
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
+static inline void mem_encrypt_init(void) { }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void);
-
 void add_encrypt_protection_map(void);
 
 /*
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/kprobes.h>
 #include <linux/kgdb.h>
+#include <linux/mem_encrypt.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/io.h>
@@ -2417,4 +2418,14 @@ void __init arch_cpu_finalize_init(void)
 	} else {
 		fpu__init_check_bugs();
 	}
+
+	/*
+	 * This needs to be called before any devices perform DMA
+	 * operations that might use the SWIOTLB bounce buffers. It will
+	 * mark the bounce buffers as decrypted so that their usage will
+	 * not cause "plain-text" data to be decrypted when accessed. It
+	 * must be called after late_time_init() so that Hyper-V x86/x64
+	 * hypercalls work when the SWIOTLB bounce buffers are decrypted.
+	 */
+	mem_encrypt_init();
 }
--- a/init/main.c
+++ b/init/main.c
@@ -95,7 +95,6 @@
 #include <linux/cache.h>
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
-#include <linux/mem_encrypt.h>
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
@@ -786,8 +785,6 @@ void __init __weak thread_stack_cache_in
 }
 #endif
 
-void __init __weak mem_encrypt_init(void) { }
-
 void __init __weak poking_init(void) { }
 
 void __init __weak pgtable_cache_init(void) { }
@@ -1043,16 +1040,6 @@ asmlinkage __visible void __init __no_sa
 
 	arch_cpu_finalize_init();
 
-	/*
-	 * This needs to be called before any devices perform DMA
-	 * operations that might use the SWIOTLB bounce buffers. It will
-	 * mark the bounce buffers as decrypted so that their usage will
-	 * not cause "plain-text" data to be decrypted when accessed. It
-	 * must be called after late_time_init() so that Hyper-V x86/x64
-	 * hypercalls work when the SWIOTLB bounce buffers are decrypted.
-	 */
-	mem_encrypt_init();
-
 	pid_idr_init();
 	anon_vma_init();
 #ifdef CONFIG_X86


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
