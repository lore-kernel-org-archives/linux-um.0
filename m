Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6cnq-0006X7-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 14:22:02 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6cno-0003xW-L3
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 14:22:01 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h96LBmj06692
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 17:11:49 -0400
Message-Id: <200310062123.h96LNhGj020809@ccure.karaya.com>
Subject: Re: [uml-devel] Separate COW patch. 
In-Reply-To: Your message of "Mon, 29 Sep 2003 11:53:40 CDT."
             <2D4B6CD74137D4119A1100104BC6BCBF0BC58605@dubntex006.qwest.net> 
References: <2D4B6CD74137D4119A1100104BC6BCBF0BC58605@dubntex006.qwest.net> 
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
Date: Mon, 06 Oct 2003 17:23:42 -0400
To: "Montgomery, Kendal L" <kendal.montgomery@qwest.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@sonycom.com

kendal.montgomery@qwest.com said:
> Where can I get what you've worked on so far?  I'd be willing to give
> it a try and possibly help to sort out the remaining pieces that need
> to make it work. 

It's in arch/um/drivers/cow_kern.c.  The bit that got me hung up was ensuring
that COW bitmap updates happen before the actual I/O.  This is necessary
in case the UML crashes during a write.  You want the bitmap update to
happen only after the data has been written.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
