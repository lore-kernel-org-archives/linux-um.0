Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B324FF886B
	for <linux-um@archiver.kernel.org>; Mon, 27 Apr 2026 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mhZ9NMxuum/7eEE1gQi0nXMq4NB/M40iUHyNchfsiT4=; b=MSsR00BD5I8D3B18qOJUNvfDWp
	naY/cQgjDJVrD+LVkBkIAyo/gMVP7RF8iz/qkgP3retBt/lYTCqEhfjjQ9tEpQnrZZVEImxX7jhhK
	HfPSXSwCzJQzshEDx7CyYHILPZJcBoNit7TbYmX/4sJ/exEv+zZe5PAKrZoe0gFmpmk9zEmJCH5wn
	6H+BMmY4VjbbOoLQZJJNkXPdgH3YLRxPJ058MRa8L8y3fxQKu0Lh0Ma4mlznFuHx9FH7IrcqAxoYU
	15jiNIniruFwB05Njdgc9JMPAqstEooOF11PG461/6R/5LHgNDvmXLYdyZW664VtieQZKssP7YOKk
	X53aOB5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPbs-0000000HRkY-1ghc;
	Mon, 27 Apr 2026 17:19:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPbo-0000000HRg2-000Q;
	Mon, 27 Apr 2026 17:19:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9368940C54;
	Mon, 27 Apr 2026 17:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C90C2BCB4;
	Mon, 27 Apr 2026 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310339;
	bh=VVuQn2YnZFi2JH9uh9hmEqXb1BpygsXabSyFGnhBvmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdO2kRaqrKnrRzE/uOUoSc+QuIvBLF9bEcfUYb9jTJLWJk0AT883/0gLUkpYyvhxW
	 JwKLSaa6O8znPG+ygzo4nQLM8J0f65SbAuU342P7t8CFNHOEuyufyC86uU6TKB6BuB
	 gSew3oyOMPJ8ALphDrpzU/JPmVzf88NlkSTCpSsq0dGpC1oXnkppqU6so9I0ayHunG
	 vmD6szQq9NnauXryTPXCD0GLKF95gnwZ47owOPgIM468cdafyYqaGorVn/T0ZUPF41
	 utCUjd396YBehKkYMEmrRy4GP6QkmxuYFD7L2LBro+x9SzGKxh5BvzwrXlX1jpWNJG
	 /RZq8/R9DjgcA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Yury Norov <ynorov@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fsi@lists.ozlabs.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-x25@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
Date: Mon, 27 Apr 2026 19:13:48 +0200
Message-ID: <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777306795.git.chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2390; i=chleroy@kernel.org; h=from:subject:message-id; bh=VVuQn2YnZFi2JH9uh9hmEqXb1BpygsXabSyFGnhBvmI=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxljeGSBfXj99HCNy2WTVFXXC9z/Hmi+//aE1/MbC +50nw1Q6ChlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQAT2djH8D+e3yYgNP/F6xtd z9QNXjIccVycwR574E38S3tWp2uq95Yy/M9xKJ2hYJCUJV9391rVwmlfl7x6GzD19bqwZeyVdgF fZ3MAAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_101900_093523_DC0CAFB2 
X-CRM114-Status: UNSURE (   8.99  )
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

At the time being, x86 and arm64 are missing unsafe_copy_from_user().

Add it.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/x86/include/asm/uaccess.h | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233..10c458ffa399 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -598,7 +598,7 @@ _label:									\
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
  */
-#define unsafe_copy_loop(dst, src, len, type, label)				\
+#define unsafe_put_loop(dst, src, len, type, label)				\
 	while (len >= sizeof(type)) {						\
 		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
 		dst += sizeof(type);						\
@@ -611,10 +611,29 @@ do {									\
 	char __user *__ucu_dst = (_dst);				\
 	const char *__ucu_src = (_src);					\
 	size_t __ucu_len = (_len);					\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
+	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
+	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
+	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+} while (0)
+
+#define unsafe_get_loop(dst, src, len, type, label)				\
+	while (len >= sizeof(type)) {						\
+		unsafe_get_user(*(type __user *)(src),(type *)(dst),label);	\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}
+
+#define unsafe_copy_from_user(_dst,_src,_len,label)			\
+do {									\
+	char *__ucu_dst = (_dst);					\
+	const char __user *__ucu_src = (_src);				\
+	size_t __ucu_len = (_len);					\
+	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
+	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
+	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
+	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-- 
2.49.0


