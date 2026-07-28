Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE17BC54F54
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 02:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HMiKFAZj2EqdrOBqduG8yVaf68o12cJkn4oOC9yg500=; b=uulZc00ZDqEPWMeYYiQ/61+iD+
	nOajOb7f4S9JgGfWYeD04/hmsCRDW7Ffcp6/98t0aBNmNc9mPbkiLDB0oMI1dmnJgyy6Dz7xbvtdA
	dfHqGFH74datgC/Yg7yFZsUjK2sBwVv4EJGZA1T4+6FKf1XRsuXlWm0xrDt2a3Zn4stFo9bTrpsIR
	jFMdkqUP1ZM1sdecom2POX5v1xHNI/sK86D3AUrEoXMe3K4dqQW/61VO1ZBxrnMbRg/WvBAFzYVAx
	MaaeDYqbT4EQlrDzG1MCKMTfnZU4Z1tkHYPva4HSNj4J/j33FGpubtB1uN9+ZLVOrTjK9qxOjU0+i
	UJVJBO4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woXPb-00000004Fex-2Y9c;
	Tue, 28 Jul 2026 02:19:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woXPb-00000004Fe5-0XgV
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 02:19:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8243B43C34;
	Tue, 28 Jul 2026 02:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316C51F00A3F;
	Tue, 28 Jul 2026 02:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785205158;
	bh=HMiKFAZj2EqdrOBqduG8yVaf68o12cJkn4oOC9yg500=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KuI8fwhJNrbxGysASEL1aCkLjr58cW54O1pC+RCnMxd5IvQotVhNN53FSu/HI+e4K
	 QQ71rkC8FMX53FYK/2U3CM1MW5iCKFtWsq1Z004UuivFLKy+AYUPDNrY+UNR7p0xm/
	 xMSVirmembNvJPL+PWaCC93usJUEI9HMUY8QTKFOfCd66sBWHFYCIpqFpiZm0BVPeC
	 z+NpjOe4TZ/Ue7Bbjt8wI9MkW15PKxurtwVz3VdbhQjh7fyxWK8/AtUHjGDX8YTOjr
	 Al74Lr3tgywUZP0zro6q+a3rO+Cr7Oh0Oe4344I5MPin+VzET8O1hYhKD44q45L2Cv
	 uxop0WQo1tahQ==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 5/8] lib/crc: x86: Stop using cpu_has_xfeatures()
Date: Mon, 27 Jul 2026 19:16:00 -0700
Message-ID: <20260728021603.79870-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728021603.79870-1-ebiggers@kernel.org>
References: <20260728021603.79870-1-ebiggers@kernel.org>
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

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crc/x86/crc-pclmul-template.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/crc/x86/crc-pclmul-template.h b/lib/crc/x86/crc-pclmul-template.h
index 02744831c6fac..893119bb7c077 100644
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


