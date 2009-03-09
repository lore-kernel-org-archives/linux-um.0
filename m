Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <renzo@cs.unibo.it>) id 1LgnmH-0007Pt-Tx
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Mar 2009 22:16:53 +0000
Received: from leb.cs.unibo.it ([130.136.1.102])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LgnmE-00011j-Q9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Mar 2009 22:16:53 +0000
Date: Mon, 9 Mar 2009 23:16:37 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
Message-ID: <20090309221637.GB3525@cs.unibo.it>
References: <20090308170758.GE6847@cs.unibo.it>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090308170758.GE6847@cs.unibo.it>
Subject: Re: [uml-devel] Nesting and other problems on 2.6.29-rc7
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

On Sun, Mar 08, 2009 at 06:07:58PM +0100, Renzo Davoli wrote:
> Eeek! page_mapcount(page) went negative! (-1)
> Then the entire outer uml crashes.
> I have spent the entire day yesterday trying to figure out what has changed since 
> the beginning of February when it worked.
> 
> On 2.6.29-rc7 I get a different error (the Eeek error has been eliminated from the
> kernel source code): the output of the nested execution is at the end of this message.
> The nested UML crashes anyway, but the calling UML does not panic.

I am hunting the bug...

The following code contains the same mmap64 call that lead nested uml to fail.

-----
#define _GNU_SOURCE
#include <sys/mman.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

main() {
  int fd;
  void * addr;
  fd = open("/tmp/test",O_CREAT|O_RDWR,0x777);
  addr = mmap64((void *) 0x100000, 0x1000,
      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, 0x15e000);
  printf("%x\n",addr);
  munmap(addr,0x1000);
  close(fd);
}
----

If you compile and run this code on 2.6.28, UML crashes completely.
On 2.6.29 it returns the same memory errors of a nested UML execution.

mmap64 is a system call.
In the outer UML it is managed by sys_mmap2.
sys_mmap2 calls do_mmap_pgoff
do_mmap_pgoff calls mmap_region
mmap region seems to find the region already allocated, thus it
unmaps the first page:
----
munmap_back:
  vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
  if (vma && vma->vm_start < addr + len) {
    if (do_munmap(mm, addr, len))
      return -ENOMEM;
    goto munmap_back;
  }
----
It fails when returning from the second call of find_vma_prepare.

Is there somebody out there with an enlighting idea on what is going on?

ciao
	renzo


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

