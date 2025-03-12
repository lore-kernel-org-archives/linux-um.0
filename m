Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA85C28B28
	for <linux-um@archiver.kernel.org>; Wed, 12 Mar 2025 13:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d/Fav/LCh9m71nPnVBm8/MdlP4cPzwHobh78/c6qUbg=; b=RZX5hLA2RCaHpsKysjYZ8eMr5/
	tih3VCoM1Hf3fMDJowWP05q1U/r5SWX8KqO0IRyz7DBCw3otbAEVDfaoLp9ntYGh/2BmoFnqTYHHU
	96Cd60iYMYJ0DWVufHTyQJncvG19wGvH2Ar3HMA1lLinEKzfJajbqao1sAJAebiFqQ9aD2NUhrRMu
	fPxUc/g2Y+sOzx3QJfRrsGyT0fOgsQMh7BH+QtwQFkmlu8F3kodzTDrYqvXiExE5+Je+9LE8L3j7y
	lRTOYhjireiHvk3RQLr2YltHslBA/BAbYn3zr1cseAd6dvFqd3zrzUY3vQcd91y67CWYM4lHNJNHG
	Kre21Ysg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsLpe-00000008WUH-18zA;
	Wed, 12 Mar 2025 13:09:10 +0000
Received: from smtp-1909.mail.infomaniak.ch ([2001:1600:7:10::1909])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsLar-00000008THm-1cyb
	for linux-um@lists.infradead.org;
	Wed, 12 Mar 2025 12:53:55 +0000
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZCVth3M6fz157x;
	Wed, 12 Mar 2025 13:53:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741784028;
	bh=d/Fav/LCh9m71nPnVBm8/MdlP4cPzwHobh78/c6qUbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XuY1ZjZWO8HfyqvMytnouBx4dzX5kwQwsbbivtTrke9BhUQsD9tqZ1rwpAI65HNPd
	 NoSRY3SJlxOY8i0UDY1FtKTSvfxCSeuDNNFxq6FH2A0ZNmFzwMWQrxjllyWIR3XlFe
	 C5L2kQglQRxzFZ9ENLUdJZXROwDFTRdcdnAn12hQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZCVtg45d1zLXf;
	Wed, 12 Mar 2025 13:53:47 +0100 (CET)
Date: Wed, 12 Mar 2025 13:53:46 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Benjamin Berg <benjamin.berg@intel.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] um: hostfs: avoid issues on inode number reuse by host
Message-ID: <20250312.iph3EFiu5eef@digikod.net>
References: <20250214092822.1241575-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214092822.1241575-1-benjamin@sipsolutions.net>
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_055353_710856_6ED1740F 
X-CRM114-Status: GOOD (  32.60  )
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

On Fri, Feb 14, 2025 at 10:28:22AM +0100, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Some file systems (e.g. ext4) may reuse inode numbers once the inode is
> not in use anymore. Usually hostfs will keep an FD open for each inode,
> but this is not always the case. In the case of sockets, this cannot
> even be done properly.
> 
> As such, the following sequence of events was possible:
>  * application creates and deletes a socket
>  * hostfs creates/deletes the socket on the host
>  * inode is still in the hostfs cache
>  * hostfs creates a new file
>  * ext4 on the outside reuses the inode number
>  * hostfs finds the socket inode for the newly created file
>  * application receives -ENXIO when opening the file
> 
> As mentioned, this can only happen if the deleted file is a special file
> that is never opened on the host (i.e. no .open fop).
> 
> As such, to prevent issues, it is sufficient to check that the inode
> has the expected type. That said, also add a check for the inode birth
> time, just to be on the safe side.
> 
> Fixes: 74ce793bcbde ("hostfs: Fix ephemeral inodes")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Thanks!  This indeed fix an issue that is at least visible when running
Landlock kselftests with an UML kernel built with Landlock audit support
(probably because of a race condition now being more consistent):
https://lore.kernel.org/all/20250308184422.2159360-1-mic@digikod.net/
FYI, I plan to merge this patch series with v6.15

I guess this patch should fix some other use of UML anyway.  Please
merge it, if possible before v6.15 .

Reviewed-by: Mickaël Salaün <mic@digikod.net>
Tested-by: Mickaël Salaün <mic@digikod.net>

> ---
>  fs/hostfs/hostfs.h      |  2 +-
>  fs/hostfs/hostfs_kern.c |  7 ++++-
>  fs/hostfs/hostfs_user.c | 59 ++++++++++++++++++++++++-----------------
>  3 files changed, 41 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
> index 8b39c15c408c..15b2f094d36e 100644
> --- a/fs/hostfs/hostfs.h
> +++ b/fs/hostfs/hostfs.h
> @@ -60,7 +60,7 @@ struct hostfs_stat {
>  	unsigned int uid;
>  	unsigned int gid;
>  	unsigned long long size;
> -	struct hostfs_timespec atime, mtime, ctime;
> +	struct hostfs_timespec atime, mtime, ctime, btime;
>  	unsigned int blksize;
>  	unsigned long long blocks;
>  	struct {
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index e0741e468956..e6e247235728 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -33,6 +33,7 @@ struct hostfs_inode_info {
>  	struct inode vfs_inode;
>  	struct mutex open_mutex;
>  	dev_t dev;
> +	struct hostfs_timespec btime;
>  };
>  
>  static inline struct hostfs_inode_info *HOSTFS_I(struct inode *inode)
> @@ -547,6 +548,7 @@ static int hostfs_inode_set(struct inode *ino, void *data)
>  	}
>  
>  	HOSTFS_I(ino)->dev = dev;
> +	HOSTFS_I(ino)->btime = st->btime;
>  	ino->i_ino = st->ino;
>  	ino->i_mode = st->mode;
>  	return hostfs_inode_update(ino, st);
> @@ -557,7 +559,10 @@ static int hostfs_inode_test(struct inode *inode, void *data)
>  	const struct hostfs_stat *st = data;
>  	dev_t dev = MKDEV(st->dev.maj, st->dev.min);
>  
> -	return inode->i_ino == st->ino && HOSTFS_I(inode)->dev == dev;
> +	return inode->i_ino == st->ino && HOSTFS_I(inode)->dev == dev &&
> +	       (inode->i_mode & S_IFMT) == (st->mode & S_IFMT) &&
> +	       HOSTFS_I(inode)->btime.tv_sec == st->btime.tv_sec &&
> +	       HOSTFS_I(inode)->btime.tv_nsec == st->btime.tv_nsec;
>  }
>  
>  static struct inode *hostfs_iget(struct super_block *sb, char *name)
> diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
> index 97e9c40a9448..3bcd9f35e70b 100644
> --- a/fs/hostfs/hostfs_user.c
> +++ b/fs/hostfs/hostfs_user.c
> @@ -18,39 +18,48 @@
>  #include "hostfs.h"
>  #include <utime.h>
>  
> -static void stat64_to_hostfs(const struct stat64 *buf, struct hostfs_stat *p)
> +static void statx_to_hostfs(const struct statx *buf, struct hostfs_stat *p)
>  {
> -	p->ino = buf->st_ino;
> -	p->mode = buf->st_mode;
> -	p->nlink = buf->st_nlink;
> -	p->uid = buf->st_uid;
> -	p->gid = buf->st_gid;
> -	p->size = buf->st_size;
> -	p->atime.tv_sec = buf->st_atime;
> -	p->atime.tv_nsec = 0;
> -	p->ctime.tv_sec = buf->st_ctime;
> -	p->ctime.tv_nsec = 0;
> -	p->mtime.tv_sec = buf->st_mtime;
> -	p->mtime.tv_nsec = 0;
> -	p->blksize = buf->st_blksize;
> -	p->blocks = buf->st_blocks;
> -	p->rdev.maj = os_major(buf->st_rdev);
> -	p->rdev.min = os_minor(buf->st_rdev);
> -	p->dev.maj = os_major(buf->st_dev);
> -	p->dev.min = os_minor(buf->st_dev);
> +	p->ino = buf->stx_ino;
> +	p->mode = buf->stx_mode;
> +	p->nlink = buf->stx_nlink;
> +	p->uid = buf->stx_uid;
> +	p->gid = buf->stx_gid;
> +	p->size = buf->stx_size;
> +	p->atime.tv_sec = buf->stx_atime.tv_sec;
> +	p->atime.tv_nsec = buf->stx_atime.tv_nsec;
> +	p->ctime.tv_sec = buf->stx_ctime.tv_sec;
> +	p->ctime.tv_nsec = buf->stx_ctime.tv_nsec;
> +	p->mtime.tv_sec = buf->stx_mtime.tv_sec;
> +	p->mtime.tv_nsec = buf->stx_mtime.tv_nsec;
> +	if (buf->stx_mask & STATX_BTIME) {
> +		p->btime.tv_sec = buf->stx_btime.tv_sec;
> +		p->btime.tv_nsec = buf->stx_btime.tv_nsec;
> +	} else {
> +		memset(&p->btime, 0, sizeof(p->btime));
> +	}
> +	p->blksize = buf->stx_blksize;
> +	p->blocks = buf->stx_blocks;
> +	p->rdev.maj = buf->stx_rdev_major;
> +	p->rdev.min = buf->stx_rdev_minor;
> +	p->dev.maj = buf->stx_dev_major;
> +	p->dev.min = buf->stx_dev_minor;
>  }
>  
>  int stat_file(const char *path, struct hostfs_stat *p, int fd)
>  {
> -	struct stat64 buf;
> +	struct statx buf;
> +	int flags = AT_SYMLINK_NOFOLLOW;
>  
>  	if (fd >= 0) {
> -		if (fstat64(fd, &buf) < 0)
> -			return -errno;
> -	} else if (lstat64(path, &buf) < 0) {
> -		return -errno;
> +		flags |= AT_EMPTY_PATH;
> +		path = "";
>  	}
> -	stat64_to_hostfs(&buf, p);
> +
> +	if ((statx(fd, path, flags, STATX_BASIC_STATS | STATX_BTIME, &buf)) < 0)
> +		return -errno;
> +
> +	statx_to_hostfs(&buf, p);
>  	return 0;
>  }
>  
> -- 
> 2.48.1
> 

