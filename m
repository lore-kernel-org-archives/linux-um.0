Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXbfD-00087Q-4h for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jun 2004 01:08:55 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXbfC-0001KJ-KT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jun 2004 01:08:54 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] [2.6 patch] terminal/console cleanups
In-Reply-To: <Pine.LNX.4.44.0406080053200.12943-100000@filer.marasystems.com>
Message-ID: <Pine.GSO.4.58.0406081008020.8135@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0406080053200.12943-100000@filer.marasystems.com>
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
Date: Tue, 8 Jun 2004 10:08:31 +0200 (MEST)
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 8 Jun 2004, Henrik Nordstrom wrote:
> On Mon, 7 Jun 2004, Gerd Knorr wrote:
> > It likely would also be possible to use CONFIG_VT and create a
> > CONFIG_VT_UMLCON driver instead.  Havn't looked at that.  I hope going
> > that route doesn't mean we'll have to implement something like screen
> > inside the uml kernel ...
>
> I think this will be hard without first giving UML a virtual framebuffer,
> allowing the framebuffer console to be used.

Indeed. And that's what I'm working on (sometimes, too many things to do).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
