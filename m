Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6cnK-0006Oe-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 14:21:30 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6cnI-0003sy-Jv
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 14:21:28 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h96LBIj06659
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 17:11:18 -0400
Message-Id: <200310062122.h96LMhGj020784@ccure.karaya.com>
Subject: Re: [uml-devel] mconsole proc interface patch 
In-Reply-To: Your message of "29 Sep 2003 18:47:31 +0200."
             <1064854051.21559.5.camel@mancillotti.retesintesi.net> 
References: <1064854051.21559.5.camel@mancillotti.retesintesi.net> 
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
Date: Mon, 06 Oct 2003 17:22:43 -0400
To: marco ancillotti <mancillotti@interfree.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

mancillotti@interfree.it said:
> in last version of uml patch there's a bug that make uml crash when
> from uml_mconsole someone try to use:
> proc ../SOMETHINK
> there's a patch to resolv prolem. 

It sure didn't take long for people to start finding problems there :-)

I thought (but didn't check) that any .. action would result in -ENOENT
because the superblock being used isn't mounted anywhere.

I'm not sure that fix is right, but I'll find some other fix if so.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
