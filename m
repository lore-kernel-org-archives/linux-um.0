Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwCsk-00020Z-Fy for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 00:58:10 -0700
Received: from mailout1-1.pacific.net.au ([61.8.2.208]
	helo=mailout1.pacific.net.au)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HwCsi-0000TX-RW
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2007 00:58:10 -0700
Received: from mailproxy1.pacific.net.au (mailproxy1.pacific.net.au
	[61.8.2.162])
	by mailout1.pacific.net.au (Postfix) with ESMTP id D9DF0372F8F
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  7 Jun 2007 17:58:05 +1000 (EST)
Received: from deepthought.Elpro.local (ppp2609.dsl.pacific.net.au
	[203.143.249.9])
	by mailproxy1.pacific.net.au (Postfix) with ESMTP id 87B668C42
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  7 Jun 2007 17:58:05 +1000 (EST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 7 Jun 2007 17:57:19 +1000
Message-ID: <7EDC24AB1ED682439657D3B7790609D39825E6@deepthought.Elpro.local>
From: "Andrew Sinclair" <Andrew.Sinclair@elprotech.com>
Subject: [uml-devel] Building a UML uClinux(Busybox/uClibc) filesystem
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hello all,

I've been able to use the pre-built Busybox 1.5.0 filesystem at
http://uml.nagafix.co.uk/ perfectly with the same UML kernel I am using.


Unfortunately, when trying to generate my own filesystem, my kernel no
longer works. It basically stops after mounting the filesystem. 

When I try and use gdb to debug I get stuck in
arch/um/include/um_uaccess.h:50

static inline int copy_to_user(void __user *to, const void *from, int n)
{
        return(CHOOSE_MODE_PROC(copy_to_user_tt, copy_to_user_skas, to, 
                                from, n));
}

If I put the kernel in tracing thread mode, to avoid this, it falls over
even with the prebuilt nagafix filesystem.

I have been unable to build the automated Busybox root filesystem
builder (based on buildroot) on
http://user-mode-linux.sourceforge.net/contrib.html
A number of the package download links in the makefile no longer exist,
so I searched the web for the packages from other locations. Perhaps I
have the wrong packages. I have got it to the point where it is looking
for a uml-gcc that is not in the build folder.

I've noticed that the nagafix prebuilt filesystem has no lib folder. I
guess this means that the pre-built filesystem was built with glibc?
(Unlike the mine or the buildroot variant which use uClibc)

Can anyone guide me as to how I can debug this from here? 


$ ./images/linux umid=unit_1 ubd0=./images/root_fs  init=/bin/sh
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
  - /proc/mm...not found
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found
UML running in SKAS0 mode
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
[42949372.960000] Linux version 2.6.17-uc1-adi3
(andrew.sinclair@LinuxMachine.elpro) (gcc version 4.1.1 20070105 (Red
Hat 4.1.1-51)) #19 Thu Jun 7 12:03:20 EST 2007
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: ubd0=./images/root_fs
init=/bin/sh root=98:0
[42949372.960000] PID hash table entries: 256 (order: 8, 1024 bytes)
[42949372.960000] Dentry cache hash table entries: 4096 (order: 2, 16384
bytes)
[42949372.960000] Inode-cache hash table entries: 2048 (order: 1, 8192
bytes)
[42949372.960000] Memory: 29108k available
[42949373.220000] Mount-cache hash table entries: 512
[42949373.220000] Checking for host processor cmov support...Yes
[42949373.220000] Checking for host processor xmm support...No
[42949373.220000] Checking that host ptys support output SIGIO...Yes
[42949373.220000] Checking that host ptys support SIGIO on close...No,
enabling workaround
[42949373.220000] Using 2.6 host AIO
[42949373.220000] NET: Registered protocol family 16
[42949373.220000] NET: Registered protocol family 2
[42949373.300000] IP route cache hash table entries: 1024 (order: 0,
4096 bytes)
[42949373.300000] TCP established hash table entries: 1024 (order: 0,
4096 bytes)
[42949373.300000] TCP bind hash table entries: 1024 (order: 0, 4096
bytes)
[42949373.300000] TCP: Hash tables configured (established 1024 bind
1024)
[42949373.300000] TCP reno registered
[42949373.300000] Checking host MADV_REMOVE support...OK
[42949373.300000] mconsole (version 2) initialized on
/home/andrew.sinclair/.uml/unit_1/mconsole
[42949373.300000] Host TLS support detected
[42949373.300000] Detected host type: i386
[42949373.300000] io scheduler noop registered (default)
[42949373.300000] RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
[42949373.300000] loop: loaded (max 8 devices)
[42949373.300000] TCP bic registered
[42949373.300000] 802.1Q VLAN Support v1.8 Ben Greear
<greearb@candelatech.com>
[42949373.300000] All bugs added by David S. Miller <davem@redhat.com>
[42949373.300000] Initialized stdio console driver
[42949373.300000] Console initialized on /dev/tty0
[42949373.300000] Initializing software serial port version 1
[42949373.300000]  ubda: unknown partition table
[42949373.300000] VFS: Mounted root (ext2 filesystem) readonly.



Kind Regards,

Andrew Sinclair

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
