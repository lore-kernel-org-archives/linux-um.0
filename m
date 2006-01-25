Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1m5j-0001aQ-Er for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Jan 2006 06:57:47 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1F1m5g-0001iG-Gm
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Jan 2006 06:57:47 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <84144f020601250133o1fd90c7vf05e8f17e1a51c2a@mail.gmail.com>
In-Reply-To: <84144f020601250133o1fd90c7vf05e8f17e1a51c2a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601251557.26762.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [PROBLEM] uml refuses to boot
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
Date: Wed, 25 Jan 2006 15:57:26 +0100
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 25 January 2006 10:33, Pekka Enberg wrote:
> Hi,

> UML in 2.6.16-rc1-git4 fails to boot a Debian 3.0r2 image. The same
> image works boots properly with 2.6.15. Here's the error:

> penberg@haji ~/src/linux/2.6 $ ./linux
> ubd0=/home/penberg/virtualized/Debian-3.0r2.ext2
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking PROT_EXEC mmap in /tmp...OK
> UML running in TT mode

So, first thing, you're still running in TT mode.

FYI, you should probably enable CONFIG_MODE_SKAS - it now (since 2.6.13) works 
even on unpatched hosts, in SKAS0 mode (even if it's a bit slower than 
SKAS3).

The only reason TT mode is still in is that its code is useful for debugging 
and future extension (i.e. there's no SMP support in SKAS0/3 modes).

Please report whether problems arise even in SKAS0 mode.

> tracing thread pid = 32600
> Linux version 2.6.16-rc1-git4 (penberg@haji) (gcc version 3.3.6
> (Gentoo 3.3.6, ssp-3.3.6-1.0, pie-8.7.8)) #1 Wed Jan 25 11:07:25 EET
> 2006
> Built 1 zonelists
> Kernel command line: ubd0=/home/penberg/virtualized/Debian-3.0r2.ext2
> root=98:0 PID hash table entries: 256 (order: 8, 4096 bytes)
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 29388k available
> Mount-cache hash table entries: 512
> Checking for host processor cmov support...Yes
> Checking for host processor xmm support...No
> Checking that host ptys support output SIGIO...Yes
> Checking that host ptys support SIGIO on close...No, enabling workaround
> Checking for /dev/anon on the host...Not available (open failed with errno
> 2) Disabling 2.6 AIO in tt mode
> 2.6 host AIO support not used - falling back to I/O thread
> NET: Registered protocol family 16
> mconsole (version 2) initialized on /home/penberg/.uml/Z81xOu/mconsole
> ubd: Synchronous mode
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> NET: Registered protocol family 2
> IP route cache hash table entries: 512 (order: -1, 2048 bytes)
> TCP established hash table entries: 2048 (order: 1, 8192 bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP reno registered
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Initialized stdio console driver
> Console initialized on /dev/tty0
> Initializing software serial port version 1
>  ubda: unknown partition table
> VFS: Mounted root (ext2 filesystem) readonly.
> line_ioctl: tty0: ioctl KDSIGACCEPT called
> os_set_fd_async : failed to set O_ASYNC and O_NONBLOCK on fd # 6, errno = 9
> register_winch_irq - failed to register IRQ
> os_set_fd_async : failed to set O_ASYNC and O_NONBLOCK on fd # 6, errno = 9
> register_winch_irq - failed to register IRQ
> INIT: os_set_fd_async : failed to set O_ASYNC and O_NONBLOCK on fd #
> 6, errno = 9
> register_winch_irq - failed to register IRQ
> version 2.84 bootingos_set_fd_async : failed to set O_ASYNC and
> O_NONBLOCK on fd # 6, errno = 9
> register_winch_irq - failed to register IRQ
>
> Kernel panic - not syncing: read of switch_pipe failed, errno = 11
>
> EIP: 0073:[<400b6e17>] CPU: 0 Not tainted ESP: 007b:9fe4a090 EFLAGS:
> 00200282 Not tainted
> EAX: 00000271 EBX: 9fe4a25c ECX: 0000540e EDX: 9fe4a25c
> ESI: 00000000 EDI: 00000000 EBP: 9fe4a35c DS: 007b ES: 007b
> a0bc3b74:  [<a0021de7>] show_regs+0xdf/0xe1
> a0bc3ba0:  [<a0010521>] panic_exit+0x25/0x3f
> a0bc3bb0:  [<a0033393>] notifier_call_chain+0x1c/0x3c
> a0bc3bd0:  [<a0025bd2>] panic+0x4b/0xd3
> a0bc3be8:  [<a0010ca2>] switch_to_tt+0xc2/0x129
> a0bc3c1c:  [<a000d0c2>] _switch_to+0x39/0xbe
> a0bc3c50:  [<a015d319>] schedule+0x41f/0x4a0
> a0bc3cb8:  [<a000d163>] interrupt_end+0x1c/0x3a
> a0bc3cc8:  [<a0012167>] sig_handler_common_tt+0xd3/0x100
> a0bc3d04:  [<a001de03>] sig_handler+0x2f/0x3c
> a0bc3d1c:  [<ffffe420>] _etext+0x5fe9ea61/0x0
>
>  sleeping process 1392 got unexpected signal : 10

> remove_umid_dir - actually_do_remove failed with err = -2
> remove_umid_dir - actually_do_remove failed with err = -2

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
