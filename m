Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F4FEFD202
	for <linux-um@archiver.kernel.org>; Wed, 25 Feb 2026 08:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m4icHQGTRNbNNPTctslHsQ21pBhC6HpCZWDHuC81RQQ=; b=1iKxdKUEkGTdLEZ7kr0EfGgRL8
	RAGPggqdGJJ9fAi9wFR+m4t1nVXtLbHBGm0D7yizMmqet5IrsTQLzZ0Ho7D7dJeZQNHyTBejTAmSH
	+EltIhKx/uyWmTT9O0SJvtkNob14f+HTPVCjGEs249v0J8k8oFV0DQS99WbWhqxCNCGEj4lpN6dTu
	ZYJfk+iQqRlWRi5wEJch+EoSWzI5bZkIy8Yj69Mr744uMvmJvJYZdW5JAgpqgxZ/SPMlVzJ2RCN3B
	Fn+/Y19WWZaRnJEvQjvWVf3ttJEVZ9TBj4yOBLutLa3LSxhNje81WZfumQX6ly7Gj3k88+g8QXuPf
	NE/SS2og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA34-00000003UQn-31n8;
	Wed, 25 Feb 2026 08:15:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA30-00000003UOY-307u
	for linux-um@lists.infradead.org;
	Wed, 25 Feb 2026 08:15:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4icHQGTRNbNNPTctslHsQ21pBhC6HpCZWDHuC81RQQ=;
	b=gChPkYouGfDHV+XebMlbXtMgisfdUvrkIp01dNimnEsH7g5EbY6Ocgy2YCfu7TwLVi7B9j
	S/CY10ZjM4huI3AS+E8OPepAO2av32o/+yPwo5xrC+sjhkG8ysyPqasX/k2IWPeT7ak5WI
	Ok4NOmScxWWv4e2ObCudOn/7k+1Hrh8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-dIDhZlzRPtCltfWDvHZypQ-1; Wed,
 25 Feb 2026 03:15:00 -0500
X-MC-Unique: dIDhZlzRPtCltfWDvHZypQ-1
X-Mimecast-MFC-AGG-ID: dIDhZlzRPtCltfWDvHZypQ_1772007298
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1EFF180025C;
	Wed, 25 Feb 2026 08:14:57 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EC9E1800465;
	Wed, 25 Feb 2026 08:14:49 +0000 (UTC)
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
Subject: [PATCH v5 02/15] mm/kasan: rename 'kasan_arg' to 'kasan_arg_disabled'
Date: Wed, 25 Feb 2026 16:13:59 +0800
Message-ID: <20260225081412.76502-3-bhe@redhat.com>
In-Reply-To: <20260225081412.76502-1-bhe@redhat.com>
References: <20260225081412.76502-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 7AZkQyH1_fBXNPW-ywBcRICl5LEDfjmQ1a1fC1_x6ow_1772007298
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_001506_827759_24E2A645 
X-CRM114-Status: GOOD (  11.34  )
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

And change it to be a bool variable. This is prepared for later
usage.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/kasan/hw_tags.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index cbef5e450954..26a69f0d822c 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -22,12 +22,6 @@
 
 #include "kasan.h"
 
-enum kasan_arg {
-	KASAN_ARG_DEFAULT,
-	KASAN_ARG_OFF,
-	KASAN_ARG_ON,
-};
-
 enum kasan_arg_mode {
 	KASAN_ARG_MODE_DEFAULT,
 	KASAN_ARG_MODE_SYNC,
@@ -41,7 +35,7 @@ enum kasan_arg_vmalloc {
 	KASAN_ARG_VMALLOC_ON,
 };
 
-static enum kasan_arg kasan_arg __ro_after_init;
+bool kasan_arg_disabled __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
 
@@ -88,9 +82,9 @@ static int __init early_kasan_flag(char *arg)
 		return -EINVAL;
 
 	if (!strcmp(arg, "off"))
-		kasan_arg = KASAN_ARG_OFF;
+		kasan_arg_disabled = true;
 	else if (!strcmp(arg, "on"))
-		kasan_arg = KASAN_ARG_ON;
+		kasan_arg_disabled = false;
 	else
 		return -EINVAL;
 
@@ -222,7 +216,7 @@ void kasan_init_hw_tags_cpu(void)
 	 * When this function is called, kasan_flag_enabled is not yet
 	 * set by kasan_init_hw_tags(). Thus, check kasan_arg instead.
 	 */
-	if (kasan_arg == KASAN_ARG_OFF)
+	if (kasan_arg_disabled)
 		return;
 
 	/*
@@ -240,7 +234,7 @@ void __init kasan_init_hw_tags(void)
 		return;
 
 	/* If KASAN is disabled via command line, don't initialize it. */
-	if (kasan_arg == KASAN_ARG_OFF)
+	if (kasan_arg_disabled)
 		return;
 
 	switch (kasan_arg_mode) {
-- 
2.52.0


