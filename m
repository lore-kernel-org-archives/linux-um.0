Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33007D690EE
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gR64ER62sWlRWtO+6RPJvOcU4SuQheV2QuvDXjQ0vTI=; b=2o6jaTz1BfayXRBXya6KAkzqFP
	WNzeL74bNIBCt7loMKKb7pNFGHoo58+Y+MNlKqR13RsblxQatd9QN/T9iIuhw83dZLO7IDZNqJ8RD
	zLLz7lr2wxY2gqamcCJQL3Dadz+0IV7vy9rOCa1Ju7KJDYQVTCfX0ten6zzXVK/WrfrdKQ1DXqdBK
	H04l1XsPfwIEwmqCKB7Wq49PJxUdj00fkp7L+ElfYLCnm0266V9Thfpz81kBVrq1NQuXCDPvDDwy2
	x3GEtKjy+/rwbgDZxRQ5w8+fIQqle2Y7vxTz2DwWsY7kpvmqw08AjsVAkli6zA53qEN1QEzF0X/7N
	AGKvB0mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZxE-0000000F0uN-3zCc;
	Thu, 28 Nov 2024 08:32:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwU-0000000F0pY-2fFL
	for linux-um@bombadil.infradead.org;
	Thu, 28 Nov 2024 08:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gR64ER62sWlRWtO+6RPJvOcU4SuQheV2QuvDXjQ0vTI=; b=Hzc5Os31eSZkVtg9jPaqbXRjIk
	n7IbLuJPKNdT4EtWDi1I3zT93FdxiYgWzgeNZFuw7oDg16S1tiYU+INKXG/PuUGErI7WxYrpXzldR
	uQo790riEXI2Egyeapr8Xd8BHfzF4aN1OEcQx+OjeL+81oz7TaImQG1nLp7yAKGMxwkTNUIzlvHkp
	2hBFgSKYf5u/e0KkxjhFjabuP+YYb0GXKw/mqqkKK8+/0vA18jrXHhhwExudeAa8tSuj13sQniTZn
	z6w8DV4J0v0MJUSuaT9d4X3XC9/qEqC0qszzyEggJEbxh6U/XskWMG7U/148O7Xab2bS4Opwt+IIC
	/dEsWzcg==;
Received: from out0-215.mail.aliyun.com ([140.205.0.215])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwQ-00000001Yho-0AZS
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732782709; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gR64ER62sWlRWtO+6RPJvOcU4SuQheV2QuvDXjQ0vTI=;
	b=NkPG46xAGfIC4NNTIEpFUh70YvxbFk/OITxlQsZ5VJzMP96oCDW/2wZ+QcDElBsBm3yNTemkKb7ylyLKc4sHy8mqxKD0PIEZXRZDEwItHI2hAWShnoOQQNYaCHJuLYD6WwI2Ao14sZoTP8gCfS4MHN6gpk9hht+ryY9y8viyflM=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP07WWG_1732782708 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:31:48 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 7/9] um: Remove unused PGD_BOUND macro
Date: Thu, 28 Nov 2024 16:31:35 +0800
Message-Id: <20241128083137.2219830-8-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
References: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_083202_869208_75B2C8F5 
X-CRM114-Status: UNSURE (   5.43  )
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

It's no longer used since commit 11100b1dfb6e ("uml: delete
unused code").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 3f0be24b3633..13f3bfeb6378 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -19,7 +19,6 @@
 #include <um_malloc.h>
 #include "internal.h"
 
-#define PGD_BOUND (4 * 1024 * 1024)
 #define STACKSIZE (8 * 1024 * 1024)
 #define THREAD_NAME_LEN (256)
 
-- 
2.34.1


