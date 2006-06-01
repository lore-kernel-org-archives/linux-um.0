Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlilA-0005ZV-IX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2006 01:42:28 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Flil6-0008D9-Pg
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2006 01:42:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Randomize on MAC address when bringing up ethernet
	iface
References: <200605302013.00091.blaisorblade@yahoo.it>
	<20060531190553.GA6111@ccure.user-mode-linux.org>
In-Reply-To: <20060531190553.GA6111@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011040.53547.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 1 Jun 2006 10:40:53 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 31 May 2006 21:05, Jeff Dike wrote:
> On Tue, May 30, 2006 at 08:12:59PM +0200, Blaisorblade wrote:
> > I've being thinking to this and I'm wondering why we shouldn't do it.
> > When we have set no IP or 0.0.0.0, which is not a unique IP, and we bring
> > it up, we should choose a random MAC to use.
> > Conditions: the broadcast bit must be 0 and the "locally-assigned address
> > flag" must be 1 (as likely we already do).

> Yeah, this sounds like a good idea.

> > For which bits they are, I've a doubt.
> > On Tanenbaum's book they're marked as the two most significant (leftmost)
> > bits (broadcast being the most significant one), but since we've longly
> > known the broadcast bit is the lowest-order one of the highest bit, I
> > suspect that MACs are read in little-endian bit order (which likely
> > implies the same for the whole packets). I can't verify this, but bytes
> > in many fields are moved to be in network order i.e. big-endian order
> > (MACs are always used in the network order).

> So what is the second bit?  I only know about the broadcast/multicast bit,
> and no one has bothered clueing me in on any other special bits :-)

Look at the other answer (which points to include/linux/etherdevice.h: 
random_ether_addr()) for the bit position - the code pointed out shows that 
indeed bit are reversed from the "text-book order".
For the "locally assigned", I guess that means we'll never conflict with a MAC 
set on some NIC.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
