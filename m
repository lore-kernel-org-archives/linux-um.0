Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37B2C87FDE
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uhqJo7wn4d11vINVZJAYBJg1z6MFqrnfmhGORBBToPc=; b=L3DDK4kA7yeJat
	ubtC8y5j7DcoIRONC3Jt9MOAb6KbSEZBCSE/avYYyPsts12e6TZ0wgBc3TVhDOGs1plD+InnB0x2G
	36IpBeQkQqa8PoQghyTbrkSNGJw7pnKzyownVYJwFpMUpve3fTaYpmj1+oPiDU6IgD6UB0yLn3U4G
	qjbAW39lxtAk/kZEjMxOnoIZB2cLCvwsA7oatsxaoGlW7CGg5ZA+KQJTEz1q1ZsF0WvsV2/NLvcr1
	J7eNk16TZ1O07EsUf82/0gzbCpDml/2zUVB5DXw2yh4Jd6R5UucQTMJtkIQEkbT/73vJkcrujWuZA
	euHkg/3mBl+C6bME7MfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s3Q-005oN7-1d;
	Wed, 07 Jun 2023 12:14:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s3I-005oJR-2n;
	Wed, 07 Jun 2023 12:14:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32FBE218A4;
	Wed,  7 Jun 2023 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686140051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbDdkBkAkihlvgimUEyqaDFQQ7hWsta3TpQfoTGouF4=;
	b=YcolPPrC7jE6w3Zyqtw/FMFFlvUTz+YgmXz15Y/Ja5pGbYcQOI2xWKpEk6rOkAGv4OEQOe
	GUHXGoC7dkbxH62fllqUSMkwEBzB9qfyJl+oVpr4TOfBAt0t4eLEElqNjd3xnhlOocxLsj
	cB70lchn4Bjk/oeQCWvsAfXocb0270I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686140051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbDdkBkAkihlvgimUEyqaDFQQ7hWsta3TpQfoTGouF4=;
	b=u60i6Cv0BWCHzE4lMuQ5hya3mWAVv5LUT6kBJLXzktzjRnyf9Hn68uapE1JN/pfx1XLC7b
	BcGGQlzMBD2ak5AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB95513776;
	Wed,  7 Jun 2023 12:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ThfIOJJ0gGTVPQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 07 Jun 2023 12:14:10 +0000
Message-ID: <e9817476-c4a4-daa3-5855-1cad65f34702@suse.de>
Date: Wed, 7 Jun 2023 14:14:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/31] cdrom: remove the unused mode argument to
 cdrom_release
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-um@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-7-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_051413_045562_B99F19CC 
X-CRM114-Status: GOOD (  10.25  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 6/6/23 09:39, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/cdrom/cdrom.c | 2 +-
>   drivers/cdrom/gdrom.c | 2 +-
>   drivers/scsi/sr.c     | 2 +-
>   include/linux/cdrom.h | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
