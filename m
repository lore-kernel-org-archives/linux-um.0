Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlW0g-0001iK-9a for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 12:05:38 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlW0g-0000m3-6a for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 12:05:38 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FlW0d-0004Ee-DY
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 12:05:38 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Randomize on MAC address when bringing up ethernet
	iface
Message-ID: <20060531190553.GA6111@ccure.user-mode-linux.org>
References: <200605302013.00091.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605302013.00091.blaisorblade@yahoo.it>
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
Date: Wed, 31 May 2006 15:05:53 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, May 30, 2006 at 08:12:59PM +0200, Blaisorblade wrote:
> I've being thinking to this and I'm wondering why we shouldn't do it. When we
> have set no IP or 0.0.0.0, which is not a unique IP, and we bring it up, we 
> should choose a random MAC to use.
> Conditions: the broadcast bit must be 0 and the "locally-assigned address 
> flag" must be 1 (as likely we already do).

Yeah, this sounds like a good idea.

> For which bits they are, I've a doubt.
> On Tanenbaum's book they're marked as the two most significant (leftmost) bits
> (broadcast being the most significant one), but since we've longly known the 
> broadcast bit is the lowest-order one of the highest bit, I suspect that MACs
> are read in little-endian bit order (which likely implies the same for the 
> whole packets). I can't verify this, but bytes in many fields are moved to be
> in network order i.e. big-endian order (MACs are always used in the network 
> order).

So what is the second bit?  I only know about the broadcast/multicast bit, and
no one has bothered clueing me in on any other special bits :-)

				Jeff


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
