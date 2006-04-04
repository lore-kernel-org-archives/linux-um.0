Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQZdF-0003Hq-BE for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Apr 2006 17:42:53 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FQZdB-0000d0-SA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Apr 2006 17:42:53 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.17-rc1 with hardened gcc
References: <1144097037.11178.24.camel@localhost>
In-Reply-To: <1144097037.11178.24.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604040242.30134.blaisorblade@yahoo.it>
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
Date: Tue, 4 Apr 2006 02:42:29 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Antoine Martin <antoine@nagafix.co.uk>

On Monday 03 April 2006 22:43, Antoine Martin wrote:
> I thought I'd give it a try.
> I guess that these aren't bugs (since switching to non-hardened gcc
> fixes most problems) but maybe this is useful to someone?

> Otherwise just ignore most issues in this email.

Don't worry, I've got and solved every report of this mail, luckily...

> - the configs are available at http://uml.nagafix.co.uk/kernels
> - GCC 3.4.5 hardened

> First, the good old ASM errors are still here (IIRC there is no easy way
> to solve this):
Will publish the fix. I've installed hardened GCC forgetting of this, got this 
error, and saw a "-vanilla" config.

I.e. the only difference is in the spec file! I.e. adding -fno-pic to the 
compilation flags (which was tricky since we're being too kludgy with Kbuild) 
solved the problem!

> wget
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.17-rc1.tar.bz2
> tar -jxf linux-2.6.17-rc1.tar.bz2
> mv linux-2.6.17-rc1 linux-2.6.17-rc1-x86
> cd linux-2.6.17-rc1-x86
> cp ../linux-2.6.16.1-bb1-x86/.config ./
> make ARCH=um SUBARCH=i386 oldconfig
> make ARCH=um SUBARCH=i386
> (...)
> CC      arch/um/kernel/skas/clone.o
> arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
> arch/um/include/sysdep/stub.h:45: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:66: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:55: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:90: error: can't find a register in class
> `BREG' while reloading `asm'
> make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
> make[1]: *** [arch/um/kernel/skas] Error 2
> make: *** [arch/um/kernel] Error 2
>
>
> AMD64 works fully, but there are some warnings during the build:
>   CC      arch/um/kernel/uaccess.o
> In file included from include/asm/processor-generic.h:14,
>                  from include/asm/processor.h:51,
>                  from include/linux/prefetch.h:14,
>                  from include/linux/list.h:7,
>                  from include/linux/wait.h:23,
>                  from include/asm/arch/semaphore.h:42,
>                  from include/asm/semaphore.h:4,
>                  from include/asm/ldt.h:11,
>                  from arch/um/include/sysdep/tls.h:25,
>                  from arch/um/include/os.h:16,
>                  from arch/um/kernel/uaccess.c:12:
> include/asm/ptrace.h:82: warning: static declaration of
> 'arch_switch_to_tt' follows non-static declaration
> arch/um/include/kern_util.h:120: warning: previous declaration of
> 'arch_switch_to_tt' was here
> include/asm/ptrace.h:87: warning: static declaration of
> 'arch_switch_to_skas' follows non-static declaration
> arch/um/include/kern_util.h:122: warning: previous declaration of
> 'arch_switch_to_skas' was here

Fixed them too.

> Something else I've noticed is that some kernels fail if TT is compiled
> in, even though it boots into skas0 or skas3 mode. I guess this isn't
> really that important since TT is going to go away.

> Finally, congratulations! all the images I have built now work - even
> fedora (4 and 5) and opensuse.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
