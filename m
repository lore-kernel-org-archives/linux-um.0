Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JeOqC-0002Gh-Rf for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Mar 2008 23:10:28 -0700
Received: from srv5.dvmed.net ([207.36.208.214] helo=mail.dvmed.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JeOqB-00060Z-GZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Mar 2008 23:10:28 -0700
Message-ID: <47E9E8CD.1060408@garzik.org>
Date: Wed, 26 Mar 2008 02:10:21 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
References: <47E9E331.1010105@trash.net>
In-Reply-To: <47E9E331.1010105@trash.net>
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
To: Patrick McHardy <kaber@trash.net>
Cc: Linux Netdev List <netdev@vger.kernel.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

>  static void uml_net_set_multicast_list(struct net_device *dev)
>  {
> -	if (dev->flags & IFF_PROMISC)
> -		return;
> -	else if (dev->mc_count)
> -		dev->flags |= IFF_ALLMULTI;
> -	else dev->flags &= ~IFF_ALLMULTI;
> +	return;
>  }



Might as well just delete the hook at that point...

	Jeff



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
