Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65743C6FA8E
	for <linux-um@archiver.kernel.org>; Sat,  4 Mar 2023 06:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vQ0860CZSwv52e3U774J0h0xysF45CK1Br7kyT6q1gY=; b=DR3otIqWNJWYPW
	RTCo8sMXNsXUX41h0MEVv0hr1OCJitQi1CvQJh6QZcAZgFcAcJxRC3UAxRfhg5I7zKIuKEgO+dCk+
	pPKZ6Z9pY7I16ljAa07LIX8c2W7ARcj6srDn60KkNfSfjtfxkpdRW5FyawRwKTquhM82QitFrJWvC
	6tyv0F2UaJmnnRxJ6Kk32gV/qLwVV+XtSZdbw5FouEiUYvS3I4/UlvdG6TVXjFb91cWnXWDFX294+
	Bg4zTcDEhgPMGetblzWM28roLHnv2/ybAsZT+qMFR9wfL+zl2TibotH9NxEn8zcSadihbsX62vhSr
	jEJo6rnXQ2KxTTTF9F0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYLOC-008Rbk-Jj; Sat, 04 Mar 2023 06:29:04 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYLO6-008Rae-Rt
	for linux-um@lists.infradead.org; Sat, 04 Mar 2023 06:29:03 +0000
Received: by mail-qt1-x82e.google.com with SMTP id r16so3719454qtx.9
        for <linux-um@lists.infradead.org>; Fri, 03 Mar 2023 22:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112; t=1677911334;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ZhmyOntrOjkxmgZEANs8FAUrxpW6skJgTb+tVElklU=;
        b=0OeMTbSZgBh+ZyunBH7xpBZFolRx1a8OaS5kt4r2FSl4Ggf3ZUuYQwQIN0GB09tzcj
         u9TqnvUgYAdiLqlvk1mgdiFagzZh+rG3r8LMeuvETcy4scAzDZxSWmFIfZdcrdRxiKxz
         Lxgp7sj48McHA2gwPQ9JTFZT0j8cTvCNkipQLQLXQbkP47XksJisWOoDJP1bOudWzrzB
         L8Rzm/Oef2psIVtAWdhFcVt82PscSmhsY8tEgux5IDEvRzZRMpBggbNLTuaNm6uFh3A9
         ECY9m40u59CKfp16q7UoeDe7oXIvgJ0fOMLoyS/Blp0oc7FTUAi0YSF7OHqTmo+qvBuQ
         8L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677911334;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZhmyOntrOjkxmgZEANs8FAUrxpW6skJgTb+tVElklU=;
        b=kztWMlrcwa+Bw/kWi9scPYgYPI834jEhUmXS0vF3YLuY8w+dApFVJu8Yzy7xKub0+s
         LUhl5chg9N/rUCoipVbzrImQToDm3NYJWRhBLfCJISbmH9/zusb8mg92z22UsFP0gk56
         JzGUJUE5ZV0pdToe/ocSAW7ZZV4yo4ODfp9hOD4yltr3aZPs12IqoWvPqdFHTL+b/CJB
         GGXgMOCZCo1oW9yTHufKT8x0xSDjzIR+ydC/bhZLlZPe+0h4D0K7qUUG35vdYZHdF/vI
         B/o3oEq9usW3kYUvoonI6KJ2aAituuWf/nT3+rYDDP87/FvYn0o779pllSreirLf6CiK
         PqVw==
X-Gm-Message-State: AO0yUKXNSbLguzMF97xGi+kF3uDzwdCl/zIKRLmKMEkgzar8muDdOjAA
	YWc/fJXq3C2zq0DYB08nsEsnhnjOQaAqLMJr3xk=
X-Google-Smtp-Source: AK7set9DSRkrLPRV4Cag9yn1sUOTyNYKhabS2nRmI7IxB3I0t9vaw+DQBhtoqMMpbRx+ohtLZEGY1Q==
X-Received: by 2002:a05:622a:18a6:b0:3ba:101e:88c6 with SMTP id v38-20020a05622a18a600b003ba101e88c6mr7001893qtc.48.1677911334384;
        Fri, 03 Mar 2023 22:28:54 -0800 (PST)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a02e400b0073bacce6ad7sm3180092qko.82.2023.03.03.22.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 22:28:54 -0800 (PST)
Date: Sat, 4 Mar 2023 00:28:46 -0600
From: Glenn Washburn <development@efficientek.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2] hostfs: handle idmapped mounts
Message-ID: <20230304002846.48278199@crass-HP-ZBook-15-G2>
In-Reply-To: <20230302083928.zek46ybxvuwgwdf5@wittgenstein>
References: <20230301015002.2402544-1-development@efficientek.com>
	<20230302083928.zek46ybxvuwgwdf5@wittgenstein>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_222859_163938_A05722EA 
X-CRM114-Status: GOOD (  29.41  )
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
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, 2 Mar 2023 09:39:28 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Tue, Feb 28, 2023 at 07:50:02PM -0600, Glenn Washburn wrote:
> > Let hostfs handle idmapped mounts. This allows to have the same
> > hostfs mount appear in multiple locations with different id
> > mappings.
> > 
> > root@(none):/media# id
> > uid=0(root) gid=0(root) groups=0(root)
> > root@(none):/media# mkdir mnt idmapped
> > root@(none):/media# mount -thostfs -o/home/user hostfs mnt
> > 
> > root@(none):/media# touch mnt/aaa
> > root@(none):/media# mount-idmapped --map-mount u:`id -u user`:0:1
> > --map-mount g:`id -g user`:0:1 /media/mnt /media/idmapped
> > root@(none):/media# ls -l mnt/aaa idmapped/aaa -rw-r--r-- 1 root
> > root 0 Jan 28 01:23 idmapped/aaa -rw-r--r-- 1 user user 0 Jan 28
> > 01:23 mnt/aaa
> > 
> > root@(none):/media# touch idmapped/bbb
> > root@(none):/media# ls -l mnt/bbb idmapped/bbb
> > -rw-r--r-- 1 root root 0 Jan 28 01:26 idmapped/bbb
> > -rw-r--r-- 1 user user 0 Jan 28 01:26 mnt/bbb
> > 
> > Signed-off-by: Glenn Washburn <development@efficientek.com>
> > ---
> > Changes from v1:
> >  * Rebase on to tip. The above commands work and have the results
> > expected. The __vfsuid_val(make_vfsuid(...)) seems ugly to get the
> > uid_t, but it seemed like the best one I've come across. Is there a
> > better way?
> 
> Sure, I can help you with that. ;)

Thank you!

> > 
> > Glenn
> > ---
> >  fs/hostfs/hostfs_kern.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> > index c18bb50c31b6..9459da99a0db 100644
> > --- a/fs/hostfs/hostfs_kern.c
> > +++ b/fs/hostfs/hostfs_kern.c
> > @@ -786,7 +786,7 @@ static int hostfs_permission(struct mnt_idmap
> > *idmap, err = access_file(name, r, w, x);
> >  	__putname(name);
> >  	if (!err)
> > -		err = generic_permission(&nop_mnt_idmap, ino,
> > desired);
> > +		err = generic_permission(idmap, ino, desired);
> >  	return err;
> >  }
> >  
> > @@ -794,13 +794,14 @@ static int hostfs_setattr(struct mnt_idmap
> > *idmap, struct dentry *dentry, struct iattr *attr)
> >  {
> >  	struct inode *inode = d_inode(dentry);
> > +	struct user_namespace *fs_userns = i_user_ns(inode);
> 
> Fyi, since hostfs can't be mounted in a user namespace
> fs_userns == &init_user_ns
> so it doesn't really matter what you use.

What would you suggest as preferable?

> >  	struct hostfs_iattr attrs;
> >  	char *name;
> >  	int err;
> >  
> >  	int fd = HOSTFS_I(inode)->fd;
> >  
> > -	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> > +	err = setattr_prepare(idmap, dentry, attr);
> >  	if (err)
> >  		return err;
> >  
> > @@ -814,11 +815,11 @@ static int hostfs_setattr(struct mnt_idmap
> > *idmap, }
> >  	if (attr->ia_valid & ATTR_UID) {
> >  		attrs.ia_valid |= HOSTFS_ATTR_UID;
> > -		attrs.ia_uid = from_kuid(&init_user_ns,
> > attr->ia_uid);
> > +		attrs.ia_uid = __vfsuid_val(make_vfsuid(idmap,
> > fs_userns, attr->ia_uid)); }
> >  	if (attr->ia_valid & ATTR_GID) {
> >  		attrs.ia_valid |= HOSTFS_ATTR_GID;
> > -		attrs.ia_gid = from_kgid(&init_user_ns,
> > attr->ia_gid);
> > +		attrs.ia_gid = __vfsgid_val(make_vfsgid(idmap,
> > fs_userns, attr->ia_gid));
> 
> Heh, if you look include/linux/fs.h:
> 
>         /*
>          * The two anonymous unions wrap structures with the same
> member. *
>          * Filesystems raising FS_ALLOW_IDMAP need to use
> ia_vfs{g,u}id which
>          * are a dedicated type requiring the filesystem to use the
> dedicated
>          * helpers. Other filesystem can continue to use ia_{g,u}id
> until they
>          * have been ported.
>          *
>          * They always contain the same value. In other words
> FS_ALLOW_IDMAP
>          * pass down the same value on idmapped mounts as they would
> on regular
>          * mounts.
>          */
>         union {
>                 kuid_t          ia_uid;
>                 vfsuid_t        ia_vfsuid;
>         };
>         union {
>                 kgid_t          ia_gid;
>                 vfsgid_t        ia_vfsgid;
>         };
> 
> this just is:
> 
> attrs.ia_uid = from_vfsuid(idmap, fs_userns, attr->ia_vfsuid));
> attrs.ia_gid = from_vfsgid(idmap, fs_userns, attr->ia_vfsgid));

Its easy to miss from this patch because of lack of context, but attrs
is a struct hostfs_iattr, not struct iattr. And attrs.ia_uid is of type
uid_t, not kuid_t. So the above fails to compile. This is why I needed
to wrap make_vfsuid() in __vfsuid_val() (to get the uid_t).

I had decided against using from_vfsuid() because then I thought I'd
need to use from_kuid() to get the uid_t. And from_kuid() takes the
namespace (again), which seemed uglier.

Based on this, what do you suggest?

Glenn

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
