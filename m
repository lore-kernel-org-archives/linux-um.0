Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC163C3DA6E
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 07:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Joh97BwP4hkODKw1vNhuky4flqFq1F3bJri6+hBTkDs=; b=K+RmA3mzVPXc1gvk6FlYWhMTgC
	6whxg+HIE/SJDj6h/jGMj55PBaEEAZqTUpmAhdaGuOWjmFm92LqMI1DH4gEPPID9HsJ9S+GABPhef
	g5ptmBitA4q1zehGRGGm7lfH9Cmpkkz5bhxuvNdkvnU4jDwlrx7FIwl3zfFbLSqsXYvHOVEOTOdle
	b5px91dQPamaDIuFE4q4X/brG96Gv1xSzI36xwVCqW9mAcrMVVEJRt71UbUSS8iQdHi92dI15m/uk
	WxY14RcycQxYRPOfjxCP3SWvSVc63lPsUUOfxaNj6IOK8eLUxv+UHWsx6Bli35WbD5ClAe9SO9RSo
	dVy/MsNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLeFC-00G6xu-1e;
	Fri, 05 Jan 2024 07:03:50 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLeF9-00G6xI-0W;
	Fri, 05 Jan 2024 07:03:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C30221D33;
	Fri,  5 Jan 2024 07:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704438223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Joh97BwP4hkODKw1vNhuky4flqFq1F3bJri6+hBTkDs=;
	b=a+MMZRcaVUJFcyQjQeZTi2fJEvZrDIhu/NbIcezE7TLkHcKRo55Rn4I1Vf4Ms0kebw0cyf
	NcUU4UykUDcWv75GWyeifhvC1PTSnAXLjelnb88afXk8O4qhDu4cP71jQ/6LxNBSzfMMH0
	UbLhyc8E5YqKzEka3o6F0a9iP04/brs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704438223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Joh97BwP4hkODKw1vNhuky4flqFq1F3bJri6+hBTkDs=;
	b=3mD1IUizJRiMr/ngWXhCDkc2dHbfceAWk49XHWOEHmTTYsC+PBoWb5uViUiAE553s9Glwy
	5SkJv8ZWi3K/tBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704438223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Joh97BwP4hkODKw1vNhuky4flqFq1F3bJri6+hBTkDs=;
	b=a+MMZRcaVUJFcyQjQeZTi2fJEvZrDIhu/NbIcezE7TLkHcKRo55Rn4I1Vf4Ms0kebw0cyf
	NcUU4UykUDcWv75GWyeifhvC1PTSnAXLjelnb88afXk8O4qhDu4cP71jQ/6LxNBSzfMMH0
	UbLhyc8E5YqKzEka3o6F0a9iP04/brs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704438223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Joh97BwP4hkODKw1vNhuky4flqFq1F3bJri6+hBTkDs=;
	b=3mD1IUizJRiMr/ngWXhCDkc2dHbfceAWk49XHWOEHmTTYsC+PBoWb5uViUiAE553s9Glwy
	5SkJv8ZWi3K/tBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F149F137E8;
	Fri,  5 Jan 2024 07:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qn8uKMmpl2VlKAAAD6G6ig
	(envelope-from <colyli@suse.de>); Fri, 05 Jan 2024 07:03:37 +0000
Date: Fri, 5 Jan 2024 15:03:34 +0800
From: Coly Li <colyli@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Josef Bacik <josef@toxicpanda.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, nbd@other.debian.org, 
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 8/9] bcache: use the default discard granularity
Message-ID: <bgbp5rqbxbghiitjvpkuforocw5ptyuubfwwrwdhqy4orkpggo@fu57au3f2hss>
References: <20231228075545.362768-1-hch@lst.de>
 <20231228075545.362768-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231228075545.362768-9-hch@lst.de>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a+MMZRca;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3mD1IUiz
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[14.79%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,lst.de:email];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 1C30221D33
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_230347_371096_48FDBF8B 
X-CRM114-Status: GOOD (  16.57  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, Dec 28, 2023 at 07:55:44AM +0000, Christoph Hellwig wrote:
> The discard granularity now defaults to a single sector, so don't set
> that value explicitly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

> ---
>  drivers/md/bcache/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index ecc1447f202a42..39ec95b8613f1f 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -954,7 +954,6 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
>  	q->limits.max_segment_size	= UINT_MAX;
>  	q->limits.max_segments		= BIO_MAX_VECS;
>  	blk_queue_max_discard_sectors(q, UINT_MAX);
> -	q->limits.discard_granularity	= block_size;
>  	q->limits.io_min		= block_size;
>  	q->limits.logical_block_size	= block_size;
>  	q->limits.physical_block_size	= block_size;
> -- 
> 2.39.2
> 
> 

-- 
Coly Li

