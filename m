Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuM-003BNu-Ui
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:06 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuM-005yea-0z
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 09/15] um, x86: bury crypto_tfm_ctx_offset
Date: Mon, 20 Sep 2021 21:32:55 +0000
Message-Id: <20210920213301.1424730-9-viro@zeniv.linux.org.uk>
In-Reply-To: <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
References: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
 <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

unused since 2011

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/common-offsets.h | 3 ---
 arch/x86/kernel/asm-offsets.c           | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index edc90ab737347..b2483104e27f0 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -18,9 +18,6 @@ DEFINE(UM_NR_CPUS, NR_CPUS);
 DEFINE(UM_GFP_KERNEL, GFP_KERNEL);
 DEFINE(UM_GFP_ATOMIC, GFP_ATOMIC);
 
-/* For crypto assembler code. */
-DEFINE(crypto_tfm_ctx_offset, offsetof(struct crypto_tfm, __crt_ctx));
-
 DEFINE(UM_THREAD_SIZE, THREAD_SIZE);
 
 DEFINE(UM_HZ, HZ);
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index ecd3fd6993d1a..9fb0a2f8b62a2 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -38,9 +38,6 @@ static void __used common(void)
 #endif
 
 	BLANK();
-	OFFSET(crypto_tfm_ctx_offset, crypto_tfm, __crt_ctx);
-
-	BLANK();
 	OFFSET(pbe_address, pbe, address);
 	OFFSET(pbe_orig_address, pbe, orig_address);
 	OFFSET(pbe_next, pbe, next);
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

