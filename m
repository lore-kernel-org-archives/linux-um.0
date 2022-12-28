Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B32C4167B
	for <linux-um@archiver.kernel.org>; Wed, 28 Dec 2022 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jCWeuD+NxZiW5CYHBTFp2dloWtJwnL79mDlaSqrzG/Q=; b=NdiXPX+oCgxFEA
	+1dANLSEm3Ej/IOUNQatOb05NLhpavy8Elek1VXzM2QbdUfkhNpj7KuvSU+IJxLSLRAdQX+LNVhGu
	fO5zFMKhgDhaLP7VKM5Lp66xKFklyCaAeFkA+n7l70BKaihOHgVaYkW0wPEs7wnH9RFsMBpDLKJhF
	kQ9WWtOBKqkPI5eZ3gKzEuXGI5bk6PzMEpTCCK8dwqv9h2YLL/Svs4uQYEfT69tlB/1yckoLyjXmT
	B93mA0MQFEuianSCwRpIx0z+Bb1co8ZGcUXvE5AbaaTUbJG3NkFcHI3gqcoL9WmX51XzvIjycGcvO
	tN0pZnRWQao8AR5M9CiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZ4g-006GPo-Se; Wed, 28 Dec 2022 16:14:39 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZ4a-006GN1-UK
	for linux-um@lists.infradead.org; Wed, 28 Dec 2022 16:14:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6C7ADB817F6;
	Wed, 28 Dec 2022 16:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967FAC433D2;
	Wed, 28 Dec 2022 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1672244070;
	bh=kRTk6nDVGgy/CNk4BdTNcr95TadAdi4NeD1/gJZGOy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xQ+d3ZBR+gZXp58Ww6HB66erW3F66DZ8Qle5N8gUVH+/nWaUk6JzDlJpkmiNByabZ
	 3/Y7pQUubgnI3gotnak4F/5P76tHrCZf40fYqOqsASVYzQob1oRamjY4eQmNlp5l6R
	 PYyuYJ6SutFgGDuncyUalZEmwXyM+UUA1bvUMXzg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-rdma@vger.kernel.org,
	Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.0 0641/1073] RDMA: Disable IB HW for UML
Date: Wed, 28 Dec 2022 15:37:09 +0100
Message-Id: <20221228144345.450630069@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221228144328.162723588@linuxfoundation.org>
References: <20221228144328.162723588@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_081433_153935_C4B5380D 
X-CRM114-Status: GOOD (  10.80  )
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 323a74fc20f53c0d0e13a16aee703a30d9751235 ]

Disable all of drivers/infiniband/hw/ and rdmavt for UML builds until
someone needs it and provides patches to support it.

This prevents build errors in hw/qib/qib_wc_x86_64.c.

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-rdma@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Link: https://lore.kernel.org/r/20221202211940.29111-1-rdunlap@infradead.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index aa36ac618e72..17a227415277 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -78,6 +78,7 @@ config INFINIBAND_VIRT_DMA
 	def_bool !HIGHMEM
 
 if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
+if !UML
 source "drivers/infiniband/hw/bnxt_re/Kconfig"
 source "drivers/infiniband/hw/cxgb4/Kconfig"
 source "drivers/infiniband/hw/efa/Kconfig"
@@ -94,6 +95,7 @@ source "drivers/infiniband/hw/qib/Kconfig"
 source "drivers/infiniband/hw/usnic/Kconfig"
 source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
 source "drivers/infiniband/sw/rdmavt/Kconfig"
+endif # !UML
 source "drivers/infiniband/sw/rxe/Kconfig"
 source "drivers/infiniband/sw/siw/Kconfig"
 endif
-- 
2.35.1




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
