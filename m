Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]
 helo=smtprelay.hostedemail.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jNJAA-0007F6-CF
 for linux-um@lists.infradead.org; Sat, 11 Apr 2020 16:39:23 +0000
Message-ID: <16239d86d8177e70f15aab5e7dca61758a749fb0.camel@perches.com>
Subject: Re: [trivial PATCH] um virtio: Neaten vu_err macro definition
From: Joe Perches <joe@perches.com>
Date: Sat, 11 Apr 2020 09:37:10 -0700
In-Reply-To: <ba7b958fda7c42e10fded7b158e892e2dfb06494.camel@perches.com>
References: <ba7b958fda7c42e10fded7b158e892e2dfb06494.camel@perches.com>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Erel Geron <erelx.geron@intel.com>, linux-um@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>

On Sat, 2020-04-11 at 09:28 -0700, Joe Perches wrote:
> Defining a macro with ... and __VA_ARGS__ (without ##) can cause
> compilation errors if a macro use does not have additional args.
> 
> Add ## to __VA_ARGS__ in the macro definition.
[]
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
[]
> @@ -74,7 +74,7 @@ struct virtio_uml_vq_info {
>  
>  extern unsigned long long physmem_size, highmem;
>  
> -#define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev, __VA_ARGS__)
> +#define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev, ##__VA_ARGS__)

Ignore this.  Caffeine-free so far this morning.

It _might_ be better as:

#define vu_err(vu_dev, fmt, ...)	dev_err(&(vu_dev)->pdev->dev, fmt, ##__VA_ARGS__)



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

