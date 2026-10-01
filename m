Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE292CA5FC5
	for <linux-um@archiver.kernel.org>; Thu,  1 Oct 2026 07:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WTf1zoaT0Wsrc4m5L9oFar53LMEzHBHomKhDhLKQLu0=; b=XPUnGyCR8PmDUpH4wZJyyMJlAo
	y0g9Zv9wYVflPFHILk8eJ8mr1AKT/ouDpYrEQeZhgK/Sv3us4c+KSd+plWeq9XQ3knVfyU25EPw0f
	KXfgl6cEXkpG2E1V0vTFnbQzYSU65WcfQEInPG4qzAiuLkzCK3yq20XbCs7dq4gkf6xdO8/9+j0E5
	d/v2Uc+nsQWDvF7k8XND79wQlgQFsJ8WOb5b7JAHTsl0wi5QklCoCLI3A63CM4pWtnq5Ts5e6ykfx
	wEyASo+UgMP8j8g2XDz7wnbVa7ALtosXVpLYN6bH/FVbi2liEuSqTBsxOyDVK9Jl0JbamqCsplXjF
	oc14xPvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCBIm-000000080gY-47rj;
	Thu, 01 Oct 2026 07:34:00 +0000
Received: from mail-ed2-x2b.google.com ([2a00:1450:4864:33::2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCBIk-000000080fV-3lBj
	for linux-um@lists.infradead.org;
	Thu, 01 Oct 2026 07:34:00 +0000
Received: by mail-ed2-x2b.google.com with SMTP id 4fb4d7f45d1cf-6af82ce3c83so97833a12.1
        for <linux-um@lists.infradead.org>; Thu, 01 Oct 2026 00:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790840037; cv=none;
        d=google.com; s=arc-20260327;
        b=oWKYZTLTC1rC7Pyv73Gtw3+G4nHKtKM16I9kli5QqlGej/QKOd7vKu23+F11+5tYRs
         sqjoM1zZR1KmCFSVpmdxqpX2br+cMMA9EUG1XTlMpEO7DBK1l4szr4pryk9Zj/Cp9o56
         INJwD7WtH15qHhK16S8Ura9mZrYP9OMauOgXkt68ztzskX9NqnXcQhZ1eidxDaEwfGEE
         vXqiaJSp6XFcPQOKq18mqrXl8syyzUHUsELY4lBn90DVi/gEEuMCvaRBcQrgW0xulz6r
         SI8WrQdaHaxxKkH7d9gqFXJLvoJfrC+pAoRk4ie0ZvewvgjThZf892TyMzRGmoFTG+qa
         Uy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WTf1zoaT0Wsrc4m5L9oFar53LMEzHBHomKhDhLKQLu0=;
        fh=NkxKtp33kqBBmU0JYYwdu9VrZJqe5yK0rKwEWi4ViFk=;
        b=nov8lJ5vvBQ90+uApJG+u3Rse1fWuTVeJPXaHWovbRWcMp+/VPBd8YeCgxLsu2B3Hc
         5af+33IItbQjU4mv/ujrrkaVpQRR22AmoUhWuPJuKSSSBz7YciQmburg/QNpgdo9Amal
         8VyoY1i06vQ3vmNOi82Iy58I46W1ycP86GMo6pbgPK0/8gQiLg5cwtWCt0knlI+GtJx2
         Qb71yf5k3eCuX5YWTGkfrSIeQZASWJf7YDPCHDmaMI611Jjiqia9p2zcZLvfsx98LeY/
         EOwtWj+7o+GR9mQVzqpJ6lgDPgPY1YDRu6DlHN/RreS6FHRj8XHXw3Yz2bEmRxZP9D/7
         UGbA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790840037; x=1791444837; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WTf1zoaT0Wsrc4m5L9oFar53LMEzHBHomKhDhLKQLu0=;
        b=Ckk1W1i6rAHnby8Qp/Tc8MbhjmEQ3aIFymjKcFZASKogCJ55vLiAcKY/d0PkyR1o1x
         /yLxPnvhctmdMXzpcnOY53+LjiIl3OPq8cbDUYPqz0c2wh2M9XpEKbekAAlFdZliE79t
         Pp1wYC2DloYlix6d4X70Q2gtM3HrysIFVFA/CFpz2ok8ubyxBjGkzLOoFz4ndECtsGhF
         wMzheYA+Zqx3sDJI02ebk4nXWrQXHncACaSj8UBDbtJDdhs6oD+v09DNFRK24oZuiFyD
         bLojP9sTEJHqpAJNeHDM++DKoxUjaIfrOGovBl7UhNgUw9rSluPEe9zG+EPZzzgpI44K
         M8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790840037; x=1791444837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTf1zoaT0Wsrc4m5L9oFar53LMEzHBHomKhDhLKQLu0=;
        b=xr/1Evtb/Am4X3tEz+KRYYCW07SsUsWW672LaIB5F96pWySSrHm2qL673q0QbW27Uk
         20luHbP6yyJ2A4RRDPPdwo3t/ybF7YKGsBbI8AuiSPnhJDRFogyugK6WuD2fW8OFN5Hi
         ZZXydyTAWY24F3llAi777w6WPv5WZCkRkfW86F+kzpWFIK5FK3Yk/F3PlJEGSHxzPab6
         VqguMDYxx4fPddKO6N/0KqFuhNhCjiBAUeHR3BvrXhC/qqz0FAo9cIFbGGK0GNCdKrTk
         8lqLE170C6WiV/Z50P++heV0kcmIhrbFx+dSnr1fClupxkbH5plpKZO2xkxY2bG3FLmQ
         q6EA==
X-Forwarded-Encrypted: i=1; AKwUvBy1duVwfpWUEsO49IzAlDdKG2reu+Otl64uGG9KuW+oYbs12wbfKz5+PgDR0LnHigP4z3y131bxcg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ854S/NcYlDg8sAZ/x32PxXY7rL8QQJDoitUgxswILbwaKJXbi
	+jINQECqSFOjtwMMMq/42lBW2XMABQqRFPYkUPrykEBjmiSITnTg3yDbh2AZG1r00v5KeQxG690
	c2AJT2vJSQUMrci2fRI1vCmCpePqY7nw=
X-Gm-Gg: AYBFou39GSimr0FQh81NoTvSsf3gml17Yc0PmWgO7S+TUxskjOGXObVy2FnMWrYw5jU
	qgD0VxLe++0Y75UYKW4cDs2YHY207gGagLsreRwIAxLze7d6r7C9JykuRiUumi5tLq/BLT/BYvP
	fRzpw40nWev2Vgd84PMwgKdV4/kCORtdjipeNilzWdQczziFTdV47GPwLQenxQ7yfdL1ZzWyB/R
	7JPI/miUKobOFn/JZ9+YlVuU73bpNbQbq52AZEemj7MtPBLG2YIVkFa/IcjwO6K9+YrjfQz0Hp0
	QEw+Dh0jYy79LxnzQPPtBoeLlRojEQtpc3eVlFDazD88Pyxxta+sioS5
X-Received: by 2002:a05:6402:3227:b0:6ac:9a44:d3ed with SMTP id
 4fb4d7f45d1cf-6ae1986075bmr3067340a12.5.1790840036710; Thu, 01 Oct 2026
 00:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260929034158.1455429-1-neilb@ownmail.net> <20260929034158.1455429-8-neilb@ownmail.net>
 <CAOQ4uxjv3Ziqy+CjbCO7noAPse+a0066UO7pkFhStnnW9FFSPg@mail.gmail.com> <179080463287.37859.4262341831478331513@noble.neil.brown.name>
In-Reply-To: <179080463287.37859.4262341831478331513@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Oct 2026 09:33:44 +0200
X-Gm-Features: AclHuK9MIhHprf4aDgaMwd_4tZZMvI-V-gvxwkigtEk9UN12WMcOwDyiP913px0
Message-ID: <CAOQ4uxgEG6Wt1z7JO+v2sjs=Aoav0u7eLz+Ge3UqhVG4msBkwA@mail.gmail.com>
Subject: Re: [PATCH 7/7] ovl: stop using lookup_one() in ovl_iterate().
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Breno Leitao <leitao@debian.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Hyunchul Lee <hyc.lee@gmail.com>, Carlos Maiolino <cem@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-um@lists.infradead.org, 
	codalist@coda.cs.cmu.edu, coda@cs.cmu.edu, linux-mm@kvack.org, 
	ntfs@lists.linux.dev, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_003359_014506_B2FB9AFA 
X-CRM114-Status: GOOD (  56.10  )
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

On Wed, Sep 30, 2026 at 11:44=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> On Wed, 30 Sep 2026, Amir Goldstein wrote:
> > On Tue, Sep 29, 2026 at 5:43=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > lookup_one() is expected to be removed as it does not fit well with
> > > proposed changes to directory locking.
> > > Specifically d_alloc_parallel() will be ordered outside of i_rwsem
> > > and as iterate_shared() is called with i_rwsem held it is not safe
> > > to call d_alloc_parallel().
> > >
> > > We can instead call d_alloc_trylock() and then call the ->lookup, but
> > > that can fail if there is a lookup attempt concurrent with the
> > > readdir().
> > >
> > > ovl cannot afford for the lookup to fail as that could produce incorr=
ect
> > > results, and it cannot safely drop i_rwsem temporarily as that could
> > > introduce races with handling of the directory cache.
> > >
> > > Instead we rely on the fact that ovl_iterate() has an exclusive lock =
on
> > > the directory, so any concurrent lookup will wait for the ovl_iterate=
()
> > > call to complete.  We allocate a separate dentry and if the lookup is
> > > successful, it is hashed with the result.
> >
> > Please document this assumption with:
> >
> > rwsem_assert_held_write(&dir->d_inode->i_rwsem);
> >
> > and comment in the code. Having it in the git commit message is not
> > enough for future code reviewers.
>
> Yes, I can do that.
>
> >
> > Other than that, I have no further comments, but I would like
> > to have a review from Miklos before this patch lands, because
> > I don't remember him reviewing any of the revisions and this is subtle.
> > I am a bit concerned that we have no test coverage for this subtle code=
.
> >
> > >
> > > When the concurrent lookup gets i_rwsem it mustn't do its own lookup =
-
> > > it must use the existing dentry.  This is found, if it exists, using
> > > try_lookup_noperm().
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/overlayfs/namei.c   | 12 ++++++++++++
> > >  fs/overlayfs/readdir.c | 26 ++++++++++++++++++++++++--
> > >  2 files changed, 36 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> > > index ca899fdfaafd..f56e33fd4d6b 100644
> > > --- a/fs/overlayfs/namei.c
> > > +++ b/fs/overlayfs/namei.c
> > > @@ -1385,6 +1385,7 @@ struct dentry *ovl_lookup(struct inode *dir, st=
ruct dentry *dentry,
> > >         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> > >         struct ovl_entry *poe =3D OVL_E(dentry->d_parent);
> > >         bool check_redirect =3D (ovl_redirect_follow(ofs) || ofs->num=
datalayer);
> > > +       struct dentry *alias;
> > >         int err;
> > >         struct ovl_lookup_ctx ctx =3D {
> > >                 .dentry =3D dentry,
> > > @@ -1399,6 +1400,17 @@ struct dentry *ovl_lookup(struct inode *dir, s=
truct dentry *dentry,
> > >         if (dentry->d_name.len > ofs->namelen)
> > >                 return ERR_PTR(-ENAMETOOLONG);
> > >
> > > +       /*
> > > +        * The existence of this in-lookup dentry might have forced
> > > +        * readdir to do the lookup with a new dentry.  If so we must
> > > +        * return that one.
> > > +        */
> > > +       alias =3D try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
> > > +                                           dentry->d_name.len),
> > > +                                 dentry->d_parent);
> > > +       if (alias && !IS_ERR(alias))
> > > +               return alias;
> > > +
> > >         with_ovl_creds(dentry->d_sb)
> > >                 err =3D ovl_lookup_layers(&ctx, &d);
> > >
> > > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > > index e7fe29cb6028..bc41da4bace8 100644
> > > --- a/fs/overlayfs/readdir.c
> > > +++ b/fs/overlayfs/readdir.c
> > > @@ -574,8 +574,30 @@ static int ovl_cache_update(const struct path *p=
ath, struct ovl_cache_entry *p,
> > >                 }
> > >         }
> > >         /* This checks also for xwhiteouts */
> > > -       this =3D lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, =
p->len), dir);
> > > -       if (IS_ERR_OR_NULL(this) || !this->d_inode) {
> > > +       this =3D d_alloc_trylock(dir, &QSTR_LEN(p->name, p->len));
> > > +       if (this =3D=3D ERR_PTR(-EWOULDBLOCK)) {
> > > +               /*
> > > +                * Some other thread is looking up this name and will
> > > +                * block on i_rwsem before it can complete the lookup=
.
> > > +                * We will do the lookup in a new dentry and when tha=
t
> > > +                * lookup gets a turn it will find and return this
> > > +                * dentry.
> > > +                */
> > > +               this =3D d_alloc_name(dir, p->name);
> > > +               if (!this)
> > > +                       this =3D ERR_PTR(-ENOMEM);
> > > +       }
> > > +       if (!IS_ERR(this) && d_unhashed(this)) {
> > > +               /* Either we got an in-lookup or we made our own unha=
shed */
> > > +               struct dentry *alias =3D ovl_lookup(dir->d_inode, thi=
s, 0);
> > > +
> > > +               d_lookup_done(this);
> > > +               if (alias) {
> > > +                       dput(this);
> > > +                       this =3D alias;
> > > +               }
> > > +       }
> > > +       if (IS_ERR(this) || !this->d_inode) {
> > >                 /* Mark a stale entry */
> > >                 p->is_whiteout =3D true;
> > >                 if (IS_ERR(this)) {
> >
> > How do you test your patch set? Do you have tests that exercise
> > parallel create/lookup/readdir?
> >
> > It would be irresponsible to merge code without showing that the `alias=
`
> > branches have been exercised. Do you have an idea how to do that?
>
> I think that to trigger the 'alias' code we would need to instrument the
> code to block and wait.
> e.g.  when readdir sees a particular name it could signal the test
> harness somehow and then wait.  The test harness would trigger a lookup
> of the name which would block on the parent i_rwsem.
> The readdir then continues somehow and gets -EWOULDBLOCK and installs
> the alias dentry.  When it completes the lookup continues and picks up
> the alias.
>
> Is there some way to set a tracepoint to block?
>
> Maybe it would be enough to have something like:
>    if (strcmp(name, "MAGIC_NAME") =3D=3D 0) {
>         printk("waiting for MAGIC_NAME\n");
>         ssleep(15);
>    }
>
> and have the test harness watch dmesg for MAGIC_NAME then trigger the
> lookup.   Then adds some tracing to ovl_lookup() to ensure it picks up
> the right thing...

For this patch I am not asking for instrumentation with CI regression tests=
.
A word from you that you tested all the unexercised alias branches manually
and how (e.g. include printk and sleep test report) is the minimum
that I require
to avoid merging subtle test-compiled-only code.

For your parallel dirops odyssey as a whole, I think that proper
fstests coverage is
a must before the last step of relaxing the dir lock and the sooner you sta=
rt
with this the better the test coverage for all the perp series along the wa=
y.

Thanks,
Amir.

