Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <50485.151.205.59.135.1091030391.squirrel@www.csee.wvu.edu>
Subject: Re: [uml-devel] help needed for running uml on a sarge
From: <atanugul@csee.wvu.edu>
In-Reply-To: <200407272357.02784.a_mulyadi@telkom.net>
References: <1359.157.182.42.226.1090946399.squirrel@www.csee.wvu.edu>
	<200407272357.02784.a_mulyadi@telkom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Wed, 28 Jul 2004 11:59:51 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
To: a_mulyadi@telkom.net
Cc: user-mode-linux-devel@lists.sourceforge.net, atanugul@csee.wvu.edu, user-mode-linux-user@lists.sourceforge.net

Hi!
I downloaded some root file sytems and got the following errors on a
Debian 2.6.3-1-386 when I tired to run UML
1)with Debian-3.0r0.ext2 rootfs

ashwin@Debian:/usr/bin$ ./linux ubd0=3D/uml/Debian-3.0r0.ext2
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid =3D 1974
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Linux version 2.4.26-1um (root@mizar) (gcc version 3.3.3 (Debian
20040422)) #2 Sat Jun 5 12:15:21 PDT 2004
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=3D/uml/Debian-3.0r0.ext2 root=3D/dev/ubd0
Calibrating delay loop... 4023.91 BogoMIPS
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
mconsole (version 2) initialized on /home/ashwin/.uml/I4vNmf/mconsole
Partition check:
 ubda: unknown partition table
Initializing stdio console driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
INIT: version 2.84 booting
Activating swap.
Checking root file system...
fsck 1.27 (8-Mar-2002)
fsck.ext2: No such file or directory while trying to open /dev/ubd/0
/dev/ubd/0:
The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>


fsck failed.  Please repair manually and reboot.  Please note
that the root file system is currently mounted read-only.  To
remount it read-write:

 # mount -n -o remount,rw /

CONTROL-D will exit from this shell and REBOOT the system.

(none):~#



2)with root_fs_toms1.7.205

ashwin@Debian:/usr/bin$ ./linux ubd0=3D/uml/root_fs_toms1.7.205
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid =3D 2085
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
Linux version 2.4.26-1um (root@mizar) (gcc version 3.3.3 (Debian
20040422)) #2 Sat Jun 5 12:15:21 PDT 2004On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ubd0=3D/uml/root_fs_toms1.7.205 root=3D/dev/ubd0
Calibrating delay loop... 4010.80 BogoMIPS
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
mconsole (version 2) initialized on /home/ashwin/.uml/brsNYL/mconsole
Partition check:
 ubda: unknown partition table
Initializing stdio console driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
INIT: version 2.84 booting
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
INIT: Entering runlevel: 5

Can anyone tell me what i can do?

Thanks,
Ashwin.



> Hello :-)
>
>> Please append a correct "root=3D" boot option
>> Kernel panic: VFS: Unable to mount root fs on 62:00
>>  <6>SysRq : Show Regs
>
> have u create root disk image? You can use UMLBuilder of mkrootfs to do
>  that....
>
> regards
>
> Mulyadi





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
