Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F46CCA0EE4
	for <linux-um@archiver.kernel.org>; Mon, 18 Aug 2025 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ubbjo8h4cvXI+kpbxgHKGsgNRSO5oS6kJQNOdicLg+U=; b=G5bHri3fgmZa1O92B5tJZ52aF5
	yBI9fm16M9KxfrYgoFLVh4HLjgQVihWUnUypMrHUgol4tiovEdMrgrPyQKF7flZJGbeVEQX5amJpe
	kIIw/ZaoYIQ/5Ilf+4cX0npIEi2ht+6V4AYKL+JaKXvkwZ+XLDcBAl1tF3qvZ2UcrJjh88Ki4S+Gq
	NeisiIICWef99dP8aoIFz2rnRilfmrLnNM2cOjVAZpqmSijXHkpdJnG9pyl0kbhQvOwTfBrdY+lvm
	dACCZY4/aiuiGBmuH1yA1ItV4O4spoH6IJZIYdr80ab5ybBHQxVi8Mc1DfBmaieZDCrWnlbkxO8vn
	NtS2e1dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo08w-00000007dYm-1XEN;
	Mon, 18 Aug 2025 13:43:22 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unz9C-00000007Lvn-3ZjF;
	Mon, 18 Aug 2025 12:39:36 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so5713374a12.0;
        Mon, 18 Aug 2025 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520773; x=1756125573; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ubbjo8h4cvXI+kpbxgHKGsgNRSO5oS6kJQNOdicLg+U=;
        b=NzkVXRd4L6wyg2v4bgYw51xlecAFS/MFKoTBTOCGCWSp63ZGqbuHqI9b2PtydJZsAG
         B7XhdulJYEtc7MuR30KPLqRzQneSSBQaefPkRF7RbNytAKtAWNI8W51Ejvu2f6KyV3xY
         +wFKEfgG0EPDNSFy9qzycV2uwdtp28j5otIKq/rNz7ULxN2oDkBY0SHeLUYQeo4W4TJo
         kEi0u/4U2jxAZ7dCsAJIU2MzSVg+p1+mKLyCU3rNlM64XJioDDS7w0ZJTG3ernqJ0NlA
         lzMTVP0KCu0eUBjubHuJgUZUqfBGPCeoDV6RGq9RaHHiBfekYQFUpon30ofNIen79erM
         Pm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520773; x=1756125573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ubbjo8h4cvXI+kpbxgHKGsgNRSO5oS6kJQNOdicLg+U=;
        b=F1KjwrvKck1vE0YTxjhJw4/JcLrS6UwshY6nRG+TvlmAgZXtrmbXFBP6S4ds89+3oM
         4220flIsSfLJYBCxRl0J7VnVRO2V9sdeKdMOKNtQcHmPpHRGpOG9QlhdcqaNEDVTXwOi
         L9Q4xqelCZOPgfXO7CIxMC96YLd6eaMSgIYZeDhbDOHiusuIQsJsWnrIEOa6lTVMIXDo
         O8WUahKYaUodIfDxzT1RpUBSyLSMkI8RvgmC4/spD4+F5/ukPFJhGo2QH2JBZxGcRDVk
         Y6lt26XR4bcQIFFIziIGqF5mAPCElzBwZ6NBbMjx7+yudE/DUzNJiKoxiokaOdNlSMMK
         0fNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0oyFQzHZSpA5+uGtkRBVPdynITKMVLn0Q7qHHrFyPL1e/wizPAfQYM3aC84TMHrcLBZT/jspdpxo=@lists.infradead.org, AJvYcCWHr1AzYkGrYlZ4Bq8qOww6DHdnUn/Gt6K/0dkhjnT26chgZbMIz+eDKJkC3LcriUXBIffrOnSMyhY=@lists.infradead.org
X-Gm-Message-State: AOJu0YzcJauDZZpG2V/5kV61ZR32FIL1h1kWYFLR+jW4jLsLlCmU4wSH
	5B2TH75zZZSWONETrdIFVYSVOd9eUqIrlIPY5msWW8Rh/HF3O/WCAHfSWCFlrP3ZxHBhxslfGUg
	1CEDUXLaHYhF20qFny/0qENQ+OnJc4lw=
X-Gm-Gg: ASbGncsSaMo9bR27MWAq1GRwKEQxbeX7/8VjllonsdJQAZKMNoO6C0xQx5if0npPzaP
	AX/UJ40gcggFrP6/A+hANtrKjfsiklwwEuZUOv7xmaXF0arp0NpYGGv1ewYZQhjKkBgBEG6PRIx
	txK6VKjntb6yl8O8kwTBG9CIj0ndhR48QK7V1LNG5AL9bF6yFMajgUpryYmtI1sKQAg52BupMUZ
	in3PYo=
X-Google-Smtp-Source: AGHT+IHreI+It7iS6Rfr+brWbz70Us6HtoYs+C56L+JOM9s0ucMSXKqtnWOloo9akQbTFfs/x14TcE577HD2A1hPXyo=
X-Received: by 2002:a05:6402:278f:b0:612:d3cf:d1e4 with SMTP id
 4fb4d7f45d1cf-619b707c2a0mr6715378a12.8.1755520772728; Mon, 18 Aug 2025
 05:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250812235228.3072318-1-neil@brown.name> <20250812235228.3072318-5-neil@brown.name>
In-Reply-To: <20250812235228.3072318-5-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 18 Aug 2025 14:39:21 +0200
X-Gm-Features: Ac12FXwaOAmOjlUtH5bpB7wOuhOZPTQBUdVvt2kp3aUZBDH4-UANLHNzz7IOKqs
Message-ID: <CAOQ4uxjFPOZe004Cv+tT=NyQg2JOY6MOYQniSjaefVcg+3s-Kg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20250818_053934_888990_398DB3D7 
X-CRM114-Status: GOOD (  28.45  )
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
> A few callers operate on a dentry which they already have - unlike the
> normal case where a lookup proceeds an operation.
>
> For these callers dentry_lookup_continue() is provided where other
> callers would use dentry_lookup().  The call will fail if, after the
> lock was gained, the child is no longer a child of the given parent.
>
> There are a couple of callers that want to lock a dentry in whatever
> its current parent is.  For these a NULL parent can be passed, in which
> case ->d_parent is used.  In this case the call cannot fail.
>
> The idea behind the name is that the actual lookup occurred some time
> ago, and now we are continuing with an operation on the dentry.
>
> When the operation completes done_dentry_lookup() must be called.  An
> extra reference is taken when the dentry_lookup_continue() call succeeds
> and will be dropped by done_dentry_lookup().
>
> This will be used in smb/server, ecryptfs, and overlayfs, each of which
> have their own lock_parent() or parent_lock() or similar; and a few
> other places which lock the parent but don't check if the parent is
> still correct (often because rename isn't supported so parent cannot be
> incorrect).
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c            | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/namei.h |  2 ++
>  2 files changed, 41 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 7af9b464886a..df21b6fa5a0e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1874,6 +1874,45 @@ struct dentry *dentry_lookup_killable(struct mnt_i=
dmap *idmap,
>  }
>  EXPORT_SYMBOL(dentry_lookup_killable);
>
> +/**
> + * dentry_lookup_continue: lock a dentry if it is still in the given par=
ent, prior to dir ops
> + * @child: the dentry to lock
> + * @parent: the dentry of the assumed parent
> + *
> + * The child is locked - currently by taking i_rwsem on the parent - to
> + * prepare for create/remove operations.  If the given parent is not
> + * %NULL and is no longer the parent of the dentry after the lock is
> + * gained, the lock is released and the call fails (returns
> + * ERR_PTR(-EINVAL).
> + *
> + * On success a reference to the child is taken and returned.  The lock
> + * and reference must both be dropped by done_dentry_lookup() after the
> + * operation completes.
> + */
> +struct dentry *dentry_lookup_continue(struct dentry *child,
> +                                     struct dentry *parent)
> +{
> +       struct dentry *p =3D parent;
> +
> +again:
> +       if (!parent)
> +               p =3D dget_parent(child);
> +       inode_lock_nested(d_inode(p), I_MUTEX_PARENT);
> +       if (child->d_parent !=3D p) {

|| d_unhashed(child))

;)

and what about silly renames? are those also d_unhashed()?

Thanks,
Amir.

