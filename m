Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bybis-0001wy-3z for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Aug 2004 12:40:18 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1Bybir-00044a-DG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Aug 2004 12:40:18 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: [ann] kraxel's 2.6.8 uml patch kit
Message-ID: <20040821192842.GC27073@bytesex>
References: <20040820122445.GA21790@bytesex>
	<200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
	<Pine.GSO.4.58.0408202303460.16715@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0408202303460.16715@waterleaf.sonytel.be>
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
Date: Sat, 21 Aug 2004 21:28:43 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Aug 20, 2004 at 11:05:56PM +0200, Geert Uytterhoeven wrote:
> On Fri, 20 Aug 2004, Jeff Dike wrote:
> > I like this one, but it's big and I'm going to have to take a good look at it.
> > I'm somewhat unhappy about the command line change, where you need to specify
> > a console or UML doesn't boot.  That'll break everyone's scripts.  Is it
> > possible to provide a default console if there isn't one on the command line?
> 
> IIRC, the default console is the one that gets registered first.

Yes.

> So by reordering the code (in source files) and/or objects (in
> Makefiles) you can make sure the correct one is the default.

No.  The stderr console is registered _much_ earlier in the boot process
than the stdio console.  And I don't want to change that as having
printk work early is a cool debugging feature.  The stdio_console can't
be registered that early as it needs -- unlike stderr console -- several
kernel subsystems being initialized already.

> BTW, what do you think of putting the stderr console in its own source file
> with its own CONFIG_* option?

Thats IMHO a good idea in any case as one can turn on/off stderr console
and stdio console independant of each other.  That simplifies things for
both backward compatibility (make the kernel with stderr console
disabled behave like older versions should be easy, even without dirty
tricks like silently appending console=tty0) and fbcon (disable
stdio_console to get it out of the way but have stderr console for
printk-debugging it).

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
