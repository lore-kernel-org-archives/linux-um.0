Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19v6RN-0000SB-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 19:35:13 -0700
Received: from sat.sws.net.au ([202.5.161.49] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19v6RL-0006CV-Qs
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 19:35:13 -0700
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: Re: [uml-devel] Kernel panic: Kernel mode fault at addr 0x0, ip 0x8053457
References: <200309041709.h84H9D74016587@uml.karaya.com>
In-Reply-To: <200309041709.h84H9D74016587@uml.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309051235.27527.russell@coker.com.au>
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
Date: Fri, 5 Sep 2003 12:35:27 +1000
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 5 Sep 2003 03:09, Jeff Dike wrote:
> russell@coker.com.au said:
> > On http://www.coker.com.au/bug/ls.gz I have a compressed version of ls
> > for  i386 that causes a reliable UML crash on 2.6.0test3 with the
> > latest test3 UML  patch.
>
> Could you make a statically linked version of it so I don't have to figure
> out where to get the libraries it needs?

Actually this has already been tracked down.  It seems that if you call a 
system call in UML which is in the range of acceptable system calls and which 
has not been set to sys_ni_syscall then it will give that result.

The interim solution is to set any unimplemented system calls that your 
programs will call (223 for me) to sys_ni_syscall.

But this still means that it will be common for UML kernels to have some 
sys-calls which applications can call to crash them (not good for honey-pot 
machines).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
