Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DF0CA0FE6
	for <linux-um@archiver.kernel.org>; Fri,  1 Sep 2023 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RpL5x9/YbaDjVjc0PqweZbwbCLQHtgHmhD+3PJ3EwVs=; b=yH7+6O4/eebr1W
	gbyg5eNGne8K81eF0eGdJbjzIShshvG0a9OqXGjKR1HA6tXFgg/HzBujjsPIc5xGbzyix4eFnXv1/
	hUef3eu+ViN9ZCAKAEcQcbRQ8tby1mzt3bvQXhxpTUK1k0lC3RsxXLA3o7wwkyIgW8q4fXKpC68FF
	nYyEhauqq75DsAARp7PWYdEClTrW037x2MOWz5PjeY44qqc6McfI59shaOt1oXY8DdPTq4NIKlVNT
	r+rOuLj2lYUC+cyiKfqcgxb1FZrYdpVJMA+OZ98GNo9rdSvKUIAlp9YZgsBAxwh0VdXo+1Br9mQNu
	Jf6lQ1ViReA1pbzCB4zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qc4JZ-00HZl0-0S;
	Fri, 01 Sep 2023 13:35:57 +0000
Received: from smtp1.axis.com ([195.60.68.17])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qc4JW-00HZkM-23
	for linux-um@lists.infradead.org;
	Fri, 01 Sep 2023 13:35:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1693575354;
  x=1725111354;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=N6etfJze35By8LfXFdbrd19JU35OJUDOzD8xl1EMvVU=;
  b=HZ9DfWiSMUXeBolC01fgneQK4z2RIamuxpMMp1QsEuDm43vTYkq1yjrP
   USYhpF6vC/oy13gD/cRo/TgOZ/qraVz3bTOWpK7QjBpGLqh2q3pGiiGhc
   5gpNhaW5nCavgG0qLtYKxfvCXu5/s9YlI6fscIWlR9bwHZ4C7ZfjDnGnm
   yf3awUis0XVCJLAYRpf1p4FB83HGRxXoZDOX12KKD66zYdOPCWOwaJbEY
   PxgxJRuZJl90I6Tci2b6vjITdOq6qzvRGouY3DJuWVTr0ruILUYMd2M3f
   NkYbm9GNnqgfLK5PtLEQ7IvNdWOKCivYmMWUoFzTjESrxE90IgNhKYoCx
   Q==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date: Fri, 1 Sep 2023 15:35:43 +0200
Subject: [PATCH] um: virt-pci: fix platform map offset
MIME-Version: 1.0
Message-ID: <20230901-uml-virt-offset-v1-1-5c1f320a037d@axis.com>
X-B4-Tracking: v=1; b=H4sIAK7o8WQC/x3MSQqAMAxA0atI1gZaJ6hXERfSJhpwotUiFO9uc
 fkW/ycI5IUC9EUCT1GCHHuGLguwy7TPhOKyoVJVrYzSeG8rRvEXHsyBLnSm0Ww7tk3rIFenJ5b
 nPw7j+34PfYvcYQAAAA==
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_063555_020426_20848107 
X-CRM114-Status: UNSURE (   9.48  )
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

The offset is currently always zero so the backend can't distinguish
between accesses to different ioremapped areas.

Fixes: 522c532c4fe7 ("virt-pci: add platform bus support")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/drivers/virt-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 7699ca5f35d4..2adcd14e1d74 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -969,7 +969,7 @@ static long um_pci_map_platform(unsigned long offset, size_t size,
 	*ops = &um_pci_device_bar_ops;
 	*priv = &um_pci_platform_device->resptr[0];
 
-	return 0;
+	return offset;
 }
 
 static const struct logic_iomem_region_ops um_pci_platform_ops = {

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230901-uml-virt-offset-d941fc6fc45d

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
