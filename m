Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXI5w-0002fg-C9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 04:15:12 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BXI5v-00072k-Eo
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 04:15:11 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXOps-00018K-KF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 11:27:04 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] [2.6 patch] terminal/console cleanups
In-Reply-To: <20040607090328.GA20535@bytesex.org>
Message-ID: <Pine.GSO.4.58.0406071311230.18235@waterleaf.sonytel.be>
References: <20040528135816.GA27837@bytesex.org>
	<Pine.GSO.4.58.0406061918460.5793@waterleaf.sonytel.be>
	<20040607090328.GA20535@bytesex.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 7 Jun 2004 13:13:56 +0200 (MEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, 7 Jun 2004, Gerd Knorr wrote:
> On Sun, Jun 06, 2004 at 07:20:36PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 28 May 2004, Gerd Knorr wrote:
> > > This is a major cleanup of the uml terminal drivers and console handling
> > > (console as in "where the kernel messages go to", not as in "linux
> > > virtual consoles).  The changes in detail:
> >
> > Nice! Does this also mean the UML console no longer interferes with the normal
> > virtual console subsystem? Before it was not possible to enable CONFIG_VT
> > without some serious surgery to the UML vc subsystem, because both tried to
> > attach to the same device number.
>
> No, that hasn't changed.  Guess you are asking because of the uml
> virtual framebuffer driver, where you want run fbcon on top of?

Indeed.

> I'm not sure how to deal with that best.
>
> Right now in UML /dev/tty[0-8] are simple terminal lines.  /dev/tty0
> hasn't the special meaning of "current foreground console" as there are
> simply no virtual consoles.  It is possible to use screen to build a
> virtual-console like setup in a pure text-based environment, which works
> pretty good.

Wouldn't it be more logical to have a separate type of device for UML virtual
consoles using xterms?

> It likely would also be possible to use CONFIG_VT and create a
> CONFIG_VT_UMLCON driver instead.  Havn't looked at that.  I hope going
> that route doesn't mean we'll have to implement something like screen
> inside the uml kernel ...

Indeed.

> By moving the stderr console code to another source file it should at
> least be possible to make the uml consoles a compile time option and
> then be able to use fbcon instead.

Good. As long as I can have a stderr console and CONFIG_VT, I'm happy.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
