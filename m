Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmNek-0001ij-Ao for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 19:13:30 -0700
Received: from stateless.plumtree.co.nz ([202.89.35.97])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BmNej-0004N5-Lp for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 19:13:30 -0700
From: Nicholas Lee <nj.lee@plumtree.co.nz>
Subject: Re: [uml-devel] [Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0"]
Message-ID: <20040719021321.GB23215@stateless>
References: <20040718184513.GP4090@mizar.alcor.net>
	<20040719000403.GA23215@stateless>
	<20040719002409.GA4456@mcgroarty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719002409.GA4456@mcgroarty.net>
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
Date: Mon, 19 Jul 2004 14:13:21 +1200
To: Brian McGroarty <brian@mcgroarty.net>
Cc: Matt Zimmerman <mdz@debian.org>, user-mode-linux-devel@lists.sourceforge.net, 260111-forwarded@bugs.debian.org


Well this is odd.

I can get it to start with my 2.4.25 kernel.

/uml/weather/linux-2.4.25  con=null con0=fd:0,fd:1 mem=256M \
ubda=/uml/weather/weather.ext2 ubd1=/uml/weather/swapfs     \
eth0=tuntap,uml-weather  eth1=tuntap,uml-weather-int

This fails

uml/weather/linux-2.4.26  con=null con0=fd:0,fd:1 mem=256M \
ubda=/uml/weather/weather.ext2 ubd1=/uml/weather/swapfs    \
eth0=tuntap,uml-weather  eth1=tuntap,uml-weather-int


This sometimes works, but not this time:-

nic@stateless:/uml/weather] /uml/weather/linux-2.4.26  con=null \
con0=fd:0,fd:1 mem=256M ubda=/uml/weather/weather.ext2 ubd1=/uml/weather/swapfs
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Kernel virtual memory size shrunk to 258998272 bytes Checking for /dev/anon on the host...Not available (open failed with
errno 2)
Linux version 2.4.26-2um (nic@stateless) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #1 Sat Jul 17 11:46:02 NZST 2004
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: con=null con0=fd:0,fd:1 mem=256M
ubda=/uml/weather/weather.ext2 ubd1=/uml/weather/swapfs root=/dev/ubd0
Calibrating delay loop... 3525.83 BogoMIPS
Kernel panic: Segfault with no mm
In idle task - not syncing
 <6>SysRq : Show Regs

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000 Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
Call Trace: [<a00ec2f0>] [<a00d4d5f>] [<a001db8d>] [<a0011c48>] [<a00d3fcb>]
   [<a01c69d2>] [<a0166ae4>] [<a00d1a23>] [<a00d4425>] [<a00da944>] [<a00d4535>]
   [<a01669f8>] [<a00da8e5>] [<a00da8dd>] [<a00d4535>] [<a01669f8>] [<a00da8e5>]
   [<a00da8dd>] [<a00d4535>] [<a01669f8>] [<a00da8e5>] [<a00da8dd>] [<a00d4535>]
   [<a01669f8>] [<a00da8e5>] [<a0195905>] [<a01783c2>] [<a01c698d>] [<a01c698d>]
   [<a0007bc8>] [<a01c95b1>] [<a01c6766>] [<a017eb37>] [<a00d2fea>] [<a01c6766>]
   [<a01783c2>] [<a0008387>] [<a00da8dd>] [<a00d4535>] [<a01669f8>] [<a00da8e5>]
   [<a00da8dd>] [<a00d4535>] [<a01669f8>] [<a00da8e5>] [<a00da8dd>] [<a00d4535>]
   [<a01669f8>] [<a001ae05>] [<a001af46>] [<a001b127>] [<a00d3699>] [<a01669f8>]
   [<a00d98f3>] [<a00d9969>] [<a00d3670>] [<a01669f8>] [<a01669f8>] [<a01669f8>]
   [<a00d9db0>] [<a01669f8>] [<a0166ae4>] [<a00d1920>] [<a00d9db0>] [<a00d99e1>]
   [<a00ce641>] [<a01667ec>] [<a00d9929>] [<a00da168>] [<a00df103>] [<a00d4bed>]
   [<a000c1b0>] [<a000c3ee>] [<a017eacb>] [<a017a681>] [<a0177fca>] [<a01783c2>]
   [<a017f234>] [<a0198f5a>] [<a01666f0>] [<a01661cc>] [<a000c021>] [<a000c210>]
   [<a0166690>] [<a01666f0>] [<a000c000>]



Strangely this works:

 /uml/weather/linux-2.4.26  con=null con0=fd:0,fd:1         mem=256M  \
ubda=/uml/weather/weather.ext2 ubd1=/uml/weather/swapfs | tee log2.txt

and this:

/uml/weather/linux-2.4.26  con=null con0=fd:0,fd:1         mem=256M
ubda=/uml/weather/weather.ext2         ubd1=/uml/weather/swapfs
eth0=tuntap,uml-weather  eth1=tuntap,uml-weather-int | tee log3.txt

full networking works on the last.


Note versions used:

Linux version 2.4.26-2um (nic@stateless) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #1 Sat Jul 17 11:46:02 NZST 2004
Linux version 2.4.25-1um (nic@stateless) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #1 Mon Mar 8 11:09:39 NZDT 2004

[nic@stateless:/uml/weather] uname -a
Linux stateless 2.4.25 #1 SMP Sat Mar 27 16:35:34 NZST 2004 i686 GNU/Linux

Both hosts and guest using SKAS.



These seems to be the only major differences in the tee log files:

+aio_thread failed to initialize context, err = 38
+2.6 AIO not supported on the host - reverting to 2.4 AIO

+ip_tables: (C) 2000-2002 Netfilter core team


This works as well:
/uml/weather/linux-2.4.26  con=null con0=fd:0,fd:1         mem=256M
ubda=/uml/weather/weather.ext2         ubd1=/uml/weather/swapfs
eth0=tuntap,uml-weather  eth1=tuntap,uml-weather-int 2>&1 | tee /dev/null


So 2.4.25 works, and 2.4.26 requires tee to work.

Nicholas




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
