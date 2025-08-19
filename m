Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA895CA0EED
	for <linux-um@archiver.kernel.org>; Tue, 19 Aug 2025 09:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eFsGbO5uv2uZgsEZblgTie/lOV7b8K80hkUH8T7DIVU=; b=oMKjVU5br0QEmCj4cSBFAD0bBG
	GvWZxUR0XFX+NM4P1fb1mt41WSjwNgPUoJCZ5Yn8G4WwFr1/TfZaNTwi3UtrptH2R3OT3+oHeDPGa
	lrFLrqMsuYbb5GIqe4cXOWaSx5/+gDm2l8BDexVwdXi+gHA5k2tSWkRUvTwS9XBwuOZh71DhT6POs
	7yepTlX2w+dWVAyat7b465vTqsEPlluPmC/viO8UlLDpUsSNBpYO4+97vEwr+nfY/Xm01G3S1yeTP
	8DFG/kBUhOPKJU0JH7SByZJIL5HNjOpEu7ENE0+3XQd9etMzc3puPtr8oajuO/oP/LcjbdFvZY7tS
	WUscVIRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIPU-00000009ubk-0nU7;
	Tue, 19 Aug 2025 09:13:40 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoHqi-00000009pIL-3axT;
	Tue, 19 Aug 2025 08:37:46 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so6750679a12.0;
        Tue, 19 Aug 2025 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755592663; x=1756197463; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFsGbO5uv2uZgsEZblgTie/lOV7b8K80hkUH8T7DIVU=;
        b=QB3mR1P8fjmdYkrB73b938zEiKmwN0+91jxzVkPXOG7cerroXjK60tFiJGxzHkb/2k
         1q6s2BYnPCJaXom2TjfLCXd2lZccpdnY29UiRXfLvJWprtl7r9pgPxK68Q0MABN9tC4j
         XELN5wKhuNX/zoQl2BV7eD+tlGI1o2wlsSnNcriWKpWbkmTDgAKz/pIcz6pwLD97cYfP
         ZYxpxqwGed4Ei4GGxR+0YkZyiKntrIJRrBj37vHCzl5jIc6I87BnpO0UDnkQ2/FpOfDQ
         liXch79wvHu74+ufVHf389j+1PVIk2tkfYOfRD9MuEXH+ZU+UvKDoxBUPd6Y/o1f52Qy
         wOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592663; x=1756197463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFsGbO5uv2uZgsEZblgTie/lOV7b8K80hkUH8T7DIVU=;
        b=ctweBQA4SLIq7+R+Hybc6/Yl2iNtYtjrKGo88YR3rQe+2eOCAGWMH+DQ0TCPYx4zaw
         qOz5zTUpAid06nsLBmgtYulAQFuac89seV+SqiS/+JBjrddK5zOxlCOePbuP8OmWAMW9
         Ar5fJ+SxHWdlArgLmT9pwQK7VksGPINhbATDHTyXwWQHO3xvzBb942UCLYJ6f/2jrxzm
         Kf8q0kxRP1z8vl+e4dt8W16WPlLc10aGU37bsUjb1DdDm43z/chdmJvDfIu35vbb9jJm
         Z5Bg2wZDiciM5AG+pKgeLTCZ0tmyeDLjFf1g4PxxLfAKUdNgUy5pCQSxEh2UnvlBZ5t5
         wOiA==
X-Forwarded-Encrypted: i=1; AJvYcCU12LbGExzYSsy3/G7LeWckUMXHkVjx2GBBtU3P7hvhYoP2K2CZpgI554A2ADg4FhrrO2lyaBa+qkQ=@lists.infradead.org, AJvYcCWE7CfkoWPfmggKyk5qaPbhNkXluNHFxxjkHjHdkfmgQsUZMj8W7h5HlX7EyBMfAa8Jro9MpG8orV4=@lists.infradead.org
X-Gm-Message-State: AOJu0YyXJlnjp4zlZIBSly+HTZX+yhZt+qqZxRiAO3YJGXlxSB/+1Gqc
	UPz86IUoYCu26oReb/tJbTpMe0MG0zsV8VW4HP6p3cyDBhla3fKHqAxEGaPBVrdmd1mNknvXx7D
	eiA+9RPveRgtFUOOChxzr/pLEFlRPYUI=
X-Gm-Gg: ASbGnctor6CrFMQgvsJafdR1vV6V0TrUBaiqS8ggVhkKWxuo0qm7Li/ChAYpmOazxy3
	kMdFthJnTDpg1MS57VOLmBsTSrBfev0op4Ger07gIDZ+LY2OkhORec07aLB99V1MWcySHkeXjQi
	PNGsq1+jmp80dkWAZ35gxCStNS2L3QaKbsMlWGndruWFjGsTu3FM+Ea8OrS0stNaopNpaDxz7c6
	yb1r1o=
X-Google-Smtp-Source: AGHT+IFPkGLsERbAFWtJMeBST+thbMymAyNwr9qtEZC9tmGauxnR7YuwZ/KcrAjTg48I0n7BxxoUhzcNK86fTEQQ3U8=
X-Received: by 2002:a05:6402:2110:b0:61a:8956:80da with SMTP id
 4fb4d7f45d1cf-61a89568752mr355544a12.17.1755592662958; Tue, 19 Aug 2025
 01:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjFPOZe004Cv+tT=NyQg2JOY6MOYQniSjaefVcg+3s-Kg@mail.gmail.com>
 <175555395905.2234665.9441673384189011517@noble.neil.brown.name>
In-Reply-To: <175555395905.2234665.9441673384189011517@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Aug 2025 10:37:30 +0200
X-Gm-Features: Ac12FXy8T19V7sCZ2PjPpODnDn2SH0EuiMx3-E257rrZ7RxWX_LLM7LKSQroU_c
Message-ID: <CAOQ4uxjh1RmAEWV22V_tdazOGxekmKUy6bdu13OhtoXboT3neg@mail.gmail.com>
Subject: Re: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-afs@lists.infradead.org, netfs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_013744_913399_CC5B4C53 
X-CRM114-Status: GOOD (  45.04  )
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

On Mon, Aug 18, 2025 at 11:53=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
> On Mon, 18 Aug 2025, Amir Goldstein wrote:
> > On Wed, Aug 13, 2025 at 1:53=E2=80=AFAM NeilBrown <neil@brown.name> wro=
te:
> > >
> > > A few callers operate on a dentry which they already have - unlike th=
e
> > > normal case where a lookup proceeds an operation.
> > >
> > > For these callers dentry_lookup_continue() is provided where other
> > > callers would use dentry_lookup().  The call will fail if, after the
> > > lock was gained, the child is no longer a child of the given parent.
> > >
> > > There are a couple of callers that want to lock a dentry in whatever
> > > its current parent is.  For these a NULL parent can be passed, in whi=
ch
> > > case ->d_parent is used.  In this case the call cannot fail.
> > >
> > > The idea behind the name is that the actual lookup occurred some time
> > > ago, and now we are continuing with an operation on the dentry.
> > >
> > > When the operation completes done_dentry_lookup() must be called.  An
> > > extra reference is taken when the dentry_lookup_continue() call succe=
eds
> > > and will be dropped by done_dentry_lookup().
> > >
> > > This will be used in smb/server, ecryptfs, and overlayfs, each of whi=
ch
> > > have their own lock_parent() or parent_lock() or similar; and a few
> > > other places which lock the parent but don't check if the parent is
> > > still correct (often because rename isn't supported so parent cannot =
be
> > > incorrect).
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/namei.c            | 39 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/namei.h |  2 ++
> > >  2 files changed, 41 insertions(+)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 7af9b464886a..df21b6fa5a0e 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -1874,6 +1874,45 @@ struct dentry *dentry_lookup_killable(struct m=
nt_idmap *idmap,
> > >  }
> > >  EXPORT_SYMBOL(dentry_lookup_killable);
> > >
> > > +/**
> > > + * dentry_lookup_continue: lock a dentry if it is still in the given=
 parent, prior to dir ops
> > > + * @child: the dentry to lock
> > > + * @parent: the dentry of the assumed parent
> > > + *
> > > + * The child is locked - currently by taking i_rwsem on the parent -=
 to
> > > + * prepare for create/remove operations.  If the given parent is not
> > > + * %NULL and is no longer the parent of the dentry after the lock is
> > > + * gained, the lock is released and the call fails (returns
> > > + * ERR_PTR(-EINVAL).
> > > + *
> > > + * On success a reference to the child is taken and returned.  The l=
ock
> > > + * and reference must both be dropped by done_dentry_lookup() after =
the
> > > + * operation completes.
> > > + */
> > > +struct dentry *dentry_lookup_continue(struct dentry *child,
> > > +                                     struct dentry *parent)
> > > +{
> > > +       struct dentry *p =3D parent;
> > > +
> > > +again:
> > > +       if (!parent)
> > > +               p =3D dget_parent(child);
> > > +       inode_lock_nested(d_inode(p), I_MUTEX_PARENT);
> > > +       if (child->d_parent !=3D p) {
> >
> > || d_unhashed(child))
> >
> > ;)
>
> As you say!
>
> >
> > and what about silly renames? are those also d_unhashed()?
>
> With NFS it is not unhashed (i.e.  it is still hashed, but with a
> different name).  I haven't checked AFS.
>
> But does it matter?  As long as it has the right parent and is not
> unhashed, it is a suitable dentry to pass to vfs_unlink() etc.
>
> If this race happened with NFS then ovl could try to remove the .nfsXXX
> file and would get ETXBUSY due to DCACH_NFSFS_RENAMED.  I don't think
> this is a problem.
>

Not a problem IMO.

FYI, ovl does not accept NFS as a valid upper fs
on account of ->d_revalidate() and no RENAME_WHITEOUT support.

        if (ovl_dentry_remote(ofs->workdir) &&
            (!d_type || !rename_whiteout || ofs->noxattr)) {
                pr_err("upper fs missing required features.\n");
                err =3D -EINVAL;
                goto out;
        }

> If we really wanted to be sure the name hadn't changed we could do a
> lookup and check that the same dentry is returned.
>
> OVL is by nature exposed to possible races if something else tried to
> modify the upper directory tree.  I don't think it needs to provide
> perfect semantics in that case, it only needs to fail-safe.  I think
> this recent change is enough to be safe in the face of concurrent
> unlinks.

<nod>

Thanks,
Amir.

