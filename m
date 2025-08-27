Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAD1CA0FF0
	for <linux-um@archiver.kernel.org>; Wed, 27 Aug 2025 00:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uyxo0bYEQAIOPSz05jSvyQiC4/vJ1m/lECYVC5EfYlI=; b=bz1iVhhpZOWHMlvVHxaqO2vFkf
	3OWvpY7R0Vl7QCGNX8amfHVd9LZg32nQqxRrE2Jg9cO20rZ3VdfVoBMsmAzb9MgqSojp3MrEqEBb3
	KE3dxaDA3LyS4u+PZnHlsLBu2vROIvM604pnVUF++mYEyPbjS5Ex7GPeVco3LPmLcQPrql5JeAmSe
	J6Ib0MFldWzS2Cb9tWfPCGqiapWO+Zm2NyD94Xxpc86e/vMlAcfZ/78sY51qdF321Nkg5d5mMKJnS
	duTyY1Lp8ZBoXDF/kSA4SRGSi2XvcMmaNZnnN5kYQjF8Ff95ILGTUdMGo3S/Tp6LkWTH1IEow7dW5
	8xypR2TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4Ty-0000000DTYU-2Sp4;
	Wed, 27 Aug 2025 00:57:46 +0000
Received: from out-182.mta1.migadu.com ([95.215.58.182])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4Tv-0000000DTNI-151q
	for linux-um@lists.infradead.org;
	Wed, 27 Aug 2025 00:57:44 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756256250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uyxo0bYEQAIOPSz05jSvyQiC4/vJ1m/lECYVC5EfYlI=;
	b=pnZlzbTgcxdl590QArWqUqnBrJUqhFmrWtmOL/iYKlkKRwL+ol3u9mO5pbmG+PN9laUVLI
	EjsXdlrwr/kAQZbOYke1qfM1QcBoP/JdyLFbNTVG+HImV9yTKRwBzUDmRyk8bugjJb2boS
	Yi4ocZ5pRJb4rnW1QERlOuLW1fNVpq4=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 2/7] um: vector: Fix indentation for help message
Date: Wed, 27 Aug 2025 08:56:58 +0800
Message-Id: <20250827005703.3847636-3-tiwei.bie@linux.dev>
In-Reply-To: <20250827005703.3847636-1-tiwei.bie@linux.dev>
References: <20250827005703.3847636-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_175743_456254_348661A5 
X-CRM114-Status: UNSURE (   8.28  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

For consistency with other help messages, use four spaces for
indentation instead of a tab plus a space.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/vector_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 9bbbddfe866b..25d9258fa592 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1721,7 +1721,7 @@ static int __init vector_setup(char *str)
 __setup("vec", vector_setup);
 __uml_help(vector_setup,
 "vec[0-9]+:<option>=<value>,<option>=<value>\n"
-"	 Configure a vector io network device.\n\n"
+"    Configure a vector io network device.\n\n"
 );
 
 late_initcall(vector_init);
-- 
2.34.1


