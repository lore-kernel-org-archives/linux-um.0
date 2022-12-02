Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD1EC4332F
	for <linux-um@archiver.kernel.org>; Fri,  2 Dec 2022 21:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Pxs3OXPF+z+z0ignaVQ0piB8A9rEfi3M92BvqPLoans=; b=BrTiBWEqE2IRAg
	knMTB0l5u8nW6wm2w3GW1aVffB0przSTEwKKLoAyFrRKg9TGf4ExpDtWnqFAAjDvrfJKqH2kIUA1H
	FP34zbeDwSacTzc03Fz/CiDQvERuNC4nbVkwL7VSWCODHFCNlpAiph3NQovu6JdvPW3iGL99EGY2B
	FkBPH/vUwlKj6wGg+Sk2Kq9VdkdulqPkZAe4wxzV2jOIRfev+EJmk+XkIXdPqgCPNvxnknVRcMEMG
	wYAbOwJjmp+RLCBwAeU0hKqgvMN5z+sOSV0PUUfiQmscuuNe73l1WlOcfrfXIAwMpmm/hwBeRVy0m
	vj0pe80mAnxwPcCOw2iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1DRo-001LsB-50; Fri, 02 Dec 2022 21:19:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1DRm-001Lrj-VZ; Fri, 02 Dec 2022 21:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=oV6byBYn0tYljp79kb76vPExm6qPuaFXLFbzIN1Gi3c=; b=lnJcPZFJS0R/dpvl0Gq+K5lQSR
	YmE2/eMHy0Y8CPju06DjtzSTvdcfzjDWl9/42ArRjqWkNLYlUnHaqldz/k/hvFkHAg0Z0I0uQplpo
	TMwbvD9pjvr8iPdEv/YtwLMgRf38lM0dcer5EYpq5KuZwUMAd18+79Dza6xICzBqczHxV0nw+n+D5
	QRFpFbtq5MTJJTHRY6luSsVrGWtZVWcRPCFI/GvClnINnKe7dShzFjnHj1pcGLZqdlBlTH3O+j3HP
	3n6YSaFFQHFVXpp8492HMQ+jtTAfk6SER0KdDMI7FWNfw8i37o8k7R8nLjNbkez2Uz6lahb95DKdP
	lTkOALHg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1DRp-000X5k-Sp; Fri, 02 Dec 2022 21:19:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-rdma@vger.kernel.org,
	Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH v2] infiniband: disable IB HW for UML
Date: Fri,  2 Dec 2022 13:19:40 -0800
Message-Id: <20221202211940.29111-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

Disable all of drivers/infiniband/hw/ for UML builds until someone
needs it and provides patches to support it.

This prevents build errors in hw/qib/qib_wc_x86_64.c.

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-rdma@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
v2: just disable infiniband/hw/, not all of infiniband.

 drivers/infiniband/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff -- a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -78,6 +78,7 @@ config INFINIBAND_VIRT_DMA
 	def_bool !HIGHMEM
 
 if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
+if !UML
 source "drivers/infiniband/hw/bnxt_re/Kconfig"
 source "drivers/infiniband/hw/cxgb4/Kconfig"
 source "drivers/infiniband/hw/efa/Kconfig"
@@ -94,6 +95,7 @@ source "drivers/infiniband/hw/qedr/Kconf
 source "drivers/infiniband/hw/qib/Kconfig"
 source "drivers/infiniband/hw/usnic/Kconfig"
 source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
+endif # !UML
 source "drivers/infiniband/sw/rdmavt/Kconfig"
 source "drivers/infiniband/sw/rxe/Kconfig"
 source "drivers/infiniband/sw/siw/Kconfig"

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
