Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BysIY-0004Fv-Th for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Aug 2004 06:22:14 -0700
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BysIX-0003o8-UM for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Aug 2004 06:22:15 -0700
From: Werner Almesberger <wa@almesberger.net>
Subject: Re: [uml-devel] Re: [ann] kraxel's 2.6.8 uml patch kit
Message-ID: <20040822102202.A6143@almesberger.net>
References: <20040820122445.GA21790@bytesex>
	<200408201901.i7KJ1eIF003843@ccure.user-mode-linux.org>
	<Pine.GSO.4.58.0408202303460.16715@waterleaf.sonytel.be>
	<20040821192842.GC27073@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821192842.GC27073@bytesex>;
	from kraxel@bytesex.org on Sat, Aug 21, 2004 at 09:28:43PM +0200
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
Date: Sun, 22 Aug 2004 10:22:02 -0300
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

Gerd Knorr wrote:
> And I don't want to change that as having printk work early is a cool
> debugging feature.

Yeah ! I had a quick look at the code, and it seems that you
could still occasionally lose printk data in non-catastrophic
situations, e.g. when writing to a pipe. I've made a (less nice)
patch a while ago that doesn't loses data unless it really
really has to:

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=108093851702249&w=2

BTW, do the console changes also remove the requirement that
stdin must be a tty, e.g. so that one could do
./linux </dev/null  and that UML doesn't alter terminal
settings ? (I've just worked around the latter problem in
umlsim, but it's rather messy.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
