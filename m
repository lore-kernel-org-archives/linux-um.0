Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82CDC6FA8E
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 08:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Waqxeoj6HTPQGI992FS7lT0kypByoCZq/bCyu6Rsk2M=; b=r2JPWl6cXJkcYt
	+U6jPbtsR+4n/pHXWXKVInR0Sf0qjSlhvaBH0y8swkgukWduq+z4I4h75LDDV2E/kMtGRZ9bNMmdj
	Dmcb9y38Elj9cz8VPCJYAm2P5eXibSa43HbFzo1gkgRcl616KzNKunZnBYiAdnd6Jak96TzZ5D6gF
	0Vu+cxzmSsMKE7IdjIh4Kgj753aP/GKxsyLYJXYUDBu6nexAoOsKLTcZJmxFGajKjKnKHP8FwP2oo
	E7SlfK+xW58LFS4VMFy01J9Ih4+1F3F0oz90vYRolyxHfKQzUhjxw7zfjnqEKPp5dLAt4AmU4Eew+
	+pqe8YRddj9XzHMzhb5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXeTT-001J6Y-D3; Thu, 02 Mar 2023 08:39:39 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXeTQ-001J59-Jy
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 08:39:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A954EB80F52;
	Thu,  2 Mar 2023 08:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6894CC4339B;
	Thu,  2 Mar 2023 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677746373;
	bh=Mn2WCZLODtYeRS6OA0ifOlfZ7zABBTX9L3F2oIQ2qDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjKoC8YKoh1LNX8WPfjJ3cc47vdNi6UeW1F0NF5HFtjBBF2oSaH+7jFpIUgkGoTU5
	 wvxmPfAjXz6TFoZkfO0GCdJV+boLjQHYmt6e5O/6UTxfT9z0wBtqKOyAcJE7LmSjWk
	 jCb71UTBXBzFzKILio/gbCua9R2xCs+6cUK5a2iKZ7qH64/FrxU8e9Gj0HKnvf3R4x
	 a3IIwukPl3/hHdseCn4H7X/YVWbJYLqRoMbVDBCMGkAeleG8zhmqwVkRG8n0laS3h0
	 gQKKoatv9AgjYuPJjjqa1Ean/XDZQ1Kqbm8XpHvk3pHfuXtM5o4Qub1W8tb4sO1ddG
	 JT+7F28hMQVZg==
Date: Thu, 2 Mar 2023 09:39:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Glenn Washburn <development@efficientek.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2] hostfs: handle idmapped mounts
Message-ID: <20230302083928.zek46ybxvuwgwdf5@wittgenstein>
References: <20230301015002.2402544-1-development@efficientek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230301015002.2402544-1-development@efficientek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_003936_995486_1207D4B4 
X-CRM114-Status: GOOD (  21.31  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Feb 28, 2023 at 07:50:02PM -0600, Glenn Washburn wrote:
> Let hostfs handle idmapped mounts. This allows to have the same hostfs
> mount appear in multiple locations with different id mappings.
> 
> root@(none):/media# id
> uid=0(root) gid=0(root) groups=0(root)
> root@(none):/media# mkdir mnt idmapped
> root@(none):/media# mount -thostfs -o/home/user hostfs mnt
> 
> root@(none):/media# touch mnt/aaa
> root@(none):/media# mount-idmapped --map-mount u:`id -u user`:0:1 --map-mount g:`id -g user`:0:1 /media/mnt /media/idmapped
> root@(none):/media# ls -l mnt/aaa idmapped/aaa
> -rw-r--r-- 1 root root 0 Jan 28 01:23 idmapped/aaa
> -rw-r--r-- 1 user user 0 Jan 28 01:23 mnt/aaa
> 
> root@(none):/media# touch idmapped/bbb
> root@(none):/media# ls -l mnt/bbb idmapped/bbb
> -rw-r--r-- 1 root root 0 Jan 28 01:26 idmapped/bbb
> -rw-r--r-- 1 user user 0 Jan 28 01:26 mnt/bbb
> 
> Signed-off-by: Glenn Washburn <development@efficientek.com>
> ---
> Changes from v1:
>  * Rebase on to tip. The above commands work and have the results expected.
>    The __vfsuid_val(make_vfsuid(...)) seems ugly to get the uid_t, but it
>    seemed like the best one I've come across. Is there a better way?

Sure, I can help you with that. ;)

> 
> Glenn
> ---
>  fs/hostfs/hostfs_kern.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index c18bb50c31b6..9459da99a0db 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -786,7 +786,7 @@ static int hostfs_permission(struct mnt_idmap *idmap,
>  		err = access_file(name, r, w, x);
>  	__putname(name);
>  	if (!err)
> -		err = generic_permission(&nop_mnt_idmap, ino, desired);
> +		err = generic_permission(idmap, ino, desired);
>  	return err;
>  }
>  
> @@ -794,13 +794,14 @@ static int hostfs_setattr(struct mnt_idmap *idmap,
>  			  struct dentry *dentry, struct iattr *attr)
>  {
>  	struct inode *inode = d_inode(dentry);
> +	struct user_namespace *fs_userns = i_user_ns(inode);

Fyi, since hostfs can't be mounted in a user namespace
fs_userns == &init_user_ns
so it doesn't really matter what you use.

>  	struct hostfs_iattr attrs;
>  	char *name;
>  	int err;
>  
>  	int fd = HOSTFS_I(inode)->fd;
>  
> -	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> +	err = setattr_prepare(idmap, dentry, attr);
>  	if (err)
>  		return err;
>  
> @@ -814,11 +815,11 @@ static int hostfs_setattr(struct mnt_idmap *idmap,
>  	}
>  	if (attr->ia_valid & ATTR_UID) {
>  		attrs.ia_valid |= HOSTFS_ATTR_UID;
> -		attrs.ia_uid = from_kuid(&init_user_ns, attr->ia_uid);
> +		attrs.ia_uid = __vfsuid_val(make_vfsuid(idmap, fs_userns, attr->ia_uid));
>  	}
>  	if (attr->ia_valid & ATTR_GID) {
>  		attrs.ia_valid |= HOSTFS_ATTR_GID;
> -		attrs.ia_gid = from_kgid(&init_user_ns, attr->ia_gid);
> +		attrs.ia_gid = __vfsgid_val(make_vfsgid(idmap, fs_userns, attr->ia_gid));

Heh, if you look include/linux/fs.h:

        /*
         * The two anonymous unions wrap structures with the same member.
         *
         * Filesystems raising FS_ALLOW_IDMAP need to use ia_vfs{g,u}id which
         * are a dedicated type requiring the filesystem to use the dedicated
         * helpers. Other filesystem can continue to use ia_{g,u}id until they
         * have been ported.
         *
         * They always contain the same value. In other words FS_ALLOW_IDMAP
         * pass down the same value on idmapped mounts as they would on regular
         * mounts.
         */
        union {
                kuid_t          ia_uid;
                vfsuid_t        ia_vfsuid;
        };
        union {
                kgid_t          ia_gid;
                vfsgid_t        ia_vfsgid;
        };

this just is:

attrs.ia_uid = from_vfsuid(idmap, fs_userns, attr->ia_vfsuid));
attrs.ia_gid = from_vfsgid(idmap, fs_userns, attr->ia_vfsgid));

(I plan to fully replace ia_{g,u}id at some point.)

Christian

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
