Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6ziC-0007Wf-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 07 Oct 2003 14:49:44 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6ziB-0006oH-3R
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 07 Oct 2003 14:49:43 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h97LdRj20148
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 7 Oct 2003 17:39:27 -0400
Message-Id: <200310072151.h97LphCt003529@ccure.karaya.com>
In-Reply-To: Your message of "Tue, 07 Oct 2003 11:55:40 PDT."
             <3F830C2C.8010308@easyco.com> 
References: <3F830C2C.8010308@easyco.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: Patch for buffer overrun in serial/console device logic
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
Date: Tue, 07 Oct 2003 17:51:43 -0400
To: Doug Dumitru <doug@easyco.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

doug@easyco.com said:
> We also have a much messier, in-house patch that we apply to hostfs.c
> so  that root mounts will correctly honor ownerships and rights.  

Does this involve some sort of list on the side which keeps track of ownership
and permissions of the host files?  If so, hostfs has needed something like
this for a long time.

> Is anyone  else working on this.

Not that I know of.  It comes up every once in a while, but no one has actually
written any code.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
