Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <50A8A382.7020400@gmail.com>
Date: Sun, 18 Nov 2012 09:59:46 +0100
From: Marco Stornelli <marco.stornelli@gmail.com>
MIME-Version: 1.0
References: <508276D3.5000708@gmail.com>
In-Reply-To: <508276D3.5000708@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] hostfs: fix a not needed double check
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Il 20/10/2012 12:02, Marco Stornelli ha scritto:
> With the commit 3be2be0a32c18b0fd6d623cda63174a332ca0de1 we removed vmtruncate,
> but actaully there is no need to call inode_newsize_ok() because the checks are
> already done in inode_change_ok() at the begin of the function.
>
> Signed-off-by: Marco Stornelli <marco.stornelli@gmail.com>
> ---
>   fs/hostfs/hostfs_kern.c |    9 +--------
>   1 files changed, 1 insertions(+), 8 deletions(-)
>
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 457addc..c9d5254 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -845,15 +845,8 @@ int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
>   		return err;
>
>   	if ((attr->ia_valid & ATTR_SIZE) &&
> -	    attr->ia_size != i_size_read(inode)) {
> -		int error;
> -
> -		error = inode_newsize_ok(inode, attr->ia_size);
> -		if (error)
> -			return error;
> -
> +	    attr->ia_size != i_size_read(inode))
>   		truncate_setsize(inode, attr->ia_size);
> -	}
>
>   	setattr_copy(inode, attr);
>   	mark_inode_dirty(inode);
>

Any feedback for this patch?

Marco
