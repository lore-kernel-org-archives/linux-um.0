Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FC6EFD208
	for <linux-um@archiver.kernel.org>; Wed, 25 Feb 2026 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dmXeuzqCGEXbsFr6BMS6DZRu4kl8OFDlvdktSaTFzJk=; b=SdCTui9aAWTP8Okx0Rl6u99DH+
	MDMRgBXnf9lJ+o4OBqWMp4d23HVRUM1J5FnQ1b7dUGrYXOSVaiYQFxUrvmj6FQJuC/aU/ILyU7Ilf
	Pzj5R20w8TzqPQTNkE2h4GX3acfhmR3BqLB1lsS677jfUUXuvAq/G1Oj084RhapkeF4LA43eCSuhV
	g5/HQIlXh7g/xHP3Ua86UYXx2xqbhLS7PZydoUYyP2Yi6ER/AhEM/PflYwODKPhbIWFKFNnEDNo64
	ehR1i+cR2IVpL1EPA9r0/q5cl0KqzTOaYGQnLuZ9Gz64wMo7+6dGV4Lr0DrIBYFBOSiBfcMEfQzqf
	bWsnHMUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA4R-00000003Vgb-1dIp;
	Wed, 25 Feb 2026 08:16:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA4P-00000003Vca-0jae
	for linux-um@bombadil.infradead.org;
	Wed, 25 Feb 2026 08:16:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=dmXeuzqCGEXbsFr6BMS6DZRu4kl8OFDlvdktSaTFzJk=; b=eFo6JeehSUmLbH9QVegTiH+LQn
	lDO80fLea+upxVIxAa+AjFw5QaeVt0qnULcwTPGEzoAhV1lNTO2Qw81xrMx2EkMsrmDHY29zqrNgc
	jCjZdw+/0oFdp1msqfOkmJeoilkjC+va9mi5YjbAGEDHDKxAD6LNWiuPkwrpiBkxXFThdeUn9HfGk
	G3kckSUEONLbNvFUryhcQlm0vp8/dhRxqkNBx3/sG5vMB/cA8viH61K+t4bp4m5hwnx7no/ZbRUwJ
	O6yQ+46pW/HHRcjQIYwiYIaCxSqP63AWayv78May4xOUqzqgWJiuZvMOEgmLvpO3H8wBTaWIC1RxH
	E7nexBNQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by casper.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvA4M-00000000jV2-1ZZ3
	for linux-um@lists.infradead.org;
	Wed, 25 Feb 2026 08:16:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmXeuzqCGEXbsFr6BMS6DZRu4kl8OFDlvdktSaTFzJk=;
	b=KlL766V4LKpzIoV5MxdQFDymkLuC3tZICns4HUJE2G4htjLLHZeJvjrQsje6kvgNeBzM2q
	WfLd1pGMP96fLcrDnobuNuHdZpPSeQC14d9TPcg4CGieCGvdtQMzSeWewTebaMv7lZEKB9
	4FU5a2BBsndqYjoe8xUooyBs3VU4wnw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmXeuzqCGEXbsFr6BMS6DZRu4kl8OFDlvdktSaTFzJk=;
	b=KlL766V4LKpzIoV5MxdQFDymkLuC3tZICns4HUJE2G4htjLLHZeJvjrQsje6kvgNeBzM2q
	WfLd1pGMP96fLcrDnobuNuHdZpPSeQC14d9TPcg4CGieCGvdtQMzSeWewTebaMv7lZEKB9
	4FU5a2BBsndqYjoe8xUooyBs3VU4wnw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmXeuzqCGEXbsFr6BMS6DZRu4kl8OFDlvdktSaTFzJk=;
	b=PhfQq/542TlWYSSMbJc6t04TVm+N3qbYO267XZBRcfXzhXlSGPeUFolUmsi52wCpk8cyea
	hvMlO2uKCZKGSWMtYcbIwLzGMWm677yLgTaZS2cp0OhllGXQN7XcFKXWJg3ZrgXED+68gI
	5upVwR5qWEneRefpALW706fygEZRhEo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-YXdFjCA1Mnetuo5LYiwicw-1; Wed,
 25 Feb 2026 03:16:22 -0500
X-MC-Unique: YXdFjCA1Mnetuo5LYiwicw-1
X-Mimecast-MFC-AGG-ID: YXdFjCA1Mnetuo5LYiwicw_1772007380
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F2CF1800282;
	Wed, 25 Feb 2026 08:16:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37D111800465;
	Wed, 25 Feb 2026 08:16:09 +0000 (UTC)
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
Subject: [PATCH v5 10/15] arch/riscv: don't initialize kasan if it's disabled
Date: Wed, 25 Feb 2026 16:14:07 +0800
Message-ID: <20260225081412.76502-11-bhe@redhat.com>
In-Reply-To: <20260225081412.76502-1-bhe@redhat.com>
References: <20260225081412.76502-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: jxuMT7zuz8FTE4BCwebv4KrMDqIDKRh9ojLbvvIrMvA_1772007380
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_081630_555383_0CD7EFFC 
X-CRM114-Status: UNSURE (   7.48  )
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
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/mm/kasan_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index c4a2a9e5586e..dc7cc0dcc7eb 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -485,6 +485,10 @@ void __init kasan_init(void)
 	phys_addr_t p_start, p_end;
 	u64 i;
 
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg_disabled)
+		return;
+
 	create_tmp_mapping();
 	csr_write(CSR_SATP, PFN_DOWN(__pa(tmp_pg_dir)) | satp_mode);
 
-- 
2.52.0


