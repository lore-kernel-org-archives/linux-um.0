Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A88q0-0005yA-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 10 Oct 2003 18:46:32 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A88pz-0001S0-HT
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 10 Oct 2003 18:46:31 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9B1a0j24428
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 10 Oct 2003 21:36:00 -0400
Message-Id: <200310110149.h9B1n94f006954@ccure.karaya.com>
Subject: Re: [uml-devel] Re: Patch for buffer overrun in serial/console device logic 
In-Reply-To: Your message of "Tue, 07 Oct 2003 15:31:08 PDT."
             <3F833EAC.20903@easyco.com> 
References: <3F830C2C.8010308@easyco.com> <200310072151.h97LphCt003529@ccure.karaya.com>  <3F833EAC.20903@easyco.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 10 Oct 2003 21:49:09 -0400
To: Doug Dumitru <doug@easyco.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

doug@easyco.com said:
> The code itself involves a lot of extra parameters from kernel to user
>  space as things like the current user aren't propogated down.  I
> personally think that our current patch set is "100% ugly" and would
> not  consider posting it as-is.  If people are interested in
> transparent  numeric UID/GID to hostfs, then I would be happy to clean
> up what we  have and submit it. 

OK, that ain't the way to do it.  Anything that involves passing a parallel
set of creds through VFS will cause Al Viro to lop my head off.  Since I'm
somewhat attached to it, I will not propose such a thing, no matter how cleaned
up it is.

What would work is to store the creds in a separate container of some sort
on the host, and reference that inside hostfs when doing permission checks.

This is more or less what UMSDOS does, from what I understand, and it keeps
the nastiness contained within hostfs.

That journalling is a neat idea, BTW.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
