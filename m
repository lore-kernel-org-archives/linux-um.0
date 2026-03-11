Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35CBFD063E
	for <linux-um@archiver.kernel.org>; Wed, 11 Mar 2026 07:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EDWCo5cE2aEVpTui5bFdNy+9+SZiFj1BIITbfBYcjoU=; b=UnL70o09WUo0HgipCedJlVwoCM
	4m8fPNyrNax0X/7bU6QKbIXn7fjoZuWNhqd0fDQmaen1vEvx7TjNhmCREaqSXlzXBMf5hfLXIwbVk
	WirkndqOFIdQDT6SkcTjen9V0ilWgERos0IhvldtyT5QCbZbRmim9JgMT3dHi+nN9OaQB6c4Jox9s
	QEhEei75PObZODm97U6hT9Mml8lL1+BIr460Pb9OZ3xZNh2VrtBicCbK4v10fPq6gp3fvhd7hD9X8
	W71uCsC3pkTUzW64N6+uncyKsaVdtNs4waL6ktJ9bc6Fh/Cp0vvPntd8wfMArQTycIvcUp1z2zj6v
	fu9JdYQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0DiA-0000000B1nc-1MGd;
	Wed, 11 Mar 2026 07:10:30 +0000
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Di7-0000000B1bE-3GZS;
	Wed, 11 Mar 2026 07:10:28 +0000
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
Subject: [PATCH 26/27] random: factor out a __limit_random_u32_below helper
Date: Wed, 11 Mar 2026 08:03:58 +0100
Message-ID: <20260311070416.972667-27-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311070416.972667-1-hch@lst.de>
References: <20260311070416.972667-1-hch@lst.de>
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

Factor out the guts of __get_random_u32_below into a new helper,
so that callers with their own prng state can reuse this code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/char/random.c  | 26 +++++++++++++++-----------
 include/linux/random.h |  1 +
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7ff4d29911fd..23b5addf02fb 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -544,18 +544,16 @@ DEFINE_BATCHED_ENTROPY(u16)
 DEFINE_BATCHED_ENTROPY(u32)
 DEFINE_BATCHED_ENTROPY(u64)
 
-u32 __get_random_u32_below(u32 ceil)
+/*
+ * This is the slow path for variable ceil. It is still fast, most of the time,
+ * by doing traditional reciprocal multiplication and opportunistically
+ * comparing the lower half to ceil itself, before falling back to computing a
+ * larger bound, and then rejecting samples whose lower half would indicate a
+ * range indivisible by ceil. The use of `-ceil % ceil` is analogous to `2^32 %
+ * ceil`, but is computable in 32-bits.
+ */
+u32 __limit_random_u32_below(u32 ceil, u32 rand)
 {
-	/*
-	 * This is the slow path for variable ceil. It is still fast, most of
-	 * the time, by doing traditional reciprocal multiplication and
-	 * opportunistically comparing the lower half to ceil itself, before
-	 * falling back to computing a larger bound, and then rejecting samples
-	 * whose lower half would indicate a range indivisible by ceil. The use
-	 * of `-ceil % ceil` is analogous to `2^32 % ceil`, but is computable
-	 * in 32-bits.
-	 */
-	u32 rand = get_random_u32();
 	u64 mult;
 
 	/*
@@ -577,6 +575,12 @@ u32 __get_random_u32_below(u32 ceil)
 	}
 	return mult >> 32;
 }
+EXPORT_SYMBOL_GPL(__limit_random_u32_below);
+
+u32 __get_random_u32_below(u32 ceil)
+{
+	return __limit_random_u32_below(ceil, get_random_u32());
+}
 EXPORT_SYMBOL(__get_random_u32_below);
 
 #ifdef CONFIG_SMP
diff --git a/include/linux/random.h b/include/linux/random.h
index 8a8064dc3970..54401dd53f68 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -50,6 +50,7 @@ static inline unsigned long get_random_long(void)
 #endif
 }
 
+u32 __limit_random_u32_below(u32 ceil, u32 rand);
 u32 __get_random_u32_below(u32 ceil);
 
 /*
-- 
2.47.3


