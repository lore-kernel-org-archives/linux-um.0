Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <17845.157.182.105.1.1097195659.squirrel@www.csee.wvu.edu>
Subject: Re: [uml-devel] building from source
From: <atanugul@csee.wvu.edu>
In-Reply-To: <200410012125.20048.blaisorblade_spam@yahoo.it>
References: <1220.157.182.105.1.1096501625.squirrel@www.csee.wvu.edu>
	<200410012125.20048.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Thu, 7 Oct 2004 20:34:19 -0400 (EDT)
Content-Transfer-Encoding: 8bit
To: blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net, atanugul@csee.wvu.edu, user-mode-linux-user@lists.sourceforge.net

Hi!
Building from source worked fine. Thanks for your help, but i am having a
problem with my uml.when i tried running it i got the follwing errors. How can i make ti run?


Debian:~# linux ubd0=/uml/root_fs_debian2.2_small
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 3037
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Linux version 2.4.26-2um (root@mizar) (gcc version 3.3.4 (Debian
1:3.3.4-3)) #2 Fri Jul 16 17:51:17 PDT 2004On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=/uml/root_fs_debian2.2_small root=/dev/ubd0
Calibrating delay loop... 3335.78 BogoMIPS
Memory: 28148k available
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Disabling 2.6 AIO in tt mode
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Initializing Cryptographic API
Initializing software serial port version 1
mconsole (version 2) initialized on /root/.uml/8V6n5Q/mconsole
Partition check:
 ubda: unknown partition table
Initializing stdio console driver
NET4: Linux TCP/IP 1.0 for NET4.0

how can i make it run?

Thanks,
Ashwin
> On Thursday 30 September 2004 01:47, atanugul@csee.wvu.edu wrote:
>> Hi!
>> I tried building a uml kernel from source.I have a debian 2.6.6 kernel
>> on my system. I downloaded a 2.4.26 kernel and a matching uml patch
>> (uml-patch-2.4.26-1.bz2) for it.I followed the steps specified in the
>> user-mode-linux.
> You should use either 2.4.26-3 on a 2.4.26 vanilla kernel or 2.4.24-1
> on a  2.4.24 vanilla kernel. All the releases between those two have
> various  problems. In fact, the 2.4.26-3um patch fixes exactly this
> problem (which  happens because you enabled CONFIG_SMP).
>
> Bye
>
>> Everything went well till step 5. When I did `make linux
>> ARCH=um' I got the following error messages:
>
>> gcc -D__KERNEL__ -I/build/kernel-source-2.4.26/include -Wall
>> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
>> -O2 -U__i386__ -Ui386 -fprofile-arcs -ftest-coverage -g -D__arch_um__
>> -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE
>> -I/build/kernel-source-2.4.26/arch/um/include -Derrno=kernel_errno
>> -I/build/kernel-source-2.4.26/arch/um/kernel/tt/include
>> -I/build/kernel-source-2.4.26/arch/um/kernel/skas/include -c
>> mk_thread_kern.cIn file included from mk_thread_kern.c:3:
>> /build/kernel-source-2.4.26/include/linux/sched.h:366: error:
>> `CONFIG_NR_CPUS' undeclared here (not in a
>> function)/build/kernel-source-2.4.26/include/linux/sched.h:366: error:
>> `CONFIG_NR_CPUS' undeclared here (not in a
>> function)/build/kernel-source-2.4.26/include/linux/sched.h:528: error:
>> `CONFIG_NR_CPUS' undeclared here (not in a function)make[1]: ***
>> [mk_thread_kern.o] Error 1 make[1]: Leaving directory
>> `/build/kernel-source-2.4.26/arch/um/sys-i386/util'make: ***
>> [arch/um/sys-i386/util/mk_thread] Error 2
>
>> Can anyone tell me what i should do?
>
> --
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729





-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
