Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19v07k-0005SO-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 12:50:32 -0700
Received: from dhcp47.ists.dartmouth.edu ([129.170.249.147] helo=uml.karaya.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19v07j-00072E-Fy
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 12:50:31 -0700
Message-Id: <200309041955.h84JtREX018760@uml.karaya.com>
Subject: Re: [uml-devel] Kernel panic: Kernel mode fault at addr 0x0, ip 0x8053457 
In-Reply-To: Your message of "Thu, 04 Sep 2003 19:03:35 BST."
             <Pine.GSO.4.53.0309041857190.21341@altair.dur.ac.uk> 
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
Date: Thu, 04 Sep 2003 15:55:26 -0400
To: M A Young <m.a.young@durham.ac.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

m.a.young@durham.ac.uk said:
> Jeff, we worked out what the bug was. His old selinux used syscall
> 223, which was completely uninitialized (ie. not even set to
> sys_ni_syscall), hence the kernel crashed. I was having the same
> problem in a different context with get_thread_area and
> set_thread_area. 

Oops, looks like I missed that.  Easily fixed, it looks like those were 
NULL-filled holes in sys_call_table.  The system call dispatcher did range
checking on the syscall number, but didn't see if the entry itself contained
anything.

And it looks like I missed some system calls that i386 has.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
