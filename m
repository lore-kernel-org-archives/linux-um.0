Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA07606A320
	for <linux-um@archiver.kernel.org>; Fri, 20 Nov 2026 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t+EeiCXV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLPFOBmp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bjsloV/HcKsVj7z9+HkdbWf0MogK/qby7SPqWG2uzjE=; b=t+EeiCXVHYbeRMS6ZssLn6SkXU
	hi7t7NUhsbVkMnmzIF4IjqmPVF/q/5b5eSxwHnr5DOxQcq+cyifhbILtlZ1cSKBbMf+W9yuo1eJ8F
	2V4/SC8C4rQiuEICEZfY+1k9kVHnohzNB3g4YCQsG+WNVa6+P5IU5M0aR9V3GSyaKhdGoFgEB7hmm
	nIjVtjaqOvFnGgxCWG2wI2/6ck0mQTt0/abBihB1KCQvAJpOucYTP4zCBbezHMObitHp6YG+2iepe
	OjCu8hW6vFBWgbzFE/9R/JUU+vi7Ky8DubR6Jw4DDUeoSvBZXw/c7+0g6IuJUWE4IGQhm917JSkbx
	yfHmTfhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUOlz-0000000F6fE-1BY0;
	Fri, 20 Nov 2026 13:35:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUOly-0000000F6f6-0Ox9
	for linux-um@lists.infradead.org;
	Fri, 20 Nov 2026 13:35:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8901860F89;
	Fri, 20 Nov 2026 13:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FD11F000C4;
	Fri, 20 Nov 2026 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795181725;
	bh=bjsloV/HcKsVj7z9+HkdbWf0MogK/qby7SPqWG2uzjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BLPFOBmpNPHpPFx0FWOYG24EYgD7CUJ6t1qXvqZvlVs6L6nHAmWejU+nksKDRzX3E
	 f/XCAUy92isyUIw3hdQtZ8BNA3hNpUFMmXAmE6dS8UXxYkJEb1gOJmqlVhSFk8eLTN
	 Hr3CspzOnm4nCBGB4u961t4qHU47LXPtLvnwyk+mDXbXxfeqCLDjKcRpAAgj5U+hz7
	 5H0cR7yQatjexLmeVub/wDBbYwWsYymhDblsgHz9sezq4uP4rKtf9ZYcoolylc2PGX
	 5TO1ramemZqDM7Zh1yS04udn5oCJsiE7pzpoF1fOaXS+TEyxhkFqjvFL0mnj/wsE9h
	 DH/9sDXLIxCDQ==
Date: Fri, 20 Nov 2026 14:35:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Jan Kara <jack@suse.cz>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Namjae Jeon <linkinjeon@kernel.org>, 
	Hyunchul Lee <hyc.lee@gmail.com>, Carlos Maiolino <cem@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	linux-kernel@vger.kernel.org, codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org, 
	linux-um@lists.infradead.org, ntfs@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] VFS/xfs/ntfs: drop parent lock across
 d_alloc_parallel() in d_add_ci()
Message-ID: <20261120-veranda-tiger-seemeilen-397d57fb2258@brauner>
References: <20261117000115.1433875-1-neilb@ownmail.net>
 <20261117000115.1433875-2-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117000115.1433875-2-neilb@ownmail.net>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 10:54:58AM +1100, NeilBrown wrote:
> We don't need to keep the parent lock held when d_add_ci() is run - the
> VFS doesn't need it as dentry is exclusively held due to
> DCACHE_PAR_LOOKUP and the filesystem has finished its work.

I'm not sure that holds? Only d_alloc_parallel() honours
DCACHE_PAR_LOOKUP. lookup_one_qstr_excl() still uses d_alloc() and
relies on the exclusive lock to guarantee that there are no in-lookup
children at all. That stops being true here:

> +		if (lookup_flags & LOOKUP_SHARED)
> +			inode_unlock_shared(d_inode(dentry->d_parent));
> +		else
> +			inode_unlock(d_inode(dentry->d_parent));
> +		must_relock = true;
>  		found = d_alloc_parallel(dentry->d_parent, name);

So if "Foo" exists on an ascii-ci xfs:

P1: stat("FOO")                      P2: unlink("Foo")
lookup_slow()
-> xfs_vn_ci_lookup()
   -> d_add_ci(dentry, X, "Foo")
      -> inode_unlock_shared(dir)
      -> found = d_alloc_parallel()
                                     start_dirop()
                                     -> inode_lock_nested(dir)
                                     -> lookup_one_qstr_excl("Foo")
                                        -> d2 = d_alloc()
                                        -> xfs_vn_ci_lookup()
                                           -> d_splice_alias(X, d2)
                                     vfs_unlink()
                                     -> xfs_vn_unlink()
                                        -> d_invalidate(d2)
                                     inode_unlock(dir)
      -> d_splice_alias(X, found)

IOW, "Foo" ends up as a hashed positive dentry for an unlinked inode
that nothing revalidates.

open("Foo", O_CREAT) then opens the orphan instead of creating a new
file and O_EXCL fails with EEXIST. Do a rename() instead of the unlink()
and "Foo" keeps pointing to what is now "Bar". ntfs gets there the same
way.

Before this patch lookup_slow() held the lock shared across all of
that so start_dirop() couldn't get in between.

So afaict this needs "VFS: use d_alloc_parallel() in
lookup_one_qstr_excl()" from your RFC to go in first. Unless I'm
missing something obvious.

