Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF737EFD208
	for <linux-um@archiver.kernel.org>; Wed, 25 Feb 2026 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ufH5nmkXpWJzJI9ksuEPClUSVztzr8yoo3w4HNv6hNs=; b=1dj7FP5rw0q9fHFc1dLfUpdNmo
	gShIcfz7WNFWaXc2wGmE/JXidxOn0ZfbjRiXWjV4RuIJ51ZVrEYfYFPjTaF9s/6QzTbYmbghlcTah
	amEXPt0e4H/59CNP2rW4ywbFrAh9jN7DS0QzvZzapBNWJUMWDyyCuRtXF/frJ0uOqirdJhfikmYfs
	dRaXqJbEID9pXC33dCeMMRbYtW2fOiHOcVnJplUA9Kf0f2GKSuFAyImFYFMjzqwC8WfKSbLgceOqr
	ov2tCE6wesN8TeNdyJXaMQL4zRWUn2ZdSz56753BSw2RIOzdfQTmq0lcmn8iUvGOVwfdr6sZ8PQNX
	xKQLyzSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA4c-00000003Vvs-1el1;
	Wed, 25 Feb 2026 08:16:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA4a-00000003Vs3-1x39
	for linux-um@bombadil.infradead.org;
	Wed, 25 Feb 2026 08:16:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=ufH5nmkXpWJzJI9ksuEPClUSVztzr8yoo3w4HNv6hNs=; b=Mmq68F8t9iXSChdGELiWDsNJLd
	8OG/TPsvLoa5DbdGyQYZ3CJ4PkX3vOCVC35dsXgv5ND1ai7018gqDXkadwSMH89CkcMfFegwDAccK
	P8dYsAB51W1AIqgpzjhCXiXDul4suw+606HO6zxGF2u1gX3MNk08VDIgn+h01ASmqO+pAD9pbUWLi
	gjn4JsObv+v9KF8izkJodmHYkcd8CgVtzwDzOcJjyA/B2f86Bhp2awM5/ewVASI9ElpkCT1QXMBlb
	K8rX2IDaXk4+ADfP4L40oyWOmsMOep/KWX16cJLLlF316U4ZZAXjFIpIw8vyKESdZx3i6H9qzOwYd
	qrArBBpw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA4X-00000000jXG-2PlT
	for linux-um@lists.infradead.org;
	Wed, 25 Feb 2026 08:16:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufH5nmkXpWJzJI9ksuEPClUSVztzr8yoo3w4HNv6hNs=;
	b=e5kUXn/3mhffdK3f9Raaf/GTZGh/L6Ie1W/AsQ7SgVhmeoJCDKGLXPxi9DNqJnvFDyVNGX
	9HCm6ucWNDeoJ88wccLJregxSzVz8/csWyKfgxA5jzOLkP37NA6uhyrzSy0CPcKuWWJnM3
	vqBB7MHXLu2YQJ2Vl0rf8+CudM2NOPg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufH5nmkXpWJzJI9ksuEPClUSVztzr8yoo3w4HNv6hNs=;
	b=e5kUXn/3mhffdK3f9Raaf/GTZGh/L6Ie1W/AsQ7SgVhmeoJCDKGLXPxi9DNqJnvFDyVNGX
	9HCm6ucWNDeoJ88wccLJregxSzVz8/csWyKfgxA5jzOLkP37NA6uhyrzSy0CPcKuWWJnM3
	vqBB7MHXLu2YQJ2Vl0rf8+CudM2NOPg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufH5nmkXpWJzJI9ksuEPClUSVztzr8yoo3w4HNv6hNs=;
	b=HRqhc9PLD9SrWJunPqvxDVzXGrOv/La6n9M39SyDXv9rOiFnazq48VcmZC6dlgeETpnLr1
	yJGQi6rkeBFqpRoI6Hf3LGRrprKHL/5JzL4p8PEy60rgoqfYjOUTRnXABew4BRbv07IkuF
	LGPDeRSDwf0rfoqhyTFUglen2uV0Ni8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Jj4asdUeMuyAfccAe_OsEQ-1; Wed,
 25 Feb 2026 03:16:33 -0500
X-MC-Unique: Jj4asdUeMuyAfccAe_OsEQ-1
X-Mimecast-MFC-AGG-ID: Jj4asdUeMuyAfccAe_OsEQ_1772007391
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B293618005BC;
	Wed, 25 Feb 2026 08:16:31 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C45A1800465;
	Wed, 25 Feb 2026 08:16:20 +0000 (UTC)
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
Subject: [PATCH v5 11/15] arch/x86: don't initialize kasan if it's disabled
Date: Wed, 25 Feb 2026 16:14:08 +0800
Message-ID: <20260225081412.76502-12-bhe@redhat.com>
In-Reply-To: <20260225081412.76502-1-bhe@redhat.com>
References: <20260225081412.76502-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 96-MEWE0_wFZPcIyoci_eFLdUdBZJM8SEoshv-hXrTI_1772007391
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_081641_787207_476DB6BC 
X-CRM114-Status: UNSURE (   7.61  )
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

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/mm/kasan_init_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 998b6010d6d3..5ebf2850c77d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -343,6 +343,10 @@ void __init kasan_init(void)
 	unsigned long shadow_cea_begin, shadow_cea_per_cpu_begin, shadow_cea_end;
 	int i;
 
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg_disabled)
+		return;
+
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
 	/*
-- 
2.52.0


