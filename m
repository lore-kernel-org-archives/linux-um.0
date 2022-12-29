Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79514C4332F
	for <linux-um@archiver.kernel.org>; Thu, 29 Dec 2022 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=r9d5/dtXwKJ+jYBdMq+qim1bQDOBB6T++e4ex+q/k9s=; b=OjfkAVKeTUsMyl
	IgXMhZl9E1OcOaa09fG2HYid/hN2DAaBWta8sSLd/YVSRE+QriI2lH3oAToTLlHk9fZ776fwl394r
	Dr1kT0DsMAF3ild+pd1K24H1n6wKFFJbhTtybJobpXeviEfGwBghQB0rhETYaaP9WmQUfstkTuQE/
	1LaS+f6VazgIkqYMpXLQylWrQ9+/6qDwze7FzQUfdtf8OjEXo3NAK2f+lNZlA6ZiQbx/7uKBiGNPE
	t8j5TXcrM3LXw5v4LqCZphOaEt/0PGSuMbWTBawApERQ6hAjeZokHvcWxyVPJYyzrjwr9q8bR+cye
	NgK+fCsC+MTJZeea0RRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAnjO-00DR0g-Pq; Thu, 29 Dec 2022 07:53:38 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAnjK-00DQwo-5B
	for linux-um@lists.infradead.org; Thu, 29 Dec 2022 07:53:35 +0000
Received: by mail-pf1-x436.google.com with SMTP id e21so2592411pfl.1
        for <linux-um@lists.infradead.org>; Wed, 28 Dec 2022 23:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDeSYbJRD5UIxf0kkPf6Les3H3nIVnzcLc/ji7ALnCE=;
        b=qtpzgTHlnAUEX2ly37pMS8tGaRlIXK0hm2KhLHj9n1OgGC9mPJ4R3s1wEEjDXcr7v8
         LH/xO2CKUW7TThMnCXMQEU9Fk5xFelRz6bQcuIWar7ylBvHdnqsKlrLT9D6avGwhi1k3
         LmoOfoEoWvjBIA2cf40UqTdy6hKv1svsnmqN10EGTR7WwHtxWgAwe08tA8Sp5BiuBktj
         2ju9o7VcUAj4/KeelGsnMQNp3IcuNtJuvIASxr7+eJX/yilF8MgvPSYnudnfAm3/5xvt
         i0tWic8Sgt7ZkiBubZUj1ckNt5qyowqTIWpqOgNKZPebk0yxzwrGsJBHf+fMUC3tgzj5
         Y/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDeSYbJRD5UIxf0kkPf6Les3H3nIVnzcLc/ji7ALnCE=;
        b=ikS0jGcG0xikT82URluJW9iscUSyyOGcJoRUg91FNA85oMEsWbdxouAAa5AK6LZwAi
         lB9VbEP+iDasOrHcNoSPa38CURYYLkeG6tweLNWHuqqEQkzjV1GpD5NXUR5SNmdjiD0r
         iKJrJMYrgrjtqmVpVKMtb7aK/d+pHjq46zgdQMSHXKS4PoAAmQ9lVCrSlRhQi+EwexvN
         jGyYPtyVbzEEhHIPOnxaBwRfNvQ2hjE1HDy3m6PdtoGJZg9GDmwW3IaxtjLSITlmjrIX
         iBPk8C2K9d117a3NBfx5Vv2B/heSX8WzsS5AgoqBr8H3P4C6bx2OheDvs3N01bw5F0g+
         qRBw==
X-Gm-Message-State: AFqh2kolwxGb/TbLa6xDMhWBAUtn6cjDZcYd5pK9oOJvN8TlwQczlUMX
	+7HlWiqWDHVMbi4D3hhromWsoc96aS/IOEL5
X-Google-Smtp-Source: AMrXdXv9sdoL0oUYN50GZYSQ/Q+vg/lYZGOj0iBbbAfLxbLORZ9wpsaC7se50iwwDrJg9KKX5LDS8w==
X-Received: by 2002:a05:6a00:410b:b0:57a:9482:843b with SMTP id bu11-20020a056a00410b00b0057a9482843bmr31812196pfb.5.1672300412939;
        Wed, 28 Dec 2022 23:53:32 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x24-20020aa78f18000000b0058134d2df41sm6126235pfr.146.2022.12.28.23.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 23:53:32 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Miaoqian Lin <linmq006@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: vector: Fix memory leak in vector_config
Date: Thu, 29 Dec 2022 11:53:21 +0400
Message-Id: <20221229075323.1394010-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_235334_286587_06884246 
X-CRM114-Status: UNSURE (   8.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

kstrdup() return newly allocated copy of the string.
Call kfree() to release the memory when after use.

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/um/drivers/vector_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index ded7c47d2fbe..78f32005dd90 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -765,6 +765,7 @@ static int vector_config(char *str, char **error_out)
 
 	parsed = uml_parse_vector_ifspec(params);
 
+	kfree(params);
 	if (parsed == NULL) {
 		*error_out = "vector_config failed to parse parameters";
 		return -EINVAL;
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
