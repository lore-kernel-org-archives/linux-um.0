Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7988FC7EE23
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lbQ+kdVdX0BDaXL/E7ThhUXOvEQSgyIV4j0D1FH1cr4=; b=KUyDFUTT97De5S
	pwGP1YDU5EyT0BBCOnrXZdM7BS/v3ef2Z3JQ3rzWiyc+TvE06Os3O6yRNmE8xtQa2OrHFxqcrLutt
	kcnRAbrBhP0SDySZhm9D9T1Wv0GHlT+3dSQEV2ztHYGC+q60R5KclUD4BVaTYPd0B8N/2Gc6iKVSi
	0JBj6bFLPa1XuEvarD5hNHIprDeIxBwdHWxWQI1W3VEPfQN9g1WFLxfT0/YecwAWg7CR/vwP1o7k1
	+PLvpp/cbJt8tO15dQIdwrR6+l+KIxPyDDk/gdFUlxYfcOIZE9Ps8RjZIcFZPSwjMyVzNtU9d0aOr
	hFIGKbuv10CAW5+vaO2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oyB-0056EZ-0G;
	Wed, 07 Jun 2023 08:56:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oy7-0056Bq-0l;
	Wed, 07 Jun 2023 08:56:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BDFE163429;
	Wed,  7 Jun 2023 08:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1335C433EF;
	Wed,  7 Jun 2023 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686128198;
	bh=XuHwZ7uaJVjyv+iO/vUQkX77q29hjzoGO5w56uvjEOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeEXqe9gjxY57lITqd/lXcoE1Ca1KQPvngcywi2EuF55EYz48E3pBAh+rBHch2qBA
	 ypy5YdNuEogegS0vPCR+mV99Mk5TjM1rLBF97+R9HX9ukYW6ykKDq2gqNInuZMB6Ay
	 XHzbm7kvaBLnWy14BEPIjrerESWXdSFPaBlrm0swncJDI/92I5eylBFX/moeEz7CG1
	 vaPZG0fzC0csi3IKOuDwjj7N745wxtG3agr3NgG0FuEl8trHhZ//gdGhKV06s6qy39
	 mpg9F8OAP6YYyEg/4+2k3U5GSd1wxRxtUnh4mR7ZFx9c5gnEAxwjVBNp5aPITn0SFx
	 tka8Sp1jBTEXw==
Date: Wed, 7 Jun 2023 10:56:29 +0200
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
Subject: Re: [PATCH 18/31] fs: remove sb->s_mode
Message-ID: <20230607-fliehen-abwurf-56e4abb8cc2a@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-19-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-19-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_015639_310929_5770203C 
X-CRM114-Status: GOOD (  12.48  )
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

On Tue, Jun 06, 2023 at 09:39:37AM +0200, Christoph Hellwig wrote:
> There is no real need to store the open mode in the super_block now.
> It is only used by f2fs, which can easily recalculate it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
