Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5tJN-0005pr-0E for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 14:52:05 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C5qoR-0002pL-Fr for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 12:12:06 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] [patch 1/1] Refer to CONFIG_USERMODE, not to CONFIG_UM
In-Reply-To: <20040910170859.24ABDC74B@zion.localdomain>
Message-ID: <Pine.GSO.4.58.0409102109330.9294@waterleaf.sonytel.be>
References: <20040910170859.24ABDC74B@zion.localdomain>
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
Date: Fri, 10 Sep 2004 21:11:37 +0200 (MEST)
To: blaisorblade_spam@yahoo.it
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 10 Sep 2004 blaisorblade_spam@yahoo.it wrote:
> We should also figure out how to make the config process work better for UML.
> We would like to make UML able to "source drivers/Kconfig" and have the right
> drivers selectable (i.e. LVM, ramdisk, and so on) and the ones for actual
> hardware excluded. I've been reading such a request even from Jeff Dike at the
> last Kernel Summit, (in the lwn.net coverage) but without any followup.

Yes, I agree 100%!

Drivers for `modern' hardware (e.g. PCI, USB), shouldn't be a problem, since
they have good dependencies.

`legacy' hardware is more of a problem. Since the consensus was that CONFIG_ISA
is meant to indicate ISA slots, perhaps we need something like CONFIG_XBUS to
mark all these legacy drivers?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
