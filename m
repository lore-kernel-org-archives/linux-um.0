Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595E1C87FCF
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 10:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fRdJdiPFdGUagAGDZioca3xLZdOqG4rbdZRaVfLlGO8=; b=hdbVX+ugJ8DhYf1vHYISeI08pi
	vLWdBcVJ8RGIAvgvgS0LiOaE0wZsa/mqv+xBKCTri392kLoGD5KmQ7OXg0DMHgfvOjwMM+/FgScHN
	C6KkgtXbSYLLh8yxTnuFxit+Jl2oB6C3qSOGTsZF80Xog5uI8xKioiMfpTs8GsY/z/dRJj31zmvtY
	4twyrHMGPmef3fM2JVWRTm85hTsyFJJPWgbqzvGMFP3oMukUQtboZRREb5nqmrsw8rlopjYUzCR+F
	fTWxXLgIe4+i11t4fI8GEvkKPHRI9yeAYsX9gpxFWrBC/sRUboolBMGPHjxFZmNCUQiqRyi5N6d4H
	HXDKRtDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um8Wh-0000000DLa2-3gUX;
	Wed, 13 Aug 2025 10:16:11 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um6EB-0000000Cyxa-1FIU;
	Wed, 13 Aug 2025 07:48:56 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1um6DQ-005asy-De;
	Wed, 13 Aug 2025 07:48:10 +0000
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
Subject: Re: [PATCH 02/11] VFS: introduce dentry_lookup() and friends
In-reply-to: <20250813041253.GY222315@ZenIV>
References: <>, <20250813041253.GY222315@ZenIV>
Date: Wed, 13 Aug 2025 17:48:09 +1000
Message-id: <175507128953.2234665.9075244835979746809@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_004855_486112_94ACF755 
X-CRM114-Status: GOOD (  43.12  )
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
> On Tue, Aug 12, 2025 at 12:25:05PM +1000, NeilBrown wrote:
> > This patch is the first step in introducing a new API for locked
> > operation on names in directories.  It supports operations that create or
> > remove names.  Rename operations will also be part of this new API but
> > require different specific interfaces.
> >=20
> > The plan is to lock just the dentry (or dentries), not the whole
> > directory.  dentry_lookup() combines locking the directory and
> > performing a lookup prior to a change to the directory.  On success it
> > returns a dentry which is consider to be locked, though at this stage
> > the whole parent directory is actually locked.
> >=20
> > dentry_lookup_noperm() does the same without needing a mnt_idmap and
> > without checking permissions.  This is useful for internal filesystem
> > management (e.g.  creating virtual files in response to events) and in
> > other cases similar to lookup_noperm().
>=20
> Details, please.  I seriously hope that simple_start_creating() will
> end up used for all of those; your variant allows passing LOOKUP_...
> flags and I would like to understand what the usecases will be.

simple_start_creating() would meet a lot of needs.
A corresponding simple_start_deleting() would suit
cachefiles_lookup_for_cull(), fuse_reverse_inval_entry(),
nfsd4_unlink_clid_dir() etc.

btrfs_ioctl_snap_destroy() would want a simple_start_deleting() but also
wants killable.

cachefiles_get_directory() wants a simple_start_creating() without the
LOOKUP_EXCL so that if is already exists, it can go ahead and use the
dentry without creating.

cachefiles_commit_tmpfile() has a similar need - if it exists it will
unlink and repeat the lookup.  Once it doesn't it it will be target of
vfs_link()

nfsd3_create_file() wants simple_start_creating without LOOKUP_EXCL.
as do a few other nfsd functions.

nfsd4_list_rec_dir() effectively wants simple_start_deleting() (i.e.
fail if it doesn't exist) but sometimes it won't delete, it will do
something else.

All calls pass one of:
   0
   LOOKUP_CREATE
   LOOKUP_CREATE | LOOKUP_EXCL

The first two aren't reliably called for any particular task so a
"simple_start_XXX" sort of name doesn't seem appropriate.


>=20
> What's more, IME the "intent" arguments are best avoided - better have
> separate primitives; if internally they call a common helper with some
> flags, etc., it's their business, but exposing that to callers ends
> up with very unpleasant audits down the road.  As soon as you get
> callers that pass something other than explicit constants, you get
> data flow into the mix ("which values can end up passed in this one?")
> and that's asking for trouble.

lookup_no_create, lookup_may_create, lookup_must_create ???

Either as function names, or as an enum to pass to the function?

If we had separate functions we would need _noperm and potentially
_killable versions of each.  Fortunately there is no current need for
_noperm_killable.  Maybe that combinatorial explosion isn't too bad.

>=20
> > __dentry_lookup() is a VFS-internal interface which does no permissions
> > checking and assumes that the hash of the name has already been stored
> > in the qstr.  This is useful following filename_parentat().
> >=20
> > done_dentry_lookup() is provided which performs the inverse of putting
> > the dentry and unlocking.
>=20
> Not sure I like the name, TBH...

I'm open to suggestions for alternatives.

>=20
> > Like lookup_one_qstr_excl(), dentry_lookup() returns -ENOENT if
> > LOOKUP_CREATE was NOT given and the name cannot be found,, and returns
> > -EEXIST if LOOKUP_EXCL WAS given and the name CAN be found.
> >=20
> > These functions replace all uses of lookup_one_qstr_excl() in namei.c
> > except for those used for rename.
> >=20
> > They also allow simple_start_creating() to be simplified into a
> > static-inline.
>=20
> Umm...  You've also moved it into linux/namei.h; we'd better verify that
> it's included in all places that need that...

I added includes where necessary.

>=20
> > A __free() class is provided to allow done_dentry_lookup() to be called
> > transparently on scope exit.  dget() is extended to ignore ERR_PTR()s
> > so that "return dget(dentry);" is always safe when dentry was provided
> > by dentry_lookup() and the variable was declared __free(dentry_lookup).
>=20
> Please separate RAII stuff from the rest of that commit.  Deciding if
> it's worth doing in any given case is hard to do upfront.

I'd rather not - it does make a few changes much nicer.  But I can if it
is necessary.

>=20
> > lookup_noperm_common() and lookup_one_common() are moved earlier in
> > namei.c.
>=20
> Again, separate commit - reduce the noise in less trivial ones.
>=20
> > +struct dentry *dentry_lookup(struct mnt_idmap *idmap,
> > +			     struct qstr *last,
> > +			     struct dentry *base,
> > +			     unsigned int lookup_flags)
>=20
> Same problem with flags, *ESPECIALLY* if your endgame involves the
> locking of result dependent upon those.

Locking the result happens precisely if a non-error is returned.  The
lookup flags indicate which circumstances result in errors.

>=20
> > -	dput(dentry);
> > +	done_dentry_lookup(dentry);
> >  	dentry =3D ERR_PTR(error);
> > -unlock:
> > -	inode_unlock(path->dentry->d_inode);
>=20
> Incidentally, this combination (dput()+unlock+return ERR_PTR())
> is common enough.  Might be worth a helper (taking error as argument;
> that's one of the reasons why I'm not sure RAII is a good fit for this
> problem space)

I found RAII worked quite well in several places and very well in a few.
I think the main reason I had for *not* using RAII is that you really
need to use it for everything and I didn't want to change code too much.


>=20
> > +/* no_free_ptr() must not be used here - use dget() */
> > +DEFINE_FREE(dentry_lookup, struct dentry *, if (_T) done_dentry_lookup(_=
T))
>=20
> UGH.  Please, take that to the very end of the series.  And the comment
> re no_free_ptr() and dget() is really insufficient - you will get a dentry
> reference that outlives your destructor, except that locking environment wi=
ll
> change.  Which is subtle enough to warrant a discussion.
>=20
> Besides, I'm not fond of mixing that with dget(); put another way, this
> subset of dget() uses is worth being clearly marked as such.  A primitive
> that calls dget() to do work?  Sure, no problem.
>=20
> We have too many dget() callers with very little indication of what we are
> doing there (besides "bump the refcount"); tree-in-dcache series will
> at least peel off the ones that are about pinning a created object in
> ramfs-style filesystems.  That's not going to cover everything (not even
> close), but let's at least not add to the already messy pile...
>=20

Thanks for the review,
NeilBrown

