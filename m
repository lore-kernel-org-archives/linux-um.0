Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BoDMw-0007eS-Nn for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jul 2004 20:38:42 -0700
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BoDMw-0002wc-41 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jul 2004 20:38:42 -0700
Received: from user-12hcjeo.cable.mindspring.com ([69.22.77.216]
	helo=bender.davehollis.com)
	by harrier.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 1BoDMs-0007h1-00 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jul 2004 20:38:38 -0700
Subject: Re: [uml-devel] uml-2.6.8-rc2 (2.6.8-rc2 w/ uml-patch-2.6.7-01)
From: David T Hollis <dhollis@davehollis.com>
In-Reply-To: <20040723214312.14567.qmail@praize.com>
References: <20040723214312.14567.qmail@praize.com>
Content-Type: text/plain
Message-Id: <1090640326.4233.4.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Fri, 23 Jul 2004 23:38:46 -0400
To: gboutwel <gboutwel@praize.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 2004-07-23 at 21:43 +0000, gboutwel wrote:
> vmlinux(.text+0x5fcd8): In function `locate_fd':
> 
> : undefined reference to `find_next_zero_bit'
> 
> vmlinux(.text+0x7e3f1): In function `scan_bitmap_block':
> 
> : undefined reference to `find_next_zero_bit'
> 
> vmlinux(.text+0x9f49e): In function `reiserfs_in_journal':
> 
> : undefined reference to `find_next_zero_bit'
> 
> vmlinux(.text+0xa6bd0): more undefined references to `find_next_zero_bit'
> 
> follow
> 
> vmlinux(.text+0xb7905): In function `sub_alloc':
> 
> : undefined reference to `find_next_bit'
> 
> vmlinux(.init.text+0x43d0): In function `__alloc_bootmem_core':
> 
> : undefined reference to `find_next_zero_bit'
> 
> collect2: ld returned 1 exit status
> 
> make: *** [linux] Error 1
> 
> 
> 
> Probably something simple, but I wanted to discuss with folks
> 
> more in the now on if the above (stdio_console) fix was the right
> 
> one, and to find out if anyone else has an idea of how to fixe
> 
> the find_next_zero_bit error.
> 

I ran into this around a week or so ago as well.  Unfortunately, I don't
have a patch but here is the rough idea of what I did to work around it.
find_next_zero_bit is defined in arch/i386/lib/bitops.c.  If you look in
arch/um/sys-i386, a couple files get symlinked from other parts of the
tree (see the Makefile).  If you add bitops.c to this, you will get past
the find_next_zero_bit problem.  You would add bitops.o to the obj-y,
bitops.c to SYMLINKS, bitops.c-dir := arch/i386/lib.  I think thats
about it.

Good luck
-- 
David T Hollis <dhollis@davehollis.com>



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
