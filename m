Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXT4v-0006xh-Gm for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 15:58:53 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BXT4u-0007im-Qv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 15:58:53 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] [2.6 patch] terminal/console cleanups
In-Reply-To: <20040607090328.GA20535@bytesex.org>
Message-ID: <Pine.LNX.4.44.0406080053200.12943-100000@filer.marasystems.com>
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
Date: Tue, 8 Jun 2004 00:58:26 +0200 (CEST)
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, 7 Jun 2004, Gerd Knorr wrote:

> It likely would also be possible to use CONFIG_VT and create a
> CONFIG_VT_UMLCON driver instead.  Havn't looked at that.  I hope going
> that route doesn't mean we'll have to implement something like screen
> inside the uml kernel ...

I think this will be hard without first giving UML a virtual framebuffer, 
allowing the framebuffer console to be used.

The concept of VT consoles on character I/O consoles like UML stdio or
Serial lines is not precisely in line with how CONFIG_VT works..

> By moving the stderr console code to another source file it should at
> least be possible to make the uml consoles a compile time option and
> then be able to use fbcon instead.

Indeed, and this would allow for normal VT console operation.

It should also not be hard (if not done already) to make the UML VT
"emulation" a compile option separate from the stdio console.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
