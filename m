Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2xNT-0000A1-Ev for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 11:03:55 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B2xNS-0004z1-CE
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 11:03:54 -0800
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id
	i2FJb8Zl024133 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 Mar 2004 14:37:08 -0500
Received: (from jdike@localhost)
	by ccure.user-mode-linux.org (8.12.5/8.12.5/Submit) id i2FJb8uZ024131
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 14:37:08 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] /dev/random oddity
Message-ID: <20040315193708.GD23741@ccure.user-mode-linux.org>
References: <20040313014957.GB13419@speedy.schwinge.homeip.net>
	<405309FE.6020603@darkman.de> <405324DB.3030404@lig.net>
	<20040314224008.GY28592@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314224008.GY28592@alcor.net>
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
Date: Mon, 15 Mar 2004 14:37:08 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Sun, Mar 14, 2004 at 02:40:08PM -0800, Matt Zimmerman wrote:
> If the host has a steady supply of randomness from any source, then UML
> should be able to simply read from /dev/random on the host.

That could be done. it would require replacing the generic /dev/random with
a UML one, and I don't know whether the kernel build makes that easy.

Another alternative is to add an mconsole interface to dump randomness into
a UML when it starts running out.

The current UML practice of feeding /dev/random from the drivers is a bit
suspect.  The randomness obtained there is related to the host randomness,
but the host random pool isn't depleted accordingly.  

I think the right solution is to feed UML /dev/random from the host /dev/random
somehow.

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
