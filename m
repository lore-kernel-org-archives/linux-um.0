Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bo7p1-0001PT-Lt for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jul 2004 14:43:19 -0700
Received: from goliath.nmsrv.com ([69.28.204.18] helo=mail.praize.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bo7p1-0004FF-BS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jul 2004 14:43:19 -0700
Message-ID: <20040723214312.14567.qmail@praize.com>
From: "gboutwel" <gboutwel@praize.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
Subject: [uml-devel] uml-2.6.8-rc2 (2.6.8-rc2 w/ uml-patch-2.6.7-01)
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
Date: 23 Jul 2004 21:43:12 -0000
To: user-mode-linux-devel@lists.sourceforge.net

  I'm testing the 2.6.8 waters. Looks like it's not been included

in the rc2 version yet. It's in the mm1 version though... so

there's hope. Here's what I've done:



1) tar jzf linux-2.6.7.tar.bz2



2) mv linux-2.6.7 linux-2.6.8-rc2-1um



3) bzcat patch-2.6.8-rc2.bz2 | patch -p1



4) bzcat uml-patch-2.6.7-01.bz2 | patch -p1 --dry-run | less



* not bad, just shows 1 reject, which is the removal of an

#include from init_setup.c



5) cp ~/2.6.7/config-2.6.7-1um .config



6) make oldconfig ARCH=um



7) make linux ARCH=um



* this fails on arch/um/drivers/stdio_console.c with:

arch/um/drivers/stdio_console.c:207: error: conflicting types

for `console_device'

include/linux/console.h:107: error: previous declaration of `console_device'



Where:



include/linux/console.h:107 extern struct tty_driver *console_device(int

*);

arch/um/drivers/stdio_console.c:207 has struct tty_driver *console_device(struct

console *c, int *index)



so, on a wild 'whim' I changed console_device in stdio_console.c

to uml_console_device.



That compiles, but then it ends with an linker error:



vmlinux(.text+0x2d8b0): In function `alloc_pidmap':

: undefined reference to `find_next_zero_bit'

vmlinux(.text+0x4faef): In function `get_unused_fd':

: undefined reference to `find_next_zero_bit'

vmlinux(.text+0x5fcd8): In function `locate_fd':

: undefined reference to `find_next_zero_bit'

vmlinux(.text+0x7e3f1): In function `scan_bitmap_block':

: undefined reference to `find_next_zero_bit'

vmlinux(.text+0x9f49e): In function `reiserfs_in_journal':

: undefined reference to `find_next_zero_bit'

vmlinux(.text+0xa6bd0): more undefined references to `find_next_zero_bit'

follow

vmlinux(.text+0xb7905): In function `sub_alloc':

: undefined reference to `find_next_bit'

vmlinux(.init.text+0x43d0): In function `__alloc_bootmem_core':

: undefined reference to `find_next_zero_bit'

collect2: ld returned 1 exit status

make: *** [linux] Error 1



Probably something simple, but I wanted to discuss with folks

more in the now on if the above (stdio_console) fix was the right

one, and to find out if anyone else has an idea of how to fixe

the find_next_zero_bit error.



Thanks,

George







----------------------------------------------------

Need to store your files online? 

Upload them for free in Praize Briefcase

http://www.praize.com/cgi-bin/members/mybriefcase.cgi



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
