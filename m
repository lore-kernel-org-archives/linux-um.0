Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yFXS-00074j-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 11:54:30 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yFXR-00037R-4Q
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 11:54:29 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8DIkFj23104
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 14:46:15 -0400
Message-Id: <200309131853.h8DIrWe4006808@ccure.karaya.com>
Subject: Re: [uml-devel] Re: pthreads? 
In-Reply-To: Your message of "Sat, 13 Sep 2003 00:25:00 +0200."
             <Pine.LNX.4.44.0309130019420.19429-100000@filer.marasystems.com> 
References: <Pine.LNX.4.44.0309130019420.19429-100000@filer.marasystems.com> 
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
Date: Sat, 13 Sep 2003 14:53:32 -0400
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Gerd Knorr <kraxel@bytesex.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

hno@marasystems.com said:
> If you think it is feasible to run another heavy user of clone(),
> message queues and signals in the same process then it might be.. but
> my gut feeling is not.. 

The only thing that worries me about clone is wait().  wait(-1, ...) is 
obviously dangerous if there are children floating around that you don't
know about.  Any properly careful user of wait will call it with the pids
of children that it knows about.  UML is not properly careful...

Signals can be handled cleanly if handlers are chained.

I don't know what message queues are.  UML doesn't use anything by that name.

However, I didn't think of the possibility of pthreads overriding system calls.
That opens up whole new vistas of brokenness.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
