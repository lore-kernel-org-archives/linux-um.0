Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BzCsb-0001k8-FN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Aug 2004 04:20:49 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BzCsa-0008V5-Sr
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Aug 2004 04:20:49 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: [ann] kraxel's 2.6.8 uml patch kit
Message-ID: <20040823110618.GB21468@bytesex>
References: <20040820122445.GA21790@bytesex>
	<200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
	<Pine.GSO.4.58.0408202303460.16715@waterleaf.sonytel.be>
	<20040821192842.GC27073@bytesex>
	<20040822102202.A6143@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040822102202.A6143@almesberger.net>
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
Date: Mon, 23 Aug 2004 13:06:18 +0200
To: Werner Almesberger <wa@almesberger.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

> BTW, do the console changes also remove the requirement that
> stdin must be a tty, e.g. so that one could do
> ./linux </dev/null  and that UML doesn't alter terminal
> settings ? (I've just worked around the latter problem in
> umlsim, but it's rather messy.)

I think so, but havn't actually tried.  I usually use the host terminal
as serial console for the uml machine (i.e. "ssl0=fd:0,fd:1 console=ttyS0").

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
