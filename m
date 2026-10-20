Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71788606A334
	for <linux-um@archiver.kernel.org>; Tue, 20 Oct 2026 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XXgcGhp6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m63M6dXV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mnqWj0L2iKBatloG5NRziYL1v5hJ5rWUbOHkD7Qml8o=; b=XXgcGhp66+wG+gP/HhHlQFKMeq
	LWnRN169cx50M+kPa+DQ2IkIVtS//Z6NYnrTwiWaKItbZzvXYssNgJa5mjtup0Mdr64ad+lfD1DHK
	ywDelk8jXG8cKQorw2o8ZBz6kWLVs29rbFw7qk9NE9iAMk7MEFnJHYcAQSFm6udglBGcBGUlHZ2mf
	PxaBhG4we8Vjs+MvrlDJov1ITk9y2rXVtmox/eR5X3t84ew9ZXwUI73iOyAV/TduGPVad9BVFy8wH
	1HEdNEYug6zQmjSsoN7CFAEI1G3j1liVwHygfxK3PEO/cM4IZMI9lR83jR1YS55NwIYOy9e9tKR3l
	WaHUxQIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ49p-000000091QD-1LnQ;
	Tue, 20 Oct 2026 07:21:13 +0000
Received: from mail-dy2-x0a.google.com ([2607:f8b0:4864:36::a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ49n-000000091Pm-3Brn
	for linux-um@lists.infradead.org;
	Tue, 20 Oct 2026 07:21:12 +0000
Received: by mail-dy2-x0a.google.com with SMTP id 5a478bee46e88-33baa8eb238so2073635eec.0
        for <linux-um@lists.infradead.org>; Tue, 20 Oct 2026 00:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792480870; x=1793085670; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mnqWj0L2iKBatloG5NRziYL1v5hJ5rWUbOHkD7Qml8o=;
        b=m63M6dXVuKWAhjMR6ueIYYANn9BBS3ZlXx7qE2XMvK5nkodFo1Ntc5tsFX0Pbww7+U
         bwMP0F+kwuEHAtO+q98oTHAMgupqXSvBjybqQmuazFctbBbvemTOblxzILB78vXHUuOn
         Jw2FJipNirkeFvCJlRyNmo+v8GSXjLALhnrOUT/1h6Ys6LWoIkJbk9FNjhbAaSa0V7lj
         7qYGLDzaL0jjSeI2/lu3MF2mxNRSYbslj82vNhAe3WBjEPfgA5T8v+F6h4zvCUIpRSzo
         gCH2piJnljnShW4VWyDOzyJVd2o3yXwC1LTkq7kikHYDuf28HflNb0vTYHejzo87ikp8
         R/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792480870; x=1793085670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mnqWj0L2iKBatloG5NRziYL1v5hJ5rWUbOHkD7Qml8o=;
        b=dp0UiZ8V//JthlUxZ1dBviCyDXUKRM2UrSALhymedL0tFAsjFjv7RmXBsTgHO1AvX1
         lqeHDUE6vqacHL9VsR+ilZo7RCLr9AVskVLM0JlJjWa3r0SaW9tMBzcMWKtjmCi3NbZD
         M7nmyJBfGX7TDh4wKiRPK27C1cwiIXZJed1ReT9CPSnjHLOYOsiBbjZI19UDjBEAdMjn
         L7YLwZoQ0e+LZ5GSLDRK4JBqg9/tLDtK9i2nASuiWmF4zG+KadmnIs1M3l35FYEVtPBo
         3Vviylbl4iuG6u9G65iok1Vf65jT9bSlnc6QZWvIKKZZLumBM0OW6DP/zibIuif4QoUJ
         uYag==
X-Gm-Message-State: AFq9FYKN9cYbbeCcGalN+zUZALAr5CwtaYeNC65P7ObqUhqr8b7j/o5K
	GF+Vkt2gGzqBHW1JyGgaf2imlPDrDJXhwXX4cgDvnxT0wvdJQ5B8o7Tc
X-Gm-Gg: AYBFou2q+nt6cV1g2y1AICDyFawrjGvo7379P/tTfH/XN/8Tx/bfddc6WVGRoQqGu0Y
	0jx07ZKDV6gm3P37JpeKHq8vlHXYrpTSM1VQ3wno69zDVKVT7v6awbvlliM8lBb5Du9+WqbUXhe
	ix4FHyZRPST/yIic1g8rIyJc/ZJinaC/V+YQMScqlfO8hZSQvXpWfLyXftMem9S2KfrZjs4Xp58
	sN5KWRNCP50e2iuShThiipN1LaU21aw5oasINIeSBQf9OpwZ+Xtg09Z3ynykfe+6eriLcuGZ5sT
	katFe7ADfGZHUtNbGFAy4NucrTBIJQPgStgzj8Gd8M4BsteTXE7Ac6t45eMJorbtOJqNpbfaM4f
	VGMKqMsfsWRL+AyoiUAYdyOmTCLlkTRy5k2E9EuCOniucAYXTCc4534ySXSbTJzUjFI8rpB58vA
	8xMqESWtvKh3fviy4C3TXhxDH+nCKAxLfVW5UTvjBQoTqZtW5M0O8D3IO4+q7rUx+WXd1CDQB7V
	pkDClFLtImbbJWZ3MX3QDz/gg==
X-Received: by 2002:a05:7300:a98f:b0:35a:3c46:80d5 with SMTP id 5a478bee46e88-3619b7ff05fmr19032434eec.0.1792480870323;
        Tue, 20 Oct 2026 00:21:10 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cc23sm43988998eec.2.2026.10.20.00.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:21:09 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] um: vector: use kmalloc_objs() for the message vector
Date: Tue, 20 Oct 2026 07:20:35 +0000
Message-ID: <20261020072035.8980-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_002111_798963_57B1A3E7 
X-CRM114-Status: UNSURE (   9.44  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allocate mmsg_vector with kmalloc_objs() so the element size is derived
from the destination type and the allocation helper handles multiplication
overflow. The default allocation flags remain GFP_KERNEL.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 arch/um/drivers/vector_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index e902e78c5ff6..d6127944b202 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -528,8 +528,7 @@ static struct vector_queue *create_queue(
 		return NULL;
 	result->max_depth = max_size;
 	result->dev = vp->dev;
-	result->mmsg_vector = kmalloc(
-		(sizeof(struct mmsghdr) * max_size), GFP_KERNEL);
+	result->mmsg_vector = kmalloc_objs(*result->mmsg_vector, max_size);
 	if (result->mmsg_vector == NULL)
 		goto out_mmsg_fail;
 	result->skbuff_vector = kmalloc(

base-commit: 4ad423aa2108485f8bc5dde51fdf9c1ed979ee4b

