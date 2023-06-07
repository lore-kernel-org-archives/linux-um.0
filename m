Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3FEC87FDC
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4bO+igkNU5wLER0GHESNFWykWqWu4RKTTR4rrI3bnHw=; b=w1yxDWRyxCgeSI
	EaioIQVDuJmt0rrr3jmyD94u9ivgPUcV3tn3BZCJad1qcvLkBBMlDgCctr/UliE8gVMbKde/eVK8J
	QSOAhbpLDui0lrZ2+tk6npShIfHR5XHFmkuOfiGYHzTmny2H9+KLs7N9WW59ZysIRLKGwq+Y84jqr
	P4DdP3zpkk1nbe4fQZTo1t8wOyaEkWWVo5yep/YUb7QaKJfsJ71t3yrppk29F3DFeCC57ah7qGer+
	Sqza8QoqvCc4u6sTOCwdMMvooXkTp8yTdRxnh55QoV3XRRLUwGruKwaUefh/xOy8jUKdL52WOgeCC
	iXulSgi/q42LTeLVEegw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oOz-004vva-2a;
	Wed, 07 Jun 2023 08:20:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oOv-004vtR-3B;
	Wed, 07 Jun 2023 08:20:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 73F3E60F7D;
	Wed,  7 Jun 2023 08:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59570C433EF;
	Wed,  7 Jun 2023 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686126016;
	bh=JsXN/EIW6Kqwigw4wGGVknucfkdIsZm79w1pPIMczSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPo1mXkKxFqrFJbgKtNEIt5ZHiTabb37wMXxLRAIeNRno5DR3AAGuKjp93g16mzBl
	 /3CNbG6uWs3WhElMnvwbqhmSsjjMwZfwrvzM8T673tQGiHisyduOo/76UvFPx8vWHx
	 9lzYUK3IeThBOk9/FedNGybyiwR4Gdt72t9wwPv9e2CIKHXV4qq0pTv7B7QX81SLyf
	 Iw3ISSaMn4rNIW1sjHFDtLvoDLYD8pYgZXmzPWirpoHmn5112xh4jwvgTxtmQ6Wuk2
	 8Bh4MVxCgMvJMsNDaUbaU0No+32RJCdez5rEuCBZAIC/6oUb+6u9qKz1t5j/Vvz6mQ
	 GPTyAfGP21eBA==
Date: Wed, 7 Jun 2023 10:20:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 06/31] cdrom: remove the unused mode argument to
 cdrom_release
Message-ID: <20230607-beulen-infiltrieren-4cacf9083274@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-7-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_012018_093752_9AB226D6 
X-CRM114-Status: GOOD (  10.15  )
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

On Tue, Jun 06, 2023 at 09:39:25AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
