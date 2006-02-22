Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCLvH-0005kI-IB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Feb 2006 11:14:43 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FCLvF-0001DT-Ur
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Feb 2006 11:14:43 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] "Configuring network interfaces...execvp of 'uml_net'
	failed - errno = 2" error msg
References: <20060217115152.GA17278@SteX> <20060221161450.GZ28322@alcor.net>
	<20060221165108.GD9131@SteX>
In-Reply-To: <20060221165108.GD9131@SteX>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602221733.14671.blaisorblade@yahoo.it>
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
Date: Wed, 22 Feb 2006 17:33:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it
Cc: Matt Zimmerman <mdz@debian.org>, Andreas Schuldei <andreas@schuldei.org>, pkg-uml-devel@lists.alioth.debian.org

On Tuesday 21 February 2006 17:51, Stefano Melchior wrote:
> On Tue, Feb 21, 2006 at 08:14:50AM -0800, Matt Zimmerman wrote:
> Hi Matt,

> > On Tue, Feb 21, 2006 at 12:02:40PM +0100, Stefano Melchior wrote:
> > > Once discovered the issue and find the workaround [1], I am wondering
> > > why, if you moved uml_net from /usr/bin to /usr/lib/uml/, you left the
> > > other uml_* executable on the first dir.

> > This was to comply with the FHS:

> > http://www.pathname.com/fhs/pub/fhs-2.3.html

> > uml_net is not intended to be executed by a user, only invoked as an
> > auxiliary program by UML itself.

> > I discussed this with Jeff at the time, and he agreed that it should
> > move, but never moved it upstream apparently.

> > I patched the Debian UML sources to match.

> > > Is it worthy to move all of them to /usr/lib/uml/?

> > No, see above.

> Ok, I understood, thank you.
> On the Makefile of uml_net source, and I read:

> BIN_DIR ?= /usr/bin

> If Jeff, Paolo and the UML devel team all agree, we can patch it and
> transform the line in:

> BIN_DIR ?= /usr/lib/uml

Yep, but we need also the symlink in /usr/bin. I think it's not the case to 
break compatibility. Send me the patch so I integrate it in next uml-utilities 
release.

> The same with uml_switch, isn't it?

No - uml_switch *must* be run by the user and is *never* run by UML.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
