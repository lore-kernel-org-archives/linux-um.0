Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BB7EFD208
	for <linux-um@archiver.kernel.org>; Wed, 25 Feb 2026 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oT83zYbQb0MMseAk5Xm5Eaz7XNiK7MPHbcs4LQizA5Y=; b=r7ao83vTkhWZY7CgTwghPOieLK
	9egav7XySkZ6PUXdbqWKYgCVD3JtCUcxeOHjRjemmEGkGuRUaUWUvAhi4v/QtWyUvWXwN8R7EurLA
	1ApyeJl/dJHom3Fszdm+oCFxjlY6PvcJHO4o1V5NN5KiFKaqjxOj6J0I3zQQMRF6Uv/dxMdMJQPF8
	tUl3UdqvUjJG8Ew4wGu6dYyOIMbpISNPyaZ+O201hGRaPI20SgpfptrAIDWRzIEUAyO191Grj2W/z
	74aMv/jzpzkrXcJGyYTkfJHNm37B97hUQzULX5Gx8v2bI1+GMLdF+5dDPAX+YUz5ue2+qwzqdG9WJ
	F79WFErw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA5D-00000003We7-2VeZ;
	Wed, 25 Feb 2026 08:17:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA57-00000003WUj-0SAJ
	for linux-um@bombadil.infradead.org;
	Wed, 25 Feb 2026 08:17:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=oT83zYbQb0MMseAk5Xm5Eaz7XNiK7MPHbcs4LQizA5Y=; b=Jps04HtGO2vwCw1FL/DOeqBFSs
	zQTbsd2Q1Vikui7GQGUW3NOBnUs07JRuSMyr1B3fzPSXHFqVWWF/TrtJwdNn/VKb8xI/nZCHqGkOn
	JDbHYI9Ivxy/7zfY76jqseZz1KgnOAFyFZF4rIb/6Y/WJZfIlLYh66nkcoF+V/ol4KQaMxX5msqdO
	4ognpCuLH3xNsRQbnidm4fv7Soa4TlAN9nr1VHrD48Bwle8f7Rdo5hYFamqecCXFheai+8c+O9mfs
	p7R0Lew4wEzMs0AQzU8FkH4NuONFWS+NfzyB094MUJUKNRRf5UsreKdmUUAqDSsG5DaM0jbS6JaBd
	GdXfJLTg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA53-00000000jgP-0sqY
	for linux-um@lists.infradead.org;
	Wed, 25 Feb 2026 08:17:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oT83zYbQb0MMseAk5Xm5Eaz7XNiK7MPHbcs4LQizA5Y=;
	b=HF6ceENmCOMyeQ8LrLa/o7C9DvtoQJB/T9BxRnGUVzm3w8DKP5Tm/WZ+EgfEhZv1cD2HmZ
	qEuHAkGtSUzy5yPDVZwm2XIkvf/qfGxGGwd+3/aKdKC6HoxVN4GRFhk+/LFSA4Q4fBpLLz
	LE3S5VzBhtzVUItTcVhnoakc9tjTBrs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oT83zYbQb0MMseAk5Xm5Eaz7XNiK7MPHbcs4LQizA5Y=;
	b=JQtmvt+COuzA8DtSwaCujo+BvxxvbGJ+GQ5fxNULM8N3uluR98ONiM2U/jzTMfVfBHdghh
	c0sXzoKgozUe0L34LdlMMd0CKi8JJqKSrq60UgMl6NjxzbJf6ZROJ04dDf+dRg04Y54REX
	MJgvXM12AGn6ggZCarrGwfs5lzxWve8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oT83zYbQb0MMseAk5Xm5Eaz7XNiK7MPHbcs4LQizA5Y=;
	b=JQtmvt+COuzA8DtSwaCujo+BvxxvbGJ+GQ5fxNULM8N3uluR98ONiM2U/jzTMfVfBHdghh
	c0sXzoKgozUe0L34LdlMMd0CKi8JJqKSrq60UgMl6NjxzbJf6ZROJ04dDf+dRg04Y54REX
	MJgvXM12AGn6ggZCarrGwfs5lzxWve8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68--PGROTGBN1uM5wyFliyqng-1; Wed,
 25 Feb 2026 03:17:06 -0500
X-MC-Unique: -PGROTGBN1uM5wyFliyqng-1
X-Mimecast-MFC-AGG-ID: -PGROTGBN1uM5wyFliyqng_1772007423
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA092195609D;
	Wed, 25 Feb 2026 08:17:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2EF4E1800465;
	Wed, 25 Feb 2026 08:16:52 +0000 (UTC)
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
Subject: [PATCH v5 14/15] mm/kasan: add document into kernel-parameters.txt
Date: Wed, 25 Feb 2026 16:14:11 +0800
Message-ID: <20260225081412.76502-15-bhe@redhat.com>
In-Reply-To: <20260225081412.76502-1-bhe@redhat.com>
References: <20260225081412.76502-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: XgFaHtUZOiTXaXi8oi8fgbObU7Bbxx-wFA2wM1jU1Lg_1772007423
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_081713_532182_BD4D6367 
X-CRM114-Status: UNSURE (   7.94  )
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

And also remove the relevant description in dev-tools/kasan.rst
which is hw_tags specificially.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 Documentation/dev-tools/kasan.rst               | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb850e5290c2..e0115fad9e60 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2899,6 +2899,10 @@ Kernel parameters
 	js=		[HW,JOY] Analog joystick
 			See Documentation/input/joydev/joystick.rst.
 
+	kasan=		[KNL] controls whether KASAN is enabled.
+			Format: off | on
+			default: on
+
 	kasan_multi_shot
 			[KNL] Enforce KASAN (Kernel Address Sanitizer) to print
 			report on every invalid memory access. Without this
diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index a034700da7c4..eaae83fcb5e4 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -129,8 +129,6 @@ Hardware Tag-Based KASAN mode is intended for use in production as a security
 mitigation. Therefore, it supports additional boot parameters that allow
 disabling KASAN altogether or controlling its features:
 
-- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
-
 - ``kasan.mode=sync``, ``=async`` or ``=asymm`` controls whether KASAN
   is configured in synchronous, asynchronous or asymmetric mode of
   execution (default: ``sync``).
-- 
2.52.0


