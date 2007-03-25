Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HVJed-0003ok-Bi for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Mar 2007 20:44:27 -0700
Received: from nemesis.fprintf.net ([66.134.112.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HVJec-0001YC-Rf
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Mar 2007 20:44:27 -0700
From: Daniel Gryniewicz <dang@gentoo.org>
In-Reply-To: <20070325012758.GA8260@c2.user-mode-linux.org>
References: <1174764836.15059.6.camel@athena.fprintf.net>
	<20070325012758.GA8260@c2.user-mode-linux.org>
Date: Sat, 24 Mar 2007 23:36:28 -0400
Message-Id: <1174793788.5906.16.camel@athena.fprintf.net>
Mime-Version: 1.0
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, 2007-03-24 at 21:27 -0400, Jeff Dike wrote:
> On Sat, Mar 24, 2007 at 03:33:56PM -0400, Daniel Gryniewicz wrote:
> > In their infinite wisdom, the Gentoo kernel team has decided to not ship
> > asm/user.h with the kernel headers package anymore.  Since UML (even, as
> > far as I can tell, in the most recent versions) uses this in several
> > places, is there a way around this?  Are there plans to remove this
> > need, or to use the ones from the UML kernel tree, or something?
> 
> This came up on IRC a week or so ago, but the conclusion then was that
> this was a botch on their part since other distro headers still
> included it, and became unusable as a result.
> 

Update:  <asm/elf.h> isn't there either, but <sys/user.h> includes
user_regs_struct, so that's sufficient for this problem.

The next problem is lack of <asm/page.h>.  Most files failing to build
with it can simply have it removed.  I've temporarily replaced PAGE_SIZE
with sysconf(_SC_PAGESIZE) for now, and we'll see how that works.

Daniel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
