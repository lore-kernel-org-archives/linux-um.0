Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BCiaE-0002l4-P7 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Apr 2004 10:17:26 -0700
Received: from covered.with.vernix.org ([64.209.120.201] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BCiaD-0006cX-SX for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Apr 2004 10:17:25 -0700
From: "Nicholas E. Walker" <new@vernix.org>
Subject: Re: [uml-devel] Re: V=R
Message-ID: <20040411171722.GI1297@vernix.org>
References: <20040410140840.GB5782@ccure.user-mode-linux.org>
	<20040410145043.GA28734@bakunin.copyleft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410145043.GA28734@bakunin.copyleft.de>
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
Date: Sun, 11 Apr 2004 13:17:22 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 10, 2004 at 04:50:43PM +0200, Michael Koehne wrote:
>   this reminds me on VM's V=R nucleus option. A V=R is a memory partition
>   dedicated to 1 user, e.g. an MVS guest running under VM who is doing its
>   own demand paging. To translate this to Linux could be the following :
> 
>   e.g. a system with 1GB real ram could boot `linux mem=256m` with
>   only a quarter of ram for the hosting system. We now need two tricks:
> 
>   1: add 768m of ram as V=R memory (dont use it for Linux processes,
>      buffers, ...) partition and offer it as /dev/v=r. (this would
>      be a host kernel patch)
> 
>   2: use this V=R region for UML `linux mem=256m@256m` (this would
>      be a user kernel patch)
> 
>   I dont know how difficult implementation would be, but I think most
>   of an UML V=R is already there. The real V=R is vice versa, so VM
>   is running in upper core, to offer the lower core to the one and
>   only guest a virtual=real environment.

You could try using the NVRD (non-volatile ram disk) driver to acheive
this.  It creates /dev/nvrd0 out of all memory not allocated by the
kernel.

http://www.savan.com/erez/v2.4.16-rmk1-hh15/nvrd.c

It's not as efficient as it could be because it is designed to allow for
enlarging the ram disk (so it puts the first block at the highest memory
address, all addresses are reversed).  This is sort of useless in a
system where RAM is volatile..

Nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
