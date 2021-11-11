Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] hostfs: Fix writeback of dirty pages
References: <20211105081052.2353801-1-sjoerd@collabora.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <42c70832-9fbe-5aa8-5f42-1db8aebb4362@cambridgegreys.com>
Date: Thu, 11 Nov 2021 18:57:17 +0000
MIME-Version: 1.0
In-Reply-To: <20211105081052.2353801-1-sjoerd@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Sjoerd Simons <sjoerd@collabora.com>, linux-um@lists.infradead.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On 05/11/2021 08:10, Sjoerd Simons wrote:
> Hostfs was not setting up the backing device information, which means it
> uses the noop bdi. The noop bdi does not have the writeback capability
> enabled, which in turns means  dirty pages never got written back to
> storage.
> 
> In other words programs using mmap to write to files on  hostfs never
> actually got their data written out...
> 
> Fix this by simply setting up the bdi with default settings as all the
> required code for writeback is already in place.
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---
> 
>   fs/hostfs/hostfs_kern.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index d5c9d886cd9f..ef481c3d9019 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -924,6 +924,9 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
>   	sb->s_op = &hostfs_sbops;
>   	sb->s_d_op = &simple_dentry_operations;
>   	sb->s_maxbytes = MAX_LFS_FILESIZE;
> +	err = super_setup_bdi(sb);
> +	if (err)
> +		goto out;
>   
>   	/* NULL is printed as '(null)' by printf(): avoid that. */
>   	if (req_root == NULL)
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

