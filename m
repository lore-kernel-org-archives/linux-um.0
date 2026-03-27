Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F87310BA426
	for <linux-um@archiver.kernel.org>; Fri, 27 Mar 2026 06:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BdVPVlwvvRbu6Ap4c1Yxra64LIHrZ5JEG5D01pyAOLU=; b=jPpRRBJbQN5epz82XAccQe7l7r
	njAFr08ISTNV4bQheg84Bn/9bY2wfwt+el70M2t+7Qknjq+HD81qkKTjs4YMw8cVy6qVRm19AKpn2
	c4Aw/FR5EutF9Sf6YyoVNc78cXGuqLn5TZDQsa5vjJrfMffEjnsEDa7zjnf0t6Nbx0D+I6CDaypOw
	KQWlnG6Oezv08iq72jyavnsALBTG+j6nzU+PZEsDpyvEbqj/fc3wR1pgBJfD8Yn6h7+pJHhDTEiYK
	5tpDGXT6I8GXPbcszdgJrTAdIUqwkSiUdHs9oEXvT+7i2aydZfTD03srrFSQkhQuH/UfVdZaslHEt
	92sBjxjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60Zl-00000006n9e-0CPi;
	Fri, 27 Mar 2026 06:21:45 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60Zh-00000006mxc-2Jay;
	Fri, 27 Mar 2026 06:21:41 +0000
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
Subject: [PATCH 18/28] s390: move the XOR code to lib/raid/
Date: Fri, 27 Mar 2026 07:16:50 +0100
Message-ID: <20260327061704.3707577-19-hch@lst.de>
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

Move the optimized XOR into lib/raid and include it it in xor.ko
instead of unconditionally building it into the main kernel image.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/Makefile                     | 2 +-
 lib/raid/xor/Makefile                      | 1 +
 {arch/s390/lib => lib/raid/xor/s390}/xor.c | 2 --
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename {arch/s390/lib => lib/raid/xor/s390}/xor.c (98%)

diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index f43f897d3fc0..2bf47204f6ab 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -5,7 +5,7 @@
 
 lib-y += delay.o string.o uaccess.o find.o spinlock.o tishift.o
 lib-y += csum-partial.o
-obj-y += mem.o xor.o
+obj-y += mem.o
 lib-$(CONFIG_KPROBES) += probes.o
 lib-$(CONFIG_UPROBES) += probes.o
 obj-$(CONFIG_S390_KPROBES_SANITY_TEST) += test_kprobes_s390.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index 3a7c887d08ee..3db6c2b2f26a 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -20,6 +20,7 @@ xor-$(CONFIG_ALTIVEC)		+= powerpc/xor_vmx.o powerpc/xor_vmx_glue.o
 xor-$(CONFIG_RISCV_ISA_V)	+= riscv/xor.o riscv/xor-glue.o
 xor-$(CONFIG_SPARC32)		+= sparc/xor-sparc32.o
 xor-$(CONFIG_SPARC64)		+= sparc/xor-sparc64.o sparc/xor-sparc64-glue.o
+xor-$(CONFIG_S390)		+= s390/xor.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
diff --git a/arch/s390/lib/xor.c b/lib/raid/xor/s390/xor.c
similarity index 98%
rename from arch/s390/lib/xor.c
rename to lib/raid/xor/s390/xor.c
index 3bbe21b40e66..acbd268adfc8 100644
--- a/arch/s390/lib/xor.c
+++ b/lib/raid/xor/s390/xor.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/export.h>
 #include <linux/raid/xor_impl.h>
 #include <asm/xor.h>
 
@@ -133,4 +132,3 @@ struct xor_block_template xor_block_xc = {
 	.do_4 = xor_xc_4,
 	.do_5 = xor_xc_5,
 };
-EXPORT_SYMBOL(xor_block_xc);
-- 
2.47.3


