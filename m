Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXLfn-0007JX-Sv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 08:04:27 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BXLfn-0007nf-AO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 08:04:27 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [2.6 patch] terminal/console cleanups
Message-ID: <20040607145504.GB28285@bytesex.org>
References: <20040528135816.GA27837@bytesex.org>
	<Pine.GSO.4.58.0406061918460.5793@waterleaf.sonytel.be>
	<20040607090328.GA20535@bytesex.org>
	<Pine.GSO.4.58.0406071311230.18235@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0406071311230.18235@waterleaf.sonytel.be>
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
Date: Mon, 7 Jun 2004 16:55:04 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Jun 07, 2004 at 01:13:56PM +0200, Geert Uytterhoeven wrote:
> On Mon, 7 Jun 2004, Gerd Knorr wrote:
> > I'm not sure how to deal with that best.
> >
> > Right now in UML /dev/tty[0-8] are simple terminal lines.  /dev/tty0
> > hasn't the special meaning of "current foreground console" as there are
> > simply no virtual consoles.  It is possible to use screen to build a
> > virtual-console like setup in a pure text-based environment, which works
> > pretty good.
> 
> Wouldn't it be more logical to have a separate type of device for UML virtual
> consoles using xterms?

The point of the uml console is that existing apps expecting
/dev/tty[0-8] being present don't cry for help because they don't exist ;)

Creating a separate device type (and thus separate special files) for
them doesn't make much sense.  You can already use virtual serial lines
to get that if you want, and it works better than something completely
new because most distributions know how to handle a serial console.

There are still issues with some apps as they expect several ioctls()
work on /dev/tty[0-9] which don't work inside a UML machine.  Some of
these would likely go away when switching over to ...

> > It likely would also be possible to use CONFIG_VT and create a
> > CONFIG_VT_UMLCON driver instead.  Havn't looked at that.  I hope going
> > that route doesn't mean we'll have to implement something like screen
> > inside the uml kernel ...
> 
> Indeed.

... such a setup.

> > By moving the stderr console code to another source file it should at
> > least be possible to make the uml consoles a compile time option and
> > then be able to use fbcon instead.
> 
> Good. As long as I can have a stderr console and CONFIG_VT, I'm happy.

While thinking about it:  A kernel parameter to disable that at runtime
should work fine as well.  With my patch the uml console is in no way
special any more, it's just a tty driver, skipping the register and
unregister calls when some variable is set should be no problem.

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
