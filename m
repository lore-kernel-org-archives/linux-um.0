Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5tId-0005ua-7S for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 14:51:19 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C5qdH-0001V9-H9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 12:00:32 -0700
From: Allen Chan <alydar@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409101457.10376.alydar@users.sourceforge.net>
Subject: [uml-devel] Broken compile with latest incremental 2.6.8.1-1um patches
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
Date: Fri, 10 Sep 2004 14:57:10 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com

Using all of the updated incremental patches as of this moment on a 
pristine 2.6.8.1 kernel, I get the following compile error:

gcc -Wl,-T,arch/um/kernel/uml.lds.s -static -Wl,--wrap,malloc 
-Wl,--wrap,free -Wl,--wrap,calloc \
        -o linux vmlinux -L/usr/lib -lutil
vmlinux(.text+0x1e0baa): In function `metafs_init_file':
: undefined reference to `print_log'
collect2: ld returned 1 exit status
make: *** [linux] Error 1

I was able to correct this manually by commenting out the print_log() 
call in the externfs patch.  On the version of the externfs patch 
from a few days ago, I had to comment out two lines containing 
print_log() calls.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
