Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDFEe-00068g-RM for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 21:13:52 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DDFEd-0006yd-BU
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 21:13:52 -0800
Received: from [192.168.1.100] (222-153-43-105.jetstream.xtra.co.nz
	[222.153.43.105]) (authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id j2L5Dipj011547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 21 Mar 2005 05:13:47 GMT
Message-ID: <423E5806.2070501@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
References: <cbec11ac05031719187cb8e7d2@mail.gmail.com>	
	<200503181843.05832.rob@landley.net>
	<cbec11ac05032020433867d95e@mail.gmail.com>
In-Reply-To: <cbec11ac05032020433867d95e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.4 do_mmap_pgoff compile problem
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
Date: Mon, 21 Mar 2005 17:13:42 +1200
To: user-mode-linux-devel@lists.sourceforge.net

linux-2.4.27.tar.bz2 + uml-2.4.27-bs2-pre6.patch.bz2 patches with no 
error.  But I get the error below compile.  It seems like the UML code 
is passing in a mm as the first arg and the only definitions of 
`do_mmap_pgoff' I can find start with a file arg and have no mm.  I 
dropped the mm arg in the code, and it then compiles OK.  But segfaults 
immediately on use.  I'm not sure if that is caused by my code change or 
not.

BTW: what is the current recommendation for a 'stable' 2.4 UML guest kernel?

Regards, Peter


gcc -D__KERNEL__ -I/usr/src/uml/linux-2.4.27-rimu2/linux-2.4.27/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing-fno-common  -U__i386__ -Ui386 -DUM_FASTCALL -g 
-D__arch_um__ -DSUBARCH="i386" -D_LARGEFILE64_SOURCE 
-I/usr/src/uml/linux-2.4.27-rimu2/linux-2.4.27/arch/um/include 
-Derrno=kernel_errno 
-I/usr/src/uml/linux-2.4.27-rimu2/linux-2.4.27/arch/um/kernel/skas/include 
    -nostdinc -iwithprefix include -DKBUILD_BASENAME=syscall_kern  -c -o 
syscall_kern.o syscall_kern.c
syscall_kern.c: In function `do_mmap2':
syscall_kern.c:82: warning: passing arg 1 of `do_mmap_pgoff' from 
incompatible pointer type
syscall_kern.c:82: warning: passing arg 2 of `do_mmap_pgoff' makes 
integer from pointer without a cast
syscall_kern.c:82: too many arguments to function `do_mmap_pgoff'
make[2]: *** [syscall_kern.o] Error 1

relevant code:

/* common code for old and new mmaps */
long do_mmap2(struct mm_struct *mm, unsigned long addr, unsigned long len,
               unsigned long prot, unsigned long flags, unsigned long fd,
               unsigned long pgoff)
{
         int error = -EBADF;
         struct file * file = NULL;

         flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
         if (!(flags & MAP_ANONYMOUS)) {
                 file = fget(fd);
                 if (!file)
                         goto out;
         }

         down_write(&mm->mmap_sem);
         error = do_mmap_pgoff(mm, file, addr, len, prot, flags, pgoff);
         up_write(&mm->mmap_sem);

         if (file)
                 fput(file);
  out:
         return error;
}


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
