Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CU3aE-0006iz-P8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 05:41:22 -0800
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CU3aB-0000gv-W0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Nov 2004 05:41:22 -0800
From: Anton Altaparmakov <aia21@cam.ac.uk>
Content-Type: text/plain
Message-Id: <1100612471.24599.42.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Another bug report for UML in latest Linux 2.6-BK
	repository.
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
Date: Tue, 16 Nov 2004 13:41:11 +0000
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

If I enable HIGHMEM in my .config (see my previous bug report for my
.config and just change HIGHMEM to enabled) compilation fails:

[snip]
  CC      arch/um/kernel/mem.o
arch/um/kernel/mem.c: In function `mem_init':
arch/um/kernel/mem.c:71: warning: implicit declaration of function
`phys_page'
arch/um/kernel/mem.c:71: warning: assignment makes pointer from integer
without a cast
arch/um/kernel/mem.c: In function `kmap_init':
arch/um/kernel/mem.c:151: warning: implicit declaration of function
`pte_offset'arch/um/kernel/mem.c:151: warning: assignment makes pointer
from integer without a cast
[snip]
  LD      .tmp_vmlinux1
arch/um/kernel/built-in.o(.text+0x2ca9): In function `mem_init':
arch/um/kernel/mem.c:71: undefined reference to `phys_page'
arch/um/kernel/built-in.o(.init.text+0x1d2): In function `kmap_init':
include/asm/pgtable.h:394: undefined reference to `pte_offset'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
make: *** [.tmp_kallsyms1.S] Error 139

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
