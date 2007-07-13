Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9JsJ-00062t-BK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:03:55 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9JsI-0006To-M5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 05:03:55 -0700
Message-ID: <46976A09.9070906@nagafix.co.uk>
Date: Fri, 13 Jul 2007 13:03:21 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <46975CD0.5020709@nagafix.co.uk>
In-Reply-To: <46975CD0.5020709@nagafix.co.uk>
Subject: Re: [uml-devel] ARCH=um SUBARCH=i386 breakage?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

I had updated the kernel headers and these include files have been removed.
Until UML uses some other trick, this works for me for the 64-bit build:

cp /usr/src/linux-2.6.22.1/include/asm/user.h /usr/include/asm/user.h
cp /usr/src/linux-2.6.22.1/include/asm/page.h /usr/include/asm/page.h
cp /usr/src/linux-2.6.22.1/include/linux/const.h /usr/include/linux/const.h

But for the 32-bit cross build (make ARCH=um SUBARCH=i386) I still get 
this error:
# make ARCH=um SUBARCH=i386
  SYMLINK arch/um/include/kern_constants.h
  CC      arch/um/sys-i386/user-offsets.s
arch/um/sys-i386/user-offsets.c: In function 'foo':
arch/um/sys-i386/user-offsets.c:52: error: invalid application of 
'sizeof' to incomplete type 'struct user_fxsr_struct'
make[1]: *** [arch/um/sys-i386/user-offsets.s] Error 1
make: *** [arch/um/sys-i386/user-offsets.s] Error 2








Antoine Martin wrote:
> # make ARCH=um SUBARCH=i386          scripts/kconfig/conf -s 
> arch/um/Kconfig
> net/bluetooth/hidp/Kconfig:4:warning: 'select' used by config symbol 
> 'BT_HIDP' refers to undefined symbol 'HID'
>  SYMLINK arch/um/include/kern_constants.h
>  SYMLINK include/asm-um/arch
>  SYMLINK arch/um/include/sysdep
>  SYMLINK arch/um/os
>  SYMLINK include/asm-um/archparam.h
>  SYMLINK include/asm-um/system.h
>  SYMLINK include/asm-um/sigcontext.h
>  SYMLINK include/asm-um/processor.h
>  SYMLINK include/asm-um/ptrace.h
>  SYMLINK include/asm-um/module.h
>  SYMLINK include/asm-um/vm-flags.h
>  SYMLINK include/asm-um/elf.h
>  SYMLINK include/asm-um/host_ldt.h
>  CHK     arch/um/include/uml-config.h
>  UPD     arch/um/include/uml-config.h
>  CC      arch/um/sys-i386/user-offsets.s
> arch/um/sys-i386/user-offsets.c:7:22: error: asm/user.h: No such file 
> or directory
> arch/um/sys-i386/user-offsets.c: In function 'foo':
> arch/um/sys-i386/user-offsets.c:51: error: invalid application of 
> 'sizeof' to incomplete type 'struct user_i387_struct'
> arch/um/sys-i386/user-offsets.c:52: error: invalid application of 
> 'sizeof' to incomplete type 'struct user_fxsr_struct'
> arch/um/sys-i386/user-offsets.c:70: error: invalid application of 
> 'sizeof' to incomplete type 'struct user_regs_struct'
> make[1]: *** [arch/um/sys-i386/user-offsets.s] Error 1
> make: *** [arch/um/sys-i386/user-offsets.s] Error 2
>
>
> This used to work fine -  I am sure the fix is quite simple, but I do 
> not have any spare time ATM.
>
> Antoine
>


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
