Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1P0h5M-000832-MS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 20:47:36 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P0h5L-0006zA-Du
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 20:47:36 +0000
Date: Tue, 28 Sep 2010 13:47:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20100928134721.f79a5955.akpm@linux-foundation.org>
In-Reply-To: <AANLkTim85sH_2o=xCiDuoQrHq_7ZL96Y91xQMGxUP5Fy@mail.gmail.com>
References: <4CA09977.80506@panasas.com>
	<AANLkTim85sH_2o=xCiDuoQrHq_7ZL96Y91xQMGxUP5Fy@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] {painfully BISECTED} Please revert f25c80a4b2:
 arch/um/drivers: remove duplicate structure field initialization
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>

On Tue, 28 Sep 2010 13:24:40 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Ping, no comments?
> 
> On Mon, Sep 27, 2010 at 6:17 AM, Boaz Harrosh <bharrosh@panasas.com> wrote:
> >
> > [bharrosh@fs2 ~/dev/git/pub/scsi-misc] 1115$ git bisect good
> > f25c80a4b2bf93c99820f470573626557db35202 is the first bad commit
> > commit f25c80a4b2bf93c99820f470573626557db35202
> 
> It looks like that commit is indeed very misleading. The commit message says:
> 
>   "arch/um/drivers: remove duplicate structure field initialization"
> 
> but it is in fact not duplicate: there's two field initializations,
> but they are _different_. Looking at the patch, it has:
> 
>         .ndo_set_mac_address    = uml_net_set_mac,
> -       .ndo_set_mac_address    = eth_mac_addr,
> 
> so it removes the later one, but it is not at all clear which one the
> compiler actually used. My guess is that it used to use the later one
> (the standard eth_mac_addr function), and the patch made it suddenly
> use the uml_net_set_mac function.
> 
> I didn't check what gcc used to do, but this:
> 
> > The patch Reverts cleanly on top of 2.6.36-rc5 and after Revert works perfectly as
> > before.
> 
> makes me suspect that nobody else checked it either.

I checked! gcc uses the second initialiser.

uml_net_set_mac() is:

static int uml_net_set_mac(struct net_device *dev, void *addr)
{
	struct uml_net_private *lp = netdev_priv(dev);
	struct sockaddr *hwaddr = addr;

	spin_lock_irq(&lp->lock);
	eth_mac_addr(dev, hwaddr->sa_data);
	spin_unlock_irq(&lp->lock);

	return 0;
}

And I misread that, assuming that it's just a wrapper around
eth_mac_addr().  Only it isn't, because it passes eth_mac_addr() the
MAC address's address directly (with ->sa_data).  But eth_mac_addr()
expects a `struct sockaddr *'.

And for some wtf reason, eth_mac_addr() passes that `struct
sockaddr *' in a `void *', thus cunningly hiding the bug.

Yeah, please revert it.


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

