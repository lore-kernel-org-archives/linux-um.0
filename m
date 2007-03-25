Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HVU7r-0007ox-C3 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Mar 2007 07:55:27 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HVU7p-0007dB-8f
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Mar 2007 07:55:18 -0700
Date: Sun, 25 Mar 2007 10:52:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070325145232.GB4901@c2.user-mode-linux.org>
References: <1174764836.15059.6.camel@athena.fprintf.net>
	<20070325012758.GA8260@c2.user-mode-linux.org>
	<1174793788.5906.16.camel@athena.fprintf.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1174793788.5906.16.camel@athena.fprintf.net>
Subject: Re: [uml-devel] missing asm/user.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Daniel Gryniewicz <dang@gentoo.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 24, 2007 at 11:36:28PM -0400, Daniel Gryniewicz wrote:
> Update:  <asm/elf.h> isn't there either, but <sys/user.h> includes
> user_regs_struct, so that's sufficient for this problem.

Hummph, I hope that's true of every other distro that people use UML on.

> The next problem is lack of <asm/page.h>.  Most files failing to build
> with it can simply have it removed.  I've temporarily replaced PAGE_SIZE
> with sysconf(_SC_PAGESIZE) for now, and we'll see how that works.

Send patches.

BTW, the important thing about PAGE_SIZE in the userspace side of UML
is not that it be the same as sysconf(_SC_PAGESIZE) but that it match
the value of PAGE_SIZE in the kernelspace side.  Obviously, these
values will all be the same everywhere that we care about now, but I
can think of one or two situations where it would matter.  On an
architecture with a variable page size, the UML kernel can have a
PAGE_SIZE of 64K but the host's sysconf can report a page size of 4K.
In this case, it's important that PAGE_SIZE in UML userspace code be
64K.

So, there's UM_KERN_PAGE_SIZE in kern_constants.h which is derived
from the kernel's PAGE_SIZE and is usable in userspace files.  Use
that instead of sysconf().

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
