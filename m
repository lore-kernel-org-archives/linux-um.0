Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xVZW-0002RG-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 10:49:34 -0700
Received: from dhcp71.ists.dartmouth.edu ([129.170.249.171] helo=uml.karaya.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xVZV-0007qs-PD
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 10:49:33 -0700
Message-Id: <200309111755.h8BHt9Pa010105@uml.karaya.com>
Subject: Re: [uml-devel] pthreads? 
In-Reply-To: Your message of "Thu, 11 Sep 2003 17:54:34 +0200."
             <Pine.GSO.4.21.0309111733190.1879-100000@vervain.sonytel.be> 
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
Date: Thu, 11 Sep 2003 13:55:09 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

geert@linux-m68k.org said:
> | capture_stack : Expected SIGSTOP, got status = 0xb7f 

This is the cloned thread segfaulting.  If you gdb it to that point, you
can grab the thread's registers and see what's happening.  Maybe the stack
is bogus and it segfaulted as soon as it tried to run.  That would be my
best guess.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
