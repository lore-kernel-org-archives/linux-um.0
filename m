Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4F1CA0EE4
	for <linux-um@archiver.kernel.org>; Mon, 18 Aug 2025 22:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hHuCUcsIDGUR83mctKaUcKPROKX7GWkzO+ZoZJL/sEk=; b=2EEwOG9H0k17sbh6FlC7afu1xg
	vN0FGfpD6B3K4zX91jlEje8e7o0xkMWIw35JnqBzLN7BIHHbivcYT7KfVSoLAWAsfhH3DdF17Xr9X
	AryOfHkSneEPG1Qm7Qr5QMr/sxqxj5i1UD4hXFMzdxuxWOBnUthIJ0G9AHZyqLYEvygiZw1BXj9mh
	3flfM7VHvIAIq1I9InG/HuuNImHhvmalXBaooufZmRe5LOheZpKCwJ6LEdfeunOhrMgdD5KI5+8YD
	yl45PBlVbsKSGJlIE0WS4d4OwKAykDSzbW3jLPA0SHQvAX9FQOwg+TKRRXHn2tWIviNalLhEJER6N
	+K9A7GsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo8hp-00000008rb9-3n6P;
	Mon, 18 Aug 2025 22:51:57 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo7nD-00000008mtU-0VH8;
	Mon, 18 Aug 2025 21:53:28 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uo7mP-006FjJ-U7;
	Mon, 18 Aug 2025 21:52:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Steve French" <sfrench@samba.org>, "Namjae Jeon" <linkinjeon@kernel.org>,
 "Carlos Maiolino" <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, netfs@lists.linux.dev,
 ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
In-reply-to: <CAOQ4uxjFPOZe004Cv+tT=NyQg2JOY6MOYQniSjaefVcg+3s-Kg@mail.gmail.com>
References: <>, <CAOQ4uxjFPOZe004Cv+tT=NyQg2JOY6MOYQniSjaefVcg+3s-Kg@mail.gmail.com>
Date: Tue, 19 Aug 2025 07:52:39 +1000
Message-id: <175555395905.2234665.9441673384189011517@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_145327_150222_4A56389E 
X-CRM114-Status: GOOD (  38.48  )
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

On Mon, 18 Aug 2025, Amir Goldstein wrote:
> On Wed, Aug 13, 2025 at 1:53=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > A few callers operate on a dentry which they already have - unlike the
> > normal case where a lookup proceeds an operation.
> >
> > For these callers dentry_lookup_continue() is provided where other
> > callers would use dentry_lookup().  The call will fail if, after the
> > lock was gained, the child is no longer a child of the given parent.
> >
> > There are a couple of callers that want to lock a dentry in whatever
> > its current parent is.  For these a NULL parent can be passed, in which
> > case ->d_parent is used.  In this case the call cannot fail.
> >
> > The idea behind the name is that the actual lookup occurred some time
> > ago, and now we are continuing with an operation on the dentry.
> >
> > When the operation completes done_dentry_lookup() must be called.  An
> > extra reference is taken when the dentry_lookup_continue() call succeeds
> > and will be dropped by done_dentry_lookup().
> >
> > This will be used in smb/server, ecryptfs, and overlayfs, each of which
> > have their own lock_parent() or parent_lock() or similar; and a few
> > other places which lock the parent but don't check if the parent is
> > still correct (often because rename isn't supported so parent cannot be
> > incorrect).
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/namei.c            | 39 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/namei.h |  2 ++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 7af9b464886a..df21b6fa5a0e 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1874,6 +1874,45 @@ struct dentry *dentry_lookup_killable(struct mnt_i=
dmap *idmap,
> >  }
> >  EXPORT_SYMBOL(dentry_lookup_killable);
> >
> > +/**
> > + * dentry_lookup_continue: lock a dentry if it is still in the given par=
ent, prior to dir ops
> > + * @child: the dentry to lock
> > + * @parent: the dentry of the assumed parent
> > + *
> > + * The child is locked - currently by taking i_rwsem on the parent - to
> > + * prepare for create/remove operations.  If the given parent is not
> > + * %NULL and is no longer the parent of the dentry after the lock is
> > + * gained, the lock is released and the call fails (returns
> > + * ERR_PTR(-EINVAL).
> > + *
> > + * On success a reference to the child is taken and returned.  The lock
> > + * and reference must both be dropped by done_dentry_lookup() after the
> > + * operation completes.
> > + */
> > +struct dentry *dentry_lookup_continue(struct dentry *child,
> > +                                     struct dentry *parent)
> > +{
> > +       struct dentry *p =3D parent;
> > +
> > +again:
> > +       if (!parent)
> > +               p =3D dget_parent(child);
> > +       inode_lock_nested(d_inode(p), I_MUTEX_PARENT);
> > +       if (child->d_parent !=3D p) {
>=20
> || d_unhashed(child))
>=20
> ;)

As you say!

>=20
> and what about silly renames? are those also d_unhashed()?

With NFS it is not unhashed (i.e.  it is still hashed, but with a
different name).  I haven't checked AFS.

But does it matter?  As long as it has the right parent and is not
unhashed, it is a suitable dentry to pass to vfs_unlink() etc.

If this race happened with NFS then ovl could try to remove the .nfsXXX
file and would get ETXBUSY due to DCACH_NFSFS_RENAMED.  I don't think
this is a problem.

If we really wanted to be sure the name hadn't changed we could do a
lookup and check that the same dentry is returned.

OVL is by nature exposed to possible races if something else tried to
modify the upper directory tree.  I don't think it needs to provide
perfect semantics in that case, it only needs to fail-safe.  I think
this recent change is enough to be safe in the face of concurrent
unlinks.

Thanks,
NeilBrown

=20
> Thanks,
> Amir.
>=20


