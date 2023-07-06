Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52266EB64DC
	for <linux-um@archiver.kernel.org>; Thu,  6 Jul 2023 12:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r48uPIppHhUKPg1Ssip8riniu3Pte/UlW9f6ig4uikQ=; b=Be3XREemWCXObc
	kiJAwuTHo8+ZsHcCdMpra2eNmkGfidWOCvGk3LVkkjRFfnG6KFrVuJXWS9KR/Rl1nO0OR+gFGwlM5
	go+06aNxR+G/Hj7GuYYVMJTLf1A2tgHuuLLJnPwtFjIzDjK3GGAzvbORjnCdZoWh/kEQGTBPk8uVL
	DYRxBr/tNCZqd5yEn68hSFX+sXTjtRncdY04B4JTij3i0Ma+I+9aZyheuZsfpetIL+I/ShAQelrz2
	XQPmiTElud6cKuDpLvYTmcz6Hcf7gpvNrQxk7Cob8XRuYfrHvH1JxXt1s4MYA8YXTmkFwEHksvNuN
	C+pAKmACdpu36HJL2WhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHOP0-001ggf-1S;
	Thu, 06 Jul 2023 12:48:06 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHOOy-001gfO-1G
	for linux-um@lists.infradead.org;
	Thu, 06 Jul 2023 12:48:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 150B1228BE;
	Thu,  6 Jul 2023 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1688647682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gRXye/rxgx5yXx+4yaqVLpPLLCHYMJGCFB4srDdTvrs=;
	b=HXYJ/++T9nVftJLw686zBdTp0YcyK0ZaRFe/2Xxm0wzQL/fp9KguiyhCNN7DBor7IsCLAS
	hD4ctzB4Pz2fvwPnnGy6mlXg+7chpKrRw7QOQD36xXsc3gckcMccpGVTQ3P5YvO4XE2aSw
	GLjtsJYxF10ha9wbTTNMpd7hCWV2+ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1688647682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gRXye/rxgx5yXx+4yaqVLpPLLCHYMJGCFB4srDdTvrs=;
	b=mH3XoeJCtzX3hkFYlQJGOO8bI2u0KB2in0z2GPcmkdyNbzdafC/huFHu0vnDvQW6he2Quw
	pCGP4mx09bJlF8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0782C138FC;
	Thu,  6 Jul 2023 12:48:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id n+nJAQK4pmQcQgAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 12:48:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AB698A0707; Thu,  6 Jul 2023 14:48:01 +0200 (CEST)
Date: Thu, 6 Jul 2023 14:48:01 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v2 50/92] hostfs: convert to ctime accessor functions
Message-ID: <20230706124801.exu6lh2d6dwt4dfj@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-48-jlayton@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-48-jlayton@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_054804_573589_0BE2065D 
X-CRM114-Status: GOOD (  16.56  )
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

On Wed 05-07-23 15:01:15, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/hostfs/hostfs_kern.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 46387090eb76..182af84a9c12 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -517,8 +517,7 @@ static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
>  		(struct timespec64){ st->atime.tv_sec, st->atime.tv_nsec };
>  	ino->i_mtime =
>  		(struct timespec64){ st->mtime.tv_sec, st->mtime.tv_nsec };
> -	ino->i_ctime =
> -		(struct timespec64){ st->ctime.tv_sec, st->ctime.tv_nsec };
> +	inode_set_ctime_to_ts(ino, &st->ctime);
>  	ino->i_size = st->size;
>  	ino->i_blocks = st->blocks;
>  	return 0;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
