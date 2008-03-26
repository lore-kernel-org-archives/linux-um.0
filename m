Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JePsO-0000Cn-4Y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Mar 2008 00:16:48 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JePsN-0005IL-Si
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Mar 2008 00:16:48 -0700
Date: Wed, 26 Mar 2008 00:16:47 -0700 (PDT)
Message-Id: <20080326.001647.97478240.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <47E9E99F.5080003@trash.net>
References: <47E9E331.1010105@trash.net> <47E9E8CD.1060408@garzik.org>
	<47E9E99F.5080003@trash.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] [UML]: uml-net: don't set IFF_ALLMULTI in
	set_multicast_list
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
To: kaber@trash.net
Cc: netdev@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, jeff@garzik.org

From: Patrick McHardy <kaber@trash.net>
Date: Wed, 26 Mar 2008 07:13:51 +0100

> Jeff Garzik wrote:
> >>  static void uml_net_set_multicast_list(struct net_device *dev)
> >>  {
> >> -    if (dev->flags & IFF_PROMISC)
> >> -        return;
> >> -    else if (dev->mc_count)
> >> -        dev->flags |= IFF_ALLMULTI;
> >> -    else dev->flags &= ~IFF_ALLMULTI;
> >> +    return;
> >>  }
> > 
> > 
> > 
> > Might as well just delete the hook at that point...
> 
> 
> I kept it so SIOCADDMULTI/SIOCDELMULTI ioctls continue to
> work on UML devices. I don't know if any userspace applications
> check for errors when using these ioctls, this way nothing
> can break.

Good idea, patch applied to net-2.6, thanks!

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
