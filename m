Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6F6C7EE23
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 13:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VAsNN7eVB8+LOocqLk8wA5/I2ch4yLA9XQ4vRX+T/dI=; b=SGlEG9iG+B9LW6
	TNn0gmk4JZVcIdBnORkhiWebOdc8x8SIwNJCRdwNZfmOvkYgmI/mGX9ARCxTTYy7ZeyUK/BxKpAxk
	lm57J4pHpFCpPsAhmIhIwHEArRY0867OMRZGgvGD7nITVFLSBlIeVKaMbi7QVXd6OqaDOibrp6vZM
	wunzi0nvAn0CK+9cG1haSaPkqm2WzbWh+0af8uBqhLeQNHdUNjOB3YNoc3enJtbkBTKKBOQQQ4rsp
	4aPqx10kjAaVkkMpMn3F+8Vfs+ZXYMrrtyvZTvFoTpfU2AGNsluai2yHVyuTHSItu/q52WzMEcIaW
	CerZ0X70nWprD3HBKK/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6tNc-0067Wt-2U;
	Wed, 07 Jun 2023 13:39:16 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6tNY-0067Va-2c;
	Wed, 07 Jun 2023 13:39:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1B66219B5;
	Wed,  7 Jun 2023 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1686145149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvX+K1GPLsIpoFmWJX2s5gmxPQdlBYXQkV75nn7bEZM=;
	b=QMstqGgedcYgY/d/rSGDFDlChRste65gtAtzSH+mlxXl5vEtulOq2TI/sCACizK7l4xAIA
	Zug8XKFA7SpEs+Tfusy0dW9TRY25HOfO+RBfFn6tbKVwi3s66msfhIUZOO9bDHcakuZnvK
	aOdFM2BAbO6jcrNhKt6b1QqrvqZHki4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1686145149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvX+K1GPLsIpoFmWJX2s5gmxPQdlBYXQkV75nn7bEZM=;
	b=wiFEvVZJSCbh6tVWyAuV/c0zFOWqBvdMPHB2HTHPCfNySm7jDxfJJMoNpYlbzC7zNnQARu
	aZxg6KqpACFRuUAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C3E41346D;
	Wed,  7 Jun 2023 13:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id AS4SBX2IgGQXbwAAMHmgww
	(envelope-from <dsterba@suse.cz>); Wed, 07 Jun 2023 13:39:09 +0000
Date: Wed, 7 Jun 2023 15:32:53 +0200
From: David Sterba <dsterba@suse.cz>
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
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 15/31] btrfs: don't pass a holder for non-exclusive
 blkdev_get_by_path
Message-ID: <20230607133253.GO25292@twin.jikos.cz>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-16-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-16-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_063913_017641_F8C4228D 
X-CRM114-Status: GOOD (  10.81  )
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
Reply-To: dsterba@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Jun 06, 2023 at 09:39:34AM +0200, Christoph Hellwig wrote:
> Passing a holder to blkdev_get_by_path when FMODE_EXCL isn't set doesn't
> make sense, so pass NULL instead and remove the holder argument from the
> call chains the only end up in non-FMODE_EXCL blkdev_get_by_path calls.

Please add

"Exclusive mode for device scanning is not used since 50d281fc434c
 ("btrfs: scan device in non-exclusive mode")."

Acked-by: David Sterba <dsterba@suse.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
