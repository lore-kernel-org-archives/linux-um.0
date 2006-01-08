Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Evidy-0003OA-Sg for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Jan 2006 14:04:06 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Evidx-0004vP-7r
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Jan 2006 14:04:06 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.64.0601081539001.4477@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] tls patch compile problem (syntax error before
	get_thread_area)
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
Date: Sun, 8 Jan 2006 17:03:25 -0500 (EST)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>, Paolo Blaisorblade Giarrusso <blaisorblade_spam@yahoo.it>

Good afternoon, all,
 	While trying to compile 2.6.15 + Jeff's 20060107 patches, I got 
this compile error:

[wstearns@sparrow linux-2.6.15-um20060107]$ make ARCH=um linux
   CHK     include/linux/version.h
gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -ffreestanding -Os     -fno-omit-frame-pointer 
-fno-optimize-sibling-calls -g  -D__arch_um__ -DSUBARCH=\"i386\" 
-Iarch/um/include 
-I/usr/src/uml-linux/linux-2.6.15-um20060107/arch/um/include/tt 
-I/usr/src/uml-linux/linux-2.6.15-um20060107/arch/um/include/skas 
-Dvmap=kernel_vmap -Din6addr_loopback=kernel_in6addr_loopback 
-Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask -fno-unit-at-a-time 
-U__i386__ -Ui386 -march=i686 -mpreferred-stack-boundary=2 
-D_LARGEFILE64_SOURCE -Wdeclaration-after-statement -Wno-pointer-sign 
-nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/4.0.2/include 
-D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -S -o 
arch/um/kernel-offsets.s arch/um/sys-i386/kernel-offsets.c
   CHK     arch/um/include/kern_constants.h
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   CC      arch/um/os-Linux/tls.o
arch/um/os-Linux/tls.c:48: error: syntax error before 'get_thread_area'
arch/um/os-Linux/tls.c:48: warning: type defaults to 'int' in declaration 
of '_syscall1'
arch/um/os-Linux/tls.c:48: warning: function declaration isn't a prototype
arch/um/os-Linux/tls.c:48: warning: data definition has no type or storage 
class
arch/um/os-Linux/tls.c:49: error: syntax error before 'set_thread_area'
arch/um/os-Linux/tls.c:49: warning: type defaults to 'int' in declaration 
of '_syscall1'
arch/um/os-Linux/tls.c:49: warning: function declaration isn't a prototype
arch/um/os-Linux/tls.c:49: warning: data definition has no type or storage 
class
arch/um/os-Linux/tls.c:51: warning: 'struct user_desc' declared inside 
parameter list
arch/um/os-Linux/tls.c:51: warning: its scope is only this definition or 
declaration, which is probably not what you want
arch/um/os-Linux/tls.c: In function 'do_set_thread_area_tt':
arch/um/os-Linux/tls.c:55: warning: implicit declaration of function 
'set_thread_area'
arch/um/os-Linux/tls.c: At top level:
arch/um/os-Linux/tls.c:62: warning: 'struct user_desc' declared inside 
parameter list
arch/um/os-Linux/tls.c: In function 'do_get_thread_area_tt':
arch/um/os-Linux/tls.c:66: warning: implicit declaration of function 
'get_thread_area'
make[1]: *** [arch/um/os-Linux/tls.o] Error 1
make: *** [arch/um/os-Linux] Error 2

 	By removing the 4 tls related patches (uml-tls-support-sc-tables, 
uml-add-tls-support, uml-add-tls-support-debug, and 
uml-add-tls-support-flush-empty) from series and reapplying, the compile 
continues past this point.  uml-clean-arch_switch also needs to be 
reverted to finish compilation.
 	If it makes a difference, I'm using: gcc version 4.0.2 20051125 
(Red Hat 4.0.2-8).  Finished kernel, config, and System.map are at 
http://www.stearns.org/uml/ (linux-2.6.15-um20060107-notls-2.bz2 and 
friends).
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
          "My fellow Americans. I've signed legislation that will outlaw
Russia forever. We begin bombing in five minutes."
         - President Reagan, before a scheduled radio broadcast, unaware
that the microphone was already on...
(Courtesy of Brian S. Dellinger <Brian.Dellinger@Dartmouth.EDU>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
