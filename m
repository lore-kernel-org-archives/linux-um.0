Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1752047AbZIUQBq@vger.kernel.org>
Date: Tue, 22 Sep 2009 00:05:32 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 5/5] arch/um: remove duplicate structure field
	initialization
Message-ID: <20090921160532.GC3868@hack>
References: <Pine.LNX.4.64.0909192149250.27171@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0909192149250.27171@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: jdike@addtoit.com, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Sep 19, 2009 at 09:49:47PM +0200, Julia Lawall wrote:
>From: Julia Lawall <julia@diku.dk>
>
>The definition of uml_netdev_ops has initializations of a local function
>and eth_mac_addr for its ndo_set_mac_address field.  This change uses only
>the local function.
>
>The semantic match that finds this problem is as follows:
>(http://coccinelle.lip6.fr/)
>
>// <smpl>
>@r@
>identifier I, s, fld;
>position p0,p;
>expression E;
>@@
>
>struct I s =@p0 { ... .fld@p = E, ...};
>
>@s@
>identifier I, s, r.fld;
>position r.p0,p;
>expression E;
>@@
>
>struct I s =@p0 { ... .fld@p = E, ...};
>
>@script:python@
>p0 << r.p0;
>fld << r.fld;
>ps << s.p;
>pr << r.p;
>@@
>
>if int(ps[0].line)!=int(pr[0].line) or int(ps[0].column)!=int(pr[0].column):
>  cocci.print_main(fld,p0)
>// </smpl>


Hmm, C99 said:
"
The initialization shall occur in initializer list order, each
initializer provided for a particular subobject overriding any
previously listed initializer for the same subobject [...]
"

I am wondering why gcc doesn't (can't?) complain about this?

>
>Signed-off-by: Julia Lawall <julia@diku.dk>
>

Acked-by: WANG Cong <xiyou.wangcong@gmail.com>

>---
> arch/um/drivers/net_kern.c          |    1 -
> 1 files changed, 0 insertions(+), 1 deletions(-)
>
>diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
>index a74245a..d17a623 100644
>--- a/arch/um/drivers/net_kern.c
>+++ b/arch/um/drivers/net_kern.c
>@@ -379,7 +379,6 @@ static const struct net_device_ops uml_netdev_ops = {
> 	.ndo_tx_timeout 	= uml_net_tx_timeout,
> 	.ndo_set_mac_address	= uml_net_set_mac,
> 	.ndo_change_mtu 	= uml_net_change_mtu,
>-	.ndo_set_mac_address 	= eth_mac_addr,
> 	.ndo_validate_addr	= eth_validate_addr,
> };
> 
>--
>To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Live like a child, think like the god.
 
