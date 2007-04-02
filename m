Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYKbw-00032Z-24 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 04:22:08 -0700
Received: from astra.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HYKbu-00056H-6r
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2007 04:22:07 -0700
Date: Mon, 2 Apr 2007 13:22:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <4610D937.20002@nagafix.co.uk>
Message-ID: <Pine.LNX.4.64.0704021318410.1276@anakin>
References: <1712880100@web.de> <200704012108.14597.blaisorblade@yahoo.it>
	<46100EF5.7040802@nagafix.co.uk>
	<20070402020530.GA589@c2.user-mode-linux.org>
	<4610D937.20002@nagafix.co.uk>
MIME-Version: 1.0
Subject: Re: [uml-devel] [RFC] UML kernel & rootfs bundle with every kernel
	release ?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, devzero@web.de

On Mon, 2 Apr 2007, Antoine Martin wrote:
> Jeff Dike wrote:
> > On Sun, Apr 01, 2007 at 08:58:45PM +0100, Antoine Martin wrote:
> >> I reckon that one critical thing which could drastically increase the 
> >> user base would be to have a working virtual framebuffer implementation.
> > 
> > Why?  I've never understood what a framebuffer gives you that you
> > don't have now.
> Just like the network auto-configuration via dhcp, it would allow users 
> to download images+kernel and run them like appliances without 
> understanding anything about X or UML, just click and run.
> We are all capable of setting up Xvfb here, but most users are not, 
> which is why they download ready-made images.
> It would also make it a lot easier to focus on writing a management UI, 
> hell if there isn't one shortly after, I'll do one myself!
> Think of a UML browser image (running IE via wine in a limited image 
> with just X + wine + IE - I would much prefer that to having wine+IE 
> installed locally), testing framebuffer apps like gtk-fb/cairo-fb 
> without risking your dev environment, etc...

There are patches floating around for a UML frame buffer device.
Gerd Kraxel^H^H^H^H^H^HHoffmann did one using plain X11, which worked
great when I gave it a try.

A few years ago I tried doing one myself using gdk/gtk, but it didn't
work reliably on all systems. My main motivation was doing development for
different frame buffer memory organizations (think Amiga and Atari bitplanes)
on UML.

I suggest taking a look at Gerd's patches. IIRC, he posted them to lkml
last year.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
