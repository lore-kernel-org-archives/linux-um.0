Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84E6CD13CF
	for <linux-um@archiver.kernel.org>; Mon,  2 Sep 2024 05:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=56VTu/qXLVL5nMG+uXbgMEcYFDCqL3Blag2bpSCjYxk=; b=Eh2Z9zTXS0v60IkZ6B6wrsBS7d
	puGY39/aQdLdmmeTGiWOKeT8AxR7a2PHlIefDKr/jma7pl3RBzYLFJoKpX1jjKFhXf7wrKaKjtLEB
	WIWcVeixFDBZOv3swhm3bSWJfXS48eEbQojgNwJQ1n4ZCqsMYcBJ9vp227I17qLW6vqRbL7wJh74v
	w2KsjCznTRXLSuyVDAYHhr72wmqgxOZEj1GuAHEFDB6LGQNsCfek37wVVvGMi4S1LcESgboEk+8WK
	Gjdz9B8OPyG4z+8Y+JA4WQmdf0T+7ild2/ZBB53lNe2VLgMwaU1LSbsrCEcj6V+SY9FynXHvYVuZu
	z0dP00ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skziR-0000000D2aL-28S0;
	Mon, 02 Sep 2024 05:35:03 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skzfJ-0000000D20l-3M4O
	for linux-um@lists.infradead.org;
	Mon, 02 Sep 2024 05:31:52 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-71428f16b09so170265b3a.0
        for <linux-um@lists.infradead.org>; Sun, 01 Sep 2024 22:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1725255109; x=1725859909; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56VTu/qXLVL5nMG+uXbgMEcYFDCqL3Blag2bpSCjYxk=;
        b=SOOCzRnqoEfURKhSvR+7MUYjVuEI3353qUnUDMvTmlbPrk/D3xn2wbsHASukpDxB9Q
         uqHdCvmxb3G9N9x+pXMDgk09Q9U9z4KRs9wBhze7SDR537MtcwJCXimtsTQX2zGS1vkN
         rpKo1z1APsLKlVNHl21KEyTpJuj2F7zFGNcVNW54OERuhIr10NT/W3g3uLtGx51EQD9U
         LFWuZwUS1lIovQAZziATbQaPVXkJ9WrNeHn88Z0EWrkiL+IisgOOz348XJFJF3rG263f
         a0ReW4N7RlFtP0cs2K90raQ8K11Ib1aKMXwr3M8PcC0Hiue7Vk/orh37x7+KaPoXPFDN
         xNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725255109; x=1725859909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56VTu/qXLVL5nMG+uXbgMEcYFDCqL3Blag2bpSCjYxk=;
        b=GBTNawh11CsjsQgWX+HSyI+L1eLqxn4UwCX3t65xu2Wtd9Liru9eofoqefkpLwlclx
         SgPCqr01X4mh2bgz4Gd6gfb102cQTozLoh1z9uhfyD4g+8lIYaizgN7OkaRtp9JRkk7q
         rFi0WRNfUVSunzdaIRlQ8UQjlsg1/f1R+ChaF+vJ8geYTwQK6E8POfk6S4yzqHqFdyLD
         9NlhiaUf8rV1Fs7y3L/S/txn7Hya8ZYoU0CVAcepVGmfxCPU78p1vX+1Yq3r1Djq1zQe
         W6+4Vtxc1xrIAnEtqPCbcxSU7C02DtKyByi4TwopN9zMz61sN8ZlR3rVZ8g3kntMUE3J
         iL4A==
X-Forwarded-Encrypted: i=1; AJvYcCUksgisCAR74UI2veXtAIGCJJZgPjwUtpYRK/Rci1IWfbcesFV54LXPKcdDEbbBIEZkIXzUW8MRuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzIzOTvWHgxsnOjPvkxFqPYRYFhLx6wU09ee5DU1XLvYAMo2rqn
	lW+uJDQ75g2x7fH577NkzyaQ+pUqhVJmKddpxXEE0AmWM965TvqhaXTbuHXwuKg=
X-Google-Smtp-Source: AGHT+IHP9EQ25y63/ZmPp8u38IbeoRt/KYiwtSvqUDmg44wFA6t/ROSaOYVvZchoffP9nEa6l2KaPg==
X-Received: by 2002:a05:6a00:1a8e:b0:714:21c2:efb5 with SMTP id d2e1a72fcca58-717305d65acmr5552903b3a.1.1725255108509;
        Sun, 01 Sep 2024 22:31:48 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::901f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a692fsm6076279b3a.60.2024.09.01.22.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 22:31:48 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] mm: rename copy_from_kernel_nofault_allowed() to copy_kernel_nofault_allowed()
Date: Sun,  1 Sep 2024 22:31:28 -0700
Message-ID: <c50815dee5c244274e880b0fc4253deaf72b9165.1725223574.git.osandov@fb.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725223574.git.osandov@fb.com>
References: <cover.1725223574.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240901_223149_886364_294A7139 
X-CRM114-Status: GOOD (  12.10  )
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

From: Omar Sandoval <osandov@fb.com>

All of the existing checks are applicable to both the "from" and "to"
directions, and the next patch needs it for copy_to_kernel_nofault().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 arch/arm/mm/fault.c         | 2 +-
 arch/loongarch/mm/maccess.c | 2 +-
 arch/mips/mm/maccess.c      | 2 +-
 arch/parisc/lib/memcpy.c    | 2 +-
 arch/powerpc/mm/maccess.c   | 2 +-
 arch/um/kernel/maccess.c    | 2 +-
 arch/x86/mm/maccess.c       | 4 ++--
 include/linux/uaccess.h     | 2 +-
 mm/maccess.c                | 7 +++----
 9 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ab01b51de559..3fef0a59af4f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -27,7 +27,7 @@
 
 #ifdef CONFIG_MMU
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	unsigned long addr = (unsigned long)unsafe_src;
 
diff --git a/arch/loongarch/mm/maccess.c b/arch/loongarch/mm/maccess.c
index 58173842c6be..70012ac0a5a8 100644
--- a/arch/loongarch/mm/maccess.c
+++ b/arch/loongarch/mm/maccess.c
@@ -3,7 +3,7 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	/* highest bit set means kernel space */
 	return (unsigned long)unsafe_src >> (BITS_PER_LONG - 1);
diff --git a/arch/mips/mm/maccess.c b/arch/mips/mm/maccess.c
index 58173842c6be..70012ac0a5a8 100644
--- a/arch/mips/mm/maccess.c
+++ b/arch/mips/mm/maccess.c
@@ -3,7 +3,7 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	/* highest bit set means kernel space */
 	return (unsigned long)unsafe_src >> (BITS_PER_LONG - 1);
diff --git a/arch/parisc/lib/memcpy.c b/arch/parisc/lib/memcpy.c
index 5fc0c852c84c..78758b9a0f49 100644
--- a/arch/parisc/lib/memcpy.c
+++ b/arch/parisc/lib/memcpy.c
@@ -48,7 +48,7 @@ void * memcpy(void * dst,const void *src, size_t count)
 
 EXPORT_SYMBOL(memcpy);
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	if ((unsigned long)unsafe_src < PAGE_SIZE)
 		return false;
diff --git a/arch/powerpc/mm/maccess.c b/arch/powerpc/mm/maccess.c
index ea821d0ffe16..e0f4c394836c 100644
--- a/arch/powerpc/mm/maccess.c
+++ b/arch/powerpc/mm/maccess.c
@@ -7,7 +7,7 @@
 #include <asm/inst.h>
 #include <asm/ppc-opcode.h>
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	return is_kernel_addr((unsigned long)unsafe_src);
 }
diff --git a/arch/um/kernel/maccess.c b/arch/um/kernel/maccess.c
index 8ccd56813f68..3497148e9aa5 100644
--- a/arch/um/kernel/maccess.c
+++ b/arch/um/kernel/maccess.c
@@ -7,7 +7,7 @@
 #include <linux/kernel.h>
 #include <os.h>
 
-bool copy_from_kernel_nofault_allowed(const void *src, size_t size)
+bool copy_kernel_nofault_allowed(const void *src, size_t size)
 {
 	void *psrc = (void *)rounddown((unsigned long)src, PAGE_SIZE);
 
diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 42115ac079cf..be28eda2c0b0 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -6,7 +6,7 @@
 #include <asm/vsyscall.h>
 
 #ifdef CONFIG_X86_64
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	unsigned long vaddr = (unsigned long)unsafe_src;
 
@@ -36,7 +36,7 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 	return __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
 }
 #else
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	return (unsigned long)unsafe_src >= TASK_SIZE_MAX;
 }
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index d8e4105a2f21..297a02b2bd53 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -387,7 +387,7 @@ copy_struct_from_user(void *dst, size_t ksize, const void __user *src,
 	return 0;
 }
 
-bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size);
+bool copy_kernel_nofault_allowed(const void *unsafe_src, size_t size);
 
 long copy_from_kernel_nofault(void *dst, const void *src, size_t size);
 long notrace copy_to_kernel_nofault(void *dst, const void *src, size_t size);
diff --git a/mm/maccess.c b/mm/maccess.c
index 518a25667323..72e9c03ea37f 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -7,8 +7,7 @@
 #include <linux/uaccess.h>
 #include <asm/tlb.h>
 
-bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
-		size_t size)
+bool __weak copy_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	return true;
 }
@@ -28,7 +27,7 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
 		align = (unsigned long)dst | (unsigned long)src;
 
-	if (!copy_from_kernel_nofault_allowed(src, size))
+	if (!copy_kernel_nofault_allowed(src, size))
 		return -ERANGE;
 
 	pagefault_disable();
@@ -83,7 +82,7 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 
 	if (unlikely(count <= 0))
 		return 0;
-	if (!copy_from_kernel_nofault_allowed(unsafe_addr, count))
+	if (!copy_kernel_nofault_allowed(unsafe_addr, count))
 		return -ERANGE;
 
 	pagefault_disable();
-- 
2.46.0


