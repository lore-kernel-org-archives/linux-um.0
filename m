Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4E3C7EE29
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sRH95Lliev/nB+Tf70yhjJWwLGr7iccIASdMm5F+zb4=; b=403CnDTNazPge/
	G8VQIZETgc+DrwViZ9OyOO9selr/ltXIGuWG2yPFP4m8UKaWsyD5z/M63OhpkCcDy1gvawiVa/xzt
	GHQuJUFCYSKkfSK1sjhAETGX8mLoIorK6bOEYLwHTTLGs2nUNQ1riG9IDdH6/1zk7z98xf8EqhUzC
	twDbIZBZEXbQZMDBB0FoUBaaCULI1e0GKaSvxz8qwnKjge/kwGzKsXPC1CeWu3tmws4ahqA4McKPq
	04jxyJQQ+2jSFPR81SbsecFocjFN33293P+zbDBAxw5n0w5iC5uNRmFXyijjbgZ6lNb/qfrKlos4X
	ntZ+6/xDo0wEH6tLEY7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oVU-004xix-09;
	Wed, 07 Jun 2023 08:27:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oVQ-004xgp-0M;
	Wed, 07 Jun 2023 08:27:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A02AE63C27;
	Wed,  7 Jun 2023 08:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDFCC433D2;
	Wed,  7 Jun 2023 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686126419;
	bh=Kl3XQ9PoGp9pTvNWEYEaCMqRkYInB2avmNbeu92C6zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rgcywzP+1oCMwlq0k2fRCPBZXdUZRn9J8LrJASSZ5i8ERKpLVi1lgtd0pJwqJB0W7
	 D8wlIL49yepvEx4+n2MmT7Ru/Aj5siKdB0jHacl1CtCKl9pO0JR5AlsMNcP4+CHinp
	 OPR0Amz34//UXpE4vCzXPXEgPCrc/4r0Ykl5ORkARbmB44ULuK5TjPuzNOZ8nQxJja
	 fGuUjMxzGMLdLJSXdYGCnhXt1cV/9zOntJTs1hNqR0nhjGSgxERqeRaqheqynMWt/A
	 ac1PW1JzvY8VShzgVMk8msTfO/mSWVq1Eb6Oegl+HSBogzogFDyzAMws4bWaCKrm0L
	 32r0fwv3mAedA==
Date: Wed, 7 Jun 2023 10:26:50 +0200
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
Subject: Re: [PATCH 08/31] block: share code between disk_check_media_change
 and disk_force_media_change
Message-ID: <20230607-abhielt-kirschen-288e7a9a9fe4@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-9-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-9-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_012700_187917_77A4C10B 
X-CRM114-Status: GOOD (  11.10  )
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

On Tue, Jun 06, 2023 at 09:39:27AM +0200, Christoph Hellwig wrote:
> Factor the common logic between disk_check_media_change and
> disk_force_media_change into a helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
