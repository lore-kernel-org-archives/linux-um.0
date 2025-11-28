Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6B3D116F1
	for <linux-um@archiver.kernel.org>; Fri, 28 Nov 2025 03:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IKXZUrmhKSnLBrasgIFsU0j1OV2RdKEZHqiMi8x1qZQ=; b=h4G5omOnB/vWvqeh6pqWIVDinv
	4I4H9o6JOs6/9CuOD6posvo8Hfo0igU1zlVWjv0YyVsuq/XysIgnIy81Dl1+XkXQ1u0UAIvH3tX1n
	AY2OBwYBBVy2zzABlgVnwpVRbYhuMb0l131J3tiNSJvUyXEFWK1DALUksMO97w8gaZ9ie2hK/GNFg
	+DquN9b8O2/nQ4RgLrTvmo2eqy7Wdhh59ZkjPFII2hbPjMAaUGByZ7pK8rnXLVKH/bx/laJOI5Qxc
	UlhkwaPSX+Q60xn4Xu3tEA3fuV9qNdcDioEzu2FFGyzaZadMMqokt7Sub/FiE0EqQOcRYkN7NksAF
	AtFk+skw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOpGR-0000000HXB0-16gB;
	Fri, 28 Nov 2025 03:35:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOpGN-0000000HX94-3obi
	for linux-um@lists.infradead.org;
	Fri, 28 Nov 2025 03:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764300915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKXZUrmhKSnLBrasgIFsU0j1OV2RdKEZHqiMi8x1qZQ=;
	b=VqQLxoZjE1jXNhrUtq2A+0hGiEFi33m1M8AmWRS91Q4rWzG1jExaFzztt21rLLax5YLAM3
	jWFX1prwXwX1/R+yZyR8rpxejJ6opn7nsvY1dC9rmWgqgjqEzM+YBKDEOU+DP6qOfgm3EH
	O+93x1ABZrCF2ktL+gL+U+2/rNtR584=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-_d3nj9KnOtCZzyg-FTOf-A-1; Thu,
 27 Nov 2025 22:35:10 -0500
X-MC-Unique: _d3nj9KnOtCZzyg-FTOf-A-1
X-Mimecast-MFC-AGG-ID: _d3nj9KnOtCZzyg-FTOf-A_1764300908
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E284195608F;
	Fri, 28 Nov 2025 03:35:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6219519560B6;
	Fri, 28 Nov 2025 03:35:00 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	elver@google.com,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>,
	linux-um@lists.infradead.org
Subject: [PATCH v4 11/12] arch/um: don't initialize kasan if it's disabled
Date: Fri, 28 Nov 2025 11:33:19 +0800
Message-ID: <20251128033320.1349620-12-bhe@redhat.com>
In-Reply-To: <20251128033320.1349620-1-bhe@redhat.com>
References: <20251128033320.1349620-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_193517_307030_92770C4E 
X-CRM114-Status: UNSURE (   8.86  )
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

And also do the kasan_arg_disabled chekcing before kasan_flag_enabled
enabling to make sure kernel parameter kasan=on|off has been parsed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-um@lists.infradead.org
---
 arch/um/kernel/mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 39c4a7e21c6f..08cd012a6bb8 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -62,8 +62,11 @@ static unsigned long brk_end;
 
 void __init arch_mm_preinit(void)
 {
+#ifdef CONFIG_KASAN
 	/* Safe to call after jump_label_init(). Enables KASAN. */
-	kasan_init_generic();
+	if (!kasan_arg_disabled)
+		kasan_init_generic();
+#endif
 
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
-- 
2.41.0


