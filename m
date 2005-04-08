Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJicI-0004Jy-2g for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 18:49:02 -0700
Received: from [209.67.213.234] (helo=ispbrasil.com.br)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJicG-0000An-DG
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 18:49:01 -0700
Message-ID: <007801c53bdd$5015bbe0$0201a8c0@lualele>
From: "itamar" <itamar@ispbrasil.com.br>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] error compilng uml-2.4.27-bs2-pre9
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
Date: Thu, 7 Apr 2005 22:50:11 -0300
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

gcc -D__KERNEL__ -I/usr/src/linux-2.4.27/include -Wall -Wstrict-prototypes -Wno-trigraphs 
 -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -U__i386__ -Ui386 
 -DUM_FASTCALL  -D__arch_um__ -DSUBARCH="i386" -D_LARGEFILE64_SOURCE -I/usr/src/linux-2.4.27/arch/um/include 
 -Derrno=kernel_errno -I/usr/src/linux-2.4.27/arch/um/kernel/tt/include -I/usr/src/linux-2.4.27/arch/um/kernel/skas/include 
    -nostdinc -iwithprefix include -DKBUILD_BASENAME=smp  -c -o smp.o smp.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.27/include -Wall -Wstrict-prototypes -Wno-trigraphs 
 -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -U__i386__ -Ui386 
 -DUM_FASTCALL  -D__arch_um__ -DSUBARCH="i386" -D_LARGEFILE64_SOURCE -I/usr/src/linux-2.4.27/arch/um/include 
 -Derrno=kernel_errno -I/usr/src/linux-2.4.27/arch/um/kernel/tt/include -I/usr/src/linux-2.4.27/arch/um/kernel/skas/include 
    -nostdinc -iwithprefix include -DKBUILD_BASENAME=syscall_kern  -c -o 
syscall_kern.o syscall_kern.c
syscall_kern.c: In function `do_mmap2':
syscall_kern.c:82: warning: passing arg 1 of `do_mmap_pgoff' from 
incompatible pointer type
syscall_kern.c:82: warning: passing arg 2 of `do_mmap_pgoff' makes integer 
from pointer without a cast
syscall_kern.c:82: error: too many arguments to function `do_mmap_pgoff'
make[2]: *** [syscall_kern.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.27/arch/um/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.27/arch/um/kernel'
make: *** [_dir_arch/um/kernel] Error 2

Itamar Reis Peixoto
+55 (34) 3238 3845
e-mail : itamar@ispbrasil.com.br
http://www.ispbrasil.com.br 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
