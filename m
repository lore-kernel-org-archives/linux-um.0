Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ED6C7EE2E
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 09:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vd6VNDNX6Zawz8Tn59N6zDgUI3cMpthUbLcoe0d2skE=; b=EOZaJOUwYfeRmE
	Ccxtg9RIaxQYDWqONr2yz81NA7fI5PV1vWeutYJgyIkVsmj9tYI9sbnhrLu5URSbNg1g5N/kzkJkv
	87Fm0WBWmv9OCU7e2Hjt13YKh6iUKahcS9LvIFz+85oxldAuU18+GgjQy0RXJvvFC4rjySxvJ8j95
	HE7qRCMh1P8T8rhrKJIfvx7nkVBz9FBOC5D+86L16mzb7HBhZlCBdOzNf82p9FBQtSDSo3EMYb6Db
	FWWSHeWvYAEeXc0+inkIykSgbN8dm2u+Lz4/H9uRNBcacBcWpjv8pTb1zZHLx4R0D8/YsLqa4bBLC
	I1wjo9hQ2CM0kRnqoafA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p3q-0058hq-2A;
	Wed, 07 Jun 2023 09:02:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p3n-0058es-0x;
	Wed, 07 Jun 2023 09:02:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zwQ7mjq/Ray9NFCEILAQk/QKOK885zMQIAzTo533urU=; b=bu0FwjWpSrznrk3a/h4PWUEI6C
	npH/joQz5Ln3wKUN15Ir3xVEERS08L47G8hbGfwdkodlU/MeqcaBS0d4yh8VFybBSryPq6G1hHhWf
	OJaNf5UNtp81KETZHTEvQ61NZk0oLQmVfXPFNoV7f1xAfn3Eo1E6FxOzLWwdrl71tokfrNP68VKEL
	KFucEx+OjXWE6+vAWJJqGTPociSiI1TSfABP1rexxm1vcHnvHirrckLUDhDPsCyfphrWibl6bfvNO
	s2uYTakGM8aNO+jFiAqsgdQjZrfaJWRZ3nFpejSU0Qd5qj461RTaZfLDfPl2uu642HRVXUfvQh8IG
	yvURefvQ==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p3i-0056xQ-1c;
	Wed, 07 Jun 2023 09:02:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 372AB61549;
	Wed,  7 Jun 2023 09:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C307C4339B;
	Wed,  7 Jun 2023 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686128540;
	bh=F5yK/CebQYGivXkJ/hRkJ11KpKZaKc+G+VOQffjNVTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sAfQXO5SH40rCtDhbwEvXcSBRhslBvNvKUU+/C6zJmUW7rk4KDZem+SyB7w55qX2y
	 S8GP7XOz+Sh1JsNAkUh/43kCDhRagfGOJ6ymJTvy8EvYu8/Y72NkSvyaxeGEoX5NYg
	 ZNDcw7HYM0UpR6uCZuSvmtx8nAL3oOFkFGjtbLip/0jPFzG0EsuCrfGiU3+dsUo6Mk
	 09/Q8RacrQEXGw7OpkFy06YCu5mCCT4iywdTjXjWEe2cbi2/c6/h5WqzuX58R/oEbv
	 wLB23zogewfEPk6rfCC+XUbaeVedBS79aJPk4vzv1kQ3/T/szT3pO6l5YM/nxQqSRl
	 uTtUOEbNKxpzw==
Date: Wed, 7 Jun 2023 11:02:12 +0200
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
Subject: Re: [PATCH 25/31] ubd: remove commented out code in ubd_open
Message-ID: <20230607-mietpreis-deich-90ec6cba9ca8@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-26-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-26-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_100227_041907_294FAD98 
X-CRM114-Status: GOOD (  12.27  )
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

On Tue, Jun 06, 2023 at 09:39:44AM +0200, Christoph Hellwig wrote:
> This code has been dead forever, make sure it doesn't show up in code
> searches.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
