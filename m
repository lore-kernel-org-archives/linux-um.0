Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xwLo-000085-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 15:25:12 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xwLn-0000bD-7b
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 15:25:11 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Re: pthreads? 
In-Reply-To: <200309121628.h8CGSce4002665@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0309130019420.19429-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sat, 13 Sep 2003 00:25:00 +0200 (CEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Gerd Knorr <kraxel@bytesex.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 12 Sep 2003, Jeff Dike wrote:

> I'm not going to Geert how to do this, but I would like to see everything in 
> one process.  The reason is that I have fond hopes of turning UML into a
> library, libUML.so, which can be used by any app that needs anything provided
> by the kernel.

If you think it is feasible to run another heavy user of clone(), message
queues and signals in the same process then it might be.. but my gut
feeling is not..

> So, if this is going to happen, libUML needs to be compatible with everything
> else out there, and this is one step in that direction.

The use of helpers does not exclude the other.. but I see your point.

Regards
enrik



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
