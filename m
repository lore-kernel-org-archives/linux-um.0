Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIihb-0003JQ-IP for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Apr 2004 23:37:51 -0700
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101]
	helo=sparrow.stearns.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BIiha-00021T-SD
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Apr 2004 23:37:51 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.58.0404280157180.8296@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] 2.4.27-pre1 with 2.4.24-2 patch
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
Date: Wed, 28 Apr 2004 02:37:34 -0400 (EDT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good evening, Jeff, all,
	The 2.4.24-2 patch goes in pretty well to 2.4.27-pre1, just a few 
offsets and the following minor issues:

	- include/asm-um/system-i386.h has a duplicate definition of
__cmpxchg .  It looks close enough to the one in include/asm/arch/system.h
that I just commented out asm-um's.

	- when compiling the aio code, there's a missing aio_abi.h.

make[2]: Entering directory 
`/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/os-Linux'
gcc    -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -U__i386__ -Ui386 -g -D__arch_um__ -DSUBARCH=\"i386\" 
-D_LARGEFILE64_SOURCE  
-I/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include 
-I/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/kernel/tt/include 
-I/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/kernel/skas/include 
-D_GNU_SOURCE -c -o aio.o aio.c
aio.c:12:27: linux/aio_abi.h: No such file or directory
aio.c: In function `init_aio_26':
aio.c:253: warning: implicit declaration of function `io_setup'
aio.c:253: error: `ctx' undeclared (first use in this function)
aio.c:253: error: (Each undeclared identifier is reported only once
aio.c:253: error: for each function it appears in.)
aio.c:260: error: `aio_thread' undeclared (first use in this function)
aio.c: In function `submit_aio_26':
aio.c:324: warning: implicit declaration of function `do_aio'
aio.c:324: error: `ctx' undeclared (first use in this function)
make[2]: *** [aio.o] Error 1
make[2]: Leaving directory 
`/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/os-Linux'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory 
`/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/os-Linux'
make: *** [_dir_arch/um/os-Linux] Error 2
[wstearns@sparrow linux-2.4.27-pre1-uml24242-netfilter20040427]$ 

	By copying one from 2.6.x to /usr/include/linux/ , the compile 
goes through to the final linking stage.  The binary links and runs.  I'll 
upload it to http://www.stearns.org/uml/

	There are a bunch of warnings about __initcal, __exit_call, and
__init_call redefinitions.
	Cheers,
	- Bill

---------------------------------------------------------------------------
Codito, ergo sum
	"I code, therefore I am"
Nolo Codito, ergo nada
	"My code is so horrible that I ceased to exist last Tuesday."
	-- Ross Carlson and William Stearns
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
