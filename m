Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0EFC47258
	for <linux-um@archiver.kernel.org>; Tue, 23 Jan 2024 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6wBb4qQBTjRG4qCKgqlX5rEI/gvPtNFtR103JaQWAfU=; b=OqO4cx5ziz8cEk23XVOavGw1Y8
	Q8Iu25vPTG0QdaBDWPkVxeiicFfG9I5M3paSvFO5LCQsyBEEsQUIbJxXSofaCAdzA2uQs9GIBEZwY
	0rVEd/sZ2L87W5jSz5Pbr+u2eRlgw2hxdRuxl0Un/lc4zewAva9C2ezfBDwXgrKhMhtZVOc1+q7wG
	HSiyxlQiTuzOk3dJnFChlTKI8m2foJvMCumkpoXcBovLKdz/4S2w9C/jJYzI0OrDHhCvx4F34FKzG
	BT9h+0K6R/AuW2r1Dpg+jdMWfWwMwCTTukSsZy1TegdpNpqrXUiLPPNOJu+3nLipqOweAfaXh+RGm
	1rk0TyRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEZY-00G3n4-1O;
	Tue, 23 Jan 2024 11:04:04 +0000
Received: from out0-221.mail.aliyun.com ([140.205.0.221])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEZU-00G3jU-0D
	for linux-um@lists.infradead.org;
	Tue, 23 Jan 2024 11:04:03 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.WDCKTjv_1706007836;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.WDCKTjv_1706007836)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 19:03:56 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 2/5] um: Fix the declaration of vfree
Date: Tue, 23 Jan 2024 19:03:44 +0800
Message-Id: <20240123110347.1274217-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
References: <20240123110347.1274217-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_030400_280931_D8986A49 
X-CRM114-Status: UNSURE (   8.85  )
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

The definition of vfree has changed since commit b3bdda02aa54
("vmalloc: add const to void* parameters"). Update the declaration
of vfree in um_malloc.h to match the latest definition.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/um_malloc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/shared/um_malloc.h b/arch/um/include/shared/um_malloc.h
index 13da93284c2c..d25084447c69 100644
--- a/arch/um/include/shared/um_malloc.h
+++ b/arch/um/include/shared/um_malloc.h
@@ -12,7 +12,7 @@ extern void *uml_kmalloc(int size, int flags);
 extern void kfree(const void *ptr);
 
 extern void *vmalloc(unsigned long size);
-extern void vfree(void *ptr);
+extern void vfree(const void *ptr);
 
 #endif /* __UM_MALLOC_H__ */
 
-- 
2.34.1


