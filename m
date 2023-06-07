Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38EAC77B7A
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 08:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pXAy9fu1hOAlpyem3umjn32t+jCvFCLFt3w24BsVWNE=; b=gOL2D1sf9Kw/w7
	lyNXK7p3aoldU3TUMFlkcw3YDwCD+C1OU45gscKdAwpwwcqtZuqzxIvtXExrtDQ51lLV6vl6nM1gQ
	j0y0jVhsqUGPVtfhLb1It0bqybKuFccC4AaRitxrRSd5zN2snlGtk46oKzr6chaeJdXZV2bEFP8x9
	gvkLar7JKth1QjodvXnHth63y0XQGbWLN4o9FO94/CDLxVoPTQsLs5nYRCZ308EtuRkGHrbW/MQHy
	5MjgSuvjCyZ1F/OG1hPUhzycrfP4JbAbAiNpgu6d6S/I+igBj4eAt7nMX+dUZqz1efQafwJntWy6P
	r6HBTp31nTFe9wfGDbCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p0W-0057CD-21;
	Wed, 07 Jun 2023 08:59:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p0Q-00579d-2E;
	Wed, 07 Jun 2023 08:59:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 306DB635B9;
	Wed,  7 Jun 2023 08:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E93C433D2;
	Wed,  7 Jun 2023 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686128341;
	bh=iX37Aj7K24viaDo0LDFhBvFVeSZ8x6AEqp0i0SvvQJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVxcE5aPOf1NjQxle/YS0zgsVQslmwVIZneDuzN8CgnsrynVNK4yLUdTchMGP7JjH
	 DnYtvu6Ebv1W+tdNOPejuUDxQY2Wm5DyW3a7K/WtGQlxu7YDI/ER1EdnprnbzrzD7c
	 V16UtVlmMg6/YKPDjmPjVgM4zGFodtWbBl3A5IdCSSlCaX64BzH8oR0bXybh1uU2ZO
	 K5SfuQpmvShS+48zhJ5RiC1X5zKGGB6jW0cKMr5i6nDwK4leRy1Drz3MAWaTydFfFG
	 GfgzELEjGh1MkqWTrFQLvzHDpJAE3Gjfoc8pk6kjdD/drvyNtr4AzJDUXkbP1AU2Um
	 tKGF7XxHcMz3A==
Date: Wed, 7 Jun 2023 10:58:53 +0200
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
Subject: Re: [PATCH 21/31] scsi: replace the fmode_t argument to ->sg_io_fn
 with a simple bool
Message-ID: <20230607-tierreich-erbeben-55e0ce413a8d@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-22-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-22-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_015902_774210_99F502D2 
X-CRM114-Status: GOOD (  11.72  )
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

On Tue, Jun 06, 2023 at 09:39:40AM +0200, Christoph Hellwig wrote:
> Instead of passing a fmode_t and only checking it for FMODE_WRITE, pass
> a bool open_for_write to prepare for callers that won't have the fmode_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
