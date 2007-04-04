Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYz5k-0005kX-Bs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 23:35:43 -0700
Received: from assei2bl6.telenet-ops.be ([195.130.133.69])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HYz5i-0005XN-O7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 23:35:36 -0700
Date: Wed, 4 Apr 2007 08:35:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <4612E802.7000302@nagafix.co.uk>
Message-ID: <Pine.LNX.4.64.0704040834450.20803@anakin>
References: <1712880100@web.de> <200704012108.14597.blaisorblade@yahoo.it>
	<46100EF5.7040802@nagafix.co.uk>
	<20070402020530.GA589@c2.user-mode-linux.org>
	<4610D937.20002@nagafix.co.uk>
	<Pine.LNX.4.64.0704021318410.1276@anakin>
	<20070402145300.GA6179@c2.user-mode-linux.org>
	<461124A9.7080609@nagafix.co.uk> <4612E802.7000302@nagafix.co.uk>
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
Cc: devzero@web.de, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, kraxel@suse.de, Blaisorblade <blaisorblade@yahoo.it>

On Wed, 4 Apr 2007, Antoine Martin wrote:
> and this one:
> http://www.suse.de/~kraxel/uml/patches/2.6.18-rc4/uml-x11-fb
> which applied cleanly, but is not letting me set the option - Kconfig is
> beyond me:
> 
> arch/um/Kconfig:144:warning: 'select' used by config symbol 'X11_FB' refer to
> undefined symbol 'FB_CFB_FILLRECT'
> arch/um/Kconfig:145:warning: 'select' used by config symbol 'X11_FB' refer to
> undefined symbol 'FB_CFB_COPYAREA'
> arch/um/Kconfig:146:warning: 'select' used by config symbol 'X11_FB' refer to
> undefined symbol 'FB_CFB_IMAGEBLIT'

Try adding

    source "drivers/video/Kconfig"

to arch/um/Kconfig.

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
