Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxY0G-0002iX-Pj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 14:29:52 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BxY0E-0005am-GL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 14:29:52 -0700
Message-Id: <200408182231.i7IMVJek003283@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] debug 2.6.7 
In-Reply-To: Your message of "Wed, 18 Aug 2004 14:46:17 +0200."
	<41234F99.6020208@exse.net> 
References: <41234F99.6020208@exse.net> 
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
Date: Wed, 18 Aug 2004 18:31:19 -0400
To: seb <seb@exse.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

seb@exse.net said:
> vhost login: Out of Memory: Killed process 3773 (xmlhandler.fcpl).
> Kernel panic: Kernel mode fault at addr 0x5be8c750, ip 0x40325b88
> In interrupt handler - not syncing 

It looks like you already had it running under gdb.  Just put a breakpoint
on panic ahead of time, and get a backtrace when you hit it.

				Jeff



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
