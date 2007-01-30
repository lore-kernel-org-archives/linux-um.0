Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HByrC-00007B-Q5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 11:41:31 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HByr9-0000be-Si
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 11:41:30 -0800
Message-ID: <45BF9F59.9010602@nagafix.co.uk>
Date: Tue, 30 Jan 2007 19:41:13 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <45BF901F.40206@nagafix.co.uk>
In-Reply-To: <45BF901F.40206@nagafix.co.uk>
Subject: Re: [uml-devel] do_syscall_stub: syscall 9 failed
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

It is 100% reproducible now, here is the gcc compilation output:

/bin/sh 
/var/tmp/portage/gcc-4.1.1-r1/work/gcc-4.1.1/gcc/../move-if-change 
tmp-attrtab.c insn-attrtab.c
insn-attrtab.c is unchanged
echo timestamp > s-attrtab
stage1/xgcc -Bstage1/ -B/usr/x86_64-pc-linux-gnu/bin/   -O2 
-fprofile-generate -DIN_GCC   -W -Wall -Wwrite-strings 
-Wstrict-prototypes -Wmissing-prototypes -pedantic -Wno-long-long 
-Wno-variadic-macros -Wold-style-definition -Wmissing-format-attribute 
    -DHAVE_CONFIG_H -I. -I. 
-I/var/tmp/portage/gcc-4.1.1-r1/work/gcc-4.1.1/gcc 
-I/var/tmp/portage/gcc-4.1.1-r1/work/gcc-4.1.1/gcc/. 
-I/var/tmp/portage/gcc-4.1.1-r1/work/gcc-4.1.1/gcc/../include 
-I/var/tmp/portage/gcc-4.1.1-r1/work/gcc-4.1.1/gcc/../libcpp/include 
  -c insn-attrtab.c \
   -o insn-attrtab.o
xgcc: Internal error: Killed (program cc1)
Please submit a full bug report.
See <URL:http://bugs.gentoo.org/> for instructions.
make[2]: *** [insn-attrtab.o] Error 1
make[2]: Leaving directory `/var/tmp/portage/gcc-4.1.1-r1/work/build/gcc'
make[1]: *** [stageprofile_build] Error 2
make[1]: Leaving directory `/var/tmp/portage/gcc-4.1.1-r1/work/build/gcc'
make: *** [profiledbootstrap] Error 2


And the new dmesg:
[42984014.510000] do_syscall_stub : ret = -12, offset = 548682067984, 
data = 0000000075e0f010
[42984014.510000] do_syscall_stub: syscall 9 failed, return value = 
0xfffffffffffffff4, expected return value = 0x48786000
[42984014.510000]     syscall parameters: 0x48786000 0x1000 0x5 0x11 0x3 
0x16cee000
[42984014.510000] fix_range_common: failed, killing current process



Antoine Martin wrote:
> Just caught this in `dmesg`
> 
> [42977596.520000] Adding 131064k swap on /dev/ubdb.  Priority:-1 
> extents:1 across:131064k
> [42980169.290000] do_syscall_stub : ret = -12, offset = 548682067984, 
> data = 0000000060b16010
> [42980169.290000] do_syscall_stub: syscall 9 failed, return value = 
> 0xfffffffffffffff4, expected return value = 0x477a000
> [42980169.290000]     syscall parameters: 0x477a000 0x1000 0x7 0x11 0x3 
> 0xad0c000
> [42980169.290000] fix_range_common: failed, killing current process
> 
> Whilst trying to compile gcc (big beast) on a 64-bit UML instance.
> Earlier it had failed and triggered OOM, which is why I added the swap, 
> now it may still not have enough (compilation crashed in a similar 
> manner) but this time there is no OOM message.
> 
> Any ideas what this is?
> 
> Cheers
> Antoine
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
