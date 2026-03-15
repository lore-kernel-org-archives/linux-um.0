Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AABF30262
	for <linux-um@archiver.kernel.org>; Sun, 15 Mar 2026 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LD1Y/Z+QIVaxjTqqF6DEde0TPCIZAs/xYcpmNl5+JUA=; b=xI5dHlA07b7ZSxgr9g1YmclGQ0
	EZ9PbM33J3LLOgqvaQ6B9Ipn/7W5x4EruyogsfGbP/cUZ6QJaALbeDv3KgDEuvHYhyoWjM4ZjqvwT
	BencUTCJVZfH3HUkDeiKTwjDiu8FEBkMVGZul6cyHzE0Z4Yvh6NbPPedx+Gjvf4QPB4XGUeyvzXYX
	Fs0VFz1Ib63ndkYqyXu4MKpqSirV0bsT1PZu+qT52fdGhVF8qoYlt8v3KH9KUcY7RDvF6Yie3bEm+
	sdsv8eUw+pCVYlqitsvPS2rfY3AFttmBx6zJS3nXuNlMyoU/8xBm629iHlStO3eAI+Qp7SlU70wFd
	w1XMriRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1lsf-00000002dhn-0GMI;
	Sun, 15 Mar 2026 13:51:45 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1lsc-00000002dh5-3efe
	for linux-um@lists.infradead.org;
	Sun, 15 Mar 2026 13:51:44 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b97bca3797dso6689466b.0
        for <linux-um@lists.infradead.org>; Sun, 15 Mar 2026 06:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773582700; cv=none;
        d=google.com; s=arc-20240605;
        b=LlMffqO3rzmpTjrac1+NgaLvzJzPBAxHEnTra67oq29IyCLVmo7iS0PbWF1NfKM9WH
         jLs749vFhxwV74FjFlGVqFbk5jLalo72RefIomG13B5ZGV1NgOmGQfZbixLDBKKBAnI6
         pzN30ENOEValYsI+c1gj8Xu9O6KHuAl6sDeRgSeNoaRh1fPelDFVzepn5EfoLUvj102K
         effb+6K5aiODF56dpLBP+4OrqJBWfT9phctqxoNs0UZzbFJ4c53KGiDRQ4dvoN/YdghC
         xHaixV9BvI92sinpVZo4vWX6NISKzl4HPbNijyFKgoaRcX5EHM8j7FsdUiA5qfQ6gIf9
         BAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LD1Y/Z+QIVaxjTqqF6DEde0TPCIZAs/xYcpmNl5+JUA=;
        fh=qtZZMiDVnyf0VybfL4t2DHjjeFMj5IrKUwOYHJJ42B4=;
        b=bvJIKeJZiS75n/u9yV3axDunHg5XxcZ0b6ortZWJj1vVD59cGI6c/4hFeoZLZRkyRp
         iIQKLcRKsfqJxWer7EUPaWszO9RF7AAYodDcG9bL8yNIq6b8iZlLA4U3X12jK2z76saO
         Vs993jWocuGa//HhPhRMQ2rXw5bz/DMt+n+wiF579hfh4/xjkp+pOb8t1kYmAdHVJ7a4
         VZi5LulfpxNZlEpZj6e8LArzAc1VvwznnqHkiQ69w5d+OfnesbjGfnHlNIzLJKG5ygeW
         vxtSkfvRU2B6dpzUaXLycGHk5QRZdZOS+k7l3CWi6SXmpRgOsjBV3WzhUVRLnQpfq2JK
         jMJA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773582700; x=1774187500; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD1Y/Z+QIVaxjTqqF6DEde0TPCIZAs/xYcpmNl5+JUA=;
        b=HGktRzT5LCIDtRrL2tX8N22ghu7nO6pFRyGvV8osjM21r9Jz8twBDRuoX9UAcfyJx+
         BXRmNneaijzDw0yNlNjYYo54YNjWzEvvYukiTM+b62pKquz6E37Vh51LKYHa2h8cZgoU
         vy2bSodMDPHxpYvmESYgT+63WLTCcrFAsHeRx/3cEBF3dr+5aoNfkLUB6en8D1X09JcH
         qf6woF5ntdD0bYVo3NSC18Y3d5YukE0b8TIal0BBPWM4X23PfG+y3MyRiHooUV2WnL8G
         QliIFRuvMd3jU1zxtBNdwmglpOj2nIk/8Nrd/iv7uTobIGvhrHoIm2g1zwvbUGnx78YZ
         eNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773582700; x=1774187500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LD1Y/Z+QIVaxjTqqF6DEde0TPCIZAs/xYcpmNl5+JUA=;
        b=Ao3+hqAZgtT+xR/Flj6KPTyNrE3QSJpWVTFiU4FUNZVoB+2Vj55cE+3UmB+kyvngWQ
         rRiDNneAM4u7p1toeKWxbe7Tt5Psa86QAjqsSSvpdMaOTv83j2TLAQwGu5X8DtGU8gkC
         r8WByF26V+VL5DgTDVqwH6H+ylg/ap8ptYAtOF2/huXMMDEmuswupy0p2NLWxARlznl6
         8W8ojEQTXmpsV1T0tAgGReUlXd1LJT8IN9us92ewZXBz5STYZHpzoBuqpON2lWRhNcdl
         ZaQZJlaYUZd7qTFKqFVY0Z6NjY9KVm2i3g5TS9YvhXCBWytfsToEBnhOSMf9XmI91p19
         i41Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfZURsNR3PTfglBQXkpZSAdQuVeDiReb9psYESBrzivc66EWN4WKAFFni9u2/uw5MvbQCRD3Lz2w==@lists.infradead.org
X-Gm-Message-State: AOJu0YzCvFQu9qI4gDKHYG0Caqz7DlLV2C1Dms3LG+eDo1I6qIrKrmc9
	8Dz77YgZ+iZi+OCrEFv8J9phaBeVkAS1Hritu3auGKtqhWPU7hCkuUk6HREJIbOMrF+/5M9R9Dj
	X423gfFFRZk4TvAUztle+DeXedZUkKvA=
X-Gm-Gg: ATEYQzwOLXEV/WSmGINbBGy4G/gPGEiqp1XKRvgXabi8wGk7NntqxnKfaMv8sTuhXy/
	Zyn+8qwzn4Uk2NSSbMcDHEOLpv82nkbSpnGaTow/wl/nnHQoJHQ0lZJ9Kt9PfFisE9O9pN8yWp2
	nBDFTWXm8Mz2j6FxoS0P8b95HZASlMqEXAh+SzxOUsmg3RyHXdFa3td5aYKtTc/N9CGKXRxyCRE
	jj/DjOux7PKnWiJjh3rqsZUBWmpBrGvVyIYazctarlMaTwFC9n9Ybxhv7julkOc46t9B2e6m9HH
	ikJZp5mplNe12mmxAxs2fxxbkjnHjmzKoQ8kYuhhqQ==
X-Received: by 2002:a17:907:8dcd:b0:b93:c5a9:a5e6 with SMTP id
 a640c23a62f3a-b976507af92mr500109966b.2.1773582699724; Sun, 15 Mar 2026
 06:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260312214330.3885211-1-neilb@ownmail.net> <20260312214330.3885211-17-neilb@ownmail.net>
In-Reply-To: <20260312214330.3885211-17-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Mar 2026 14:51:27 +0100
X-Gm-Features: AaiRm50yYPhN2uA9nBAPVNuAVUOhGIEBVS5rPtx5ZlpdDP1j4SB9NhEOC_7KNWo
Message-ID: <CAOQ4uxjmcNxsCmDSVgkTns=3BAuQcT3pVvsQzza+u3iqXqrz5g@mail.gmail.com>
Subject: Re: [PATCH 16/53] ovl: drop dir lock for lookups in impure readdir
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jan Harkes <jaharkes@cs.cmu.edu>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Steve French <sfrench@samba.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Breno Leitao <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Tyler Hicks <code@tyhicks.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, gfs2@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260315_065142_963500_A773238A 
X-CRM114-Status: GOOD (  37.83  )
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

On Thu, Mar 12, 2026 at 10:49=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> From: NeilBrown <neil@brown.name>
>
> When performing an "impure" readdir, ovl needs to perform a lookup on som=
e
> of the names that it found.
> With proposed locking changes it will not be possible to perform this
> lookup (in particular, not safe to wait for d_alloc_parallel()) while
> holding a lock on the directory.
>
> ovl doesn't really need the lock at this point.

Not exactly. see below.

> It has already iterated
> the directory and has cached a list of the contents.  It now needs to
> gather extra information about some contents.  It can do this without
> the lock.
>
> After gathering that info it needs to retake the lock for API
> correctness.  After doing this it must check IS_DEADDIR() again to
> ensure readdir always returns -ENOENT on a removed directory.
>
> Note that while ->iterate_shared is called with a shared lock, ovl uses
> WRAP_DIR_ITER() so an exclusive lock is held and so we drop and retake
> that exclusive lock.
>
> As the directory is no longer locked in ovl_cache_update() we need
> dget_parent() to get a reference to the parent.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/readdir.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 1dcc75b3a90f..d5123b37921c 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -568,13 +568,12 @@ static int ovl_cache_update(const struct path *path=
, struct ovl_cache_entry *p,
>                         goto get;
>                 }
>                 if (p->len =3D=3D 2) {
> -                       /* we shall not be moved */
> -                       this =3D dget(dir->d_parent);
> +                       this =3D dget_parent(dir);
>                         goto get;
>                 }
>         }
>         /* This checks also for xwhiteouts */
> -       this =3D lookup_one(mnt_idmap(path->mnt), &QSTR_LEN(p->name, p->l=
en), dir);
> +       this =3D lookup_one_unlocked(mnt_idmap(path->mnt), &QSTR_LEN(p->n=
ame, p->len), dir);

ovl_cache_update() is also called from ovl_iterate_merged() where inode
is locked.

>         if (IS_ERR_OR_NULL(this) || !this->d_inode) {
>                 /* Mark a stale entry */
>                 p->is_whiteout =3D true;
> @@ -666,11 +665,12 @@ static int ovl_dir_read_impure(const struct path *p=
ath,  struct list_head *list,
>         if (err)
>                 return err;
>
> +       inode_unlock(path->dentry->d_inode);
>         list_for_each_entry_safe(p, n, list, l_node) {
>                 if (!name_is_dot_dotdot(p->name, p->len)) {
>                         err =3D ovl_cache_update(path, p, true);
>                         if (err)
> -                               return err;
> +                               break;
>                 }
>                 if (p->ino =3D=3D p->real_ino) {
>                         list_del(&p->l_node);
> @@ -680,14 +680,19 @@ static int ovl_dir_read_impure(const struct path *p=
ath,  struct list_head *list,
>                         struct rb_node *parent =3D NULL;
>
>                         if (WARN_ON(ovl_cache_entry_find_link(p->name, p-=
>len,
> -                                                             &newp, &par=
ent)))
> -                               return -EIO;
> +                                                             &newp, &par=
ent))) {
> +                               err =3D -EIO;
> +                               break;
> +                       }
>
>                         rb_link_node(&p->node, parent, newp);
>                         rb_insert_color(&p->node, root);
>                 }
>         }
> -       return 0;
> +       inode_lock(path->dentry->d_inode);
> +       if (IS_DEADDIR(path->dentry->d_inode))
> +               err =3D -ENOENT;
> +       return err;
>  }
>
>  static struct ovl_dir_cache *ovl_cache_get_impure(const struct path *pat=
h)
> --

You missed the fact that overlayfs uses the dir inode lock
to protect the readdir inode cache, so your patch introduces
a risk for storing a stale readdir cache when dir modify operations
invalidate the readdir cache version while lock is dropped
and also introduces memory leak when cache is stomped
without freeing cache created by a competing thread.
I think something like the untested patch below should fix this.

I did not look into ovl_iterate_merged() to see if it has a simple
fix and I am not 100% sure that this fix for impure dir is enough.

Thanks,
Amir.

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index d5123b37921c8..9e90064b252ce 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -702,15 +702,13 @@ static struct ovl_dir_cache
*ovl_cache_get_impure(const struct path *path)
        struct inode *inode =3D d_inode(dentry);
        struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
        struct ovl_dir_cache *cache;
+       /* Snapshot version before ovl_dir_read_impure() drops i_rwsem */
+       u64 version =3D ovl_inode_version_get(inode);

        cache =3D ovl_dir_cache(inode);
-       if (cache && ovl_inode_version_get(inode) =3D=3D cache->version)
+       if (cache && version =3D=3D cache->version)
                return cache;

-       /* Impure cache is not refcounted, free it here */
-       ovl_dir_cache_free(inode);
-       ovl_set_dir_cache(inode, NULL);
-
        cache =3D kzalloc_obj(struct ovl_dir_cache);
        if (!cache)
                return ERR_PTR(-ENOMEM);
@@ -721,6 +719,14 @@ static struct ovl_dir_cache
*ovl_cache_get_impure(const struct path *path)
                kfree(cache);
                return ERR_PTR(res);
        }
+
+       /*
+        * Impure cache is not refcounted, free it here.
+        * Also frees cache stored by concurrent readdir during i_rwsem dro=
p.
+        */
+       ovl_dir_cache_free(inode);
+       ovl_set_dir_cache(inode, NULL);
+
        if (list_empty(&cache->entries)) {
                /*
                 * A good opportunity to get rid of an unneeded "impure" fl=
ag.
@@ -736,7 +742,7 @@ static struct ovl_dir_cache
*ovl_cache_get_impure(const struct path *path)
                return NULL;
        }

-       cache->version =3D ovl_inode_version_get(inode);
+       cache->version =3D version;
        ovl_set_dir_cache(inode, cache);

        return cache;

