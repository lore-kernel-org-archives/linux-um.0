Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iuAoK-0002NV-3o
 for linux-um@lists.infradead.org; Wed, 22 Jan 2020 07:52:25 +0000
Message-ID: <946dd98f6597cdc9e75cce1929991ca3c6d6b12d.camel@sipsolutions.net>
Subject: Re: [PATCH] overlayfs: print format optimization
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 22 Jan 2020 08:51:54 +0100
In-Reply-To: <9e77421d905f0eda08753cf7a7b40f51b5b8c688.1579676323.git.liuyang34@xiaomi.com>
References: <cover.1579676323.git.liuyang34@xiaomi.com>
 <9e77421d905f0eda08753cf7a7b40f51b5b8c688.1579676323.git.liuyang34@xiaomi.com>
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
To: liuyang34 <yangliuxm34@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Miklos Szeredi <miklos@szeredi.hu>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Alex Dewar <alex.dewar@gmx.co.uk>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: liuyang34 <liuyang34@xiaomi.com>


> diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
> index 44def53..54246b7 100644
> --- a/arch/um/os-Linux/umid.c
> +++ b/arch/um/os-Linux/umid.c
> @@ -349,7 +349,7 @@ int __init umid_file_name(char *name, char *buf, int len)
>  	if (err)
>  		return err;
>  
> -	n = snprintf(buf, len, "%s%s/%s", uml_dir, umid, name);
> +	n = snddprintf(buf, len, "%s%s/%s", uml_dir, umid, name);
>  	if (n >= len) {

Huh, what's this?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

