Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1xdK-0005kA-ND for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 17:08:10 -0800
Received: from postman4.arcor-online.net ([151.189.0.154]
	helo=postman.arcor.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B1xdJ-0000qE-Ax
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Mar 2004 17:08:09 -0800
Received: from server.schwinge.homeip.net (dialin-212-144-135-153.arcor-ip.net
	[212.144.135.153]) (authenticated bits=0)
	by postman.arcor.de (8.13.0.PreAlpha4/8.13.0.PreAlpha4) with ESMTP id
	i2D183D1015805 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 13 Mar 2004 02:08:04 +0100 (MET)
From: Thomas Schwinge
	<schwinge-lists-sourceforge.net-user-mode-linux-devel@nic-nac-project.de>
Subject: Re: [uml-devel] UML crashing-the known scheduler bug
Message-ID: <20040313010000.GA13419@speedy.schwinge.homeip.net>
References: <20040311185105.GA22820@speedy.schwinge.homeip.net>
	<200403112056.08200.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403112056.08200.blaisorblade_spam@yahoo.it>
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
Date: Sat, 13 Mar 2004 02:00:00 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Mar 11, 2004 at 08:55:46PM +0100, BlaisorBlade wrote:
> I've given a look to the problem and I think that it has already been 
> discussed and that fixes were posted and included in next UML patch (not yet 
> released).

OK. Using linux-2.6.4 with uml-patch-2.6.4-1 solved this problem.
I should have waited just one day... :-)

> Also, UML for now does not work well in SMP mode (and it does not actually 
> parallelize the work): the spinlock messages at the beginning suggest you are 
> using it.

I'm not using SMP mode, but these messages also disappeared with 2.6.4.

> If you have a SMP host, use for the host the SKAS patch found at: 
> 
> http://www.user-mode-linux.org/~blaisorblade
> 
> since it has a critical fix for SMP mode.

Are there any other differences between your SKAS mode patch and
<URL:http://www.metaparadigm.com/~mclark/uml/uml-2.6.3-skas-1.patch>?


Regards,
 Thomas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
