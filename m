Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dn1bM-00023a-GY	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jun 2005 14:57:12 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dn1bK-0002f9-UM	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jun 2005 14:57:12 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] NPTL can't be disabled in fc4?
In-Reply-To: <Pine.LNX.4.63.0506271708560.6415@sparrow>
Message-ID: <Pine.LNX.4.63.0506271724020.6543@sparrow>
References: <Pine.LNX.4.63.0506271708560.6415@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Mon, 27 Jun 2005 17:56:25 -0400 (EDT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

Good afternoon, all,

On Mon, 27 Jun 2005, William Stearns wrote:

> 	I tried to boot an fc4 VM ( http://www.stearns.org/uml-root/ )on 
> zaphod.
> 	I compiled 2.6.12-mm1-um26121_20050627 at Jeff's suggestion, and 
> still get:
>
> Setting hostname placeholder.stearns.org:  [  OK  ]
> set_thread_area failed when setting up thread-local storage
>
> 	It doesn't appear that any of the patches in Jeff's current 2.6 quilt 
> patch set refer to set_thread_area (Although I could believe that one of them 
> addresses it indirectly so the string doesn't show up in the patches.)
> 	Even adding LD_ASSUME_KERNEL=2.4.1 to the end of the kernel command 
> line (which, according to doc/kernel-parameters.txt passes that environment 
> variable on to the environment inside the VM) doesn't help. 
> LD_ASSUME_KERNEL=2.2.5 on the kernel command line also exhibits 
> set_thread_area failed....
> 	I've also tried disabling nptl from userspace with the following 
> added lines:
>
> /etc/profile.d/glibc.sh
> export LD_ASSUME_KERNEL=2.4.19
>
> /etc/init.d/functions
> export LD_ASSUME_KERNEL=2.4.19
>
> /etc/initscript : (make mode 755)
> export LD_ASSUME_KERNEL=2.4.19
> eval exec "$4"
>
> 	Still hitting that set_thread_area error.
>
> 	Is there _any_ way to convince an fc4 userspace to not use NPTL?

 	Oops, forgot to mention that I already have renamed /lib/tls 
(already done in stock dowmloadable root_fs....) and /usr/lib/tls (not 
done in downloadable root_fs, but done by hand here.

Also, Blaisorblade wrote:

> Yes, it's indicated on the FC4 release notes, I already posted this link
> (http://fedora.redhat.com/docs/release-notes/fc4/).

 	I tried adding the following line to /etc/profile.d/glibc.sh, 
/etc/init.d/functions, and /etc/initscript (skipped {,64} because this is 
32 bit only):
export LD_LIBRARY_PATH=/lib/obsolete/linuxthreads

 	and I still get:

Setting hostname placeholder.stearns.org:  [  OK  ]
set_thread_area failed when setting up thread-local storage
/etc/rc.d/rc.sysinit: line 323:   757 Done                    echo 
"raidautorun /dev/md0"
        758 Segmentation fault      | nash --quiet
set_thread_area failed when setting up thread-local storage
/etc/rc.d/rc.sysinit: line 340:   760 Done                    echo 
"mkdmnod"
        761 Segmentation fault      | /sbin/nash --quiet >/dev/null 2>&1
set_thread_area failed when setting up thread-local storage
/etc/rc.d/rc.sysinit: line 340:   762 Segmentation fault 
/sbin/lvm.static vgscan --mknodes --ignorelockingfailure >/dev/null 2>&1
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext2 (1) -- /] fsck.ext2 -a /dev/ubd/0
set_thread_area failed when setting up thread-local storage
Warning... fsck.ext2 for device /dev/ubd/0 exited with signal 11.
[FAILED]

*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
Give root password for maintenance
(or type Control-D to continue):

 	Blaisor, was there some other piece of that release note you were 
referring to?

 	I've also tried, in addition to the three system files above, 
adding the "LD_ASSUME_KERNEL=2.4.19 
LD_LIBRARY_PATH=/lib/obsolete/linuxthreads" to the end of the kernel 
command line.  Same problem.
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	Too many packets
 	Syn. Ack. Fin. I. C. M. P.
 	I am so tired
 	-- Dennis McGrath
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
