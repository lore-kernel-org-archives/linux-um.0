Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yFXO-00074d-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 11:54:26 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yFXN-000307-AE
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 11:54:25 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8DIkAj23091
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 14:46:10 -0400
Message-Id: <200309131854.h8DIsEe4006813@ccure.karaya.com>
Subject: Re: [uml-devel] Re: pthreads? 
In-Reply-To: Your message of "Sat, 13 Sep 2003 17:24:31 +0200."
             <Pine.GSO.4.21.0309131710100.2634-100000@vervain.sonytel.be> 
References: <Pine.GSO.4.21.0309131710100.2634-100000@vervain.sonytel.be> 
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
Date: Sat, 13 Sep 2003 14:54:14 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

geert@linux-m68k.org said:
> First step: libpthread redefines sigaction to install its own signal
> handler around the signal.

Gawd, that's unpleasant.  What does its signal handler do?

> and quits without any further messages. If I try to run it under gdb,
> gdb crashes immediately with a segmentation fault. 

Try stracing it.  You can tell a lot about its progress by looking at its 
system calls.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
