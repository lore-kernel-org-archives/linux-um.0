Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A508FF886C
	for <linux-um@archiver.kernel.org>; Mon, 27 Apr 2026 17:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gXNNHxOKJNxC6UbQGAQkWPTYQLhbBO1PUuIbA1i3jbc=; b=FYB+MS4jwKWgPwgjFQu3hGCqGY
	rgC1wtbZMls8LQg6bhHAeJCEzRMlqojKLhxa8ohM5B6z9KZL+U9ufqZcLVRwCN9kDYc3wiNzpXBxN
	kyykMCTPqlmp0Jn3/8iF+i7YZVlGxo7ZFJ7VPQiQfupcjCkw5YBIl0F564arDFo8upQTTXlFWhx+t
	vtpeBOty21IKXThGbCnO0HdKKCRcgsvpShiEDDmuvFxgEEZfr71QWT9FKRjf+9SWY/Hmvr6hdEmoC
	qT1UTq+L4/jNvcYE7RWisQD88pU5C63g9qV/SWWXdhKH57WLyxEMO36el2wrTL+YzfzQ/syakoCA0
	nKkXkksQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPbf-0000000HRYL-1kkw;
	Mon, 27 Apr 2026 17:18:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPba-0000000HRTU-1AQu;
	Mon, 27 Apr 2026 17:18:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E16F243CD6;
	Mon, 27 Apr 2026 17:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5390FC2BCB4;
	Mon, 27 Apr 2026 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310325;
	bh=x+yz+Ptlr8yUKihbRCrYsj2OzN4+HDHdWj3mTkeeywo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YS9v5orti9jIm2coPKy7cH4iQCLjTYOH2T4kGrmAKw1lk2UpD8UcWDut4XHtMo5CX
	 290KHU3PNOVzMmnTKEL1o/OfzgOnzBVsJnbuGicRbc3HqjVsrjLo1DZ4Ncwz6tafWZ
	 SG8/hG1Ct8pUgSHrDrW4chwaJ34uCldA2tlOQo4bI8M4kMxsW5bP0OLNOAC7BeTwPk
	 Mil/pgBJA2/iCGWwmbEh5WNZZrQ4Md/gtqmnREocwFdhobkWjiqhIB30lRO/GV15k3
	 DZOePxOSt4vdcYmGqKSVWX7R1FegGyxqEmqkjMUEcFWkKzHsBpXNo8/6bbP3EGANbq
	 KZwGUUWEURiLg==
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
Subject: [RFC PATCH v1 6/9] uaccess: Change copy_{to/from}_user to return -EFAULT
Date: Mon, 27 Apr 2026 19:13:47 +0200
Message-ID: <1a55107abe15dd78450888e2b5327c3a56af29b7.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777306795.git.chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2416; i=chleroy@kernel.org; h=from:subject:message-id; bh=x+yz+Ptlr8yUKihbRCrYsj2OzN4+HDHdWj3mTkeeywo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxkjryH88LzkjscmK202zhcwuOPhcJTlidTVNdtCP 9vs/VPG2lHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAm0nCN4b9/yT75hpDtr4zk 9XPfORmtVO2p/XH+8bFg730PPNfMvn6dkWHDjsJSC09Vr9bDobdrxTgfMm1ckveKR+Rkud3skLM HLXgA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_101846_369728_53A92076 
X-CRM114-Status: UNSURE (   9.10  )
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

Now that copy_{to/from}_user_partial() are used by callers which expect
partial copy with number of not copied bytes as return value, change
copy_{to/from}_user() to return an int, and return -EFAULT when the
copy is not complete.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 include/linux/uaccess.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 2d37173782b3..33b7d0f5f808 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -211,7 +211,7 @@ extern __must_check unsigned long
 _copy_to_user(void __user *, const void *, unsigned long);
 
 static __always_inline unsigned long __must_check
-copy_from_user(void *to, const void __user *from, unsigned long n)
+copy_from_user_common(void *to, const void __user *from, unsigned long n, bool partial)
 {
 	if (!check_copy_size(to, n, false))
 		return n;
@@ -221,10 +221,20 @@ copy_from_user(void *to, const void __user *from, unsigned long n)
 		return _inline_copy_from_user(to, from, n);
 }
 
-#define copy_from_user_partial copy_from_user
+static __always_inline unsigned long __must_check
+copy_from_user_partial(void *to, const void __user *from, unsigned long n)
+{
+	return copy_from_user_common(to, from, n, true);
+}
+
+static __always_inline int __must_check
+copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return copy_from_user_common(to, from, n, false) ? -EFAULT : 0;
+}
 
 static __always_inline unsigned long __must_check
-copy_to_user(void __user *to, const void *from, unsigned long n)
+copy_to_user_common(void __user *to, const void *from, unsigned long n, bool partial)
 {
 	if (!check_copy_size(from, n, true))
 		return n;
@@ -235,7 +245,17 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
 		return _inline_copy_to_user(to, from, n);
 }
 
-#define copy_to_user_partial copy_to_user
+static __always_inline unsigned long __must_check
+copy_to_user_partial(void __user *to, const void *from, unsigned long n)
+{
+	return copy_to_user_common(to, from, n, true);
+}
+
+static __always_inline int __must_check
+copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return copy_to_user_common(to, from, n, false) ? -EFAULT : 0;
+}
 
 #ifndef copy_mc_to_kernel
 /*
-- 
2.49.0


