Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dn0vn-0008JT-GO	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jun 2005 14:14:15 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1Dn0vh-0000qk-K3	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jun 2005 14:14:15 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.63.0506271708560.6415@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] NPTL can't be disabled in fc4?
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
Date: Mon, 27 Jun 2005 17:13:24 -0400 (EDT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>, Jeff Dike <jdike@addtoit.com>

Good afternoon, all,
 	I tried to boot an fc4 VM ( http://www.stearns.org/uml-root/ )on 
zaphod.
 	I compiled 2.6.12-mm1-um26121_20050627 at Jeff's suggestion, and 
still get:

Setting hostname placeholder.stearns.org:  [  OK  ]
set_thread_area failed when setting up thread-local storage

 	It doesn't appear that any of the patches in Jeff's current 2.6 
quilt patch set refer to set_thread_area (Although I could believe that 
one of them addresses it indirectly so the string doesn't show up in the 
patches.)
 	Even adding LD_ASSUME_KERNEL=2.4.1 to the end of the kernel 
command line (which, according to doc/kernel-parameters.txt passes that 
environment variable on to the environment inside the VM) doesn't help. 
LD_ASSUME_KERNEL=2.2.5 on the kernel command line also exhibits 
set_thread_area failed....
 	I've also tried disabling nptl from userspace with the following 
added lines:

/etc/profile.d/glibc.sh
export LD_ASSUME_KERNEL=2.4.19

/etc/init.d/functions
export LD_ASSUME_KERNEL=2.4.19

/etc/initscript : (make mode 755)
export LD_ASSUME_KERNEL=2.4.19
eval exec "$4"

 	Still hitting that set_thread_area error.

 	Is there _any_ way to convince an fc4 userspace to not use NPTL?
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
         "Revolutions do not require corporate support."
(Courtesy of Matthew Wilcox <willy@debian.org>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
