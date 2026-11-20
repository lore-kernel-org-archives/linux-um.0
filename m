Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C8606A33B
	for <linux-um@archiver.kernel.org>; Fri, 20 Nov 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F1lG7cSI;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVt/gpeT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qZNnoG+Fb9/W4ISE55dTt9q7EvNYjApPu7ZJ7FyZ+gg=; b=F1lG7cSIH5gSVlnlLtIBrW9pMm
	WofDxYLmvTmrhRAgKOFMmTl02FjEZ9HAH6TiWfe06HqCjctv75teqasMLUQSZ1on4wQwvHeCNj4r9
	i4VrqHe6s+3+rqK6MDXOwI0vMJn0ss/aneEA/7nNEETfFEPLyvqgTf1Jj2RQ7EZOIkMfwox0pKc6t
	8JF6XX3qh5zZFHfVjqybdhWL0/Za5O3+PdCcGEe2xtPKwPx0LCdXLf1kEfac9zGn9mFp61SN6N5yM
	BMq0ex7LbrCEjHLlsj0ZYRN24AtaJZOSnRDQxx8DwHjInCIZpvLtL8smRKCNdS2DOUTMQr+U/wCcv
	/n60kbJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUOpJ-0000000F71O-3OSg;
	Fri, 20 Nov 2026 13:38:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUOpI-0000000F70y-02DB
	for linux-um@lists.infradead.org;
	Fri, 20 Nov 2026 13:38:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C96A609F8;
	Fri, 20 Nov 2026 13:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5DE1F000CA;
	Fri, 20 Nov 2026 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795181930;
	bh=qZNnoG+Fb9/W4ISE55dTt9q7EvNYjApPu7ZJ7FyZ+gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZVt/gpeT+QwOmnfJsc/3ftB9+K4CjZ3YSI88OOCcUEyqT8stAjszp+96a1oJ8+0Ns
	 tJ28EUnrlrLw9TlUOid9CZzjfn9sO4YAFQTD69kTlmyLwU5FrG5okc44xqgyYHPO9k
	 72COaeHn+Gxg6/5DfuobCFUQxlXa/5iZuMi/kBejSCtB4CLtllAXZ9ODJZwsH/NGBR
	 me1qLoTncPhWjF3BwjgrOy0tCk4+03m+KRYy5i/BYG3pC+wuQs7E2NKAfbcsFxCgsT
	 UgMCojc7Jqf5gf7TYm5o8CJidfwqwilfz1646EEe12O0PTjnF7rI/OQf91AzOYM3w9
	 eAvB4es4XUd3A==
Date: Fri, 20 Nov 2026 14:38:43 +0100
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
Subject: Re: [PATCH v2 4/4] procfs: drop parent lock for d_alloc_parallel()
 in iterate_shared()
Message-ID: <20261120-visier-dortig-gutachten-7a478b74ea10@brauner>
References: <20261117000115.1433875-1-neilb@ownmail.net>
 <20261117000115.1433875-5-neilb@ownmail.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117000115.1433875-5-neilb@ownmail.net>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 10:55:01AM +1100, NeilBrown wrote:
> +	if (child == ERR_PTR(-EWOULDBLOCK)) {
> +		/*
> +		 * Need to drop directory lock, which isn't really
> +		 * needed here anyway.  As rmdir never happens in procfs
> +		 * we don't need to be concerned about S_DEAD being set
> +		 * while unlocked.
> +		 */
> +		inode_unlock_shared(dir->d_inode);
>  		child = d_alloc_parallel(dir, &qname);
> [...]
> +		inode_lock_shared(dir->d_inode);
> +	}

I think this can deadlock.
If we're colliding with the failed lookup because the fd was closed, the
task exited or the sysctl unregistered then the  dentry is unhashed and
d_alloc_parallel() hands us a new in-lookup dentry.

We then retake the lock while still owning it. But the VFS waits for
in-lookup dentries with the lock held, e.g., open() with O_CREAT:

P1: getdents(/proc/$pid/fd)         P2: open("/proc/$pid/fd/5", O_CREAT)
proc_fill_cache("5")
-> d_alloc_trylock() == -EWOULDBLOCK
-> inode_unlock_shared(dir)
                                    lookup_open()
                                    -> inode_lock(dir)
                                    -> d_lookup("5") == NULL
-> child = d_alloc_parallel("5")
                                    -> d_alloc_parallel("5")
                                       -> d_wait_lookup(child)
-> inode_lock_shared(dir)

Both sleep uninterruptibly.
A shell redirect to /dev/fd/5 is enough for P2.

I don't tink it even needs O_CREAT. Any queued writer like a mkdir in
the directory or chmod on it plus a lookup_slow() of the same name that
holds the lock shared and waits on the child has the asme issue.

And under /proc/sys/net it doesn't need a failing lookup either.
proc_sys_compare() matches any in-lookup dentry but after the wait
sysctl_is_seen() rejects a dentry from another netns and we get our
own.

d_add_ci() in 1/4 gets this right and finishes all in-lookup dentries
before relocking. So I think procfs needs to do the same, sm like
(UNTESTED):

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5f9ec52..d30f877 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2105,19 +2105,19 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	struct inode *inode;
 	unsigned type = DT_UNKNOWN;
 	ino_t ino = 1;
+	bool relock = false;
 
 	child = d_alloc_trylock(dir, &qname);
-
 	if (child == ERR_PTR(-EWOULDBLOCK)) {
 		/*
-		 * Need to drop directory lock, which isn't really
-		 * needed here anyway.  As rmdir never happens in procfs
-		 * we don't need to be concerned about S_DEAD being set
-		 * while unlocked.
+		 * Wait for the other lookup without the directory lock and
+		 * don't take it back while @child is in-lookup: lookup_open()
+		 * waits for in-lookup dentries with the lock held exclusive.
+		 * procfs never sets S_DEAD.
 		 */
 		inode_unlock_shared(dir->d_inode);
+		relock = true;
 		child = d_alloc_parallel(dir, &qname);
-		inode_lock_shared(dir->d_inode);
 	}
 	if (IS_ERR(child))
 		goto end_instantiate;
@@ -2137,6 +2137,8 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	type = inode->i_mode >> 12;
 	dput(child);
 end_instantiate:
+	if (relock)
+		inode_lock_shared(dir->d_inode);
 	return dir_emit(ctx, name, len, ino, type);
 }
 

The sysctl side needs the same.

This also has the same lookup_one_qstr_excl() problem as the earlier
patch.

