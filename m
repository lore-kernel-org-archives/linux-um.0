Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAPzq-0004F6-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 01:30:06 -0700
Received: from [80.88.36.193] (helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAPxx-00016V-Uc
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 17 Oct 2003 01:28:10 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] Hardening hostfs
In-Reply-To: <03db01c39475$cfc00be0$0600a8c0@objexcel>
Message-ID: <Pine.GSO.4.21.0310171026070.22754-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 17 Oct 2003 10:26:54 +0200 (MEST)
To: Peter <peter@rimuhosting.com>
Cc: Doug Dumitru <doug@easyco.com>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 17 Oct 2003, Peter wrote:
> > I don't think that this is perfect as you could still load a LKM and 
> > probably get to the underlying filesystem.  At least it is chroot'd at 
> > this point.
> 
> You can disable module support in the UML kernel.

But you can still access /dev/mem from UML userspace and do whatever you want.
I don't think you can do anything about this inside UML, only in the
environment you launch UML from.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
