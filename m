Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uyTB-0006L4-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 11:04:33 -0700
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uyT5-000758-Vf
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 11:04:28 -0700
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] Kernel panic: Kernel mode fault at addr 0x0, ip
 0x8053457
Message-ID: <Pine.GSO.4.53.0309041857190.21341@altair.dur.ac.uk>
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
Date: Thu, 4 Sep 2003 19:03:35 +0100 (BST)
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com

Jeff Dike wrote:
> russell@coker.com.au said:
> > On http://www.coker.com.au/bug/ls.gz I have a compressed version of ls
> > for  i386 that causes a reliable UML crash on 2.6.0test3 with the
> > latest test3 UML  patch.
>
> Could you make a statically linked version of it so I don't have to
> figure out where to get the libraries it needs?

Jeff, we worked out what the bug was. His old selinux used syscall 223,
which was completely uninitialized (ie. not even set to sys_ni_syscall),
hence the kernel crashed. I was having the same problem in a different
context with get_thread_area and set_thread_area.

	Michael Young


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
