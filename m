Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yXn8-0006M1-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 07:23:54 -0700
Received: from jstevenson.plus.com
	([212.159.71.212] helo=alpha.stev.org ident=mistral)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yXn4-0003eG-QT
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 07:23:51 -0700
From: James Stevenson <james@stev.org>
Subject: Re: [uml-devel] uml-patch-2.4.22-4
In-Reply-To: <200309140317.h8E3H2e4008178@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0309141522550.29078-100000@god.stev.org>
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
Date: Sun, 14 Sep 2003 15:24:08 +0100 (IST)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


Hi

I get the following missing.
I see these under 2.4.22-um3 as well.

Compiled from the cvs.

Does anyone know what mmu_gathers is ?

gcc -Wl,-T,arch/um/link.ld -static -Wl,--wrap,malloc -Wl,--wrap,free 
-Wl,--wrap,calloc \
	-o linux arch/um/main.o vmlinux.o -L/usr/lib -lutil
vmlinux.o: In function `zap_page_range':
/mnt/home/james/kernel-build/linux-2.4.22-um4/include/asm-generic/tlb.h:42: 
undefined reference to `mmu_gathers'
/mnt/home/james/kernel-build/linux-2.4.22-um4/include/asm-generic/tlb.h:44: 
undefined reference to `mmu_gathers'
/mnt/home/james/kernel-build/linux-2.4.22-um4/include/asm-generic/tlb.h:46: 
undefined reference to `mmu_gathers'

thanks
	James

On Sat, 13 Sep 2003, Jeff Dike wrote:

> This is a major cleanup patch.  It's mostly due to Steve Schmidtke, the 
> wild and wacky guy who brought sound support to UML.  He seems to be taking
> his medications more consistently now, with the result that he sent in a 
> comparatively sane patch which makes UML make much better use of the os_* 
> interfaces.
> 
> There are also a couple of cleanups from Stian, and also from me, since I
> was feeling left out of all the fun.
> 
> 				Jeff
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
