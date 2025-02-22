Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBF1C021B2
	for <linux-um@archiver.kernel.org>; Sat, 22 Feb 2025 04:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kBorF+lu9MOKjw9Zu9aJHBKvFxgx/GsLywDagfgLFsk=; b=alfRu/vNrhFsOdyimcoEfs2mXU
	4kdMrsOWi+w70fM1cMDMtXF39CcVxWC6fKBxh0DstKuWQWyjPkPHFnq+Ji5tKKooZ+ak0yR3DqoKt
	BnCJ/h/AskzInHK7aaVPe5m8dqHGLDHtwhZVZyNteLj6JY5bojLDppeW0uDny4sUewwb6vLU76Pvw
	V1FV2DSijW6pw3iRrxzXElRtoc/1yuxlq+dyCM+VQT5CiEMxQT0GFy+3gvAZOmy7OuQGPyXbBhbQ7
	lkZ1O3Wpe0C0qx4tNYj/G8BrD7jUGAwt/sSjrmNgUJpyzVDA42j+YeIjaX7fET8Xhx1h+KUtLS5Oo
	47lUDm0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlh3j-00000007RJB-0DAy;
	Sat, 22 Feb 2025 04:24:11 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlh3g-00000007RIo-2nkN
	for linux-um@lists.infradead.org;
	Sat, 22 Feb 2025 04:24:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kBorF+lu9MOKjw9Zu9aJHBKvFxgx/GsLywDagfgLFsk=; b=N7KmNtyNyy18k2f5aXEQzFXbBc
	Sk9hBBz+sLj6HF6d6GP7Kw7D0jUrI0Xbk6up5O5pRCfCOaSKOitMRHUx4G5diKUe/WLV4uCgelBse
	N4/i/r1S2T+H7WReVvhM4ZD+nVE/GVndldfzR5o4o7P9Y6KvNwc7lW7twaWiDw1creTAe+PNfRGal
	ORODDU07dnHmbj9B15OH5pMN4bwZlFu7oHKdZFBTpRNMftCyUG9pGPr9aQAkZeUKpZ8/jl1CGFoHR
	Q9J+xAKKo8yxXb7clIWokRa2Tqf4lzQaAQ+sqF4j70goOWLX0kKKpubH+VriThS2oVagP7I3TSc4+
	mEtLQQXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlh3a-00000004e23-30tr;
	Sat, 22 Feb 2025 04:24:02 +0000
Date: Sat, 22 Feb 2025 04:24:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: Re: [PATCH 4/6] fuse: return correct dentry for ->mkdir
Message-ID: <20250222042402.GN1977892@ZenIV>
References: <20250220234630.983190-1-neilb@suse.de>
 <20250220234630.983190-5-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220234630.983190-5-neilb@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_202408_715381_924BCFE5 
X-CRM114-Status: UNSURE (   8.65  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, Feb 21, 2025 at 10:36:33AM +1100, NeilBrown wrote:

> @@ -871,7 +870,12 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	args.in_args[0].value = &inarg;
>  	args.in_args[1].size = entry->d_name.len + 1;
>  	args.in_args[1].value = entry->d_name.name;
> -	return create_new_entry(idmap, fm, &args, dir, entry, mode);
> +	de = create_new_entry(idmap, fm, &args, dir, entry, mode);
> +	if (IS_ERR(de))
> +		return PTR_ERR(de);
> +	if (de)
> +		dput(de);
> +	return 0;

Can that really happen?

> @@ -934,7 +939,12 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	args.in_args[1].value = entry->d_name.name;
>  	args.in_args[2].size = len;
>  	args.in_args[2].value = link;
> -	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> +	de = create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
> +	if (IS_ERR(de))
> +		return PTR_ERR(de);
> +	if (de)
> +		dput(de);
> +	return 0;

Same question.

> +	de = create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
> +	if (!IS_ERR(de)) {
> +		if (de)
> +			dput(de);
> +		de = NULL;

Whoa...  Details, please.  What's going on here?

