Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWuFz-0001s5-Dt for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 02:20:15 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CWuFv-0002ms-LR
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Nov 2004 02:20:15 -0800
Subject: Re: [uml-devel] [PATCH] uml_router: cleanup
References: <BAY24-F27D8548BC9B2976EFF8B3883B80@phx.gbl>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <BAY24-F27D8548BC9B2976EFF8B3883B80@phx.gbl>
Message-ID: <874qjfftsz.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: 24 Nov 2004 11:03:08 +0100
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

"Steve Schmidtke" <steve_schmidtke@hotmail.com> writes:

> Hi,
> 
> While I was playing around with uml_switch, I started thinking that
> the code is a bit messy and really could use a facelift.

BTW: not sure I ever mentioned it here, but some time ago I basically
rewrote the switch daemon as well for several reasons.  Main reason is
that debugging network problems with the original one is very hard.

While browsing the code I figured that it likely is easier to largely
rewrite the stuff rather than trying to fix the existing stuff.
Especially the mac handling is broken by design.

The code is here:
        http://www.suse.de/~kraxel/uml/switch.tar.gz

The README is below.

Enjoy,

  Gerd

==============================[ cut here ]==============================
This is a drop-in replacement for the uml_switch daemon from the
uml-utilities package.  It is very loosely based on the original
uml_switch daemon code.

Improvements:

  * Prints nice help text on '-h'.
  * Redesigned MAC handling, it can deal with multiple MAC addresses
    per switch port correctly.
  * Has outgoing package queues per switch port.
  * Drives the switch ports using non-blocking I/O for both reads
    and writes.
  * Pidfile support.

Drawbacks:

  * supports the v3 protocol only.

On my maybe-TODO list:

  * Reintroduce hash table for MAC lookup (not sure through that this
    would noticable speedup the daemon as the number of mac addresses
    usually is small ...).
  * use poll() instead of select() (again this likely doesn't make a
    noticable difference for most users ...).

Have fun,

  Gerd

--
Gerd Knorr <kraxel@bytesex.org> [SUSE Labs]


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
