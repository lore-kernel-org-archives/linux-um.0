Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX8Wj-0004VU-FS
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 16:29:57 -0800
Received: from mta9.adelphia.net ([68.168.78.199])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AX8Wj-0001DH-3h
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 16:29:57 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20031219002949.GX18100@alcor.net>
References: <1071789754.763978.973.nullmailer@nietzsche.wgtn.cat-it.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071789754.763978.973.nullmailer@nietzsche.wgtn.cat-it.co.nz>
Subject: [uml-devel] Re: Bug#224431: user-mode-linux: Hangs
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Dec 2003 16:29:49 -0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Srdjan <srdjan@catalyst.net.nz>, 224431-forwarded@bugs.debian.org

retitle 224431 Fails to start init in tt mode
thanks

On Fri, Dec 19, 2003 at 12:22:34PM +1300, Srdjan wrote:

> srdjan@nietzsche:/plato-home/srdjan/local/user-mode-linux$ linux eth0=tuntap,,,192.168.2.98
> Checking for the skas3 patch in the host...not found
> Checking for /proc/mm...not found
> tracing thread pid = 927
> Linux version 2.4.22-7um (mdz@mizar) (gcc version 2.95.4 20011002
> (Debian prerelease)) #1 Tue Dec 16 14:55:39 PST 2003
> On node 0 totalpages: 8192
> zone(0): 8192 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: eth0=tuntap,,,192.168.2.98 root=/dev/ubd0
> Calibrating delay loop... 1513.52 BogoMIPS
> Memory: 28848k available
> Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
> Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Checking for host processor cmov support...Yes
> Checking for host processor xmm support...No
> Checking that ptrace can change system call numbers...OK
> Checking that host ptys support output SIGIO...Yes
> Checking that host ptys support SIGIO on close...No, enabling workaround
> Checking for /dev/anon on the host...Not available (open failed with errno 2)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> VFS: Disk quotas vdquot_6.5.1
> Journalled Block Device driver loaded
> devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> pty: 256 Unix98 ptys configured
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> Initializing Cryptographic API
> Initializing software serial port version 1
> mconsole (version 2) initialized on /home/srdjan/.uml/gIRhMa/mconsole

Are you able to connect to it with mconsole?

> Partition check:
>  ubda: unknown partition table
>  Initializing stdio console driver
>  Netdevice 0 : TUN/TAP backend - IP = 192.168.2.98
>  NET4: Linux TCP/IP 1.0 for NET4.0
>  IP: routing cache hash table of 512 buckets, 4Kbytes
>  TCP: Hash tables configured (established 2048 bind 2048)
>  Linux IP multicast router 0.06 plus PIM-SM
>  NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>  VFS: Mounted root (ext2 filesystem) readonly.
> 
> And stops...

Apparently, tt mode is broken.  I use skas, which is working fine in
2.4.22-7um-1, but I can reproduce your failure with mode=tt.

What was the last version which worked for you?  The only difference in the
kernel configuration since 2.4.22-5um-1 is CONFIG_UML_REAL_TIME_CLOCK=y.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
