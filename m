Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ve7Z-0007IZ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 06 Sep 2003 07:33:01 -0700
Received: from web41607.mail.yahoo.com ([66.218.93.107])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19ve7Y-0001pE-Gn
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 06 Sep 2003 07:33:00 -0700
Message-ID: <20030906143230.47744.qmail@web41607.mail.yahoo.com>
From: Jason Johnson <jsjohn2000@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Problems with linking of 2.4.19-5um (elf-init.o symbols missing during final link)
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
Date: Sat, 6 Sep 2003 07:32:30 -0700 (PDT)
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jsjohn2000@yahoo.com

I have been experimenting with user mode linux and
when I tried compiling against the 2.4.19 kernel I
received the following link error

gcc -Wl,-T,arch/um/link.ld  -Wl,--wrap,malloc
-Wl,--wrap,free -Wl,--wrap,calloc \
        -o linux -static arch/um/main.o vmlinux.o
-L/usr/lib -lutil
/usr/lib/libc.a(elf-init.o)(.text+0x2): In function
`__libc_csu_init':
: undefined reference to `__preinit_array_end'
/usr/lib/libc.a(elf-init.o)(.text+0x9): In function
`__libc_csu_init':
: undefined reference to `__preinit_array_start'
/usr/lib/libc.a(elf-init.o)(.text+0x23): In function
`__libc_csu_init':
: undefined reference to `__preinit_array_start'
/usr/lib/libc.a(elf-init.o)(.text+0x34): In function
`__libc_csu_init':
: undefined reference to `__init_array_end'
/usr/lib/libc.a(elf-init.o)(.text+0x39): In function
`__libc_csu_init':
: undefined reference to `__init_array_start'
/usr/lib/libc.a(elf-init.o)(.text+0x49): In function
`__libc_csu_init':
: undefined reference to `__init_array_start'
/usr/lib/libc.a(elf-init.o)(.text+0x61): In function
`__libc_csu_fini':
: undefined reference to `__fini_array_end'
/usr/lib/libc.a(elf-init.o)(.text+0x67): In function
`__libc_csu_fini':
: undefined reference to `__fini_array_start'
/usr/lib/libc.a(elf-init.o)(.text+0x84): In function
`__libc_csu_fini':
: undefined reference to `__fini_array_start'
collect2: ld returned 1 exit status
make: *** [linux] Error 1

I applied the 2.4.19-5um patch to my kernel source
tree.  Does anyone have any ideas on how to fix this
problem.

I tried compiling a new version of glibc, but the when
I did a objdump -t libc.a symbols mentioned above do
not appear.

Thanks for the help.


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
