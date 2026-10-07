Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6C3CA5FFF
	for <linux-um@archiver.kernel.org>; Wed,  7 Oct 2026 09:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WKfTrq8VHIA+znChlNb3NuZ60B46dqCeKbF4f81115I=; b=0WT9JIBl4NDmNdMIc06bZatTzb
	qx3XnRa0TTIaWdV6ZDAUKtkLj33/sX54r0Fip+Th+k0CGxciJuHEtCp3N7sfm9dQHn3GlFLT/ytQB
	ezeoWfZnM8uGTLgjR7yQHW0oF+W1KGRkHpOaF6vP9TUKcQZShPode/f8yPpl11qmeQ5gILyeuRkyb
	pAAWwd18sGwzMbFXvKI6Stbp8CmaMp2mF6J7T1+ynUiR0mPMCUxgaRzL16aBa2Ht08ra/ZyfNRz+v
	HJXmL2yxW9dVVrWg645QD5hsO+MRZkrX21jgNml4VjYEDmxcUa0503vbZOEwZZEAzc8Aifo+vzpgZ
	B9rO2QOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEOFC-000000025hV-1ZrC;
	Wed, 07 Oct 2026 09:47:26 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEOFB-000000025hK-0GoF
	for linux-um@lists.infradead.org;
	Wed, 07 Oct 2026 09:47:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 748EC414F6;
	Wed,  7 Oct 2026 09:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB331F0089B;
	Wed,  7 Oct 2026 09:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791366444;
	bh=WKfTrq8VHIA+znChlNb3NuZ60B46dqCeKbF4f81115I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fai2JdxQg2GTZDr/VvQZVCO9hLiWsjmsp3kCspc8fuKK4Idhvb8afxieuvkYwQyYm
	 EROdJ2PNOewRKi2TlzftYwYAKyOzWDZOqcN/uIKMcnbgV4RmoSWKvkrrjXqOH103u4
	 pkW/zLZZoKah5esAFQs3D/dVu6u2y5mvWBDTVdUYX8sUlAMw/6TGZqWNoZl9+0sMb5
	 XRIYEsb8pFZMI07mxgwGXu32WJ+4ExSOAeE3Q6diCbSoyE+fYRs6OFJ8RwEG+2QP6M
	 t5VGgOEOdwhnOdt+AfIzlhYUJpGyLhxBjp3rfpsYz8tJfVVrUI3imhuR0jMSWv7pUP
	 MBSrx6oIQcWWw==
Date: Wed, 7 Oct 2026 11:47:09 +0200
From: Carlos Maiolino <cem@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Breno Leitao <leitao@debian.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Hyunchul Lee <hyc.lee@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-um@lists.infradead.org, codalist@coda.cs.cmu.edu, 
	coda@cs.cmu.edu, linux-mm@kvack.org, ntfs@lists.linux.dev, 
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/7] VFS/xfs/ntfs: drop parent lock across
 d_alloc_parallel() in d_add_ci()
Message-ID: <asYVApB1jdBYj9tN@cronus.toxiclabs.cc>
References: <20260929034158.1455429-1-neilb@ownmail.net>
 <20260929034158.1455429-2-neilb@ownmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929034158.1455429-2-neilb@ownmail.net>
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

On Tue, Sep 29, 2026 at 01:36:01PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> A proposed change will invert the lock ordering between
> d_alloc_parallel() and inode_lock() on the parent.
> When that happens it will not be safe to call d_alloc_parallel() while
> holding the parent lock - even shared.
> 
> We don't need to keep the parent lock held when d_add_ci() is run - the
> VFS doesn't need it as dentry is exclusively held due to
> DCACHE_PAR_LOOKUP and the filesystem has finished its work.
> 
> So drop and reclaim the lock (shared or exclusive as determined by
> LOOKUP_SHARED) to avoid future deadlock.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---

XFS bits are really small, but anyway, if needed, feel free to add:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

>  Documentation/filesystems/porting.rst |  7 ++++++
>  fs/dcache.c                           | 32 +++++++++++++++++++++++----
>  fs/ntfs/namei.c                       |  2 +-
>  fs/xfs/xfs_iops.c                     |  2 +-
>  include/linux/dcache.h                |  3 ++-
>  5 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 4e015f1bf1f8..f6a38bd9c68e 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1409,3 +1409,10 @@ use only if you have no alternative.
>  The .create inode_operation no longer receives the 'excl' arg.  It must
>  always assume the file does not already exist.  If the filesystem needs
>  to be involved in non-exclusive create, it should provide atomic_open.
> +
> +---
> +
> +**mandatory**
> +
> +d_add_ci() must now be passed the flags arguemnt that was given to ->lookup
> +
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 83790c7a4dee..61e0896dc077 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2383,6 +2383,7 @@ EXPORT_SYMBOL(d_obtain_root);
>   * @dentry: the negative dentry that was passed to the parent's lookup func
>   * @inode:  the inode case-insensitive lookup has found
>   * @name:   the case-exact name to be associated with the returned dentry
> + * @lookup_flags: flags passed to ->lookup
>   *
>   * This is to avoid filling the dcache with case-insensitive names to the
>   * same inode, only the actual correct case is stored in the dcache for
> @@ -2395,9 +2396,10 @@ EXPORT_SYMBOL(d_obtain_root);
>   * the exact case, and return the spliced entry.
>   */
>  struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
> -			struct qstr *name)
> +			struct qstr *name, unsigned int lookup_flags)
>  {
>  	struct dentry *found, *res;
> +	bool must_unlock = false;
>  
>  	/*
>  	 * First check if a dentry matching the name already exists,
> @@ -2409,24 +2411,46 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
>  		return found;
>  	}
>  	if (d_in_lookup(dentry)) {
> +		/*
> +		 * We are holding parent lock and so don't want to wait
> +		 * for a d_in_lookup() dentry.  We can safely drop the
> +		 * parent lock and reclaim it as we have exclusive
> +		 * access to dentry as it is d_in_lookup() (so
> +		 * ->d_parent is stable) and we are near the end
> +		 * ->lookup() and will shortly drop the lock anyway.
> +		 * We cannot retake the lock while the new dentry is in-lookup
> +		 */
> +		if (lookup_flags & LOOKUP_SHARED)
> +			inode_unlock_shared(d_inode(dentry->d_parent));
> +		else
> +			inode_unlock(d_inode(dentry->d_parent));
> +		must_unlock = true;
>  		found = d_alloc_parallel(dentry->d_parent, name);
>  		if (IS_ERR(found) || !d_in_lookup(found)) {
>  			iput(inode);
> -			return found;
> +			goto out_unlock;
>  		}
>  	} else {
>  		found = d_alloc(dentry->d_parent, name);
>  		if (!found) {
>  			iput(inode);
>  			return ERR_PTR(-ENOMEM);
> -		} 
> +		}
>  	}
>  	res = d_splice_alias(inode, found);
>  	if (res) {
>  		d_lookup_done(found);
>  		dput(found);
> -		return res;
> +		found = res;
>  	}
> +	if (!must_unlock)
> +		return found;
> +out_unlock:
> +	d_lookup_done(dentry);
> +	if (lookup_flags & LOOKUP_SHARED)
> +		inode_lock_shared(d_inode(dentry->d_parent));
> +	else
> +		inode_lock_nested(d_inode(dentry->d_parent), I_MUTEX_PARENT);
>  	return found;
>  }
>  EXPORT_SYMBOL(d_add_ci);
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index 7091b2496fac..61cfa4e16586 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -309,7 +309,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
>  		}
>  		nls_name.hash = full_name_hash(dent, nls_name.name, nls_name.len);
>  
> -		dent = d_add_ci(dent, dent_inode, &nls_name);
> +		dent = d_add_ci(dent, dent_inode, &nls_name, flags);
>  		kfree(nls_name.name);
>  		return dent;
>  
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 4a3299abf774..fd480c0e4147 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -368,7 +368,7 @@ xfs_vn_ci_lookup(
>  	/* else case-insensitive match... */
>  	dname.name = ci_name.name;
>  	dname.len = ci_name.len;
> -	dentry = d_add_ci(dentry, VFS_I(ip), &dname);
> +	dentry = d_add_ci(dentry, VFS_I(ip), &dname, flags);
>  	kfree(ci_name.name);
>  	return dentry;
>  }
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index adf239f8205f..97d11f5e6a7b 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -267,7 +267,8 @@ struct dentry *d_duplicate(struct dentry *dentry);
>  /* weird procfs mess; *NOT* exported */
>  extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
>  					  const struct dentry_operations *);
> -extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
> +extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *,
> +				unsigned int);
>  extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
>  			const struct qstr *name);
>  extern struct dentry *d_find_any_alias(struct inode *inode);
> 
> base-commit: 3879f51857325da9bf3cfb073280257cd16ae067
> -- 
> 2.50.0.107.gf914562f5916.dirty
> 

