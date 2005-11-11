Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EactW-0003U9-Bt for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Nov 2005 09:40:58 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EactR-00067U-HM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Nov 2005 09:40:58 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <1131140395.27405.6.camel@localhost.localdomain>
In-Reply-To: <1131140395.27405.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511111848.01764.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: 2.6.14-bs1
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 11 Nov 2005 18:48:00 +0100
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Friday 04 November 2005 22:39, Antoine Martin wrote:
> Hi,

> I thought you might be interested in this regression:

> make ARCH=um SUBARCH=i386 defconfig
> make ARCH=um SUBARCH=i386 vmlinux
> (...)
>   CC      arch/um/kernel/initrd.o
>   CC      arch/um/kernel/skas/clone.o
> arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
> arch/um/include/sysdep/stub.h:32: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:53: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:42: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:75: error: can't find a register in class
> `BREG' while reloading `asm'
> make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
> make[1]: *** [arch/um/kernel/skas] Error 2
> make: *** [arch/um/kernel] Error 2

Ok, today I've had time to look at the compile error, and while they are 
"legitimate" (aka you didn't do anything wrong, and I don't think it can 
be .config-dependant), they're still totally bogus (aka GCC is drunk).

And what's going on is possibly related to the hardening patches both you 
Gentoo GCC (3.4.4) says to have and that the FC4 GCC (4.0) I know to have.

In fact, I compile with 3.4.4 and it works; plus, the source code is IMHO 
legitimate.

However, I just remembered I have an Ubuntu with GCC 4.0... so I could test 
the thing.
> I've had quite a few problems with 2.6.14 not booting on 2.6.13 and
> 2.6.14 hosts. (errors have been reported by other users - unfortunately
> the strace isn't very useful)

I've not looked deeply at the strace, but I don't see anything much clear.

Also, I suppose the problem is with SKAS0 and no regression is seen in other 
modes.

However, given that you're having this compilation problem (caused by 
uml-fix-misassembling-skas0-stub-segv, which you can unapply for testing), 
you could test the 32-bit binaries I've built and uploaded on my homepage.

For at least one people they run better than home-compiled binaries, and 
there's no report of the opposite.

Also, there is at least another GCC-triggered bug in SKAS0 sources, so if 
you're hitting this one then the binaries will fix it.

> Antoine

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
