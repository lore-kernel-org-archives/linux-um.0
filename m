Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xqnB-0003Mm-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 09:29:05 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xqnA-0007fy-Cb
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 09:29:04 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8CGKrj13063
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 12:20:53 -0400
Message-Id: <200309121628.h8CGSce4002665@ccure.karaya.com>
Subject: Re: [uml-devel] Re: pthreads? 
In-Reply-To: Your message of "12 Sep 2003 13:18:04 +0200."
             <1063365483.13933.0.camel@henrik.marasystems.com> 
References: <Pine.GSO.4.21.0309121104430.2312-100000@vervain.sonytel.be>  <1063365483.13933.0.camel@henrik.marasystems.com> 
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
Date: Fri, 12 Sep 2003 12:28:38 -0400
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Gerd Knorr <kraxel@bytesex.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

hno@marasystems.com said:
> What about running the X11 stuff in a helper and using mmap to map the
> framebuffer data in both the UML and the helper process? 

I'm not going to Geert how to do this, but I would like to see everything in 
one process.  The reason is that I have fond hopes of turning UML into a
library, libUML.so, which can be used by any app that needs anything provided
by the kernel.

So, if this is going to happen, libUML needs to be compatible with everything
else out there, and this is one step in that direction.

So, my preference would be to figure out what the incompatibility between
UML and pthreads is, and fix UML.  And I'll provide whatever help is needed
to sort this out.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
