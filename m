Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXGIi-0005yk-Ai for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 02:20:16 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BXGIh-0005lI-N9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 02:20:15 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [2.6 patch] terminal/console cleanups
Message-ID: <20040607090328.GA20535@bytesex.org>
References: <20040528135816.GA27837@bytesex.org>
	<Pine.GSO.4.58.0406061918460.5793@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0406061918460.5793@waterleaf.sonytel.be>
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
Date: Mon, 7 Jun 2004 11:03:29 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Jun 06, 2004 at 07:20:36PM +0200, Geert Uytterhoeven wrote:
> On Fri, 28 May 2004, Gerd Knorr wrote:
> > This is a major cleanup of the uml terminal drivers and console handling
> > (console as in "where the kernel messages go to", not as in "linux
> > virtual consoles).  The changes in detail:
> 
> Nice! Does this also mean the UML console no longer interferes with the normal
> virtual console subsystem? Before it was not possible to enable CONFIG_VT
> without some serious surgery to the UML vc subsystem, because both tried to
> attach to the same device number.

No, that hasn't changed.  Guess you are asking because of the uml
virtual framebuffer driver, where you want run fbcon on top of?

I'm not sure how to deal with that best.

Right now in UML /dev/tty[0-8] are simple terminal lines.  /dev/tty0
hasn't the special meaning of "current foreground console" as there are
simply no virtual consoles.  It is possible to use screen to build a
virtual-console like setup in a pure text-based environment, which works
pretty good.

It likely would also be possible to use CONFIG_VT and create a
CONFIG_VT_UMLCON driver instead.  Havn't looked at that.  I hope going
that route doesn't mean we'll have to implement something like screen
inside the uml kernel ...

By moving the stderr console code to another source file it should at
least be possible to make the uml consoles a compile time option and
then be able to use fbcon instead.

  Gerd

-- 
Smoking Crack Organization


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
