Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAC1D132B5
	for <linux-um@archiver.kernel.org>; Mon,  4 Nov 2024 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oNPCbRRC5kFw9ptz+pnC+2aPTM4Yaky57TSQ/Rupsrw=; b=A4VhnVAGh5BOZODtoDteS4SOiq
	F0MW0GaMADbn2QvryVZ9QDSlTaar+KYS0el0O6XraiBe77SznGX87AhEVS6H6M8JrNx3YQY2Qr+ET
	m4wx0TsiqKAMeWTY0hJuaLGdIQUCjGX6Iw/B4LVDEBCM3zq6k8euTuRnPHBgldJWTXboxD7MEC9jP
	G5U4ceF1C73Z8/EL/qd9ux51TFIqKyVIWllNbbttnvre9S1gtNfzBa8g1LIHQMP0m31789ivsr/N9
	aYC7+yzh0YmR0F5KEJVy90HjFfprMsivwfQAt+Rbk8S/jTesBmL1Jy18Zg3nW/nlGQMceAKOvnbBR
	6JFGYXdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7wIP-0000000DiDS-0h9p;
	Mon, 04 Nov 2024 12:35:01 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7wIL-0000000DiCX-3SBY
	for linux-um@lists.infradead.org;
	Mon, 04 Nov 2024 12:34:59 +0000
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XhrTv3Wxpz1SDrD;
	Mon,  4 Nov 2024 20:33:07 +0800 (CST)
Received: from kwepemj200012.china.huawei.com (unknown [7.202.194.24])
	by mail.maildlp.com (Postfix) with ESMTPS id A7B6D1A016C;
	Mon,  4 Nov 2024 20:34:46 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemj200012.china.huawei.com (7.202.194.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Nov 2024 20:34:45 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <willy@infradead.org>, <josef@toxicpanda.com>,
	<brauner@kernel.org>, <zhangxiaoxu5@huawei.com>, <wanghai38@huawei.com>,
	<zhangpeng362@huawei.com>
Subject: [PATCH] hostfs: Fix the NULL vs IS_ERR() bug for __filemap_get_folio()
Date: Mon, 4 Nov 2024 20:34:40 +0800
Message-ID: <20241104123440.1347175-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemj200012.china.huawei.com (7.202.194.24)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_043458_055872_B95CD7B4 
X-CRM114-Status: UNSURE (   9.44  )
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

From: ZhangPeng <zhangpeng362@huawei.com>

The __filemap_get_folio() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Fixes: 1da86618bdce ("fs: Convert aops->write_begin to take a folio")
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 fs/hostfs/hostfs_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6d1cf2436ead..084f6ed2dd7a 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -471,8 +471,8 @@ static int hostfs_write_begin(struct file *file, struct address_space *mapping,
 
 	*foliop = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping));
-	if (!*foliop)
-		return -ENOMEM;
+	if (IS_ERR(*foliop))
+		return PTR_ERR(*foliop);
 	return 0;
 }
 
-- 
2.25.1


