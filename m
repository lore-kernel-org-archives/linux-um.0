Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BC6C87FCF
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0SNIdZiTJR/nPW1SdNBX7/DJYyYBUtTTIadH/4Y1HCg=; b=V144S4Q7o63cDwL0zWKtx05c7X
	i5OeOgWyLT6giWHx3qZ9FgdtZ7aww4i5Ru7QfJj57DriTqqJgY7YBKKxMNjMpDeWsHP8uk8p4ed5a
	7gm6hROJoO/pXKydqzIes890CWAHCC9ZuRNMJVUf2+9DWB36ZrmRIjs4urOpKT3Oq3Hm6Ec4O3eFX
	c3lON77WqOHJD6dGkGrNzxGygOp/zVT3G0eOxYa6yp6pfnpUM+qSh0laZDHm1XoAucmyxr6+KfJ+H
	9VXU/9/QlNYFZpqTpSxJZkZXL2i+TeXyDjTZVbiAF7JCd0OuCedQ31a3hnIV3B30tfvtjgRwdjZzl
	MW+hdo/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um66R-0000000CxJO-3yOV;
	Wed, 13 Aug 2025 07:40:55 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5E4-0000000CpIG-3p7A;
	Wed, 13 Aug 2025 06:44:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0SNIdZiTJR/nPW1SdNBX7/DJYyYBUtTTIadH/4Y1HCg=; b=vt6VckGnfO/bRRiyFxmXG9ogQn
	sU3C5xi4iIp5tuRc34S9kxl5tNaRl9AtTgEm+7SWGAGEbW4/p/dK1U9ns6ca+6XQpjKnsL6WwqfPv
	IiWYMQMqYj6y3NQs1sn1zJub+2HYiOP4yyFS8U9o0DSMHmZUwO0/Xd42zILkkvfEL7P/0vayh8GHw
	tQcul4hTNmy+uZj/vdV/WA6o58XjgJCGKYJTITnQenOcJRPIwOFEIqfpTy/8WEpgr1Hp+0+EilJ92
	68d+GTcpetaDTVjn8KbX7NpVPzyNwIFk0u7npkiQcDSDEbOy7Xsl3S+yIvv1gjeukl5q9naab7Bqn
	xPYjpGFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5Dr-00000006iOl-1FbN;
	Wed, 13 Aug 2025 06:44:31 +0000
Date: Wed, 13 Aug 2025 07:44:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] VFS: use global wait-queue table for
 d_alloc_parallel()
Message-ID: <20250813064431.GF222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-10-neil@brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-10-neil@brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_234444_957719_3ADBDA3D 
X-CRM114-Status: GOOD (  23.73  )
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

On Tue, Aug 12, 2025 at 12:25:12PM +1000, NeilBrown wrote:

> +** mandatory**
> +
> +d_alloc_parallel() no longer requires a waitqueue_head.  It uses one
> +from an internal table when needed.

Misleading, IMO - that sounds like "giving it a wq is optional, it will
pick one if needed" when reality is "calling conventions have changed,
no more passing it a waitqueue at all".

> +#define	PAR_LOOKUP_WQ_BITS	8
> +#define PAR_LOOKUP_WQS (1 << PAR_LOOKUP_WQ_BITS)
> +static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_aligned;

I wonder how hot these cachelines will be...

> +static int __init par_wait_init(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < PAR_LOOKUP_WQS; i++)
> +		init_waitqueue_head(&par_wait_table[i]);
> +	return 0;
> +}
> +fs_initcall(par_wait_init);

Let's not open _that_ can of worms; just call it from dcache_init().

> +static inline void d_wake_waiters(struct wait_queue_head *d_wait,
> +				  struct dentry *dentry)
> +{
> +	/* ->d_wait is only set if some thread is actually waiting.
> +	 * If we find it is NULL - the common case - then there was no
> +	 * contention and there are no waiters to be woken.
> +	 */
> +	if (d_wait)
> +		__wake_up(d_wait, TASK_NORMAL, 0, dentry);

Might be worth a note re "this is wake_up_all(), except that key is dentry
rather than NULL" - or a helper in wait.h to that effect, for that matter.
I see several other places where we have the same thing (do_notify_pidfd(),
nfs4_callback_notify_lock(), etc.), so...


> +		struct wait_queue_head *wq;
> +		if (!dentry->d_wait)
> +			dentry->d_wait = &par_wait_table[hash_ptr(dentry,
> +								  PAR_LOOKUP_WQ_BITS)];
> +		wq = dentry->d_wait;

Yecchhh...  Cosmetic change: take
	&par_wait_table[hash_ptr(dentry, PAR_LOOKUP_WQ_BITS)];
into an inlined helper, please.

BTW, while we are at it - one change I have for that function is
(in the current form)
static bool d_wait_lookup(struct dentry *dentry,
			  struct dentry *parent,
			  const struct qstr *name)
{
	bool valid = true;
	spin_lock(&dentry->d_lock);
        if (d_in_lookup(dentry)) {
		DECLARE_WAITQUEUE(wait, current);
		add_wait_queue(dentry->d_wait, &wait);
		do {   
			set_current_state(TASK_UNINTERRUPTIBLE);
			spin_unlock(&dentry->d_lock);
			schedule();
			spin_lock(&dentry->d_lock);
		} while (d_in_lookup(dentry));
	}
	/*
	 * it's not in-lookup anymore; in principle the caller should repeat
	 * everything from dcache lookup, but it's likely to be what
	 * d_lookup() would've found anyway.  If so, they can use it as-is.
	 */
	if (unlikely(dentry->d_name.hash != name->hash ||
		     dentry->d_parent != parent ||
		     d_unhashed(dentry) ||
		     !d_same_name(dentry, parent, name)))
		valid = false;
	spin_unlock(&dentry->d_lock);
	return valid;
}

with
	if (unlikely(d_wait_lookup(dentry, parent, name))) {
                dput(dentry);
		goto retry;
	}
	dput(new);
	return dentry;
in the caller (d_alloc_parallel()).  Caller easier to follow and fewer functions
that are not neutral wrt ->d_lock...  I'm not suggesting to fold that with
yours - just a heads-up on needing to coordinate.

Anyway, modulo fs_initcall() thing it's all cosmetical; I certainly like
the simplified callers, if nothing else.

That's another patch I'd like to see pulled in front of the queue.

