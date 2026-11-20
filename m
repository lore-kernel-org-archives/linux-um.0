Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C4606A33E
	for <linux-um@archiver.kernel.org>; Fri, 20 Nov 2026 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tCv/6x8a;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.a=rsa-sha256 header.s=google-2021 header.b=UqBwIK76
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Cpp+sFCicuYgf+c3zxc4haugV0ip6eM5biX4gD19sTs=; b=tCv/6x8ax40NSov68S0dz3YBww
	lHWd3rgxI4pXbZ+1Zig80Fl5/HCgVFt/GYSZ2q31T4yMDZBjahasGXt2/+h7QdbWzgsW9VpDsXHBq
	uKbRaexJoWvPJ1mRpVlkoiTm4ND+62CJQvRqA1fLMt+eEchbAwR2dIkSQOvdUQJCgkzomAF0r50pX
	QeqSdAGL2tteQyHNyqmtXTO+iRqUk31RjQ+0Ce+jbUA/4yVHyFpGOYkWGPJFplpU68Xh9Rt+g5W/y
	wdWT+E/+z/Fhz6ZrZhpJGavXh3AD64QKNSzXReuLf3R0On8lu//AFON7UUCowYEX03BZymnLze/8V
	CAhzS+pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSSr-0000000FiNI-0b9n;
	Fri, 20 Nov 2026 17:31:57 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSRw-0000000Fi6N-0Wom
	for linux-um@lists.infradead.org;
	Fri, 20 Nov 2026 17:31:26 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-55c304f7031so13455751cf.1
        for <linux-um@lists.infradead.org>; Fri, 20 Nov 2026 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1795195855; x=1795800655; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cpp+sFCicuYgf+c3zxc4haugV0ip6eM5biX4gD19sTs=;
        b=UqBwIK76QNHYITdwwUGAW0jFyyxbF2P2duFq9m1ux9RbeDR89efAPYn1u4uXrtYoWJ
         xUYOxSIiubG+/93204h8QU1VC1wOpquRhECrkFKkHusHGdcpqRN3/4OayiBy7QCspP3Z
         bCu+UScHrCV7Yt/tu9d5jHSHyeCUBHVOHpwSFI9IbDK7KFv0BatAveRxb9uSaYwT4dIt
         5JSjGIyBJs98yYG/ty1zK489LoQQoYhd/IX/G4HgxYjFT/bpV6LD1GY1r9GpeysRojwD
         dHOq2bELgSYMcVzzuvNtwO2PZ/COb9avAUaq62JcYlYtHufrLVPO0+yhBOzq/HC+wWw1
         JqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795195855; x=1795800655;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cpp+sFCicuYgf+c3zxc4haugV0ip6eM5biX4gD19sTs=;
        b=IQaH2hh+paHsFnz2gid4hxb20FfAkVo1LjqfOhCxndgoUa/ZLZqH9NmoMC3ffsTk/w
         WNwGFxrwVkIMbQRD4FDNa+1QO2RZH1FXjfHIb3XvNbrjlAUSGg+aQdNQGPo9H8XiURQ9
         BGUZOEj9b1Kp/O4Cy0cSlx/xP7jOaGXLjvxfvMPasnfTDrzRvWfng06inYqqIRbePzSO
         JqavZwgkyafg+omiJkyLtuLJ3VLjb75tSD9n190ieNx+3k0VJuehvoxKpfg/i56u4t1O
         rrqKkVDloBlFvMfg4tYXKFHMCLU8a+SIBPSwBjJ3HLdFWd0V9ijg1c5pf2kb3mJihATV
         GrtA==
X-Forwarded-Encrypted: i=1; AL+hErF4X2EL5VuGsLVgy1z0pZ3MeDXgTfjy6huyWoSrEYgv+9U1oYm1T9h9OmMW5Qq6gc0HezKbMYF2Qw==@lists.infradead.org
X-Gm-Message-State: APuU4Z+krL5ayM3zKdKrsiA5oWHTktBMHVBJ/g0geNsAuRpl7rdekXCd
	qKgoNzEJSmdk/43CjELkg7vpdzGMB9u/cdW86L99/ErdIoihBofWWF1CDHNhY3C/PQ==
X-Gm-Gg: AYBFou16oBjKTp8DQjiSHzYoHAmLkOwJ1Plw3GdSXv9yPY68m4E9LcgMtClOdId0HGC
	K2y2Ij3Uebd0PxcXjr2J+QXDt0amq/uEO9lUYbpY92DRw2xGztMHuyoZisB03pDgL68smDGyajU
	acjE+DCnMCF3EZ/AZvQeJKBkEQtBr+oQtZzttlx2ZRmxHn1YmoL9WkTnTKHgfVuVuQBi9RdtiRX
	1AGdnUh7uuaU6pAupGMCtnvtuyym2Yqep1kuq/aWiKGpg4eBBWCgoMwFSqiDjTu5MaF/aR8kmma
	3s5k31scT9nwI2Ex8SSL5TJ/pX1l5j0JH2OnRQQqeirgvSN83Io30UDjzMO5sCN2DpGqM3fQMt2
	OO0XEUF9mPm1JxQgN+Jf5AiCLnJcCSULt6pTXUWmAUl+OfemdJL5GE/ob8Vd7zT0uoS2g1BAlNV
	YecrymRhzLqNg91snOvus3/4IWCB8M9kFWCpj574Sasg+hiZHuyLEmX65VHxHenZrHSFcqEnWV2
	rHkhFwqCbbGPfTdIarDAL992LGUFj6JU2iOAIcKf8hHEYeJoFt8OeUTkuQjCeZ0IsFa1DtPijYF
	8B9LYb6qSfk3QJ0uRiWaTykFC5nSZSN/ncBXpKAm/TBxrRrXe6w=
X-Received: by 2002:ac8:5d0e:0:b0:535:1d5b:a7fa with SMTP id d75a77b69052e-55d769fe4ddmr65344931cf.14.1795195855134;
        Fri, 20 Nov 2026 09:30:55 -0800 (PST)
Received: from cs.cmu.edu (tempest.elijah.cs.cmu.edu. [128.2.210.10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882e32dsm28152341cf.13.2026.11.20.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:30:54 -0800 (PST)
Date: Fri, 20 Nov 2026 12:30:41 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Carlos Maiolino <cem@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
	ntfs@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] coda: don't d_drop() early.
Message-ID: <20261120173041.bd3xeidt4ndkmimd@cs.cmu.edu>
Mail-Followup-To: NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Carlos Maiolino <cem@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
	ntfs@lists.linux.dev, linux-xfs@vger.kernel.org
References: <20261117000115.1433875-1-neilb@ownmail.net>
 <20261117000115.1433875-3-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117000115.1433875-3-neilb@ownmail.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_093100_784877_D35B802D 
X-CRM114-Status: GOOD (  24.31  )
X-Spam-Score: -2.0 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 07:09:14PM -0500, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> Proposed locking changes will mean that calling d_drop() could
> effectively unlock the name allowing a parallel lookup to proceed.
> For this reason it should only be called *after* the attempt to create a
> symlink (in this case) has completed (whether successfully or not).
> 
> So move the d_drop() to after the venus_symlink() call.
> 
> Doing this also means that if the upcall that handles venus_symlink()
> happens to look up the name being created, it will get -ENOENT rather
> then a possible deadlock.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>

I was sort of already assuming that the userspace cache manager should
never ever traverse into the mounted /coda file system tree because
there is only a finite pool of worker threads. But it is good to know
that this change would fix at least one possible deadlock.

> ---
>  fs/coda/dir.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> index a85be5962e62..b47299527b65 100644
> --- a/fs/coda/dir.c
> +++ b/fs/coda/dir.c
> @@ -249,13 +249,13 @@ static int coda_symlink(const struct mnt_idmap *idmap,
>  	if (symlen > CODA_MAXPATHLEN)
>  		return -ENAMETOOLONG;
>  
> +	error = venus_symlink(dir_inode->i_sb, coda_i2f(dir_inode), name, len,
> +			      symname, symlen);
>  	/*
> -	 * This entry is now negative. Since we do not create
> +	 * This entry is still negative. Since we did not create
>  	 * an inode for the entry we have to drop it.
>  	 */
>  	d_drop(de);
> -	error = venus_symlink(dir_inode->i_sb, coda_i2f(dir_inode), name, len,
> -			      symname, symlen);
>  
>  	/* mtime is no good anymore */
>  	if (!error)
> -- 
> 2.50.0.107.gf914562f5916.dirty
> 

