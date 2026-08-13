Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6B0C5DF67
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4lrJRkT6oIO9uz4byVKnhiX3ckXssiVruBvq7U+FfI=; b=4S/dhN6XxjCDMdZ/Lb3sfaWakf
	v11sI6vwGI028rCt2RtqPOay/vXtrhY+Q0GtS2LDfrSpTMBrbVcgeUJnJ5ipXY6lpBUyCWstBH9LT
	oBAY95OnpDRAQYfdMhWo8I+wrMbiw5paNLArauc/YJomtchTY/7eSHPXFRk8vXCwkKXrUNcYhWQw5
	u106Iu6RoYRinH68Qy4tHr7lEnJbQFAz6kbyBC5+jEsH4RYexWJg8vgkJt+/4THmItxRAaQc7ztti
	wHdb35/lqmLeHqY4aPHipUYz0WX6M33RCpqc4Hma96FZRTH2F6CdkfHISdc2midkNOJ53x/XHNP6R
	wQ+QxZ8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuL3N-0000000HGuy-3M8m;
	Thu, 13 Aug 2026 02:20:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuL3M-0000000HGuk-4AbJ
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 02:20:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BEFB943FCF;
	Thu, 13 Aug 2026 02:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7461F00A3A;
	Thu, 13 Aug 2026 02:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786587620;
	bh=r4lrJRkT6oIO9uz4byVKnhiX3ckXssiVruBvq7U+FfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IgiWjcmVhU1gKXdR+1IvaeAgk+3vKhkKAgCls+SdvY1Tl+fuzFVGuERmu/8/5/3HY
	 bHrmDIWanBHy3f2c8rMsmLqWeUZwgU0coN5CVoWDwvvqvXW7z30hQIwWK12f0DIF2u
	 HhxzF4M1x4q4dhxl2cbfE4LH4QOgE0XDwWuT/CPangnuSbxr6G6YvYobfLgA0lt2zb
	 Xd8uulN7c2B868pVEU2hPJMnJyyiHScfLtFb79BjSIxb8ufNfzCuk/TqvjG/2nCDhZ
	 kD0k8awSpCP+jC6+fvdcUzbeOeh+fz6h93yD1A01DFetYFFPf5s3ChMqEESbT6bpGT
	 s6hav4GzWX3KA==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 5/8] lib/crc: x86: Stop using cpu_has_xfeatures()
Date: Wed, 12 Aug 2026 19:15:03 -0700
Message-ID: <20260813021506.55129-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813021506.55129-1-ebiggers@kernel.org>
References: <20260813021506.55129-1-ebiggers@kernel.org>
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


