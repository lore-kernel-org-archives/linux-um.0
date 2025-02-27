Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2405C1B087
	for <linux-um@archiver.kernel.org>; Thu, 27 Feb 2025 19:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yeHa1165hMUzzY3GYVzuOOa0JeBsBAvDXSVEqUrokwE=; b=INuRyyq3TklawYkccIXaebEbSP
	ddZp6A2GTYSVTaUsC1djBZc53etcZOoGY/65LXKR7ZY0PNMBx1L1xCqi59vzA9zdWmdw1rTa41bs8
	pc1hXBYANYUxfM8puiNBf5HRsPPKZDTSG99PKFZyvsNi02iZs+IrmOJw7ERnb+NgU7xZgnOoQeLae
	Vn54BLUi1m8q0SWoGxpQ9jO5PKT88LNk5hGYe1tFrrzW+nLQMPf5hmYW2KcSKWUS/e5HlI5WAFKeZ
	roj0cgJJSoaeaK0kTOn2qLEcZYj7wjm99JzIbXt+9yIbllrAWCS7xhUFkCd+A0XSNM+uT91JOJ47S
	ZICdYWaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnjmu-00000008eMS-3E1b;
	Thu, 27 Feb 2025 19:43:16 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnj8l-00000008Oln-08Q2
	for linux-um@lists.infradead.org;
	Thu, 27 Feb 2025 19:01:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E72C261F42;
	Thu, 27 Feb 2025 19:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5149C4CEDD;
	Thu, 27 Feb 2025 19:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740682906;
	bh=z2uX0uqipn42HUDO7nFkLHmTKkunvB8G3pQIRSUI+Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QN39c1vYxAwHPGcFalnYzSvoZb25lnxy8x6SG7Xg1OIS4Jvx4esHkW4m8Rtu1+sBy
	 9xtPjfKoqu81r9Tcl4Q5TUw199c1mDy0EziGH4Thd3eyUsgZ37ZLi3SEoaNCAzdqXC
	 MyQqXd0/i9vogmLdSRF6+7veI46X5R97mOOb1+Hbl/45KSb45W0NLGepZQbWU9M5j8
	 u+l/seZDAfkRll8uPNpBv2caTZVKH/bm9nmnDfLuPG9LTkSWZwAcWlQcr10x/N/gPS
	 1M8+C/VUaFJBc5PvqF61tYCKZBgbvBucB6PASdeKbhxLQZ3PIuhr9Ui7ZdDzHTjSC+
	 dRmXPdJQrPi+Q==
Date: Thu, 27 Feb 2025 20:01:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] ceph: return the correct dentry on mkdir
Message-ID: <20250227-dinge-jazzkonzert-3f68e3839fac@brauner>
References: <20250227013949.536172-1-neilb@suse.de>
 <20250227013949.536172-4-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227013949.536172-4-neilb@suse.de>
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

On Thu, Feb 27, 2025 at 12:32:55PM +1100, NeilBrown wrote:
> ceph already splices the correct dentry (in splice_dentry()) from the
> result of mkdir but does nothing more with it.
> 
> Now that ->mkdir can return a dentry, return the correct dentry.
> 
> Note that previously ceph_mkdir() could call
>    ceph_init_inode_acls()
> on the inode from the wrong dentry, which would be NULL.  This
> is safe as ceph_init_inode_acls() checks for NULL, but is not
> strictly correct.  With this patch, the inode for the returned dentry
> is passed to ceph_init_inode_acls().
> 
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/ceph/dir.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 39e0f240de06..5e98394e2dca 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1099,6 +1099,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	struct ceph_client *cl = mdsc->fsc->client;
>  	struct ceph_mds_request *req;
>  	struct ceph_acl_sec_ctx as_ctx = {};
> +	struc dentry *ret;

Forgot to mention that I fixed this when I applied.

