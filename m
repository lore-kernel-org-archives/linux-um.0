Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6EDd-0007D3-7d for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 13:11:33 -0700
Received: from mailgate.uni-paderborn.de ([131.234.22.32])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C6EDb-00053a-Hl
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 13:11:33 -0700
Message-ID: <41435C04.3080204@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [PATCH] nptl/sys_clone fix for i386/ppc
References: <20040826020626.GA28471@malice.crymeariver.org>
	<200409102352.i8ANql0O004842@ccure.user-mode-linux.org>
	<4142FEC3.1040904@upb.de>
	<200409111719.44196.blaisorblade_spam@yahoo.it>
In-Reply-To: <200409111719.44196.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sat, 11 Sep 2004 22:11:48 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

>>Sorry, i guess my question is stupid, but does UML now run an a
>>host-system that is NPTL enabled? I didn't try that for a few months
>>now, and LD_ASSUME_KERNEL=2.4.1 won't work with my host-system (gentoo)
>>since it doesn't come with a 2nd glibc-versions.
> 
> That fix is only needed with TT mode off, SKAS mode on and Static Linking on, 
> as far as I know.

Well, i've got a NPTL-glibc here, and when starting 2.6.8.1-um1, it puts 
itself into background (however that is possible) and if i type "fg" on 
the shell, it segfaults.

Static linkage seems fails with the following error:
gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free 
-Wl,--wrap,calloc \
         -o linux arch/um/main.o vmlinux -L/usr/lib -lutil
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bin/ld: 
BFD 2.15.90.0.1.1 20040303 assertion fail elf.c:3470
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bin/ld: 
BFD 2.15.90.0.1.1 20040303 assertion fail elf.c:3470
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bin/ld: 
BFD 2.15.90.0.1.1 20040303 assertion fail elf.c:3470
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bin/ld: 
BFD 2.15.90.0.1.1 20040303 assertion fail elf.c:3470
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bin/ld: 
linux: Not enough room for program headers (allocated 6, need 8)
/usr/lib/gcc-lib/i686-pc-linux-gnu/3.3.4/../../../../i686-pc-linux-gnu/bin/ld: 
final link failed: Bad value
collect2: ld returned 1 exit status


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
