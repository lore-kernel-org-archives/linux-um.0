Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rjones@redhat.com>) id 1V8Zkw-0001AA-29
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Aug 2013 17:48:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V8Zku-00018Q-P8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Aug 2013 17:48:42 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r7BHmYZ7013863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 11 Aug 2013 13:48:34 -0400
Received: from localhost (vpn1-6-112.ams2.redhat.com [10.36.6.112])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id r7BHmXFJ032205 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 11 Aug 2013 13:48:34 -0400
Date: Sun, 11 Aug 2013 18:48:31 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20130811174831.GD10864@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] How to reliably kill all vmlinux processes for a single
	VM?
To: user-mode-linux-devel@lists.sourceforge.net

I found by experimentation that killing (SIGTERM) the first vmlinux
process only kills part of a UML virtual machine.  There are still
vmlinux processes (or threads?) running.

Compare the process listings below before and after sending the
SIGTERM signal to the head process (25356).

Is there a way to reliably kill a single UML VM?  Note that "killall
vmlinux" isn't a suitable answer because I don't want to kill every
UML instance on the host.  Also using process groups is difficult
because it stops ^C (in the parent process) from killing the VM.

I'm thinking perhaps naming the processes using umid=<unique> and
iterating over the process table ...

Rich.

Before:

25356 pts/4    S      0:01 /home/rjones/d/linux/vmlinux mem=500M initrd=/home/rjones/d/libguestfs/tmp/.guestfs-1000/initrd.25291 init=/init guestfs_noreboot=1 rw panic=1 TERM=xterm-256color selinux=0 ubd0=/tmp/test1.img ubd1=/home/rjones/d/libguestfs/tmp/libguestfsUtAePE/cow0 root=/dev/ubdb ssl3=fd:6 guestfs_channel=/dev/ttyS3
25364 pts/4    S      0:00 /home/rjones/d/linux/vmlinux mem=500M initrd=/home/rjones/d/libguestfs/tmp/.guestfs-1000/initrd.25291 init=/init guestfs_noreboot=1 rw panic=1 TERM=xterm-256color selinux=0 ubd0=/tmp/test1.img ubd1=/home/rjones/d/libguestfs/tmp/libguestfsUtAePE/cow0 root=/dev/ubdb ssl3=fd:6 guestfs_channel=/dev/ttyS3
25365 pts/4    S      0:00 /home/rjones/d/linux/vmlinux mem=500M initrd=/home/rjones/d/libguestfs/tmp/.guestfs-1000/initrd.25291 init=/init guestfs_noreboot=1 rw panic=1 TERM=xterm-256color selinux=0 ubd0=/tmp/test1.img ubd1=/home/rjones/d/libguestfs/tmp/libguestfsUtAePE/cow0 root=/dev/ubdb ssl3=fd:6 guestfs_channel=/dev/ttyS3
25366 pts/4    S      0:00 /home/rjones/d/linux/vmlinux mem=500M initrd=/home/rjones/d/libguestfs/tmp/.guestfs-1000/initrd.25291 init=/init guestfs_noreboot=1 rw panic=1 TERM=xterm-256color selinux=0 ubd0=/tmp/test1.img ubd1=/home/rjones/d/libguestfs/tmp/libguestfsUtAePE/cow0 root=/dev/ubdb ssl3=fd:6 guestfs_channel=/dev/ttyS3
25367 pts/4    t      0:00 /home/rjones/d/linux/vmlinux mem=500M initrd=/home/rjones/d/libguestfs/tmp/.guestfs-1000/initrd.25291 init=/init guestfs_noreboot=1 rw panic=1 TERM=xterm-256color selinux=0 ubd0=/tmp/test1.img ubd1=/home/rjones/d/libguestfs/tmp/libguestfsUtAePE/cow0 root=/dev/ubdb ssl3=fd:6 guestfs_channel=/dev/ttyS3
25388 pts/4    t      0:00 /home/rjones/d/linux/vmlinux mem=500M initrd=/home/rjones/d/libguestfs/tmp/.guestfs-1000/initrd.25291 init=/init guestfs_noreboot=1 rw panic=1 TERM=xterm-256color selinux=0 ubd0=/tmp/test1.img ubd1=/home/rjones/d/libguestfs/tmp/libguestfsUtAePE/cow0 root=/dev/ubdb ssl3=fd:6 guestfs_channel=/dev/ttyS3
25437 pts/4    t      0:00 /home/rjones/d/linux/vmlinux mem=500M initrd=/home/rjones/d/libguestfs/tmp/.guestfs-1000/initrd.25291 init=/init guestfs_noreboot=1 rw panic=1 TERM=xterm-256color selinux=0 ubd0=/tmp/test1.img ubd1=/home/rjones/d/libguestfs/tmp/libguestfsUtAePE/cow0 root=/dev/ubdb ssl3=fd:6 guestfs_channel=/dev/ttyS3

After:

25364 pts/4    S      0:00 /home/rjones/d/linux/vmlinux mem=500M initrd=/home/rjones/d/libguestfs/tmp/.guestfs-1000/initrd.25291 init=/init guestfs_noreboot=1 rw panic=1 TERM=xterm-256color selinux=0 ubd0=/tmp/test1.img ubd1=/home/rjones/d/libguestfs/tmp/libguestfsUtAePE/cow0 root=/dev/ubdb ssl3=fd:6 guestfs_channel=/dev/ttyS3
25365 pts/4    S      0:00 /home/rjones/d/linux/vmlinux mem=500M initrd=/home/rjones/d/libguestfs/tmp/.guestfs-1000/initrd.25291 init=/init guestfs_noreboot=1 rw panic=1 TERM=xterm-256color selinux=0 ubd0=/tmp/test1.img ubd1=/home/rjones/d/libguestfs/tmp/libguestfsUtAePE/cow0 root=/dev/ubdb ssl3=fd:6 guestfs_channel=/dev/ttyS3
25366 pts/4    S      0:00 /home/rjones/d/linux/vmlinux mem=500M initrd=/home/rjones/d/libguestfs/tmp/.guestfs-1000/initrd.25291 init=/init guestfs_noreboot=1 rw panic=1 TERM=xterm-256color selinux=0 ubd0=/tmp/test1.img ubd1=/home/rjones/d/libguestfs/tmp/libguestfsUtAePE/cow0 root=/dev/ubdb ssl3=fd:6 guestfs_channel=/dev/ttyS3



-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

