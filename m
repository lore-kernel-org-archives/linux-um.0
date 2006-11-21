Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmbD7-00004r-Vg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 11:23:14 -0800
Received: from nf-out-0910.google.com ([64.233.182.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GmbD4-00058t-29
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 11:23:13 -0800
Received: by nf-out-0910.google.com with SMTP id c31so410434nfb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 21 Nov 2006 11:23:08 -0800 (PST)
Message-ID: <22a33e9f0611211123w3b57d6bdh5e599a87589816c9@mail.gmail.com>
Date: Tue, 21 Nov 2006 19:23:08 +0000
From: "Matt Willsher" <matt@monki.org.uk>
In-Reply-To: <200611210813.14745.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
References: <22a33e9f0611180345w7ec64513l34424a59e1671479@mail.gmail.com>
	<200611210813.14745.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Problem with newer (>2.6.14) UML kernels hanging
	under Xen DomU/Centos 4.4
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
Cc: Blaisorblade <blaisorblade@yahoo.it>

On 11/21/06, Blaisorblade <blaisorblade@yahoo.it> wrote:
> On Saturday 18 November 2006 12:45, Matt Willsher wrote:
> > I've been trying to get UML running under a Xen DomU running Centos
> > 4.4, which I understand is a reasonable thing to do.
> >
> > When I started out I was using a download 2.6.12 kernel and the image
> > booted up fine. I then tried 2.6.18.2, which is hanging after VFS:
> > Mounted root (ext3 filesystem) readonly. I've had someone check my
> > kernel and the image on another machine and it works without problem.
> > I've tried some other kernels, and 2.6.14 seemed ok, 2.6.16 wasn't.

> I have two suggestions for you to try:
> * reduce CONFIG_HOST_VM_SPLIT for UML guest kernels (Xen consumes part of the
> available memory for UML, which causes crashes)
>
> * try if booting with mode=tt helps - around 2.6.14 or 2.6.15 skas0 support
> was introduced (a very big change!) and become the new default, so that's the
> 1st likely culprit.

Thank you for your suggestions.

I must correct myself. 2.6.14 does indeed hang in the same way as
later kernels. I think I tried 2.6.13 resulting in the same hang but I
can't be sure (I've tried rather a lot of kernels this last week!)

I've applied your latest patch bundle to the 2.6.18.3 tree, and set
the VM_HOST split to 1/3. Booting with this, the guest kernel hangs at
the same point. With mode=tt it crashes outright. I've posted the
output from the run below. I've also got an strace output, which I can
post if you want, but thought I'd check first as it's 380K.

The same command line used on the below works with a 2.6.12.2-bb11
kernel. I've also tried init=/bin/sh, again with the same results as
below.

Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
UML running in TT mode
tracing thread pid = 1350
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Linux version 2.6.18.3-bb2 (root@localhost) (gcc version 3.4.6
20060404 (Red Hat 3.4.6-3)) #3 Tue Nov 21 19:06:28 GMT 2006
Built 1 zonelists.  Total pages: 16384
Kernel command line: ubd0=/home/uml/images/ano_router_root_fs
ubd1=/home/uml/images/ano_router_swap_fs mode=tt mem=64M con=null
con0=fd:0,fd:1 con1=port:9000 eth0=tuntap,umltun0 eth1=tuntap,umltun1
root=98:0
PID hash table entries: 512 (order: 9, 2048 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61164k available
Mount-cache hash table entries: 512
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
/usr/include/linux/aio_abi.h not present during build
2.6 host AIO support not used - falling back to I/O thread
Failed to initialize umid "anoroute", trying with a random umid
make_umid - mkstemp(/home/uml/.uml/MyLtrF) failed: Permission denied
NET: Registered protocol family 16
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
Checking host MADV_REMOVE support...OK
make_umid - mkstemp(/home/uml/.uml/i5cVhQ) failed: Permission denied
ubd: Synchronous mode
Netdevice 0 : TUN/TAP backend -
Netdevice 1 : TUN/TAP backend -
Host TLS support detected
Detected host type: i386
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
 ubda: unknown partition table
 ubdb: unknown partition table
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Kernel panic - not syncing: No init found.  Try passing init= option to kernel.

EIP: 0073:[<2017abc1>] CPU: 0 Not tainted ESP: 007b:203357d4 EFLAGS: 00000216
    Not tainted
EAX: 00000000 EBX: 00000566 ECX: 0000000a EDX: 20014df2
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
20333bdc:  [<20048c2c>] notifier_call_chain+0x28/0x3e
20333bf0:  [<2000e193>] init+0x0/0x175
20333bf8:  [<2003643b>] panic+0x70/0xff
20333c10:  [<2000e2a0>] init+0x10d/0x175
20333c2c:  [<20026c66>] run_kernel_thread+0x52/0x5c
20333c3c:  [<2000e193>] init+0x0/0x175
20333c4c:  [<20026c39>] run_kernel_thread+0x25/0x5c
20333cd4:  [<2000e193>] init+0x0/0x175
20333cdc:  [<20014dc1>] new_thread_handler+0x13f/0x170
20333ce0:  [<2000e193>] init+0x0/0x175
20333d48:  [<20014df2>] new_thread_proc+0x0/0x43
20333d5c:  [<2017abc1>] __kill+0x11/0x20

 remove_umid_dir - remove_files_and_dir failed with err = -13

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
