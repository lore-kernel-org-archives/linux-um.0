Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kf9f7-00036G-40 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Sep 2008 01:42:25 -0700
Received: from ftp.linux-mips.org ([213.58.128.207])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kf9f5-0007bh-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Sep 2008 01:42:25 -0700
Received: from localhost.localdomain ([127.0.0.1]:9432 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S32707809AbYIOH3s (ORCPT
	<rfc822;user-mode-linux-devel@lists.sourceforge.net>);
	Mon, 15 Sep 2008 08:29:48 +0100
Date: Thu, 11 Sep 2008 13:50:09 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20080911115009.GA6715@linux-mips.org>
References: <48C8D76B.10901@goop.org> <Pine.LNX.4.64.0809111202560.1545@anakin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0809111202560.1545@anakin>
Subject: Re: [uml-devel] [PATCH 0/3] Globally defining phys_addr_t
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>, Jeremy Fitzhardinge <jeremy@goop.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alex Nixon <alex.nixon@citrix.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Sep 11, 2008 at 12:03:36PM +0200, Geert Uytterhoeven wrote:

> On Thu, 11 Sep 2008, Jeremy Fitzhardinge wrote:
> > This is a repost of a little 3-patch series which Andrew has been
> > carrying in -mm.  It cleans up the definition of phys_addr_t to make it
> > kernel-wide rather than x86-specific, and fixes up PFN_PHYS() to use it
> > to avoid address truncation.
> > 
> > We currently have a few workarounds for this problem in the tree, but
> > Alex found another bug caused by PFN_PHYS(), so it's probably better if
> > you bring these patches into tip.git for now.
> > 
> > PowerPC also defines a phys_addr_t with the same meaning as x86; the
> > powerpc arch maintainers are happy with these patches.
> 
> If I'm not mistaking, this is also true for some MIPS machines.

Jeremy probably missed it because it's called phys_t on MIPS.  It's usually
the same size as unsigned long but a few of the 32-bit Alchemy SOCs have
peripherals placed outside of the 32-bit physical address space so for
those CONFIG_64BIT_PHYS_ADDR will be defined and phys_t be unsigned long
long and used for some pagetable stuff to map those devices into the 32-bit
virtual address space.

UM uses a phys_t for its pagetables.

A single data type for everybody is enough.  phys_addr_t or phys_t I don't
care; I went for phys_t because it's shorter, less to type.

  Ralf

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
