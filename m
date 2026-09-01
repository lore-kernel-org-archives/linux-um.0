Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6992C624D7
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4lrJRkT6oIO9uz4byVKnhiX3ckXssiVruBvq7U+FfI=; b=CieM7tPlixZTS0JswfHhpPkrGA
	tpGp2b12P9kurR3fmlzyj/7aUdZRU26UJn30MrsyKtdBOF7u4LTe7Mamo2zQmA2Wf9z+lllorky4x
	z+WtxCl5/LsX9gQn2OpCARWtWcpUpU0ySwLxLlJMmBSaQGwaIRKyOv1vKdgzeTREXsaqVNq9Dd8uu
	zg4eq8Va72rvb45p9f/cDq/Hv+zVSpUvBijIry/qscEXkHlOQdARs8K1W+XdAjU9GAN5KS0TMMzAU
	bf0nQJYXzPY8GrKp5TaDdOAzdb5p7pAmWFNR6fwYKg54K98T/wiL/Et3+pErVnZsZiNNWRhpvVjYT
	erO9l/9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PwH-0000000COX4-1ckb;
	Tue, 01 Sep 2026 14:58:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1PwF-0000000COUp-17Wz
	for linux-um@lists.infradead.org;
	Tue, 01 Sep 2026 14:58:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AA7BA602BA;
	Tue,  1 Sep 2026 14:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2676D1F00A3F;
	Tue,  1 Sep 2026 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274694;
	bh=r4lrJRkT6oIO9uz4byVKnhiX3ckXssiVruBvq7U+FfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YawVhUJAl4XJC+0lJg0JqnzvyLoGpclba5vFqMseu8aQdeAfRNCqF/n89C5BFnRn4
	 ZMgZnt00svTZ7gKmJhtJ04BvxTdeX+//rW59BNZmOABb8rXM8WE4tuFSRJOTY0O+a3
	 wzlzCcKF1wjNushRp8DgVQU/dXj39smX7CyBzSJH1YujqkwHIJgLd/5F0hTLEiXvwp
	 rpILnJjIGoK4ZqXwRp1daZvUbnKwICqiVWNfsFNqVZML5vihbF6lJP71+QoQZ6nnn8
	 cGO6BziajnHnrbES/E803CCkdcHeqva1iZHlGmQ767J9u+QH407m0Ng6QB+EJcNiWk
	 vNW9n5eYCeh4w==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v5 5/8] lib/crc: x86: Stop using cpu_has_xfeatures()
Date: Tue,  1 Sep 2026 07:57:37 -0700
Message-ID: <20260901145740.42337-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901145740.42337-1-ebiggers@kernel.org>
References: <20260901145740.42337-1-ebiggers@kernel.org>
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

Checking both boot_cpu_has() and cpu_has_xfeatures() has never really
been needed in practice, and it's never been universally done (e.g.,
lib/raid/ omits cpu_has_xfeatures()).  Nevertheless, both x86 and UML
now explicitly clear the AVX and AVX-512 flags if their xfeatures are
missing, which should remove any remaining doubts.

Thus, remove all the calls to cpu_has_xfeatures().

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crc/x86/crc-pclmul-template.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/crc/x86/crc-pclmul-template.h b/lib/crc/x86/crc-pclmul-template.h
index 02744831c6fa..893119bb7c07 100644
--- a/lib/crc/x86/crc-pclmul-template.h
+++ b/lib/crc/x86/crc-pclmul-template.h
@@ -27,16 +27,14 @@ DEFINE_STATIC_CALL(prefix##_pclmul, prefix##_pclmul_sse)
 static inline bool have_vpclmul(void)
 {
 	return boot_cpu_has(X86_FEATURE_VPCLMULQDQ) &&
-	       boot_cpu_has(X86_FEATURE_AVX2) &&
-	       cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL);
+	       boot_cpu_has(X86_FEATURE_AVX2);
 }
 
 static inline bool have_avx512(void)
 {
 	return boot_cpu_has(X86_FEATURE_AVX512BW) &&
 	       boot_cpu_has(X86_FEATURE_AVX512VL) &&
-	       !boot_cpu_has(X86_FEATURE_PREFER_YMM) &&
-	       cpu_has_xfeatures(XFEATURE_MASK_AVX512, NULL);
+	       !boot_cpu_has(X86_FEATURE_PREFER_YMM);
 }
 
 /*
-- 
2.55.0


