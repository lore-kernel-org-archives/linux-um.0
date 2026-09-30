Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376B5CA5FC5
	for <linux-um@archiver.kernel.org>; Wed, 30 Sep 2026 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4QchkhwI1w5bSASLXqcxUjuWuiosjQacZxJlQZryO/o=; b=StQXy22bDzrxMBR0IrDRkB7+QM
	g5+sZu1KIMCWRa15LhBhum7K+89BOm/O4mET1WyNpP6EBZGTWcirG/EeqLiZsgw2Zt2e+mpcz7LOw
	SuFWRrybI/cNa1yjvHaaDdbzLGTzITU8fqs1MZfJshARFUV1Mt8PVH9HH+j0ne+yFZUNBCN7YemEj
	i9CKj6DC+I/yxMtHfO48psNb/3pCPgqxy8eIBaoHMpftArP46j5aJB9WxMOIxjT7q+5bM8iwVLy/N
	fqKmu6Gv2PGoXz5pAgXdTzqP6nWOmsnoJJdOObDmC1zSkvfAy+rPbcMw0zSeGRHDTCvdRq/8PHxZ4
	9H/MtvyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBuTc-000000069DG-2VU0;
	Wed, 30 Sep 2026 13:36:04 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBuTY-000000069Cf-1KZw
	for linux-um@lists.infradead.org;
	Wed, 30 Sep 2026 13:36:02 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-6ac64e54f2fso2669646a12.0
        for <linux-um@lists.infradead.org>; Wed, 30 Sep 2026 06:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790775357; cv=none;
        d=google.com; s=arc-20260327;
        b=FLTKqvMHgOFJpHL+MJdccNNrVdKZKvZaUqw7tymBl34gdRVjY92qgiMyijyf6dPNDq
         pih5CGB0Eyks69LSVXQh7M3qyNqGqTurzPP4rLTTaixxhTaYo8pfslXqhvcKn5oPHXGI
         e8TLEOGTrWc+vJSLzKeKGhKEGg4KE4ex+hGUv2NgOrgLHCLxCJ0IpjnZ3HA6BIh9ezld
         04Gh7wUcNhLlwNgNtB77rL6X/rMFSzxljVJKSq6jA+op49bx3GxVX06s7ixwXU9hLaeo
         i7eBBNxk1XE/v0Cic9e8IG6G/2GFhtIxhmESOF0U762/HQUaLHJpaAeNJX4R7GfRzdVl
         AfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4QchkhwI1w5bSASLXqcxUjuWuiosjQacZxJlQZryO/o=;
        fh=kt4jP8nJmCXAwp/B//FvZ86a+mcEsHCYGz/SBj1vkmo=;
        b=ijDW3S9FvKPQKrs4b2uefP5p2hzLQjRPLcBdZOtMh2uM1A9GX3BNiF6D48GKZAXB2i
         9UvfP/JLF4VqG87I46KPv0wqs1hr+/jo3JIZ37KhbflHOXAq68k++mB0RsRb/k0QbicU
         1HGbvIMAe8kyGXkxM/pTPS8PzsMRut62eUH2fz3qUMQQLY9WDfNMAtzYAqGb7pymtw+h
         Hy3iAyE7ZXGXAnrK8Z9KGuPsfImH4C5QZtcfUmQW1CV9c/N9YPE7OOE1dnlqdfqZBRAG
         3BzCC/Q2yUnXhnEcU2mUkJXNcuSCwl5/CQr7Hl3tqNPCtXWSAp9hPSVMSyAUg3vldfWL
         ri7Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790775357; x=1791380157; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4QchkhwI1w5bSASLXqcxUjuWuiosjQacZxJlQZryO/o=;
        b=UMPmeNFIusBkc2zh34+0ogADGT5EBratIp7WfZAlDUd7m1gbCgYajwagVUdyEBdioR
         GpaJxDaHCVom/stKnqe4P3B4PhTQFRj+YoA+66fe1SHNu3fpgwNYXiTEc4cq0N0AZ/Zw
         jFmz/+ZjcLNg6bSezYFgenSFjsolWJX5JCv1OfLr6u8Db0jXmu6Dlr2Q/4QGOAUFgDUP
         R8cz62UZcJVO77X6PSjJ24bleU1mAXqgUWi9GgM/AHWr6B/QuvhFNBccD+z2xeyJC8NQ
         VbQrKBfnFxy+1zgPxYDs5+CVFwx6jaIs3v2m/mHxQFSoyBY/BxKYWxtZXtiN5HvQM07g
         PI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790775357; x=1791380157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4QchkhwI1w5bSASLXqcxUjuWuiosjQacZxJlQZryO/o=;
        b=d4smdFWSA37eq80kZSq7eoJtraYrpkP8XvfpXT4leqE3scia0iuH5V4G/OWxwARg0B
         LJaM3majHtUf/ZvSZXfTxydtThXcvHf9R0PbgrWkpK1IJoADSLleN8l04JpwTWmhYERu
         +lBHErhcKkTroNMkFIHrxHuj3XiGXQOMIea6hKb/XNzuyPiyWrHDnLjuvAgsZaLH3h/V
         MRu/I4om7erI+7J9Q15N60g0s4hkwFThcu4wPssiTP9R94Qd/LnQUQQxfaulnklDq0sd
         5SK5WyYMWt9mul2G9vL8Suop5WEDlfTfvrVlYwFlUkqqOZSIvxIsY3BVCDIrmPAlrmrf
         DyYg==
X-Forwarded-Encrypted: i=1; AKwUvBz8tMHDFNpPCh7XN9Lc1flwZ1AAa8HM3VKsqB0fxPLnKgNTWIlivIBj7+i1570eqsTuvbGs0XfltA==@lists.infradead.org
X-Gm-Message-State: AFuF++mk9Nmay4TUPuhCqkIkE10QoV/Vo92FJlAju0bOz4rR/g3on1jn
	VMN/m3JBqfquE5i6sFNOSUTjxIVNY9jasgRa39zgkoc4l2pqk0aOmt8INXNBglMVu7ILA6fvrsM
	S/5/XDpEwDFQKdY75Q8kOIiverIBu8jU=
X-Gm-Gg: AYBFou3o0/kjBNuNrfWPOe4woMC3Ib30o83tXNtb3caK3qFS9RzMb/vO0eMMQXjDEnD
	3QG8WhK02Kw/VGG+4qwE85xMKu1DokbRiAeV0twhv8HKf3lYmPZfW8zGTvpaIqbtlbqAyKeQt4e
	JWoV8jPHZpKIHSNEwnZSHUYzh5DbrPTLFurX8OjfQtOgDjcYpWUxcA2PzPmqnhoYtopPM6x+u3i
	uMdA1rj8KO6OToZD8W0GGTCL/Ng+DzlyuS8KPSDohehghYJm/gU94bOTxJCi8PZPosUO/nilYok
	LDNAtH7eE644gpCTcqGpJCQxtvXtZpwt1Yh5vL4NCjlt2XnppJLAUPTEJfRvNJjV0HDW
X-Received: by 2002:a17:906:6a05:b0:c2d:b9b4:f4de with SMTP id
 a640c23a62f3a-c2e23d9207amr125564266b.18.1790775356627; Wed, 30 Sep 2026
 06:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260929034158.1455429-1-neilb@ownmail.net> <20260929034158.1455429-8-neilb@ownmail.net>
In-Reply-To: <20260929034158.1455429-8-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 30 Sep 2026 15:35:45 +0200
X-Gm-Features: AclHuK-7IYZDCVZREHuHZMSP_wgME-NMrM9tsJnpybGevda7U-xOXfVzEqygZdo
Message-ID: <CAOQ4uxjv3Ziqy+CjbCO7noAPse+a0066UO7pkFhStnnW9FFSPg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260930_063600_757826_28B92615 
X-CRM114-Status: GOOD (  38.41  )
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

On Tue, Sep 29, 2026 at 5:43=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> lookup_one() is expected to be removed as it does not fit well with
> proposed changes to directory locking.
> Specifically d_alloc_parallel() will be ordered outside of i_rwsem
> and as iterate_shared() is called with i_rwsem held it is not safe
> to call d_alloc_parallel().
>
> We can instead call d_alloc_trylock() and then call the ->lookup, but
> that can fail if there is a lookup attempt concurrent with the
> readdir().
>
> ovl cannot afford for the lookup to fail as that could produce incorrect
> results, and it cannot safely drop i_rwsem temporarily as that could
> introduce races with handling of the directory cache.
>
> Instead we rely on the fact that ovl_iterate() has an exclusive lock on
> the directory, so any concurrent lookup will wait for the ovl_iterate()
> call to complete.  We allocate a separate dentry and if the lookup is
> successful, it is hashed with the result.

Please document this assumption with:

rwsem_assert_held_write(&dir->d_inode->i_rwsem);

and comment in the code. Having it in the git commit message is not
enough for future code reviewers.

Other than that, I have no further comments, but I would like
to have a review from Miklos before this patch lands, because
I don't remember him reviewing any of the revisions and this is subtle.
I am a bit concerned that we have no test coverage for this subtle code.

>
> When the concurrent lookup gets i_rwsem it mustn't do its own lookup -
> it must use the existing dentry.  This is found, if it exists, using
> try_lookup_noperm().
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/namei.c   | 12 ++++++++++++
>  fs/overlayfs/readdir.c | 26 ++++++++++++++++++++++++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index ca899fdfaafd..f56e33fd4d6b 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1385,6 +1385,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct=
 dentry *dentry,
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct ovl_entry *poe =3D OVL_E(dentry->d_parent);
>         bool check_redirect =3D (ovl_redirect_follow(ofs) || ofs->numdata=
layer);
> +       struct dentry *alias;
>         int err;
>         struct ovl_lookup_ctx ctx =3D {
>                 .dentry =3D dentry,
> @@ -1399,6 +1400,17 @@ struct dentry *ovl_lookup(struct inode *dir, struc=
t dentry *dentry,
>         if (dentry->d_name.len > ofs->namelen)
>                 return ERR_PTR(-ENAMETOOLONG);
>
> +       /*
> +        * The existence of this in-lookup dentry might have forced
> +        * readdir to do the lookup with a new dentry.  If so we must
> +        * return that one.
> +        */
> +       alias =3D try_lookup_noperm(&QSTR_LEN(dentry->d_name.name,
> +                                           dentry->d_name.len),
> +                                 dentry->d_parent);
> +       if (alias && !IS_ERR(alias))
> +               return alias;
> +
>         with_ovl_creds(dentry->d_sb)
>                 err =3D ovl_lookup_layers(&ctx, &d);
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index e7fe29cb6028..bc41da4bace8 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -574,8 +574,30 @@ static int ovl_cache_update(const struct path *path,=
 struct ovl_cache_entry *p,
>                 }
>         }
>         /* This checks also for xwhiteouts */
> -       this =3D lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->l=
en), dir);
> -       if (IS_ERR_OR_NULL(this) || !this->d_inode) {
> +       this =3D d_alloc_trylock(dir, &QSTR_LEN(p->name, p->len));
> +       if (this =3D=3D ERR_PTR(-EWOULDBLOCK)) {
> +               /*
> +                * Some other thread is looking up this name and will
> +                * block on i_rwsem before it can complete the lookup.
> +                * We will do the lookup in a new dentry and when that
> +                * lookup gets a turn it will find and return this
> +                * dentry.
> +                */
> +               this =3D d_alloc_name(dir, p->name);
> +               if (!this)
> +                       this =3D ERR_PTR(-ENOMEM);
> +       }
> +       if (!IS_ERR(this) && d_unhashed(this)) {
> +               /* Either we got an in-lookup or we made our own unhashed=
 */
> +               struct dentry *alias =3D ovl_lookup(dir->d_inode, this, 0=
);
> +
> +               d_lookup_done(this);
> +               if (alias) {
> +                       dput(this);
> +                       this =3D alias;
> +               }
> +       }
> +       if (IS_ERR(this) || !this->d_inode) {
>                 /* Mark a stale entry */
>                 p->is_whiteout =3D true;
>                 if (IS_ERR(this)) {

How do you test your patch set? Do you have tests that exercise
parallel create/lookup/readdir?

It would be irresponsible to merge code without showing that the `alias`
branches have been exercised. Do you have an idea how to do that?

Thanks,
Amir.

