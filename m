Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0eix-0001QD-2O for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Feb 2005 03:49:07 -0800
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D0eiv-0002R5-BB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Feb 2005 03:49:06 -0800
From: Anton Altaparmakov <aia21@cam.ac.uk>
Content-Type: text/plain
Message-Id: <1108381733.10703.5.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [BUG: UML 2.6.11-rc4-bk-latest] sleeping function called
	from invalid context and segmentation fault
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
Date: Mon, 14 Feb 2005 11:48:53 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, lkml <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Hi,

I get a few Debug messages of the form from UML:

Debug: sleeping function called from invalid context at
include/asm/arch/semaphore.h:107
in_atomic():0, irqs_disabled():1
Call Trace:
087d77b0:  [<0809aaa5>] __might_sleep+0x135/0x180
087d77d8:  [<084d377f>] mcount+0xf/0x20
087d77e0:  [<0807cc13>] uml_console_write+0x33/0x80
087d7800:  [<080a2138>] __call_console_drivers+0x88/0xc0
087d7830:  [<080a2b9c>] release_console_sem+0x33c/0x5f0
087d7850:  [<080a3a69>] vprintk+0x309/0x5f0
087d7868:  [<084d377f>] mcount+0xf/0x20
087d78a0:  [<080a23f6>] printk+0x26/0x40
087d78b0:  [<081678a2>] d_splice_alias+0x2f2/0x3e0
087d78c0:  [<0807f272>] line_ioctl+0x102/0x120
087d78dc:  [<0807f170>] line_ioctl+0x0/0x120
087d78e0:  [<0807f17a>] line_ioctl+0xa/0x120
087d78f0:  [<0832b83d>] tty_ioctl+0x2bd/0x2a00
087d7930:  [<08073539>] get_signals+0x49/0xb0
087d7940:  [<08155fb1>] link_path_walk+0x1931/0x2580
087d7948:  [<081e3d00>] ext3_permission+0x0/0x30
087d7970:  [<0809115b>] os_window_size+0x2b/0x80
087d7990:  [<0807e5f2>] generic_window_size+0x32/0xb0
087d79c0:  [<0807d3cb>] chan_window_size+0x8b/0xa0
087d79e0:  [<080801b3>] line_open+0x93/0x240
087d7a10:  [<0807cb7c>] con_open+0x2c/0x40
087d7a30:  [<083293b2>] tty_open+0x332/0x750
087d7a58:  [<084d377f>] mcount+0xf/0x20
087d7a68:  [<08144e48>] exact_match+0x8/0x20
087d7a90:  [<08073218>] enable_mask+0x78/0xb0
087d7aa0:  [<0807331e>] set_signals+0xce/0x2a0
087d7ad0:  [<0815b49e>] do_ioctl+0x6e/0xe0
087d7b00:  [<0815b608>] vfs_ioctl+0xf8/0x960
087d7b40:  [<084d377f>] mcount+0xf/0x20
087d7b60:  [<0815becf>] sys_ioctl+0x5f/0xb0
087d7b74:  [<084d377f>] mcount+0xf/0x20
087d7b90:  [<0807b162>] execute_syscall_skas+0xc2/0xe0
087d7bb0:  [<0807b0ae>] execute_syscall_skas+0xe/0xe0
087d7be0:  [<0806fa1c>] syscall_trace+0xc/0x200
087d7c00:  [<084d377f>] mcount+0xf/0x20
087d7c20:  [<0807b1fb>] handle_syscall+0x5b/0xb0
087d7c30:  [<08093c52>] save_registers+0x42/0xb0
087d7c50:  [<0807a19d>] userspace+0x45d/0x6e0
087d7c78:  [<0807e000>] chan_interrupt+0x250/0x420
087d7cb0:  [<0809c8c1>] schedule_tail+0x21/0x100
087d7cc4:  [<08068250>] init+0x0/0x410
087d7cd0:  [<0807aed7>] new_thread_handler+0x117/0x190
087d7d20:  [<084c2358>] __restore+0x0/0x8
087d7d60:  [<084c2511>] kill+0x11/0x20

Most are coming via uml_console_write.  If interested you can get the
full UML console log (starting uml, logging in as root and shutting it
down again) here:

http://www-uxsup.csx.cam.ac.uk/~aia21/linux/uml/uml-console-log.txt

Also, once the UML has shutdown, the gnome-terminals (which I use
instead of xterm) do not disappear and I get the following segmentation
fault on the host:

vmlinux umid=uml0 mem=256m ubd0=ubd0 ubd1=/usr/src/ntfs_hdd10
eth0=tuntap,uml0,fe:fd:dd:f8:a6:4e ssl=none con=xterm
xterm=gnome-terminal,-t,-x root=/dev/ubda1
Set 'uml0' persistent and owned by uid 29847
Starting uml...
Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK
 
/home/aia21/bin/my-start-uml: line 76:  9613 Segmentation
fault      /bin/bash -c "./$KERNEL $UML_ARGS $*"
Set 'uml0' nonpersistent

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
