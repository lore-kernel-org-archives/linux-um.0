Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIqRV-0002bA-R1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Apr 2004 07:53:45 -0700
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101]
	helo=sparrow.stearns.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BIqRU-0001RV-Qu
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Apr 2004 07:53:45 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] 2.4.27-pre1 with 2.4.24-2 patch
In-Reply-To: <Pine.LNX.4.44.0404280901550.4504-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.58.0404281051470.8296@sparrow>
References: <Pine.LNX.4.44.0404280901550.4504-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 28 Apr 2004 10:53:34 -0400 (EDT)
To: Henrik Nordstrom <uml@henrik.marasystems.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, William Stearns <wstearns@pobox.com>

Good day, Henrik,

On Wed, 28 Apr 2004, Henrik Nordstrom wrote:

> On Wed, 28 Apr 2004, William Stearns wrote:
> 
> > Thre are a bunch of warnings about __initcal, __exit_call, and
> > __init_call redefinitions.
> 
> Which warnings?

	A sample from late in the build:

gcc -D__KERNEL__ 
-I/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common  -U__i386__ -Ui386 -g -D__arch_um__ -DSUBARCH="i386" 
-D_LARGEFILE64_SOURCE 
-I/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include 
-Derrno=kernel_errno 
-I/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/kernel/tt/include 
-I/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/kernel/skas/include   
-nostdinc -iwithprefix include -DKBUILD_BASENAME=line  -c -o line.o line.c
In file included from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include/chan_user.h:9,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include/chan_kern.h:11,
                 from line.c:12:
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include/init.h:103:1: 
warning: "__initcall" redefined
In file included from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/asm/arch/system.h:6,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/asm/system-generic.h:4,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/asm/system.h:4,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/spinlock.h:6,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/wait.h:16,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/fs.h:12,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/capability.h:17,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/binfmts.h:5,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/sched.h:9,
                 from line.c:6:
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/init.h:54:1: 
warning: this is the location of the previous definition
In file included from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include/chan_user.h:9,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include/chan_kern.h:11,
                 from line.c:12:
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include/init.h:106:1: 
warning: "__init_call" redefined
In file included from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/asm/arch/system.h:6,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/asm/system-generic.h:4,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/asm/system.h:4,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/spinlock.h:6,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/wait.h:16,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/fs.h:12,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/capability.h:17,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/binfmts.h:5,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/sched.h:9,
                 from line.c:6:
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/init.h:84:1: 
warning: this is the location of the previous definition
In file included from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include/chan_user.h:9,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include/chan_kern.h:11,
                 from line.c:12:
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/arch/um/include/init.h:107:1: 
warning: "__exit_call" redefined
In file included from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/asm/arch/system.h:6,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/asm/system-generic.h:4,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/asm/system.h:4,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/spinlock.h:6,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/wait.h:16,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/fs.h:12,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/capability.h:17,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/binfmts.h:5,
                 from 
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/sched.h:9,
                 from line.c:6:
/usr/src/uml-linux/linux-2.4.27-pre1-uml24242-netfilter20040427/include/linux/init.h:85:1: 
warning: this is the location of the previous definition
rm -f built-in.o

	Nothing fatal, just bringing it up.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	If you've been pounding nails with your forehead for years, it may
feel strange the first time somebody hands you a hammer. But that
doesn't mean that you should strap the hammer to a headband just to give
your skull that old familiar jolt.
	-- Wayne Throop, during the ``TCL Wars''
(Courtesy of Steve Dodd <dirk@loth.demon.co.uk>)
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
