Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp2.axis.com ([195.60.68.18])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n9pLP-001pbF-BM
 for linux-um@lists.infradead.org; Tue, 18 Jan 2022 14:20:21 +0000
Date: Tue, 18 Jan 2022 15:20:13 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH 2/2] um: Add devicetree support
Message-ID: <20220118142013.GA556@axis.com>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
 <20211208151123.29313-3-vincent.whitchurch@axis.com>
 <YeF/Vbxo6fAt0WLp@robh.at.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YeF/Vbxo6fAt0WLp@robh.at.kernel.org>
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
To: Rob Herring <robh@kernel.org>
Cc: "jdike@addtoit.com" <jdike@addtoit.com>, "richard@nod.at" <richard@nod.at>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>, kernel <kernel@axis.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Jan 14, 2022 at 02:49:09PM +0100, Rob Herring wrote:
> On Wed, Dec 08, 2021 at 04:11:23PM +0100, Vincent Whitchurch wrote:
> > --- /dev/null
> > +++ b/arch/um/kernel/dtb.c
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/init.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/printk.h>
> > +#include <linux/memblock.h>
> > +#include <init.h>
> > +
> > +#include "um_arch.h"
> > +
> > +static char *dtb __initdata;
> > +
> > +void uml_dtb_init(void)
> > +{
> > +	long long size;
> > +	void *area;
> > +
> > +	area = uml_load_file(dtb, &size);
> > +	if (!area)
> > +		return;
> > +
> > +	if (!early_init_dt_scan(area)) {
> > +		pr_err("invalid DTB %s\n", dtb);
> > +		memblock_free(area, size);
> > +		return;
> > +	}
> > +
> > +	unflatten_device_tree();
> > +	early_init_fdt_scan_reserved_mem();
> 
> These should be reversed. early_init_fdt_scan_reserved_mem() works on 
> the flat tree. Reserved memory needs to be reserved before 
> unflatten_device_tree() starts allocating memory. Though I imagine that 
> doesn't really matter for UML.

I only tested dynamic allocation of reserved memory, and that,
unsuprisingly, works regardless of the order.  But I'll send a patch to
change it.

> Also, does the dtb end up in permanently allocated memory (i.e. not 
> init)? It needs to be if not.

The dtb is allocated with memblock_alloc() in arch/um/kernel/load_file.c
and is never freed (except on an error from early_init_dt_scan() as in
the above hunk), so I think this is already taken care of.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

