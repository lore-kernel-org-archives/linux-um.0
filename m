Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A78FD8FCA
	for <linux-um@archiver.kernel.org>; Thu, 26 Feb 2026 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6wXlWATGkI9LtZmZKd6pDj/YsUZIAwbclFsmEmtMkgM=; b=FG1/823eTLlojNIDd7k4mWklBq
	yE+Qxoy0jeX3w4kgtoyaX7j+V++KmBM7YEYW1DAn3zPHk//Am9jIBqy/8xuZMrNyvVw4e/zSwW2+f
	Io8/46BkemmjS6b+XyDu7YvRofkXbyeAl7O99DPd3X0WzoZvwi7qftiM5KREMxNGNUQK+vs78xxqC
	KS8tA/6UgYsqwNtZ3v1HOkYn4xdF6ckoUTCg7aq0pVIGMmJrLMEeXibx2OgcvFBtjqQRfDsrrHELH
	5/APybBJRp816d5MAFCMiLFPmFcmgDCEVXXDq5broZmGG43iWedAOYO29leSHanqYX0BqMjVwQgic
	a0aG6oQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd2H-00000006Rdc-3mjC;
	Thu, 26 Feb 2026 15:12:17 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvd1i-00000006Qgq-3lP2;
	Thu, 26 Feb 2026 15:11:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
Subject: [PATCH 21/25] xor: add a better public API
Date: Thu, 26 Feb 2026 07:10:33 -0800
Message-ID: <20260226151106.144735-22-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226151106.144735-1-hch@lst.de>
References: <20260226151106.144735-1-hch@lst.de>
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

xor_blocks is very annoying to use, because it is limited to 4 + 1
sources / destinations, has an odd argument order and is completely
undocumented.

Lift the code that loops around it from btrfs and async_tx/async_xor into
common code under the name xor_gen and properly document it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/raid/xor.h |  3 +++
 lib/raid/xor/xor-core.c  | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/raid/xor.h b/include/linux/raid/xor.h
index 02bda8d99534..4735a4e960f9 100644
--- a/include/linux/raid/xor.h
+++ b/include/linux/raid/xor.h
@@ -7,4 +7,7 @@
 extern void xor_blocks(unsigned int count, unsigned int bytes,
 	void *dest, void **srcs);
 
+void xor_gen(void *dest, void **srcss, unsigned int src_cnt,
+		unsigned int bytes);
+
 #endif /* _XOR_H */
diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index 8dda4055ad09..b7c29ca931ec 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -46,6 +46,34 @@ xor_blocks(unsigned int src_count, unsigned int bytes, void *dest, void **srcs)
 }
 EXPORT_SYMBOL(xor_blocks);
 
+/**
+ * xor_gen - generate RAID-style XOR information
+ * @dest:	destination vector
+ * @srcs:	source vectors
+ * @src_cnt:	number of source vectors
+ * @bytes:	length in bytes of each vector
+ *
+ * Performs bit-wise XOR operation into @dest for each of the @src_cnt vectors
+ * in @srcs for a length of @bytes bytes.
+ *
+ * Note: for typical RAID uses, @dest either needs to be zeroed, or filled with
+ * the first disk, which then needs to be removed from @srcs.
+ */
+void xor_gen(void *dest, void **srcs, unsigned int src_cnt, unsigned int bytes)
+{
+	unsigned int src_off = 0;
+
+	while (src_cnt > 0) {
+		unsigned int this_cnt = min(src_cnt, MAX_XOR_BLOCKS);
+
+		xor_blocks(this_cnt, bytes, dest, srcs + src_off);
+
+		src_cnt -= this_cnt;
+		src_off += this_cnt;
+	}
+}
+EXPORT_SYMBOL(xor_gen);
+
 /* Set of all registered templates.  */
 static struct xor_block_template *__initdata template_list;
 static int __initdata xor_forced = false;
-- 
2.47.3


