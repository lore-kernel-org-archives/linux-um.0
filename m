Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yEop-0003H2-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 11:08:23 -0700
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19yEop-0000qn-FK
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 11:08:23 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Problems with linking of 2.4.19-5um (elf-init.o symbols missing during final link)
References: <20030906143230.47744.qmail@web41607.mail.yahoo.com>
In-Reply-To: <20030906143230.47744.qmail@web41607.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309132008.52834.blaisorblade_spam@yahoo.it>
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
Date: Sat, 13 Sep 2003 20:08:52 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jsjohn2000@yahoo.com

Alle 16:32, sabato 6 settembre 2003, Jason Johnson ha scritto:
> I have been experimenting with user mode linux and
> when I tried compiling against the 2.4.19 kernel I
> received the following link error
Hmmm, it seems like libc itself is wrong. Maybe you new libc is just fine but 
those symbols simply don't have to appear. Since you recompiled libc(I hope 
glibc), you should test it with a simpler program, using static linking. 
Maybe you changed something in the libc config that broke this.
If, instead, libc is good, check below for UML-related ideas.

First: what version of glibc have you got? If it's much older/newer than UML, 
it could be a problem(I remember that glibc 2.3 gave problems, fixed in 
2.3.1, with some special programs with a little stack... I'm not sure at all, 
but could be the case).
Second: try to recheck the build procedure, after a make mrproper(save your 
.config before)
(use
make menuconfig ARCH=um
make linux ARCH=um
don't forgot the ARCH=um part!)

Third: it could be a bug, maybe, but you are using a very old version! Also, 
you should at all be using something newer! 2.4.19 is very old and has 
serious bugs, too(Google ptrace 2.4.20 Linux to find news about it).

Download the needed patches from kernel.org(it won't be 30 M, much less) to go 
at least to 2.4.21(which fixes that bug), even for your host kernel, and the 
related patch from the UML site.

If you still need help, specify your distro, your libc/gcc/binutils version... 
and so on. And try to build a static program as I said above!
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
