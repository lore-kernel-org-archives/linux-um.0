Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DIUJc-0007O1-8L for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Apr 2005 09:20:40 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DIUJb-0000xV-Ef for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Apr 2005 09:20:40 -0700
Message-ID: <4251694E.1090403@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030407070707050003090700"
Subject: [uml-devel] UML/s390 is up in SKAS0 mode
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
Date: Mon, 04 Apr 2005 18:20:30 +0200
To: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>

This is a multi-part message in MIME format.
--------------030407070707050003090700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The first UML/s390 system is running (in SKAS0).

	Bodo

--------------030407070707050003090700
Content-Type: text/plain;
 name="UML_s390-logging"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="UML_s390-logging"

140lin3:/home2/uml0 # /usr/src/tmp/linux-2.6.11/vmlinux ubd0=sles9.rootfs.img ubd1=swap.img ssl=pts
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...missing
Checking if syscall restart handling in host can be skipped...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found
  - PTRACE_FAULTINFO...found
Checking PROT_EXEC mmap in /tmp...OK
Host doesn't provide PTRACE_GETREGS, going to use PTRACE_POKEUSR_AREA
Linux version 2.6.11 (root@s140lin3) (gcc version 3.2.2) #14 Thu Mar 24 16:57:24 CET 2005
Built 1 zonelists
Kernel command line: ubd0=sles9.rootfs.img ubd1=swap.img ssl=pts root=98:0
PID hash table entries: 256 (order: 8, 4096 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 28584k available
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
NET: Registered protocol family 16
mconsole (version 2) initialized on /root/.uml/EzYeVm/mconsole
audit: initializing netlink socket (disabled)
audit(0.230:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
i8042.c: i8042 controller self test timeout.
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
 ubda: unknown partition table
 ubdb: unknown partition table
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
line_ioctl: tty0: ioctl KDSIGACCEPT called
INIT: version 2.85 booting
line_ioctl: tty0: unknown ioctl: 0x80045432
System Boot Control: Running /etc/init.d/boot
Mounting /proc filesystem                                                   done
Mounting sysfs on /sys                                                      done
Mounting /dev/pts                                                           done
Mounting shared memory FS on /dev/shm                                       done
Activating swap-devices in /etc/fstab...
Adding 262136k swap on /dev/ubdb.  Priority:42 extents:1                    done
line_ioctl: tty0: unknown ioctl: 0x80045432
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking root file system...
fsck 1.34 (25-Jul-2003)
[/sbin/fsck.ext2 (1) -- /] fsck.ext2 -a /dev/ubda
/dev/ubda: clean, 96800/244320 files, 474491/488279 blocks                  done
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Activating device mapper...
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Creating /dev/mapper/control character device with major:10 minor:63.
                                                                            done
Scanning for LVM volume groups...
  Reading all physical volumes.  This may take a while...
  No volume groups found
Activating LVM volume groups...
  No volume groups found
                                                                            skipped
line_ioctl: tty0: unknown ioctl: 0x80045432
showconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking file systems...
fsck 1.34 (25-Jul-2003)
Checking all file systems.                                                  done
Setting up                                                                  done
Mounting local file systems...
proc on /proc type proc (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
nothing was mounted                                                         done
Loading required kernel modules                                             done
Activating remaining swap-devices in /etc/fstab...                          done
Restore device permissions                                                  done
Creating /var/log/boot.msg                                                  done
Setting up the system clock                                                 done
Setting up timezone data                                                    done
Setting scheduling timeslices                                               unused
Setting up hostname 'sles9s390'                                             done
Setting up loopback interface     lo
    lo        IP address: 127.0.0.1/8
                                                                            done
Enabling syn flood protection                                               done
Disabling IP forwarding                                                     done
                                                                            done
System Boot Control: The system has been                                    set up
Skipped features:                                                    boot.sched
System Boot Control: Running /etc/init.d/boot.local                         done
INIT: Entering runlevel: 3

... snip ...

Starting Name Service Cache Daemon                                          done
Starting mail service (Postfix)                                             done
Starting CRON daemon                                                        done
Master Resource Control: runlevel 3 has been                                reached
Failed services in runlevel 3:                                      network kbd
Skipped services in runlevel 3:                                smbfs nfs splash
Give root password for login:

... snip ...

sles9s390:~ # uname -a
Linux sles9s390 2.6.11 #14 Thu Mar 24 16:57:24 CET 2005 s390 s390 s390 GNU/Linux
sles9s390:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : User Mode Linux
model name      : UML
mode            : skas
host            : Linux s120lin3 2.4.21-fsc.11-highmem #13 SMP Thu Mar 24 17:56:19 CET 2005 s390
bogomips        : 778.24

sles9s390:~ #

--------------030407070707050003090700--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
