Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvKqD-0005EQ-88 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Feb 2004 10:30:05 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AvKX0-0007Hd-Pu
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Feb 2004 10:10:15 -0800
Message-Id: <200402231851.i1NIp2mX024424@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: Fwd: [uml-user] Host 2.6.2/3 + CFQ + BlaisorBlade
	patches == host panic 
In-Reply-To: Your message of "Mon, 23 Feb 2004 09:38:01 +0100."
	<20040223083801.GA28222@elte.hu> 
References: <200402221604.19495.blaisorblade_spam@yahoo.it>
	<20040223083801.GA28222@elte.hu> 
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
Date: Mon, 23 Feb 2004 13:51:02 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

mingo@elte.hu said:
> is UML SMP-ready? There seem to be a handful of data structures that
> should be per-CPU for correctness. (eg. userspace_pid?) 

The tt mode side of the house is.  skas isn't, quite, for the reasons you
mention.

However, this was SMP on the host, not SMP support inside UML.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
