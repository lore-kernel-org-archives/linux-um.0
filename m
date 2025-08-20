Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CEDCA0EED
	for <linux-um@archiver.kernel.org>; Wed, 20 Aug 2025 05:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z1K+NrhffiuczGQxxvXLPTT8safjMr4ane+44BSMgbw=; b=Nz5MT/v9l8yNE2hm99eSqa0I3j
	ljXm0+kVfZsOTmB+/NV9XOJZmr4ngmopkMYM5mAG0S53EZG8NrHUSLSzOPA/U0Jzet4HpFWN7dyj0
	LivVKIVZ3FRH+r+/hRrSmucMpFoRLnYhlwRR0mbn8Wt/+gcdf7drc6IvbKqPnO2I3lmYyGlpFv/fk
	E/YsT9X3EGzU1fWkE4ybcC8MskSv2iwCTDdkwOvyZEp0PChNDzgOfm0VX1F0oHEOGuZw4Y4lc+tsi
	Ol7GDppCKQbMLGvF/ET2t4IQQrwq/HZeqVC5GjaQ3qNtxnLrDMdyplqy1GZr0JRoKD82jePCpgWOk
	wRAqVCTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobdf-0000000CRhh-22b4;
	Wed, 20 Aug 2025 05:45:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobVN-0000000CQOM-171A
	for linux-um@lists.infradead.org;
	Wed, 20 Aug 2025 05:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1K+NrhffiuczGQxxvXLPTT8safjMr4ane+44BSMgbw=;
	b=HR6ocByz7mw4F8A3NwodU+qxiioDXqR8oSQ1Umtfp+E5Vw4+b9dd+ksDTPkrXZacS3kPgL
	eek0BdaqzpVQwvgyO4Osld6GpNEWupdpH1HfQOgV1y4l+mMtd8kouOkzldsjznPx+RS2y2
	jLdMuVBkMC7n9iw4Ic3Gc+M11HObT1M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-FM4T_kMAMBejUgJcViqkcg-1; Wed,
 20 Aug 2025 01:36:56 -0400
X-MC-Unique: FM4T_kMAMBejUgJcViqkcg-1
X-Mimecast-MFC-AGG-ID: FM4T_kMAMBejUgJcViqkcg_1755668214
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62A951800366;
	Wed, 20 Aug 2025 05:36:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1826D19560B0;
	Wed, 20 Aug 2025 05:36:45 +0000 (UTC)
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
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>,
	linux-um@lists.infradead.org
Subject: [PATCH v3 11/12] arch/um: don't initialize kasan if it's disabled
Date: Wed, 20 Aug 2025 13:34:58 +0800
Message-ID: <20250820053459.164825-12-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
References: <20250820053459.164825-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_223701_378081_CB7F08B3 
X-CRM114-Status: UNSURE (   9.31  )
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

And also add code to enable kasan_flag_enabled, this is for later
usage. Since kasan_init() is called before main(), enabling
kasan_flag_enabled is done in arch_mm_preinit() which is after
jump_label_init() invocation.

And also do the kasan_arg_disabled chekcing before kasan_flag_enabled
enabling to make sure kernel parameter kasan=on|off has been parsed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-um@lists.infradead.org
---
 arch/um/kernel/mem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b5..7b7f838274b5 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -58,6 +58,13 @@ static unsigned long brk_end;
 
 void __init arch_mm_preinit(void)
 {
+
+#ifdef CONFIG_KASAN
+	/* Safe to call after jump_label_init(). Enables KASAN. */
+	if (!kasan_arg_disabled)
+		static_branch_enable(&kasan_flag_enabled);
+#endif
+
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
-- 
2.41.0


