Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B0S9O-0004I2-TM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Mar 2004 13:19:02 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B0RW1-00005E-I7
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Mar 2004 12:38:21 -0800
Message-Id: <200403082133.i28LXgVa022876@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] More security questions (was: Module exploits into
	the host?) 
In-Reply-To: Your message of "Wed, 03 Mar 2004 23:14:01 GMT."
	<20040303231401.GM14069@localhost.localdomain> 
References: <20040303200937.GK14069@localhost.localdomain>
	<Pine.LNX.4.44.0403032227040.17693-100000@filer.marasystems.com>
	<20040303231401.GM14069@localhost.localdomain> 
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
Date: Mon, 08 Mar 2004 16:33:42 -0500
To: Robin Green <greenrd@greenrd.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

greenrd@greenrd.org said:
> 1. Has the lcall vulnerability been fixed? By a change in the mainline
> kernel?

No.  It's easy enough to do - I just haven't got around to it yet.

> 2. I read on some mailing list (not this one) that in tt mode,
> processes within a UML instance can read and write to each other's
> memory!

Yes, they can do that through the UML kernel memory, which is mapped writeable
into each process.

This is impossible in skas mode.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
