Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9oho-0004t0-6w for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 10:17:48 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D9ohm-0007ce-Jz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 10:17:48 -0800
Message-Id: <200503111845.j2BIjkJp003341@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator 
In-Reply-To: Your message of "Thu, 10 Mar 2005 13:41:37 EST."
	<200503101341.37346.rob@landley.net> 
References: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>
	<200503101341.37346.rob@landley.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 11 Mar 2005 13:45:46 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org

rob@landley.net said:
> I'm just thinking about those UML hosting farms, with several UML
> instances  per machine, on machines which haven't got a keyboard
> attached constantly  feeding entropy into the pool.  If just ONE of
> them is serving ssl  connections from its own /dev/urandom, that would
> drain the /dev/random  entropy pool on the host machine almost
> immediately... 

All true (except for that last reference to urandom), but also irrelevant to
whether UML's hwrng should be hooked up to the host's /dev/random or not.

As far as I can see, the only thing that matters is that hwrng should produce
real randomness, and that can only be had by reading /dev/random (or maybe
the host's /dev/hwrng, but that's supposed to be fed into /dev/random anyway).

So, hooking up the UML /dev/hwrng to the host's /dev/urandom would be lying.

If the host's entropy pool gets drained as a result, I would say that's an
application bug, and not a reason for UML to get its randomness from the
host's /dev/urandom.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
