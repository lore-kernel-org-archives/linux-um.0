Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yHW3-0000FQ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 14:01:11 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yHW2-0007qz-FM
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 14:01:10 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Re: pthreads? 
In-Reply-To: <200309131853.h8DIrWe4006808@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0309132243570.27756-100000@filer.marasystems.com>
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
Date: Sat, 13 Sep 2003 23:01:02 +0200 (CEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Sat, 13 Sep 2003, Jeff Dike wrote:

> However, I didn't think of the possibility of pthreads overriding system calls.
> That opens up whole new vistas of brokenness.

It doesn't override system calls from what I know, but it does replace a 
whole lot of the glibc calls, some of which have the same name as some of 
the system calls.. (open, close, read, write, fcntl, recvmsg, sendmgs, 
sigaction, wait, waitpid, malloc, free and a whole lot more).

Regards
Henrik



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
