Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C50FC7EE2E
	for <linux-um@archiver.kernel.org>; Fri,  9 Jun 2023 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FtvTcaTyzSWe1sP01V5TxCO0qk4dYGY7jkNdzZ61rbE=; b=ayoUb/felSsZc0
	o59Zc1kZbVRxLdD0kyC/wUs6x6hJH90uG1Gn+WuHRLywGrae++69E3mk0EiVsJdO6zgYmwU3D8bnj
	draYj9i2LxKnjXTTI9SPmss+2sju09j5J9IJHD9vaVKHsgR0vK0B42cg402lZcWmu5jmgnM6oJsZH
	RiC8nMKdjhxRYkxnSQxJpSbSIZD+2S6FM+5g++ICUA4gFF5VGmBPRbtzrg5HK1sEfbOCw0lPxeWNK
	khDY5CNr5Gzl2Cb682l5xlL2o6DdItYQt+Zmk2a3zXSPbGauNHRLD3+qVZlyzf2EZdeHmnBOo9Xe/
	Oc3QRZpWU9b4gjZuoVVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7eNG-00DVjJ-1J;
	Fri, 09 Jun 2023 15:50:02 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7eNC-00DVhD-1x;
	Fri, 09 Jun 2023 15:49:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AEE3465969;
	Fri,  9 Jun 2023 15:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD00C433D2;
	Fri,  9 Jun 2023 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686325797;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHtOuYp0TmsS9C41zBB8bRnNowLvmEqTLajK40KrGYXbNtm+pGnwaZIgRwj7VkfF6
	 ToT8ZkmVhHIYZITuzZR8dQwIKnvzyfbSqu3MTnPYi2yHHrCzSD4+fIyFK5IRer3XSE
	 XP1/X6pcw/4xghZaL8LBbcBoazv3n/axO9Egj4JkEQopsHm5F28FzihGpJtB/yUnWf
	 u498nYtGJPusyoaO38WDi7BxJhU0L9Jzdyc15SGKMxUEIq6a91z46ZPKQW9cNiYeTw
	 fctvLRTOSN3cJGWM77Zf1OWNHYkAvGdXMKCYo1D/Qj6F/3niSHHWcYC4L/fFNtQiR2
	 L5jLwoeehBLHg==
Date: Fri, 9 Jun 2023 09:49:53 -0600
From: Keith Busch <kbusch@kernel.org>
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
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 21/30] nvme: replace the fmode_t argument to the nvme
 ioctl handlers with a simple bool
Message-ID: <ZINKIQbBc0MB9wRz@kbusch-mbp>
References: <20230608110258.189493-1-hch@lst.de>
 <20230608110258.189493-22-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230608110258.189493-22-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_084958_689627_261E47C5 
X-CRM114-Status: UNSURE (   8.12  )
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

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
