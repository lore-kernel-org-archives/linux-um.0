Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232E1C87FCF
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=orpa4r8gH8eS0evni3lIuGSBjIWNZOO2BZpAbJmaB6A=; b=3x6vzAmv0lGQIiZhC9YvuHh9+k
	dntsss6B/XMmdl3p4ygwyM1SDRcUgQQ5m5wqS3m37s9zrX6abDk5s8O59/cyB0aqSvoD4Hryg+rnY
	psQCKWicw/0x3A6NnaPRuSTN8pfhhpq1HrBYRa5YwiKCokhlYWbG0VLjseb7+W3+25XiMy7n0oR1k
	3Zmuts8epFxkCsSBOGHEoTxWwXM1KvgEI2xy4RTNZMWQEx9n+UPczYwJPon6Agv4ywW2tbKx4DzQb
	5CPwR7FuatDc7FmEOBmI53dbDkxj5hcvLyjXLR1JCUrxfyX1vsWxfB7id+9WxVxutmr85nfpbBuxj
	JNcvoMQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um6CD-0000000Cyf5-2BLV;
	Wed, 13 Aug 2025 07:46:53 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um5oT-0000000CuyG-2XCq;
	Wed, 13 Aug 2025 07:22:22 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso8357631a12.0;
        Wed, 13 Aug 2025 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755069740; x=1755674540; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orpa4r8gH8eS0evni3lIuGSBjIWNZOO2BZpAbJmaB6A=;
        b=dW/0obfOfyXdSdpjEu+baWdk+3E9wWPMluJLtd6/mYqjiEwKDy24YPse2YVruDC0j+
         yWvpMyfABgXkch2Cwv5pqKZtoWKPiPRSWy5IZdAoUvHIdIWm6M27gwVr7ND3xqu2Ho5B
         N5q3E+7SwVLnrQmXa+nB4tj6O4sYFgGtcoNtcDMN0aYviw0vhIMD9+fk2sIRDDN+MgAv
         /pTvaVKc3RqIMJtP6xM4CA6mcQ98FIgtzSnB26b6VAnAdCqf+O4g5bIfF+PLllXgal+N
         Y2z9W1641iprc6k5h/5Ni2Y8AIKpWtLZ6O474ssd5gD6zyAt1bh5xbdA/7v6Eq6yBDq5
         sWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069740; x=1755674540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orpa4r8gH8eS0evni3lIuGSBjIWNZOO2BZpAbJmaB6A=;
        b=CLX4DKntLpfZcGisqzhudKphOa7hNKKaBqlB/BQBTBtwLftL2TnPkm/x2h4sS/PznY
         K8QWpQHNfNfyQGO86mQHBN8+LxHlPznDr0g1IiGAxdvGOYYc8YQB8eLCL536b3gEMHNy
         1VNnxXQmutY04zedIuYUsaf129hS9WRc+FL1e52xQd5qNAW8hW1N3BD9/tlDjIBQVQ5h
         H0AlJ9qFMVxaqGc2Z5X54CdYH2Hvnw7zupRH5U6HanigVZQgHl7JYrGIpxJ2UbdHaZ8r
         GxnU2B3s1L+qKjK8v7GSbxuMcNjrcfE1juv6SxKnup6VfrWXNEkz9q6887+qAZspInR1
         N76Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5U49k3qX41EbQ+AaH5WY6dd0p2DY0stgBlJqrdWJSYY4Nml3P7hn0hjeRpNdccsrtu4JMeSkslR8=@lists.infradead.org, AJvYcCX0swjrrszhxGXMSYaFetFel+W5QC7QBLqdqxzJ/YO1YzAf7kkz5pEeCmAs6SHNwZZNNo5IuxIRb44=@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1iJ606zqNVdY0+DZF/hu0e0Bd3XZCHCQjF6vBqDPi7mT83v3P
	sNHSx9PEzFuTeLgjVbQxE181u74bNtd38d5u7XWwGfiFnJ40c8vI3XREYIjklDLhMG7txwENwTe
	129CYga3g/+P0qDlpW2ES1TINoCEvlPs=
X-Gm-Gg: ASbGnct/q7SCoT9/UPFkpxcrLARvyToD1UodICjetWtEbhf4k58qrfWNT1rEY8Jwpvk
	5HdLJnaKXbHMOnrrMmQug7RrMoLMN42Sm0ZodUgxUkCSEqfHIQfU2i7YOwfXmMTJL5S7U0L6yzL
	SCNaltOwq0nTKUZ7fj+wrNFIFVSdmWJ76KPYDqQ9JlTop7p6MUnVt1WN0VZp8j+cQberQ52TLQ7
	LZeJlRPPLh63fvsKQ==
X-Google-Smtp-Source: AGHT+IGOXg/qO7nOvSc+9upBTuFdN9gkoZr2ooHCH00oHdLGmBP/f/jaP6ih0T+T7ZtaDnRktY5n/bEZet/hUzbOyNs=
X-Received: by 2002:a17:907:7f90:b0:af9:6bfb:58b7 with SMTP id
 a640c23a62f3a-afca4ccbdf5mr186837966b.5.1755069739183; Wed, 13 Aug 2025
 00:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250812235228.3072318-1-neil@brown.name> <20250812235228.3072318-8-neil@brown.name>
In-Reply-To: <20250812235228.3072318-8-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Aug 2025 09:22:08 +0200
X-Gm-Features: Ac12FXwtRWkT3_8pRQNxkfPe9bIkc7MlydN-xB3KA9S7ZYYDtuYZQn46STskK1g
Message-ID: <CAOQ4uxhU12U8g_EYkUyc4Jdpzjy3hT1hZYB0L1THwvTsti8mTw@mail.gmail.com>
Subject: Re: [PATCH 07/11] VFS: Change vfs_mkdir() to unlock on failure.
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
X-CRM114-CacheID: sfid-20250813_002221_644525_F195FBBC 
X-CRM114-Status: GOOD (  36.45  )
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

On Wed, Aug 13, 2025 at 1:53=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Proposed changes to directory-op locking will lock the dentry rather
> than the whole directory.  So the dentry will need to be unlocked.
>
> vfs_mkdir() consumes the dentry on error, so there will be no dentry to
> be unlocked.

Why does it need to consume the dentry on error?
Why can't it leave the state as is on error and let the caller handle
its own cleanup?

>
> So this patch changes vfs_mkdir() to unlock on error as well as
> releasing the dentry.  This requires various other functions in various
> callers to also unlock on error - particularly in nfsd and overlayfs.
>
> At present this results in some clumsy code.  Once the transition to
> dentry locking is complete the clumsiness will be gone.
>
> Callers of vfs_mkdir() in ecrypytfs, nfsd, xfs, cachefiles, and
> overlayfs are changed to make the new behaviour.

I will let Al do the vfs review of this and will speak up on behalf of
the vfs users of the API

One problem with a change like this - subtle change to semantics
with no function prototype change is that it is a "backporting land mine"
both AUTOSEL and human can easily not be aware of the subtle
semantic change in a future time when a fix is being backported
across this semantic change.

Now there was a prototype change in c54b386969a5 ("VFS: Change
vfs_mkdir() to return the dentry.") in v6.15 not long ago, so (big) if this
semantic change (or the one that follows it) both get into the 2025 LTS
kernel, we are in less of a problem, but if they don't, it's kind of a big
problem for the stability of those subsystems in LTS kernels IMO -
not being able to use "cleanly applies and build" as an indication to
"likelihood of a correct backport".

and now onto review of ovl code...

> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 70b8687dc45e..24f7e28b9a4f 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -162,14 +162,18 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
>         goto out;
>  }
>
> +/* dir will be unlocked on return */
>  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent=
,
> -                              struct dentry *newdentry, struct ovl_cattr=
 *attr)
> +                              struct dentry *newdentry_arg, struct ovl_c=
attr *attr)
>  {
>         struct inode *dir =3D parent->d_inode;
> +       struct dentry *newdentry __free(dentry_lookup) =3D newdentry_arg;
>         int err;
>
> -       if (IS_ERR(newdentry))
> +       if (IS_ERR(newdentry)) {
> +               inode_unlock(dir);
>                 return newdentry;
> +       }
>
>         err =3D -ESTALE;
>         if (newdentry->d_inode)
> @@ -213,12 +217,9 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, s=
truct dentry *parent,
>                 err =3D -EIO;
>         }
>  out:
> -       if (err) {
> -               if (!IS_ERR(newdentry))
> -                       dput(newdentry);
> +       if (err)
>                 return ERR_PTR(err);
> -       }
> -       return newdentry;
> +       return dget(newdentry);
>  }
>
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
> @@ -228,7 +229,6 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
>         inode_lock(workdir->d_inode);
>         ret =3D ovl_create_real(ofs, workdir,
>                               ovl_lookup_temp(ofs, workdir), attr);
> -       inode_unlock(workdir->d_inode);

Things like that putting local code out of balance make my life as
maintainer very hard.

I prefer that you leave the explicit dir unlock in the callers until the ti=
me
that you change the create() API not require holding the dir lock.

I don't even understand how you changed the call semantics to an ovl
function that creates a directory or non-directory when your patch only
changes mkdir semantics, but I don't want to know, because even if this
works and I cannot easily understand how, then I do not want the confusing
semantics in ovl code.

I think you should be able to scope ovl_lookup_temp() with
dentry_lookup*() { } done_dentry_lookup() and use whichever semantics
you like about dir lock inside the helpers, as long as ovl code looks and f=
eels
balanced.

>         return ret;
>  }
>
> @@ -336,7 +336,6 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>                                     ovl_lookup_upper(ofs, dentry->d_name.=
name,
>                                                      upperdir, dentry->d_=
name.len),
>                                     attr);
> -       inode_unlock(udir);
>         if (IS_ERR(newdentry))
>                 return PTR_ERR(newdentry);
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 4f84abaa0d68..238c26142318 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -250,6 +250,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_=
fs *ofs,
>
>         ret =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
>         pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZE=
RO(ret));
> +       /* Note: dir will have been unlocked on failure */
>         return ret;
>  }
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index df85a76597e9..5a4b0a05139c 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -328,11 +328,13 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
>                 }
>
>                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> -               inode_unlock(dir);
>                 err =3D PTR_ERR(work);
>                 if (IS_ERR(work))
>                         goto out_err;
>
> +               dget(work); /* Need to return this */
> +
> +               done_dentry_lookup(work);

Another weird example.
I would expect that dentry_lookup*()/done_dentry_lookup()
would be introduced to users in the same commit, so the code
always remains balanced.

All in all, I think you should drop this patch from the series altogether
and drop dir unlock from callers only later after they have been
converted to use the new API.

Am I misunderstanding something that prevents you from doing that?

Thanks,
Amir.

