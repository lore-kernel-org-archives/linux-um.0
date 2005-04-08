Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJiuA-0004re-NL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 19:07:30 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DJiu7-00055e-2W for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 19:07:30 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] error compilng uml-2.4.27-bs2-pre9
References: <007801c53bdd$5015bbe0$0201a8c0@lualele>
In-Reply-To: <007801c53bdd$5015bbe0$0201a8c0@lualele>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504080413.29612.blaisorblade@yahoo.it>
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
Date: Fri, 8 Apr 2005 04:13:25 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: itamar <itamar@ispbrasil.com.br>

On Friday 08 April 2005 03:50, itamar wrote:
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.27/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
> -U__i386__ -Ui386 -DUM_FASTCALL  -D__arch_um__ -DSUBARCH="i386"
> -D_LARGEFILE64_SOURCE -I/usr/src/linux-2.4.27/arch/um/include
> -Derrno=kernel_errno -I/usr/src/linux-2.4.27/arch/um/kernel/tt/include
> -I/usr/src/linux-2.4.27/arch/um/kernel/skas/include -nostdinc -iwithprefix
> include -DKBUILD_BASENAME=smp  -c -o smp.o smp.c gcc -D__KERNEL__
> -I/usr/src/linux-2.4.27/include -Wall -Wstrict-prototypes -Wno-trigraphs
> -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -U__i386__ -Ui386
> -DUM_FASTCALL  -D__arch_um__ -DSUBARCH="i386" -D_LARGEFILE64_SOURCE
> -I/usr/src/linux-2.4.27/arch/um/include -Derrno=kernel_errno
> -I/usr/src/linux-2.4.27/arch/um/kernel/tt/include
> -I/usr/src/linux-2.4.27/arch/um/kernel/skas/include -nostdinc -iwithprefix
> include -DKBUILD_BASENAME=syscall_kern  -c -o syscall_kern.o syscall_kern.c
> syscall_kern.c: In function `do_mmap2':
> syscall_kern.c:82: warning: passing arg 1 of `do_mmap_pgoff' from
> incompatible pointer type
> syscall_kern.c:82: warning: passing arg 2 of `do_mmap_pgoff' makes integer
> from pointer without a cast
> syscall_kern.c:82: error: too many arguments to function `do_mmap_pgoff'
Remove the first param at that line.... I'm sorry, in my tree the func was 
correct, but in the exported patch it was not.

I'm uploading -pre10, with only this fix. Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
