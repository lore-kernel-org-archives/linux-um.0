Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQ8Cj-0000Yw-Nr for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 15:07:01 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KQ8Cg-000080-Nh for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 15:07:01 -0700
Received: from [192.168.130.27] (lnxtleo01004.meduna.lan [192.168.130.27])
	by meduna.org (Postfix) with ESMTP id B6CB49C434
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  5 Aug 2008 00:14:41 +0200 (CEST)
Message-ID: <48977D4E.4070104@meduna.org>
Date: Tue, 05 Aug 2008 00:06:06 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <48970AEC.6020503@meduna.org>
	<20080804203319.GA14732@c2.user-mode-linux.org>
	<48976DB8.3020001@meduna.org>
	<20080804214731.GA18697@c2.user-mode-linux.org>
In-Reply-To: <20080804214731.GA18697@c2.user-mode-linux.org>
Subject: Re: [uml-devel] sysconf(_SC_NPROCESSORS_CONF) returning zero
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:

> I see it counting cpu<n> lines in /proc/stat, which is what I'm
> seeing.  It will also look at /proc/cpuinfo.  Can you strace your
> version and see if it's looking there at all?

No.. looks like they changed the method:

open("/sys/devices/system/cpu", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|0x80
000) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(3, F_GETFD)                     = 0x1 (flags FD_CLOEXEC)
getdents64(3, /* 5 entries */, 4096)    = 144
getdents64(3, /* 0 entries */, 4096)    = 0
close(3)                                = 0

No reference to /proc/stat nor /proc/cpuinfo.

# ls -l /sys/devices/system/cpu
-r--r--r-- 1 root root 4096 2008-08-04 23:51 online
-r--r--r-- 1 root root 4096 2008-08-04 23:51 possible
-r--r--r-- 1 root root 4096 2008-08-04 23:51 present

# cat /sys/devices/system/cpu/online
0
# cat /sys/devices/system/cpu/possible
0
# cat /sys/devices/system/cpu/present
0


On another Linux (real, 2.6.18) this looks completely
different:

$ ls -l /sys/devices/system/cpu
total 0
drwxr-xr-x 4 root root 0 2008-08-04 23:53 cpu0


$ ls -l /sys/devices/system/cpu/cpu0/
total 0
drwxr-xr-x 5 root root    0 2007-06-11 09:30 cache
-r-------- 1 root root 4096 2008-08-04 23:53 crash_notes
drwxr-xr-x 2 root root    0 2007-06-11 09:30 topology


Well.. so this is an interface definition problem.. now who has
changet something and did not tell the others..


-- 
                                   Stano

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
