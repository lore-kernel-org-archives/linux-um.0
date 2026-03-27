Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27DF10BA431
	for <linux-um@archiver.kernel.org>; Fri, 27 Mar 2026 06:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jmVHDIGjSVXJ6mznFR3BDf1KydPvvWCTsKbXoXp3DKw=; b=GyX2cb3nkRNrxKPuHn9drOeZ03
	TKRbahWPcuacgtGpjQEX2h93r4UCsQIVyhEm5rR4FV0XCMauDA+PkN7VtKiWJOo8dvvtVnGOKmIFi
	MvFaze+bkxUvASRUrqibNroEfJsFrQQerVaFxBWOgWMWTXkv09H5offUOwJ68JQ3T6rUYQian6obu
	yPzFW5dGI/t9+41UDa3Udwrle6GoXJnXXnmS1TylnjujJzcDhEgpqAFCQYvO5kshIMvljJ3oKKL+6
	nRSLMf67hdoVmpHBY/jUv45tWiH+TVtPZAS3JrdDQnDJWP2FNevDWCiECiBq13nR8tVKBmaQCtqwn
	tBfxRKZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60XW-00000006lRu-1ifq;
	Fri, 27 Mar 2026 06:19:26 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60XT-00000006lGc-035D;
	Fri, 27 Mar 2026 06:19:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 07/28] xor: cleanup registration and probing
Date: Fri, 27 Mar 2026 07:16:39 +0100
Message-ID: <20260327061704.3707577-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327061704.3707577-1-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Originally, the XOR code benchmarked all algorithms at load time, but
it has since then been hacked multiple times to allow forcing an
algorithm, and then commit 524ccdbdfb52 ("crypto: xor - defer load time
benchmark to a later time") changed the logic to a two-step process
or registration and benchmarking, but only when built-in.

Rework this, so that the XOR_TRY_TEMPLATES macro magic now always just
deals with adding the templates to the list, and benchmarking is always
done in a second pass; for modular builds from module_init, and for the
built-in case using a separate init call level.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/raid/xor/xor-core.c | 98 ++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index c54f48405c40..e6e593e404fb 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -52,29 +52,14 @@ EXPORT_SYMBOL(xor_blocks);
 
 /* Set of all registered templates.  */
 static struct xor_block_template *__initdata template_list;
+static bool __initdata xor_forced = false;
 
-#ifndef MODULE
 static void __init do_xor_register(struct xor_block_template *tmpl)
 {
 	tmpl->next = template_list;
 	template_list = tmpl;
 }
 
-static int __init register_xor_blocks(void)
-{
-	active_template = XOR_SELECT_TEMPLATE(NULL);
-
-	if (!active_template) {
-#define xor_speed	do_xor_register
-		// register all the templates and pick the first as the default
-		XOR_TRY_TEMPLATES;
-#undef xor_speed
-		active_template = template_list;
-	}
-	return 0;
-}
-#endif
-
 #define BENCH_SIZE	4096
 #define REPS		800U
 
@@ -85,9 +70,6 @@ do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
 	unsigned long reps;
 	ktime_t min, start, t0;
 
-	tmpl->next = template_list;
-	template_list = tmpl;
-
 	preempt_disable();
 
 	reps = 0;
@@ -111,63 +93,79 @@ do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
 	pr_info("   %-16s: %5d MB/sec\n", tmpl->name, speed);
 }
 
-static int __init
-calibrate_xor_blocks(void)
+static int __init calibrate_xor_blocks(void)
 {
 	void *b1, *b2;
 	struct xor_block_template *f, *fastest;
 
-	fastest = XOR_SELECT_TEMPLATE(NULL);
-
-	if (fastest) {
-		printk(KERN_INFO "xor: automatically using best "
-				 "checksumming function   %-10s\n",
-		       fastest->name);
-		goto out;
-	}
+	if (xor_forced)
+		return 0;
 
 	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
 	if (!b1) {
-		printk(KERN_WARNING "xor: Yikes!  No memory available.\n");
+		pr_warn("xor: Yikes!  No memory available.\n");
 		return -ENOMEM;
 	}
 	b2 = b1 + 2*PAGE_SIZE + BENCH_SIZE;
 
-	/*
-	 * If this arch/cpu has a short-circuited selection, don't loop through
-	 * all the possible functions, just test the best one
-	 */
-
-#define xor_speed(templ)	do_xor_speed((templ), b1, b2)
-
-	printk(KERN_INFO "xor: measuring software checksum speed\n");
-	template_list = NULL;
-	XOR_TRY_TEMPLATES;
+	pr_info("xor: measuring software checksum speed\n");
 	fastest = template_list;
-	for (f = fastest; f; f = f->next)
+	for (f = template_list; f; f = f->next) {
+		do_xor_speed(f, b1, b2);
 		if (f->speed > fastest->speed)
 			fastest = f;
-
+	}
+	active_template = fastest;
 	pr_info("xor: using function: %s (%d MB/sec)\n",
 	       fastest->name, fastest->speed);
 
+	free_pages((unsigned long)b1, 2);
+	return 0;
+}
+
+static int __init xor_init(void)
+{
+	/*
+	 * If this arch/cpu has a short-circuited selection, don't loop through
+	 * all the possible functions, just use the best one.
+	 */
+	active_template = XOR_SELECT_TEMPLATE(NULL);
+	if (active_template) {
+		pr_info("xor: automatically using best checksumming function   %-10s\n",
+			active_template->name);
+		xor_forced = true;
+		return 0;
+	}
+
+#define xor_speed	do_xor_register
+	XOR_TRY_TEMPLATES;
 #undef xor_speed
 
-	free_pages((unsigned long)b1, 2);
-out:
-	active_template = fastest;
+#ifdef MODULE
+	return calibrate_xor_blocks();
+#else
+	/*
+	 * Pick the first template as the temporary default until calibration
+	 * happens.
+	 */
+	active_template = template_list;
 	return 0;
+#endif
 }
 
-static __exit void xor_exit(void) { }
+static __exit void xor_exit(void)
+{
+}
 
 MODULE_DESCRIPTION("RAID-5 checksumming functions");
 MODULE_LICENSE("GPL");
 
+/*
+ * When built-in we must register the default template before md, but we don't
+ * want calibration to run that early as that would delay the boot process.
+ */
 #ifndef MODULE
-/* when built-in xor.o must initialize before drivers/md/md.o */
-core_initcall(register_xor_blocks);
+__initcall(calibrate_xor_blocks);
 #endif
-
-module_init(calibrate_xor_blocks);
+core_initcall(xor_init);
 module_exit(xor_exit);
-- 
2.47.3


