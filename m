Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtZ1O-00074L-VE
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 13:14:18 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AtYwW-0004qx-6Y
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 13:09:16 -0800
Message-Id: <200402182137.i1ILbOMM008506@ccure.user-mode-linux.org>
Subject: Re: 2.6.3-rc2 failure - was: Re: [uml-devel] Kernel idles in loop after loading IPv4 
In-Reply-To: Your message of "Wed, 18 Feb 2004 20:01:44 +0100."
             <200402182001.44243.blaisorblade_spam@yahoo.it> 
References: <1bf401c3f3eb$c35704f0$2000000a@schlepptopp> <200402152045.17138.blaisorblade_spam@yahoo.it> <20d501c3f5c1$ef1d3d70$2000000a@schlepptopp>  <200402182001.44243.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 18 Feb 2004 16:37:24 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, roland <for_spam@gmx.de>

blaisorblade_spam@yahoo.it said:
> If I guessed right, the attached patch will solve everything.
> Jeff, do you think this makes sense? 

Yes, it makes all kinds of sense, and looks very similar to the fix I posted
a couple of days ago.

Nice debugging, though.  This was somewhat subtle.

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
