Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ELIUZ-00089L-GU	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 03:51:51 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ELIUY-0005oN-02
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2005 03:51:51 -0700
Received: by wproxy.gmail.com with SMTP id i1so103671wra
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 30 Sep 2005 03:51:43 -0700 (PDT)
Message-ID: <229e70f205093003511a49c171@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Reply-To: Etay Meiri <etay.meiri@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6933_20303368.1128077503790"
Subject: [uml-devel] Error running UML
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
Date: Fri, 30 Sep 2005 13:51:43 +0300
To: user-mode-linux-devel@lists.sourceforge.net

------=_Part_6933_20303368.1128077503790
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I downloaded a root file system from:
http://www.stearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.bz2
and followed the instructions in
http://www.stearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.note
in order to extract it. I am able to mount it as a loop device without
problems.
I applied the patch from
http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.13-bs2/u=
ml-2.6.13-bs2.patch.bz2
to the 2.6.13 vanilla kernel and built a uml kernel with ext3 support not a=
s
a module.
Now when I run it I get the following error:

[cl@amber uml]$ ./vmlinux mem=3D160M ubd0=3Droot_fs.2005062201 ubd1=3Dswap
root=3D/dev/ubd/0 con=3Dpty con0=3Dfd:0,fd:1
Checking for /proc/mm...not found
Checking for the skas3 patch in the host...not found
UML running in SKAS0 mode
Checking PROT_EXEC mmap in /tmp...OK
Adding 15347712 bytes to physical memory to account for exec-shield gap
[42949372.960000] Linux version 2.6.13-bs2 (cl@amber) (gcc version
4.0.120050727 (Red Hat
4.0.1-5)) #1 Fri Sep 30 13:10:14 IDT 2005
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: mem=3D160M ubd0=3Droot_fs.2005062201
ubd1=3Dswap root=3D/dev/ubd/0 con=3Dpty con0=3Dfd:0,fd:1
[42949372.960000] PID hash table entries: 1024 (order: 10, 16384 bytes)
[42949372.960000] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes)
[42949372.960000] Inode-cache hash table entries: 16384 (order: 4, 65536
bytes)
[42949372.960000] Memory: 153984k available
[42949373.210000] Security Framework v1.0.0 initialized
[42949373.210000] SELinux: Initializing.
[42949373.210000] SELinux: Starting in permissive mode
[42949373.210000] selinux_register_security: Registering secondary module
capability
[42949373.210000] Capability LSM initialized as secondary
[42949373.210000] Mount-cache hash table entries: 512
[42949373.220000] Checking for host processor cmov support...Yes
[42949373.220000] Checking for host processor xmm support...No
[42949373.220000] Checking that ptrace can change system call numbers...OK
[42949373.220000] Checking syscall emulation patch for ptrace...missing
[42949373.220000] Checking that host ptys support output SIGIO...Yes
[42949373.220000] Checking that host ptys support SIGIO on close...No,
enabling workaround
[42949373.220000] Checking for /dev/anon on the host...Not available (open
failed with errno 2)
[42949373.220000] NET: Registered protocol family 16
[42949373.230000] mconsole (version 2) initialized on
/home/cl/.uml/aAKSzJ/mconsole
[42949373.230000] audit: initializing netlink socket (disabled)
[42949373.230000] audit(0.270:1): initialized
[42949373.230000] VFS: Disk quotas dquot_6.5.1
[42949373.230000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes=
)
[42949373.230000] SELinux: Registering netfilter hooks
[42949373.280000] Initializing Cryptographic API
[42949373.280000] io scheduler noop registered
[42949373.280000] io scheduler anticipatory registered
[42949373.280000] io scheduler deadline registered
[42949373.280000] io scheduler cfq registered
[42949373.280000] RAMDISK driver initialized: 16 RAM disks of 16384K size
1024 blocksize
[42949373.280000] loop: loaded (max 8 devices)
[42949373.280000] nbd: registered device at major 43
[42949373.300000] NET: Registered protocol family 2
[42949373.430000] IP route cache hash table entries: 2048 (order: 1, 8192
bytes)
[42949373.430000] TCP established hash table entries: 8192 (order: 4, 65536
bytes)
[42949373.430000] TCP bind hash table entries: 8192 (order: 5, 229376 bytes=
)
[42949373.430000] TCP: Hash tables configured (established 8192 bind 8192)
[42949373.430000] TCP reno registered
[42949373.430000] TCP bic registered
[42949373.430000] Initializing IPsec netlink socket
[42949373.430000] NET: Registered protocol family 1
[42949373.430000] NET: Registered protocol family 17
[42949373.430000] Initialized stdio console driver
[42949373.430000] Console initialized on /dev/tty0
[42949373.430000] ubda: unknown partition table
[42949373.560000] ubdb: unknown partition table
[42949373.560000] VFS: Cannot open root device "ubd/0" or unknown-block(0,0=
)
[42949373.560000] Please append a correct "root=3D" boot option
[42949373.560000] Kernel panic - not syncing: VFS: Unable to mount root fs
on unknown-block(0,0)
[42949373.560000]
[42949373.560000] EIP: 0073:[<a0382721>] CPU: 0 Not tainted ESP:
007b:b7f7df9c EFLAGS: 00200246
[42949373.560000] Not tainted
[42949373.560000] EAX: 00000000 EBX: 00000a1f ECX: 00000013 EDX: 00000a1f
[42949373.560000] ESI: 00000a1e EDI: 00000011 EBP: b7f7dfb8 DS: 007b ES:
007b
[42949373.560000] aae97ac0: [<a006304d>] show_regs+0x309/0x378
[42949373.560000] aae97af0: [<a002d1c3>] panic_exit+0x43/0x8c
[42949373.560000] aae97b20: [<a0097206>] notifier_call_chain+0x2e/0x88
[42949373.560000] aae97b50: [<a006d7df>] panic+0x9f/0x1f8
[42949373.560000] aae97b80: [<a000231a>] mount_block_root+0x116/0x1cc
[42949373.560000] aae97bd0: [<a00025ee>] mount_root+0x7e/0x94
[42949373.560000] aae97bf0: [<a000266d>] prepare_namespace+0x69/0x224
[42949373.560000] aae97c00: [<a001c3c7>] init+0x1d7/0x220
[42949373.560000] aae97c20: [<a00227c5>] run_kernel_thread+0x59/0x74
[42949373.560000] aae97ce0: [<a003538e>] new_thread_handler+0xd2/0x138
[42949373.560000] aae97d20: [<b7f7f420>] 0xb7f7f420
[42949373.560000]
[42949373.560000]
[cl@amber uml]$

Any idea?

Thanks,

--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_6933_20303368.1128077503790
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I downloaded a root file system from:<br clear=3D"all"><a href=3D"http://ww=
w.stearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.bz2">http://www.=
stearns.org/uml-root/root_fs.fc-4-base.pristine.20050622.bz2</a><br>
and followed the instructions in <br>
<a href=3D"http://www.stearns.org/uml-root/root_fs.fc-4-base.pristine.20050=
622.note">http://www.stearns.org/uml-root/root_fs.fc-4-base.pristine.200506=
22.note</a><br>
in order to extract it. I am able to mount it as a loop device without prob=
lems.<br>
I applied the patch from<br>
<a href=3D"http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2=
.6.13-bs2/uml-2.6.13-bs2.patch.bz2">http://www.user-mode-linux.org/~blaisor=
blade/patches/guest/uml-2.6.13-bs2/uml-2.6.13-bs2.patch.bz2</a><br>
to the 2.6.13 vanilla kernel and built a uml kernel with ext3 support not a=
s a module.<br>
Now when I run it I get the following error:<br>
<br>
[cl@amber uml]$ ./vmlinux mem=3D160M ubd0=3Droot_fs.2005062201 ubd1=3Dswap =
root=3D/dev/ubd/0 con=3Dpty con0=3Dfd:0,fd:1<br>
Checking for /proc/mm...not found<br>
Checking for the skas3 patch in the host...not found<br>
UML running in SKAS0 mode<br>
Checking PROT_EXEC mmap in /tmp...OK<br>
Adding 15347712 bytes to physical memory to account for exec-shield gap<br>
[42949372.960000] Linux version 2.6.13-bs2 (cl@amber) (gcc version
4.0.1 20050727 (Red Hat 4.0.1-5)) #1 Fri Sep 30 13:10:14 IDT 2005<br>
[42949372.960000] Built 1 zonelists<br>
[42949372.960000] Kernel command line: mem=3D160M ubd0=3Droot_fs.2005062201=
 ubd1=3Dswap root=3D/dev/ubd/0 con=3Dpty con0=3Dfd:0,fd:1<br>
[42949372.960000] PID hash table entries: 1024 (order: 10, 16384 bytes)<br>
[42949372.960000] Dentry cache hash table entries: 32768 (order: 5, 131072 =
bytes)<br>
[42949372.960000] Inode-cache hash table entries: 16384 (order: 4, 65536 by=
tes)<br>
[42949372.960000] Memory: 153984k available<br>
[42949373.210000] Security Framework v1.0.0 initialized<br>
[42949373.210000] SELinux:&nbsp; Initializing.<br>
[42949373.210000] SELinux:&nbsp; Starting in permissive mode<br>
[42949373.210000] selinux_register_security:&nbsp; Registering secondary mo=
dule capability<br>
[42949373.210000] Capability LSM initialized as secondary<br>
[42949373.210000] Mount-cache hash table entries: 512<br>
[42949373.220000] Checking for host processor cmov support...Yes<br>
[42949373.220000] Checking for host processor xmm support...No<br>
[42949373.220000] Checking that ptrace can change system call numbers...OK<=
br>
[42949373.220000] Checking syscall emulation patch for ptrace...missing<br>
[42949373.220000] Checking that host ptys support output SIGIO...Yes<br>
[42949373.220000] Checking that host ptys support SIGIO on close...No, enab=
ling workaround<br>
[42949373.220000] Checking for /dev/anon on the host...Not available (open =
failed with errno 2)<br>
[42949373.220000] NET: Registered protocol family 16<br>
[42949373.230000] mconsole (version 2) initialized on /home/cl/.uml/aAKSzJ/=
mconsole<br>
[42949373.230000] audit: initializing netlink socket (disabled)<br>
[42949373.230000] audit(0.270:1): initialized<br>
[42949373.230000] VFS: Disk quotas dquot_6.5.1<br>
[42949373.230000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes=
)<br>
[42949373.230000] SELinux:&nbsp; Registering netfilter hooks<br>
[42949373.280000] Initializing Cryptographic API<br>
[42949373.280000] io scheduler noop registered<br>
[42949373.280000] io scheduler anticipatory registered<br>
[42949373.280000] io scheduler deadline registered<br>
[42949373.280000] io scheduler cfq registered<br>
[42949373.280000] RAMDISK driver initialized: 16 RAM disks of 16384K size 1=
024 blocksize<br>
[42949373.280000] loop: loaded (max 8 devices)<br>
[42949373.280000] nbd: registered device at major 43<br>
[42949373.300000] NET: Registered protocol family 2<br>
[42949373.430000] IP route cache hash table entries: 2048 (order: 1, 8192 b=
ytes)<br>
[42949373.430000] TCP established hash table entries: 8192 (order: 4, 65536=
 bytes)<br>
[42949373.430000] TCP bind hash table entries: 8192 (order: 5, 229376 bytes=
)<br>
[42949373.430000] TCP: Hash tables configured (established 8192 bind 8192)<=
br>
[42949373.430000] TCP reno registered<br>
[42949373.430000] TCP bic registered<br>
[42949373.430000] Initializing IPsec netlink socket<br>
[42949373.430000] NET: Registered protocol family 1<br>
[42949373.430000] NET: Registered protocol family 17<br>
[42949373.430000] Initialized stdio console driver<br>
[42949373.430000] Console initialized on /dev/tty0<br>
[42949373.430000]&nbsp; ubda: unknown partition table<br>
[42949373.560000]&nbsp; ubdb: unknown partition table<br>
[42949373.560000] VFS: Cannot open root device &quot;ubd/0&quot; or unknown=
-block(0,0)<br>
[42949373.560000] Please append a correct &quot;root=3D&quot; boot option<b=
r>
[42949373.560000] Kernel panic - not syncing: VFS: Unable to mount root fs =
on unknown-block(0,0)<br>
[42949373.560000]<br>
[42949373.560000] EIP: 0073:[&lt;a0382721&gt;] CPU: 0 Not tainted ESP: 007b=
:b7f7df9c EFLAGS: 00200246<br>
[42949373.560000]&nbsp;&nbsp;&nbsp;&nbsp; Not tainted<br>
[42949373.560000] EAX: 00000000 EBX: 00000a1f ECX: 00000013 EDX: 00000a1f<b=
r>
[42949373.560000] ESI: 00000a1e EDI: 00000011 EBP: b7f7dfb8 DS: 007b ES: 00=
7b<br>
[42949373.560000] aae97ac0:&nbsp; [&lt;a006304d&gt;] show_regs+0x309/0x378<=
br>
[42949373.560000] aae97af0:&nbsp; [&lt;a002d1c3&gt;] panic_exit+0x43/0x8c<b=
r>
[42949373.560000] aae97b20:&nbsp; [&lt;a0097206&gt;] notifier_call_chain+0x=
2e/0x88<br>
[42949373.560000] aae97b50:&nbsp; [&lt;a006d7df&gt;] panic+0x9f/0x1f8<br>
[42949373.560000] aae97b80:&nbsp; [&lt;a000231a&gt;] mount_block_root+0x116=
/0x1cc<br>
[42949373.560000] aae97bd0:&nbsp; [&lt;a00025ee&gt;] mount_root+0x7e/0x94<b=
r>
[42949373.560000] aae97bf0:&nbsp; [&lt;a000266d&gt;] prepare_namespace+0x69=
/0x224<br>
[42949373.560000] aae97c00:&nbsp; [&lt;a001c3c7&gt;] init+0x1d7/0x220<br>
[42949373.560000] aae97c20:&nbsp; [&lt;a00227c5&gt;] run_kernel_thread+0x59=
/0x74<br>
[42949373.560000] aae97ce0:&nbsp; [&lt;a003538e&gt;] new_thread_handler+0xd=
2/0x138<br>
[42949373.560000] aae97d20:&nbsp; [&lt;b7f7f420&gt;] 0xb7f7f420<br>
[42949373.560000]<br>
[42949373.560000]<br>
[cl@amber uml]$ <br>
<br>
Any idea?<br>
<br>
Thanks,<br>
<br>-- <br>------------------------------------------------------<br>Etay M=
eiri<br><a href=3D"mailto:etay.meiri@gmail.com">etay.meiri@gmail.com</a>

------=_Part_6933_20303368.1128077503790--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
