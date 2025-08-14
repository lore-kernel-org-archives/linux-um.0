Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616A6CA0EE4
	for <linux-um@archiver.kernel.org>; Thu, 14 Aug 2025 01:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=prMLDcyChav8YocJtuSlDskFW0Yyr+EkeaSOjliD5HU=; b=bGCrIkThtJCrXWhUyd2sxjtu9t
	t/5eQ+LDN5VGOIiifmMqbDhtVmHzixkuJOMK+nSuAfOIe55djWVJbLI2Pa6hqyL7bLh3ZeBWzwBxO
	jJsRck8XrZ9QX3LSVH7tbYHO3xr/DqmoBRZC/owuEq1zeUejT0d3SDH1FysCigYsC6sdlzHwEEQQq
	b0M2IpUxCO8LeQdkVGx8QblwmQXSEJL9o/gyfpIgZRIiLJZGVT5FD/Ffkhrjckrk9fc0JURDbZglg
	ZGxn7jiW8JOR2Jeqw08Nw6qxQO3WBlNZMuuaxvZAdEIvLcG7cjYJ1ddeg2msPMHCEGEq+FzJ+FsRu
	J/0UF5AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umNBk-0000000FXfq-2PpP;
	Thu, 14 Aug 2025 01:55:32 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umMoi-0000000FVTB-10YT;
	Thu, 14 Aug 2025 01:31:45 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1umMoE-005hAB-I4;
	Thu, 14 Aug 2025 01:31:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 netfs@lists.linux.dev, ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] VFS: use global wait-queue table for d_alloc_parallel()
In-reply-to: <20250813064431.GF222315@ZenIV>
References: <>, <20250813064431.GF222315@ZenIV>
Date: Thu, 14 Aug 2025 11:31:15 +1000
Message-id: <175513507565.2234665.11138440093783281571@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_183144_287512_6D536071 
X-CRM114-Status: GOOD (  33.48  )
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

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:12PM +1000, NeilBrown wrote:
>=20
> > +** mandatory**
> > +
> > +d_alloc_parallel() no longer requires a waitqueue_head.  It uses one
> > +from an internal table when needed.
>=20
> Misleading, IMO - that sounds like "giving it a wq is optional, it will
> pick one if needed" when reality is "calling conventions have changed,
> no more passing it a waitqueue at all".

I'll rephrase it.

>=20
> > +#define	PAR_LOOKUP_WQ_BITS	8
> > +#define PAR_LOOKUP_WQS (1 << PAR_LOOKUP_WQ_BITS)
> > +static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_alig=
ned;
>=20
> I wonder how hot these cachelines will be...

Are you questioning the __cacheline_aligned??  I confess I just copied
the annotation on bit_wait_table.

My guess is that concurrent attempts to add the same name to the dcache
are rare, so these wait_queue_heads will be rarely used.

>=20
> > +static int __init par_wait_init(void)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < PAR_LOOKUP_WQS; i++)
> > +		init_waitqueue_head(&par_wait_table[i]);
> > +	return 0;
> > +}
> > +fs_initcall(par_wait_init);
>=20
> Let's not open _that_ can of worms; just call it from dcache_init().
>=20
> > +static inline void d_wake_waiters(struct wait_queue_head *d_wait,
> > +				  struct dentry *dentry)
> > +{
> > +	/* ->d_wait is only set if some thread is actually waiting.
> > +	 * If we find it is NULL - the common case - then there was no
> > +	 * contention and there are no waiters to be woken.
> > +	 */
> > +	if (d_wait)
> > +		__wake_up(d_wait, TASK_NORMAL, 0, dentry);
>=20
> Might be worth a note re "this is wake_up_all(), except that key is dentry
> rather than NULL" - or a helper in wait.h to that effect, for that matter.
> I see several other places where we have the same thing (do_notify_pidfd(),
> nfs4_callback_notify_lock(), etc.), so...
>=20
>=20

As there are no exclusive waiters, any wakeup is a wake_up_all so I
think that emphasising the "all" adds no value.  So I could equally have
used "1" instead of "0", but I chose "0" as the number was irrelevant.

Having a "wake_up_key()" which does=20
   __wake_up(wq, TASK_NORMAL, 1, key)
would be nice.

> > +		struct wait_queue_head *wq;
> > +		if (!dentry->d_wait)
> > +			dentry->d_wait =3D &par_wait_table[hash_ptr(dentry,
> > +								  PAR_LOOKUP_WQ_BITS)];
> > +		wq =3D dentry->d_wait;
>=20
> Yecchhh...  Cosmetic change: take
> 	&par_wait_table[hash_ptr(dentry, PAR_LOOKUP_WQ_BITS)];
> into an inlined helper, please.
>=20
> BTW, while we are at it - one change I have for that function is
> (in the current form)
> static bool d_wait_lookup(struct dentry *dentry,
> 			  struct dentry *parent,
> 			  const struct qstr *name)
> {
> 	bool valid =3D true;
> 	spin_lock(&dentry->d_lock);
>         if (d_in_lookup(dentry)) {
> 		DECLARE_WAITQUEUE(wait, current);
> 		add_wait_queue(dentry->d_wait, &wait);
> 		do {  =20
> 			set_current_state(TASK_UNINTERRUPTIBLE);
> 			spin_unlock(&dentry->d_lock);
> 			schedule();
> 			spin_lock(&dentry->d_lock);
> 		} while (d_in_lookup(dentry));
> 	}
> 	/*
> 	 * it's not in-lookup anymore; in principle the caller should repeat
> 	 * everything from dcache lookup, but it's likely to be what
> 	 * d_lookup() would've found anyway.  If so, they can use it as-is.
> 	 */
> 	if (unlikely(dentry->d_name.hash !=3D name->hash ||
> 		     dentry->d_parent !=3D parent ||
> 		     d_unhashed(dentry) ||
> 		     !d_same_name(dentry, parent, name)))
> 		valid =3D false;
> 	spin_unlock(&dentry->d_lock);
> 	return valid;
> }
>=20
> with
> 	if (unlikely(d_wait_lookup(dentry, parent, name))) {
>                 dput(dentry);
> 		goto retry;
> 	}
> 	dput(new);
> 	return dentry;
> in the caller (d_alloc_parallel()).  Caller easier to follow and fewer func=
tions
> that are not neutral wrt ->d_lock...  I'm not suggesting to fold that with
> yours - just a heads-up on needing to coordinate.

I see the value in that, but it does mean the function is doing more
than just waiting, and it might make my life a bit harder....

One of the steps toward per-dentry locking involves finding a new
solution to excluding all other accesses when rmdir() is happening.  An
exclusive lock on the directory will no longer be sufficient.

So I set a flag which says "rmdir processing has started" and cause
d_alloc_parallel() (and dentry_lock) to wait for that flag to clear.
A new rmdir_lock() needs to wait for all current DCACHE_PAR_LOOKUP
dentries to complete the lookup and my code currently uses
d_wait_lookup().  The extra test you've added at the end wouldn't be
harmful exactly but would be unnecessary.
Maybe we could have d_wait_lookup_and_check() for your version and
d_wait_lookup() for me?

>=20
> Anyway, modulo fs_initcall() thing it's all cosmetical; I certainly like
> the simplified callers, if nothing else.
>=20
> That's another patch I'd like to see pulled in front of the queue.
>=20

Thanks.

NeilBrown

