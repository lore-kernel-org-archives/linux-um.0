Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756A8EB64DC
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1yRkZ2p+oarLikHe9isRA+t3i9h2KB3Ka5uGN1L0Xwc=; b=W5xvWEL/iW2Gw3
	qZG1IJu1wdpLxgKTDO8rI+MWAbtqrNjflseju/TVdDTQLTFLMuklTCkvPqjvJfjpaAYiz0kjau9f0
	Jf+EfPPyGNdoAUwNgMunEp40EWQ06hcHBqxlKl9aMAr3kjFGqjxpLw2yD/Wit8/8XrvDSAzOdYs3o
	49bgs7tlfr5RrfN167AA0rxARfSoRx3Wvoq4oUQSehVKvIN+hn9vpxAoVuNoJ59JmNb9y+KjjVIaB
	wglGGacFhoLnbFHXyfR09bgGAYppEqDREAQw5yIVoC2o/I08f+gbrzwP088iaKquFUI6lmt2zSE2E
	4tzin2lF55iiT1KMMJqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDObZ-007yZy-0l;
	Sun, 25 Jun 2023 12:12:33 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDObV-007yYa-0f
	for linux-um@lists.infradead.org;
	Sun, 25 Jun 2023 12:12:30 +0000
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QpqYF0C08zLn4F;
	Sun, 25 Jun 2023 20:10:09 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 25 Jun
 2023 20:12:10 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>
CC: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>, YueHaibing
	<yuehaibing@huawei.com>
Subject: [PATCH -next] um/x86: Remove unsued extern declaration ldt_host_info()
Date: Sun, 25 Jun 2023 20:11:20 +0800
Message-ID: <20230625121120.27584-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_051229_467929_3DC9C292 
X-CRM114-Status: UNSURE (   5.66  )
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

This is unused now, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/um/asm/mm_context.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/um/asm/mm_context.h b/arch/x86/um/asm/mm_context.h
index 4a73d63e4760..dc32dc023c2f 100644
--- a/arch/x86/um/asm/mm_context.h
+++ b/arch/x86/um/asm/mm_context.h
@@ -11,8 +11,6 @@
 #include <linux/mutex.h>
 #include <asm/ldt.h>
 
-extern void ldt_host_info(void);
-
 #define LDT_PAGES_MAX \
 	((LDT_ENTRIES * LDT_ENTRY_SIZE)/PAGE_SIZE)
 #define LDT_ENTRIES_PER_PAGE \
-- 
2.34.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
