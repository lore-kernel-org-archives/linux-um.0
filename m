Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFABC87FCF
	for <linux-um@archiver.kernel.org>; Thu, 14 Aug 2025 01:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-id:Date:References:
	In-reply-to:Subject:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/Yr0Z4yg/5rUR3ynJBUtPdG52PiSnptS1nNTcWgiMM=; b=geG4wP8zk2MIno1Ux+Nt4B8aN0
	9qJCs63Ckou0kUblMSs1Sc8Zp5g37+HujCckOSIiGHYBfjh2LYsdKQWLYqCG/bMD/NNPo7D1/roXG
	Ja0aphV0EliGQ7Zz0WviSzbNmAOUgQHT/OezDldIA8rHTVdyRDcGkYX34jinhP436HRwZUIl3oE9U
	rfEWSIvx/XU6zDVq/Qdv1uX7/O/dTuRRPwCkNUxwnck/XOXz59YcBNr72fhhBFkrK+LuuT9u/v5Zz
	YtOlGRTinx+CSdOQGeblcQTnN6k5TPr0TFTKE6SqXXh6cNtMmhsY78N432WTbq+FzE7MrLZALo1X7
	xZIs5wpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umMXU-0000000FTBO-1iTi;
	Thu, 14 Aug 2025 01:13:56 +0000
Received: from neil.brown.name ([103.29.64.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umMXR-0000000FTAE-3CCd;
	Thu, 14 Aug 2025 01:13:55 +0000
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1umMWx-005h4S-F7;
	Thu, 14 Aug 2025 01:13:25 +0000
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
Subject: Re: [PATCH 07/11] VFS: Change vfs_mkdir() to unlock on failure.
In-reply-to: <CAOQ4uxhU12U8g_EYkUyc4Jdpzjy3hT1hZYB0L1THwvTsti8mTw@mail.gmail.com>
References: <>, <CAOQ4uxhU12U8g_EYkUyc4Jdpzjy3hT1hZYB0L1THwvTsti8mTw@mail.gmail.com>
Date: Thu, 14 Aug 2025 11:13:24 +1000
Message-id: <175513400457.2234665.11514455496974675927@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_181353_942479_01BBAA2A 
X-CRM114-Status: GOOD (  46.63  )
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

On Wed, 13 Aug 2025, Amir Goldstein wrote:
> On Wed, Aug 13, 2025 at 1:53=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > Proposed changes to directory-op locking will lock the dentry rather
> > than the whole directory.  So the dentry will need to be unlocked.
> >
> > vfs_mkdir() consumes the dentry on error, so there will be no dentry to
> > be unlocked.
>=20
> Why does it need to consume the dentry on error?

Because when the recent change was made to have vfs_mkdir() and ->mkdir
handling the fact that the passed-in denty might not be used, that was
the interface that was deemed to be best of all that were considered.


> Why can't it leave the state as is on error and let the caller handle
> its own cleanup?

There are three possible results from vfs_mkdir()
 - the dentry that was passed in has been instantiated
 - a different dentry was already attached to the inode, and it has been
   splice in to the given name
 - there was an error.

In the second case it seems easiest to dput() the original dentry as it
is no longer interesting and that saves the caller from having the test
and maybe dput() - all callers would need identical handling.
It seemed most consistent to always dput() the passed-in dentry if it
wasn't returned.
>=20
> >
> > So this patch changes vfs_mkdir() to unlock on error as well as
> > releasing the dentry.  This requires various other functions in various
> > callers to also unlock on error - particularly in nfsd and overlayfs.
> >
> > At present this results in some clumsy code.  Once the transition to
> > dentry locking is complete the clumsiness will be gone.
> >
> > Callers of vfs_mkdir() in ecrypytfs, nfsd, xfs, cachefiles, and
> > overlayfs are changed to make the new behaviour.
>=20
> I will let Al do the vfs review of this and will speak up on behalf of
> the vfs users of the API
>=20
> One problem with a change like this - subtle change to semantics
> with no function prototype change is that it is a "backporting land mine"
> both AUTOSEL and human can easily not be aware of the subtle
> semantic change in a future time when a fix is being backported
> across this semantic change.
>=20
> Now there was a prototype change in c54b386969a5 ("VFS: Change
> vfs_mkdir() to return the dentry.") in v6.15 not long ago, so (big) if this
> semantic change (or the one that follows it) both get into the 2025 LTS
> kernel, we are in less of a problem, but if they don't, it's kind of a big
> problem for the stability of those subsystems in LTS kernels IMO -
> not being able to use "cleanly applies and build" as an indication to
> "likelihood of a correct backport".

Renaming to vfs_mkdir2() might be justified.  I think we have to change
the interface somehow to enable per-dentry locking, and I don't think a
signature change would be justified.  So maybe a name change is needed.

>=20
> and now onto review of ovl code...
>=20
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 70b8687dc45e..24f7e28b9a4f 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -162,14 +162,18 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
> >         goto out;
> >  }
> >
> > +/* dir will be unlocked on return */
> >  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
> > -                              struct dentry *newdentry, struct ovl_cattr=
 *attr)
> > +                              struct dentry *newdentry_arg, struct ovl_c=
attr *attr)
> >  {
> >         struct inode *dir =3D parent->d_inode;
> > +       struct dentry *newdentry __free(dentry_lookup) =3D newdentry_arg;
> >         int err;
> >
> > -       if (IS_ERR(newdentry))
> > +       if (IS_ERR(newdentry)) {
> > +               inode_unlock(dir);
> >                 return newdentry;
> > +       }
> >
> >         err =3D -ESTALE;
> >         if (newdentry->d_inode)
> > @@ -213,12 +217,9 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, s=
truct dentry *parent,
> >                 err =3D -EIO;
> >         }
> >  out:
> > -       if (err) {
> > -               if (!IS_ERR(newdentry))
> > -                       dput(newdentry);
> > +       if (err)
> >                 return ERR_PTR(err);
> > -       }
> > -       return newdentry;
> > +       return dget(newdentry);
> >  }
> >
> >  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
> > @@ -228,7 +229,6 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
> >         inode_lock(workdir->d_inode);
> >         ret =3D ovl_create_real(ofs, workdir,
> >                               ovl_lookup_temp(ofs, workdir), attr);
> > -       inode_unlock(workdir->d_inode);
>=20
> Things like that putting local code out of balance make my life as
> maintainer very hard.

I understand.  By the end of the change this is no longer unbalanced.
Keeping the code perfect at each step while making each step coherent
enough to be reviewed is a challenge.


>=20
> I prefer that you leave the explicit dir unlock in the callers until the ti=
me
> that you change the create() API not require holding the dir lock.
>=20
> I don't even understand how you changed the call semantics to an ovl
> function that creates a directory or non-directory when your patch only
> changes mkdir semantics, but I don't want to know, because even if this
> works and I cannot easily understand how, then I do not want the confusing
> semantics in ovl code.
>=20
> I think you should be able to scope ovl_lookup_temp() with
> dentry_lookup*() { } done_dentry_lookup() and use whichever semantics
> you like about dir lock inside the helpers, as long as ovl code looks and f=
eels
> balanced.
>=20
> >         return ret;
> >  }
> >
> > @@ -336,7 +336,6 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
> >                                     ovl_lookup_upper(ofs, dentry->d_name.=
name,
> >                                                      upperdir, dentry->d_=
name.len),
> >                                     attr);
> > -       inode_unlock(udir);
> >         if (IS_ERR(newdentry))
> >                 return PTR_ERR(newdentry);
> >
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 4f84abaa0d68..238c26142318 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -250,6 +250,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_=
fs *ofs,
> >
> >         ret =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> >         pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZE=
RO(ret));
> > +       /* Note: dir will have been unlocked on failure */
> >         return ret;
> >  }
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index df85a76597e9..5a4b0a05139c 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -328,11 +328,13 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
> >                 }
> >
> >                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> > -               inode_unlock(dir);
> >                 err =3D PTR_ERR(work);
> >                 if (IS_ERR(work))
> >                         goto out_err;
> >
> > +               dget(work); /* Need to return this */
> > +
> > +               done_dentry_lookup(work);
>=20
> Another weird example.
> I would expect that dentry_lookup*()/done_dentry_lookup()
> would be introduced to users in the same commit, so the code
> always remains balanced.
>=20
> All in all, I think you should drop this patch from the series altogether
> and drop dir unlock from callers only later after they have been
> converted to use the new API.
>=20
> Am I misunderstanding something that prevents you from doing that?

I think I tried delaying the vfs_mkdir() change and stumbled.
The problem involved done_path_create(). e.g. dev_mkdir() calls=20
  kern_path_create()
  vfs_mkdir()
  done_path_create()

Changing semantics of vfs_mkdir() necessitated a corresponding change in
done_path_create() and doing that necessitated prep elsewhere.
init_mkdir and ksmbd_vfs_mkdir follow the same pattern.

Maybe I could temporarily introduce a done_path_create_mkdir() for
those.

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20


