Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFM2C-0006GZ-Np
 for linux-um@lists.infradead.org; Tue, 01 Oct 2019 17:34:01 +0000
Message-ID: <0c6503e6b74ed1f25457d9919552fbfe48b68f37.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: Loadable BPF "Firmware" for vector drivers
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 01 Oct 2019 19:33:58 +0200
In-Reply-To: <20191001165537.3386-1-anton.ivanov@cambridgegreys.com>
References: <20191001165537.3386-1-anton.ivanov@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: richard@nod.at

On Tue, 2019-10-01 at 17:55 +0100, Anton Ivanov wrote:
> 
> +	vp->bpf->filter = kmalloc(fw->size, GFP_KERNEL);
> +	if (!vp->bpf->filter)
> +		goto free_buffer;
> +
> +	memcpy(vp->bpf->filter, fw->data, fw->size);

Also, that's really just kmemdup().

> +	release_firmware(fw);
> +
> +	vp->bpf->len = fw->size / sizeof(struct sock_filter);

and that's a use-after-free, afaict?

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

