Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsPHl-0006Jx-Eq
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 08:38:25 -0800
Received: from neo.wh-stuttgart.de ([141.70.120.50])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AsPEj-0006Cq-5p
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 08:35:17 -0800
From: Martin =?iso-8859-1?Q?Thei=DF?= <mtheiss@neo.wh-stuttgart.de>
Message-ID: <20040215163513.GA26606@neo.wh-stuttgart.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
Subject: [uml-devel] syscall sysinfo error
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
Date: Sun, 15 Feb 2004 17:35:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net



--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

recently i tried to run debian-installer on a 2.6.2 uml kernel. it didn't
work. i determined the problem has to be the syscall sysinfo. it return
zeroed values for totalram and totalswap. i proved the problem by creating
an initrd containing this as linuxrc executable:

#include <stdio.h>

struct sysinfo {
	long uptime;                    /* Seconds since boot */
	unsigned long loads[3];         /* 1, 5, and 15 minute load averages */
	unsigned long totalram;         /* Total usable main memory size */
	unsigned long freeram;          /* Available memory size */
	unsigned long sharedram;        /* Amount of shared memory */
	unsigned long bufferram;        /* Memory used by buffers */
	unsigned long totalswap;        /* Total swap space size */
	unsigned long freeswap;         /* swap space still available */
	unsigned short procs;           /* Number of current processes */
	unsigned short pad;             /* Padding needed for m68k */
	unsigned long totalhigh;        /* Total high memory size */
	unsigned long freehigh;         /* Available high memory size */
	unsigned int mem_unit;          /* Memory unit size in bytes */
	char _f[20-2*sizeof(long)-sizeof(int)]; /* Padding: libc5 uses this.. */
};

extern int sysinfo (struct sysinfo* info);

int main(void) {
	struct sysinfo info;
	sysinfo(&info);
	printf("info.mem_unit  =3D %d\n", info.mem_unit);
	printf("info.totalram  =3D %d\n", info.totalram);
	printf("info.totalswap =3D %d\n", info.totalswap);
	return 0;
}

The output of the kernel is following:


Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Linux version 2.6.2-guml-ipt+initrd-1um (mtheiss@scara) (gcc version 3.3.2 =
(Debian)) #8 Sun Feb 15 16:06:36 CET 2004
On node 0 totalpages: 32768
  DMA zone: 32768 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: ubd0=3Drootfs mem=3D128MB ramdisk_size=3D16384 initrd=
=3Droot.bin root=3D98:0
PID hash table entries: 16 (order 4: 128 bytes)
Memory: 119200k available
Calibrating delay loop... 1340.21 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an in=
itrd
Freeing initrd memory: 6900k freed
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno =
2)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
mconsole (version 2) initialized on /home/mtheiss/.uml/mkRSl9/mconsole
ikconfig 0.7 with /proc/config*
Could not kern_mount tmpfs
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
ip_conntrack version 2.1 (932 buckets, 7456 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/=
projects/ipt_recent/
NET: Registered protocol family 1
NET: Registered protocol family 17
Initializing software serial port version 1
Using anticipatory io scheduler
 ubda: unknown partition table
Initializing stdio console driver
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 6900 blocks [1 disk] into ram disk... done.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
info.mem_unit  =3D 1
info.totalram  =3D 0
info.totalswap =3D 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Warning: unable to open an initial console.
Kernel panic: No init found.  Try passing init=3D option to kernel.

Is this a general problem of uml or is it a problem of busybox, which is
using this method to determine the amount of free memory?

Greetings
Martin

--=20
Martin Thei=DF <mtheiss@neo.wh-stutgart.de>
GPG-Fingerprint: EC80 53A2 F0A2 6E6C 74D2  CB6E 002A F6D3 E78B 7F45

The box said 'Requires Windows 95 or better', so I installed Linux - TKK 5

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAL5/AACr20+eLf0URAo+4AKCKLhxTyyBJvT/m2bThcvaEeflW3gCgkBQX
SqAya0HT7EbAFyMZ3bn6o8g=
=l+of
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
