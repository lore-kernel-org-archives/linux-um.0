Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ib3B8-0005NB-NH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 16:53:58 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ib3B8-0007aC-Fr
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 16:53:58 -0700
Date: Thu, 27 Sep 2007 16:53:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070927165340.fd5dc2d0.akpm@linux-foundation.org>
In-Reply-To: <20070927170126.GA6542@c2.user-mode-linux.org>
References: <20070927170126.GA6542@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] UML - Correctly handle skb allocation failures
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, 27 Sep 2007 13:01:26 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> +static int update_drop_skb(int max)
> +{
> +	struct sk_buff *new;
> +	int err = 0;
> +
> +	spin_lock(&drop_lock);
> +
> +	if (max <= drop_max)
> +		goto out;
> +
> +	err = -ENOMEM;
> +	new = dev_alloc_skb(max);
> +	if (new == NULL)
> +		goto out;
> +
> +	skb_put(new, max);
> +
> +	kfree_skb(drop_skb);
> +	drop_skb = new;
> +	drop_max = max;
> +	err = 0;
> +out:
> +	spin_unlock(&drop_lock);
> +
> +	return err;
> +}
> +
>  static int uml_net_rx(struct net_device *dev)
>  {
>  	struct uml_net_private *lp = dev->priv;
> @@ -43,6 +82,9 @@ static int uml_net_rx(struct net_device 
>  	/* If we can't allocate memory, try again next round. */
>  	skb = dev_alloc_skb(lp->max_packet);
>  	if (skb == NULL) {
> +		drop_skb->dev = dev;
> +		/* Read a packet into drop_skb and don't do anything with it. */
> +		(*lp->read)(lp->fd, drop_skb, lp);
>  		lp->stats.rx_dropped++;
>  		return 0;

Still wanna know why it is safe for uml_net_rx to be playing with
drop_skb when update_drop_skb() could be concurrently reallocating
and freeing it.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
