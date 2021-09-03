Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mM4R4-00BF0F-T9
 for linux-um@lists.infradead.org; Fri, 03 Sep 2021 08:20:32 +0000
Message-ID: <93705335a3e6dcdb56de601df566445aa5bcb28e.camel@sipsolutions.net>
Subject: Re: [PATCH -next] um: virt-pci: Fix the application of sizeof to
 pointer
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 03 Sep 2021 10:20:13 +0200
In-Reply-To: <1630655468-71684-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1630655468-71684-1-git-send-email-yang.lee@linux.alibaba.com>
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
To: Yang Li <yang.lee@linux.alibaba.com>, jdike@addtoit.com
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, 2021-09-03 at 15:51 +0800, Yang Li wrote:
> sizeof() when applied to a pointer typed expression gives the size of
> the pointer.
> 
> Clean up coccicheck warning:
> ./arch/um/drivers/virt-pci.c:192:20-26: ERROR: application of sizeof to
> pointer
> 

> -	memset(data, 0xff, sizeof(data));
> +	memset(data, 0xff, sizeof(*data));

Oops. I guess I only tested on 64-bit where this is the same, and in
fact on 32-bit it also wouldn't matter since you can't even do 64-bit
reads there :)

A Fixes: tag would be nice, but otherwise

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

