Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB710C4332F
	for <linux-um@archiver.kernel.org>; Sun,  4 Dec 2022 13:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=um51lVm4nSlfY7lWje1s0gf4m/ixNbd07Hzx0OMQt3w=; b=OHXwYX9bjSqvRf
	UKC36f4vQxUoZ/WtQBXRz599ucXl2vyOBWsYAPPJ1KUNBbYo+OPLOcVMJlNREykpDf+oAgMxMZW3b
	4QXABLPjc+YKr/FB0ZbMqdW9Y/BECguWNgyC8r6gwbwsVy1IDms28Sjg/iIHb8BSc5pNm1FFnuZSM
	4AcJSsuLa66wrth35iEU1LUuG3ifUHCA237Eo0UVOyyj9sxoLMx1+x4BpRD6jM8Q2Y/1D06Xhowb0
	hy2/S+ig6+jSBTEN/Aq9cCnRAbf1EyaK7SwpD/yLUgP7aKTH9O+wjhMjzyMdKV/INPfq1GnVzyLrJ
	j9bXWH4PRQTsliWkJH7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1owe-008CEc-Fm; Sun, 04 Dec 2022 13:22:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1owX-008CAR-Eh
	for linux-um@lists.infradead.org; Sun, 04 Dec 2022 13:22:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 863E560DDC;
	Sun,  4 Dec 2022 13:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B45C433D6;
	Sun,  4 Dec 2022 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670160123;
	bh=/N4+1ICTq4Tnoftodb+i7fsD1R/4aMkMhsB2THYI6d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTAOHpmKu5V1ZB3eUCqaBq7rVAEbxd+dr3k0cJ8pp9eU57ovrJPpnMQ1dk0/JCBi7
	 sPWz5mdX/g9FbtC+Fxslg9dttAi1Xl7wCDcd9JEmcs9XRIvMIsiEQ7DOHN+XWa23If
	 MDHCW39VeWfw88R3YiHVR29F9NIqnu12fqRbP/b3392+w87qxembDatMRzqTr+sctJ
	 ZHJZ7kXkfQ8n7Li/gZC0RBtoBrllDLkYtd7u1DAyOIPdNOUYUUVgYBxJBz4/XtKh8+
	 DbC1NNP2wdu3Ps0qgV7WO8vuKT6gBRfj9U/q2P9+qwG0TO5JREX1YJrXv/zLHjmC/k
	 DevFwms+FRPWg==
Date: Sun, 4 Dec 2022 15:21:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Christoph Hellwig <hch@infradead.org>, linux-rdma@vger.kernel.org,
	Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v2] infiniband: disable IB HW for UML
Message-ID: <Y4ye8YOWk0V/BqKL@unreal>
References: <20221202211940.29111-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221202211940.29111-1-rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221204_052205_610955_E525332A 
X-CRM114-Status: GOOD (  15.96  )
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

On Fri, Dec 02, 2022 at 01:19:40PM -0800, Randy Dunlap wrote:
> Disable all of drivers/infiniband/hw/ for UML builds until someone
> needs it and provides patches to support it.
> 
> This prevents build errors in hw/qib/qib_wc_x86_64.c.
> 
> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: linux-rdma@vger.kernel.org
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org
> ---
> v2: just disable infiniband/hw/, not all of infiniband.
> 
>  drivers/infiniband/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)

I added rdmavt to the mix and applied.
https://lore.kernel.org/linux-rdma/20221130200958.25305-1-rdunlap@infradead.org/

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 6ee97c898231..a5827d11e934 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -95,8 +95,8 @@ source "drivers/infiniband/hw/qedr/Kconfig"
 source "drivers/infiniband/hw/qib/Kconfig"
 source "drivers/infiniband/hw/usnic/Kconfig"
 source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
-endif # !UML
 source "drivers/infiniband/sw/rdmavt/Kconfig"
+endif # !UML
 source "drivers/infiniband/sw/rxe/Kconfig"
 source "drivers/infiniband/sw/siw/Kconfig"
 endif
(END)




> 
> diff -- a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -78,6 +78,7 @@ config INFINIBAND_VIRT_DMA
>  	def_bool !HIGHMEM
>  
>  if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
> +if !UML
>  source "drivers/infiniband/hw/bnxt_re/Kconfig"
>  source "drivers/infiniband/hw/cxgb4/Kconfig"
>  source "drivers/infiniband/hw/efa/Kconfig"
> @@ -94,6 +95,7 @@ source "drivers/infiniband/hw/qedr/Kconf
>  source "drivers/infiniband/hw/qib/Kconfig"
>  source "drivers/infiniband/hw/usnic/Kconfig"
>  source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
> +endif # !UML
>  source "drivers/infiniband/sw/rdmavt/Kconfig"
>  source "drivers/infiniband/sw/rxe/Kconfig"
>  source "drivers/infiniband/sw/siw/Kconfig"

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
