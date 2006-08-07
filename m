Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GADMV-0004jQ-6F for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Aug 2006 15:14:15 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GADMU-0002Ul-Kb
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Aug 2006 15:14:15 -0700
Date: Mon, 7 Aug 2006 18:14:00 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060807221400.GC5890@ccure.user-mode-linux.org>
References: <20060806154700.536.32978.stgit@memento.home.lan>
	<20060806154703.536.80128.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060806154703.536.80128.stgit@memento.home.lan>
Subject: Re: [uml-devel] [PATCH 2/3] uml: fix proc-vs-interrupt context
	spinlock deadlock
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Aug 06, 2006 at 05:47:03PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> This spinlock can be taken on interrupt too, so spin_lock_irq[save] must be used.
> 
> However, Documentation/networking/netdevices.txt explains we are called with
> rtnl_lock() held - so we don't need to care about other concurrent opens.
> Verified also in LDD3 and by direct checking. Also verified that the network
> layer (through a state machine) guarantees us that nobody will close the
> interface while it's being used. Please correct me if I'm wrong.
> 
> Also, we must check we don't sleep with irqs disabled!!! But anyway, this is not
> news - we already can't sleep while holding a spinlock. Who says this is
> guaranted really by the present code?

This patch looks fairly scary.  It's protecting the device private
data, you're removing the locking from some accesses and leaving it
(albeit with irqs off now) on others.  It seems to me that can't be
right.  It's either always there, or always not.

You observe that open and close are protected by rtnl_lock.  I observe
that uml_net_change_mtu and uml_net_set_mac are as well, in dev_ioctl.

The spinlock protecting this has to be _irqsave because the interrupt
routine takes it, to protect against receiving packets on an interface
that's being closed.  If that's impossible, we should prove that, and
remove the locking from uml_net_interrupt.

I can't decide about uml_net_start_xmit - there's some RCU stuff
around one call that leads to it, but I don't see any sign of
rtnl_lock.

So, I'd say there are some changes needed here, but they're not
entirely the ones in this patch.

				Jeff

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
