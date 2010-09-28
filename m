Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <viro@ftp.linux.org.uk>) id 1P0hf4-0001ft-43
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 21:24:30 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P0hf2-0001u4-Kk
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 21:24:30 +0000
Date: Tue, 28 Sep 2010 22:24:17 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20100928212417.GF19804@ZenIV.linux.org.uk>
References: <4CA09977.80506@panasas.com>
	<AANLkTim85sH_2o=xCiDuoQrHq_7ZL96Y91xQMGxUP5Fy@mail.gmail.com>
	<20100928211106.GE19804@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100928211106.GE19804@ZenIV.linux.org.uk>
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
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Stephen Hemminger <shemminger@vyatta.com>, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

On Tue, Sep 28, 2010 at 10:11:06PM +0100, Al Viro wrote:

> IOW, it _must_ use the last one in such cases.
> 
> As for the driver, I smell an interface change (in eth_mac_addr() arguments)
> that has been missed...  FWIW, grep through the tree shows one more instance
> of eth_mac_addr() called with such argument and it's also in net_kern.c; there
> we simply want memcpy() instead, since device is definitely not running at
> that point and we'd done the validity checks earlier.
> 
> Not sure if we need lp->lock around that eth_mac_addr() call - not familiar
> with the driver in question.  If we don't, we should switch to eth_mac_addr
> for the method, indeed...

FWIW, after looking at that code... I don't think we need lp->lock there,
but I really wonder if we need to update lp->mac as well, or, perhaps simply
remove it completely.  Who maintains these drivers?  It's not just
net_kern/net_user; there's a bunch of subdrivers for that sucker...

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

