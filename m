Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gmn6M-0005W2-I7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Nov 2006 00:05:02 -0800
Received: from nf-out-0910.google.com ([64.233.182.184])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gmn6L-0001qE-Fv
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Nov 2006 00:05:02 -0800
Received: by nf-out-0910.google.com with SMTP id c31so732636nfb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 22 Nov 2006 00:05:00 -0800 (PST)
Message-ID: <22a33e9f0611220004m46ce8d98nc7f21eff09febc89@mail.gmail.com>
Date: Wed, 22 Nov 2006 08:04:59 +0000
From: "Matt Willsher" <matt@monki.org.uk>
In-Reply-To: <200611220122.24515.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
References: <22a33e9f0611180345w7ec64513l34424a59e1671479@mail.gmail.com>
	<200611210813.14745.blaisorblade@yahoo.it>
	<22a33e9f0611211123w3b57d6bdh5e599a87589816c9@mail.gmail.com>
	<200611220122.24515.blaisorblade@yahoo.it>
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

On 11/22/06, Blaisorblade <blaisorblade@yahoo.it> wrote:
> On Tuesday 21 November 2006 20:23, Matt Willsher wrote:
> > On 11/21/06, Blaisorblade <blaisorblade@yahoo.it> wrote:
> >
> > I've applied your latest patch bundle to the 2.6.18.3 tree, and set
> > the VM_HOST split to 1/3. Booting with this, the guest kernel hangs at
> > the same point. With mode=tt it crashes outright.
>
> mode=tt can possibly work only on _old_ kernel, say the first one where skas0
> was introduced i.e. (if my guess is right) the first one breaking under Xen.

From the output below is the line:

UML running in TT mode

Does that not indicate that it is running in TT mode? The kernel
option for TT mode is set. I tried to disable SKAS support but the
kernel won't compile with out that set (check_host_supports_tls not
found, as reported on the user mailing list last month). I will
however try with 2.6.13 and 2.6.14.

> The output makes me suspicious of some misconfiguration - I've never seen a
> bug giving a misleading "no init found". And it happens that even smart users
> use different command lines, say, because they use a script for the default
> kernel and do not use it for the other one.

The same script was used for both. I copied my start script and simply
changed the kernel file being called and added the mode=tt option. I
was particular about this. I also used the same base .config file for
the 2.6.12 kernel and the 2.6.18 kernel, running menuconfig to
sanitise it, and only adjusted the options you've recommended.

> /home/uml/.uml ($HOME/.uml) seems not writable according to messages below,
> which is _very_ strange.

That was my fault. I accidentally ran the binary as root before
running it as the unpriviledged user. I fixed the permissions and the
error went away but I still get the same crash.

As far as further debugging from me, I'm at the limits of my abilities
in that area. I'm happy do what every anyone requests of me if I'm
given a few pointers in the right direction. I'm keen to see this
issue resolved.

Thanks again for you time on this,

Matt

> > The same command line used on the below works with a 2.6.12.2-bb11
> > kernel. I've also tried init=/bin/sh, again with the same results as
> > below.
> >
> > Checking that ptrace can change system call numbers...OK
> > Checking syscall emulation patch for ptrace...OK
> > Checking advanced syscall emulation patch for ptrace...OK
> > Checking for tmpfs mount on /dev/shm...OK
> > Checking PROT_EXEC mmap in /dev/shm/...OK
> > UML running in TT mode
> > tracing thread pid = 1350
> > Checking that ptrace can change system call numbers...OK
> > Checking syscall emulation patch for ptrace...OK
> > Checking advanced syscall emulation patch for ptrace...OK
> > Linux version 2.6.18.3-bb2 (root@localhost) (gcc version 3.4.6
> > 20060404 (Red Hat 3.4.6-3)) #3 Tue Nov 21 19:06:28 GMT 2006
> > Built 1 zonelists.  Total pages: 16384
> > Kernel command line: ubd0=/home/uml/images/ano_router_root_fs
> > ubd1=/home/uml/images/ano_router_swap_fs mode=tt mem=64M con=null
> > con0=fd:0,fd:1 con1=port:9000 eth0=tuntap,umltun0 eth1=tuntap,umltun1
> > root=98:0
> > PID hash table entries: 512 (order: 9, 2048 bytes)
> > Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> > Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> > Memory: 61164k available
> > Mount-cache hash table entries: 512
> > Checking for host processor cmov support...Yes
> > Checking for host processor xmm support...No
> > Checking that host ptys support output SIGIO...Yes
> > Checking that host ptys support SIGIO on close...No, enabling workaround
> > /usr/include/linux/aio_abi.h not present during build
> > 2.6 host AIO support not used - falling back to I/O thread
> > Failed to initialize umid "anoroute", trying with a random umid
> > make_umid - mkstemp(/home/uml/.uml/MyLtrF) failed: Permission denied
> > NET: Registered protocol family 16
> > NET: Registered protocol family 2
> > IP route cache hash table entries: 512 (order: -1, 2048 bytes)
> > TCP established hash table entries: 2048 (order: 1, 8192 bytes)
> > TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
> > TCP: Hash tables configured (established 2048 bind 1024)
> > TCP reno registered
> > Checking host MADV_REMOVE support...OK
> > make_umid - mkstemp(/home/uml/.uml/i5cVhQ) failed: Permission denied
> > ubd: Synchronous mode
> > Netdevice 0 : TUN/TAP backend -
> > Netdevice 1 : TUN/TAP backend -
> > Host TLS support detected
> > Detected host type: i386
> > Initializing Cryptographic API
> > io scheduler noop registered
> > io scheduler anticipatory registered
> > io scheduler deadline registered
> > io scheduler cfq registered (default)
> > NET: Registered protocol family 1
> > NET: Registered protocol family 17
> > Initialized stdio console driver
> > Console initialized on /dev/tty0
> > Initializing software serial port version 1
> >  ubda: unknown partition table
> >  ubdb: unknown partition table
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode.
> > VFS: Mounted root (ext3 filesystem) readonly.
> > Kernel panic - not syncing: No init found.  Try passing init= option to
> > kernel.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
