Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A4zdt-0005jY-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 02 Oct 2003 02:21:01 -0700
Received: from cimice4.lam.cz ([212.71.168.94] helo=vagabond.light.src)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A4zdr-0007Db-VY
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 02 Oct 2003 02:21:00 -0700
From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [uml-devel] Re: pthreads?
Message-ID: <20031002092044.GA3512@vagabond>
References: <Pine.GSO.4.21.0309150853020.3191-100000@vervain.sonytel.be> <Pine.LNX.4.44.0309151033390.15749-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309151033390.15749-100000@filer.marasystems.com>
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
Date: Thu, 2 Oct 2003 11:20:44 +0200
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Sep 15, 2003 at 11:19:11 +0200, Henrik Nordstrom wrote:
> Hoever, if UML uses clone() or other libc calls (yes, clone() is a libc
> call, direcly matched by a kernel syscall) in a manner which should not
> confuse other users of the same calls then pthreads may be a bad guy as
> well, not dealing properly with the situation.

Just a side note: It's not overly direct. Libc does a LOT work before
calling the syscall -- the libc call takes a function argument, while
the syscall takes a stack pointer argument.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
