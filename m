Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2xRR-0001cu-Sq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 11:08:01 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B2xRR-0006fF-2d
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 11:08:01 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] /dev/random oddity
Message-ID: <20040315194114.GE23741@ccure.user-mode-linux.org>
References: <20040313014957.GB13419@speedy.schwinge.homeip.net>
	<405309FE.6020603@darkman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405309FE.6020603@darkman.de>
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
Date: Mon, 15 Mar 2004 14:41:14 -0500
To: Sven 'Darkman' Michels <sven@darkman.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 13, 2004 at 02:17:50PM +0100, Sven 'Darkman' Michels wrote:
> never is wrong, you can 'fill' the pool by doing some work like find /
> ps aux etc, but this is really slow in filling up the pool. Maybe
> other things should be used to fill the pool, too. Jeff? Blaisor?
> anyone? ;)

That doesn't fill the random pool directly.  What it does do is cause disk
IO, and the ubd driver will refill the random pool.  It's a bit heavy-weight
for generating randomness, and I don't really like it anyway.  See my other
reply in this thread.

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
