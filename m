Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EA9C67871
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 04:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zCrQWoWX3kwpEnsX/d1KoXaODnVpopHpgvGanQX1raI=; b=NYh3hUDtQjh3w7
	AfzbhKqsVTD3zCp1z/VnHYKaSQzcB/xHHolUEu+EbWqbmTKe2VpPWacXF/COVcXFnau+fHHI88sH6
	qhpi/eVj66u2INoKggTq+B9pEY2WlByGkTRkOg5PrJwIWKOdaBtrz9xdOa+HG2IxQ5nCRHR4jUu62
	zwRJtHr1r7yPuBp+dfulZ69jPRUHdMiAUD3znm7VvzhaP9hdFzlnwxTv0ggPq/uSZWsaJHJ+VBtIf
	6mKK53E1JRW2NYUvfFUEVTZxton2He5FHz7YViq8MiyzXFiQDY27lcGVaCvns1wulkQRfsgXIKBxl
	gJ4jqWQdQMaOmRV4doFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGC0J-000RNI-8P; Fri, 13 Jan 2023 04:49:23 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGC0E-000RLF-98
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 04:49:20 +0000
Received: by mail-qt1-x82e.google.com with SMTP id j15so12796578qtv.4
        for <linux-um@lists.infradead.org>; Thu, 12 Jan 2023 20:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKL+FkRBVGdlcDPsmoeX6zsOGWo6bw9MhMVT8FhJJdU=;
        b=ThajRpZiQS+ExcexJ90RPZlFJIxRsZQjG67taK6tWkRw9iMA3nan6BucM5DTe4h9zw
         VuF25zZYkp7yPwo26kEeiPLtEHt+4ZiKwSJ0sKf16Bdcuoz1Q04Sm6usexU2OigzL5Yi
         /iGZLdM4lZHliaMCBWlR1YYumF/AWcpL/1ZUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKL+FkRBVGdlcDPsmoeX6zsOGWo6bw9MhMVT8FhJJdU=;
        b=vZUxy3D/ILu2uO/VViB8KltKl1BGsTIWddLhbRfqzlViMVKbtt6Wepa9p6N7mJ/3tY
         DR28xBWcVrgEf3Rd3HU8IMmxhI50OOpZrlTf58oS+WqIcn8a4Qobsnc3bphD7IIXiBrl
         JXM7SiFUD5pLR+9nQBEwAW2ZFRnRJiat+NcpR73g2ckEtRGTQnr3cbHbZNHoaQSj6EkG
         h0YZ1cR4zabnOJoP4CJELddt3TByO50dN66rwRx/QGqsnYXlqqGDuWSND3JCYFVkYXNE
         nvEDhPKBMCiwSMgQlnGGR0kRdo5vAWzKEs0YftRk8nAEAR7DeLOoawXrYRiaH5uV50sm
         tjGg==
X-Gm-Message-State: AFqh2kqKlmgx2jSdnqLZeKv4o4fqWn4atNhxnLEHXjDytp4TQl5PPbg0
	OkGKCq9z3QpHlV9zINwzpY8g8Hy3CF+KofLGLbk=
X-Google-Smtp-Source: AMrXdXu6WsXDkaK3qQyqiRnnE21ZhANn7yzKVtm6zCjaqywxitsRsQfF5r/SyGQmxC6Ta4YBcz0Ddg==
X-Received: by 2002:a05:622a:1e8c:b0:3ad:14d0:e8b8 with SMTP id bz12-20020a05622a1e8c00b003ad14d0e8b8mr27510609qtb.26.1673585355803;
        Thu, 12 Jan 2023 20:49:15 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm12099472qki.73.2023.01.12.20.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:49:15 -0800 (PST)
From: Peter Foley <pefoley2@pefoley.com>
Date: Thu, 12 Jan 2023 23:49:08 -0500
Subject: [PATCH 2/4] um: Avoid pcap multiple definition errors
MIME-Version: 1.0
Message-Id: <20230112-um-v1-2-6bec9e97ad13@pefoley.com>
References: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
In-Reply-To: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
To: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673585354; l=1145;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=6+vpUXmt9fMS9wiEsw48LBnr2Y8Q2+1VbsxVT5rxS4s=;
 b=ivWCsOmTeN9z2HCdfQL6ie4FA5ZbD21inE4lJMPPNuOfy5kT9In2CLmOBuwihABF5gX12oK1JB1R
 IxexZ61xBZ6QMNZ2ZjMihtKqGDBkWxJbBR7xVqq7XtCA1LMymnK9
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_204918_348385_A5E72E1D 
X-CRM114-Status: GOOD (  10.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Change the function name in pcap_kern to avoid conflicting with
libpcap.a.

e.g.
ld: /usr/lib/gcc/x86_64-pc-linux-gnu/12/../../../../lib64/libpcap.a(pcap.o): in function `pcap_init':
(.text+0x7f0): multiple definition of `pcap_init'; arch/um/drivers/pcap_kern.o:pcap_kern.c:(.text.unlikely+0x0): first defined here
---
 arch/um/drivers/pcap_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/pcap_kern.c b/arch/um/drivers/pcap_kern.c
index cfe4cb17694c..25ee2c97ca21 100644
--- a/arch/um/drivers/pcap_kern.c
+++ b/arch/um/drivers/pcap_kern.c
@@ -15,7 +15,7 @@ struct pcap_init {
 	char *filter;
 };
 
-void pcap_init(struct net_device *dev, void *data)
+void pcap_init_kern(struct net_device *dev, void *data)
 {
 	struct uml_net_private *pri;
 	struct pcap_data *ppri;
@@ -44,7 +44,7 @@ static int pcap_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
 }
 
 static const struct net_kern_info pcap_kern_info = {
-	.init			= pcap_init,
+	.init			= pcap_init_kern,
 	.protocol		= eth_protocol,
 	.read			= pcap_read,
 	.write			= pcap_write,

-- 
2.39.0

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
