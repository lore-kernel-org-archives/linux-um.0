Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDA7EFD208
	for <linux-um@archiver.kernel.org>; Wed, 25 Feb 2026 08:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4hnbGAm/9+0AQuOsI/z6/MObWdWASDtilCdbwr5t2xI=; b=PaWhDTDFv6MliaENPjO+YO7bTg
	Uk/Z1iNSSvKVL1pgdNPpzzZRHcLJ3IVbFV+wxNX9YPiV1+kh9zOOOQqRz1a+MHGnCCORjWFmoWBES
	xNnfaSee7CfEvW0bsz2VcksYH9NdmeLcMxAuAeGX/CbCDwTuNFMNph39kiEQ2AiMl+brCKhcDfVMW
	PGgFMqYDNhOCBQa15qoNAImVQSWSsUV9bD+rdLODagKjugbKQVcZU0mO4Of2qEhqdT7OiyL4oYm/x
	7XS3PbBpSlvdL1igjmOj9erPeYwGzd/F0kgptBtIwEgfB6QX/MvfDb22kA55Hr1UhOaz7w9RPqC5i
	qtP22quQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA4m-00000003W7g-05xn;
	Wed, 25 Feb 2026 08:16:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA4k-00000003W4q-2X7O
	for linux-um@bombadil.infradead.org;
	Wed, 25 Feb 2026 08:16:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=4hnbGAm/9+0AQuOsI/z6/MObWdWASDtilCdbwr5t2xI=; b=vHhRVxhe2bKs8iYTThtvMnQRnE
	793Nbp2ZH71POOErwO3h5HURsxQxpMOwixITerObI+GEirDAzdd/NSHRo8M8CMio1bV4Jp9FCkgLb
	aMJc1XzUGOnQbcryoCF9Bo2K1vCfWIwzo4ZVH6/3Xo+zdbdnU4wPio+ZOtsuw3N5dBb34GTs3130J
	YayCrJuiCt+kHVASFrSn0vVj5U1/yfUxGKWIxvSxKhVL1d6J5bJiIYbPSL4zuwN0sL0x7myqZuPcv
	P1jMK4o0y7oOo9DKzf9SW0a5lIBZm6UlJywCT4UKMCerV9Gb3de9QLgDCFS0APpt2upx1XC6pO5/K
	gPrM/4xg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA4g-00000000jYy-1bwq
	for linux-um@lists.infradead.org;
	Wed, 25 Feb 2026 08:16:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hnbGAm/9+0AQuOsI/z6/MObWdWASDtilCdbwr5t2xI=;
	b=CstRHfmzJW0SAxDBPeC8ZrG0UQEVnejWHsT7+J6zBnovr3XL6d49DauJKhaz0IgqFNeuDJ
	DU9rwxvTwFZH6qTLcBApGqxhQlUbYi5dT8J1vLN5Nq3/ZuIj7q1SzYvHvSt3Fy4j65menh
	a22Uzgw9wwAS5YqRE6kpiUKCeFNa+vo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hnbGAm/9+0AQuOsI/z6/MObWdWASDtilCdbwr5t2xI=;
	b=CstRHfmzJW0SAxDBPeC8ZrG0UQEVnejWHsT7+J6zBnovr3XL6d49DauJKhaz0IgqFNeuDJ
	DU9rwxvTwFZH6qTLcBApGqxhQlUbYi5dT8J1vLN5Nq3/ZuIj7q1SzYvHvSt3Fy4j65menh
	a22Uzgw9wwAS5YqRE6kpiUKCeFNa+vo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hnbGAm/9+0AQuOsI/z6/MObWdWASDtilCdbwr5t2xI=;
	b=CstRHfmzJW0SAxDBPeC8ZrG0UQEVnejWHsT7+J6zBnovr3XL6d49DauJKhaz0IgqFNeuDJ
	DU9rwxvTwFZH6qTLcBApGqxhQlUbYi5dT8J1vLN5Nq3/ZuIj7q1SzYvHvSt3Fy4j65menh
	a22Uzgw9wwAS5YqRE6kpiUKCeFNa+vo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-kB3PHjUANFi-zOP_mIJF6w-1; Wed,
 25 Feb 2026 03:16:43 -0500
X-MC-Unique: kB3PHjUANFi-zOP_mIJF6w-1
X-Mimecast-MFC-AGG-ID: kB3PHjUANFi-zOP_mIJF6w_1772007401
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6D5A19560A7;
	Wed, 25 Feb 2026 08:16:41 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8570F1800465;
	Wed, 25 Feb 2026 08:16:32 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org,
	andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	linux-s390@vger.kernel.org,
	hca@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 12/15] arch/xtensa: don't initialize kasan if it's disabled
Date: Wed, 25 Feb 2026 16:14:09 +0800
Message-ID: <20260225081412.76502-13-bhe@redhat.com>
In-Reply-To: <20260225081412.76502-1-bhe@redhat.com>
References: <20260225081412.76502-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: kgirDAlCtkfDugyB5VkafJEyCXeOy1cmJ-KQdMa9ZIM_1772007401
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_081650_537828_10B65E17 
X-CRM114-Status: UNSURE (   8.52  )
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

Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.

And also call jump_label_init() early in setup_arch() so that later
kasan_init() can enable static key kasan_flag_enabled. Put
jump_label_init() beofre parse_early_param() as other architectures
do.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/setup.c  | 1 +
 arch/xtensa/mm/kasan_init.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index f72e280363be..aabeb23f41fa 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -352,6 +352,7 @@ void __init setup_arch(char **cmdline_p)
 	mem_reserve(__pa(_SecondaryResetVector_text_start),
 		    __pa(_SecondaryResetVector_text_end));
 #endif
+	jump_label_init();
 	parse_early_param();
 	bootmem_init();
 	kasan_init();
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index 0524b9ed5e63..eb367b801218 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -70,6 +70,10 @@ void __init kasan_init(void)
 {
 	int i;
 
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg_disabled)
+		return;
+
 	BUILD_BUG_ON(KASAN_SHADOW_OFFSET != KASAN_SHADOW_START -
 		     (KASAN_START_VADDR >> KASAN_SHADOW_SCALE_SHIFT));
 	BUILD_BUG_ON(VMALLOC_START < KASAN_START_VADDR);
-- 
2.52.0


