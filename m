Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlA5u-007yGr-OO
 for linux-um@lists.infradead.org; Thu, 11 Nov 2021 13:26:24 +0000
Subject: Re: [PATCH] hostfs: Fix writeback of dirty pages
References: <20211105081052.2353801-1-sjoerd@collabora.com>
From: Christopher Obbard <chris.obbard@collabora.com>
Message-ID: <d9bcb237-39e1-29b1-9718-b720a7e7540b@collabora.com>
Date: Thu, 11 Nov 2021 13:26:17 +0000
MIME-Version: 1.0
In-Reply-To: <20211105081052.2353801-1-sjoerd@collabora.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Sjoerd Simons <sjoerd@collabora.com>, linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hi Sjoerd,

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

Cc: stable@vger.kernel.org
Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>

...replying mainly as I wonder if adding the stable tag in a reply will 
make the patch appear in stable (obviously once it is in mainline) ? :-)


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

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

