Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F9UuU-0005Js-Bz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Feb 2006 14:14:06 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F9UuS-0004Tu-Fc
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Feb 2006 14:14:06 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id k1FNttNN006805
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 15 Feb 2006 18:55:56 -0500
From: Rob Landley <rob@landley.net>
References: <200602151116.37212.rob.landley@timesys.com>
In-Reply-To: <200602151116.37212.rob.landley@timesys.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602151713.52833.rob@landley.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Error messages booting 2.6.16-pre3
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
Date: Wed, 15 Feb 2006 17:13:52 -0500
To: user-mode-linux-devel@lists.sourceforge.net

So I finally got around to building 2.6.16-pre3 on my newly upgraded Ubuntu 
"Flatulent Badger" system, like so:

tar xvjf linux-2.6.13-rc3.tar.bz2

cat > allno.config << EOF
CONFIG_MODE_SKAS=y
CONFIG_BINFMT_ELF=y
CONFIG_HOSTFS=y
CONFIG_SYSCTL=y
CONFIG_STDERR_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_LBD=y
CONFIG_EXT2_FS=y
CONFIG_PROC_FS=y
EOF
make ARCH=um allnoconfig
make ARCH=um

Run it:

./linux rootfstype=hostfs rw init=/bin/sh

And it's developed yet more verbose error messages:

> Checking for /dev/anon on the host...Not available (open failed with errno
> 2) Using 2.6 host AIO
> io scheduler noop registered (default)
> loop: loaded (max 8 devices)
> Initialized stdio console driver
> parse_chan_pair failed for device 1
> parse_chan_pair failed for device 2
> parse_chan_pair failed for device 3
> parse_chan_pair failed for device 4
> parse_chan_pair failed for device 5
> parse_chan_pair failed for device 6
> parse_chan_pair failed for device 7
> parse_chan_pair failed for device 8
> parse_chan_pair failed for device 9
> parse_chan_pair failed for device 10
> parse_chan_pair failed for device 11
> parse_chan_pair failed for device 12
> parse_chan_pair failed for device 13
> parse_chan_pair failed for device 14
> parse_chan_pair failed for device 15
> Console initialized on /dev/tty0
> VFS: Mounted root (hostfs filesystem).
> idr_remove called for id=1 which is not allocated.
> 0817f984:  [<080f2c7f>] sub_remove+0xef/0x100
> 0817f9a0:  [<0806305a>] set_signals+0x1a/0x30
> 0817f9a8:  [<080905ef>] free_hot_cold_page+0xdf/0x120
> 0817f9ac:  [<080a3633>] kfree+0x23/0x90
> 0817f9c4:  [<080f2cbf>] idr_remove+0x2f/0xc0
> 0817f9dc:  [<080fbd22>] release_dev+0x5e2/0x700
> 0817fa1c:  [<0806b296>] __wake_up+0x46/0x60
> 0817fa44:  [<0806305a>] set_signals+0x1a/0x30
> 0817fa4c:  [<080fb1d5>] init_dev+0x1b5/0x5a0
> 0817fa98:  [<080fbf6f>] tty_open+0x12f/0x380
> 0817fab4:  [<080f340a>] kobject_get+0x1a/0x30
> 0817fac0:  [<080afcff>] cdev_get+0xf/0x20
> 0817fac8:  [<080afeef>] exact_lock+0xf/0x20
> 0817faec:  [<080fbe40>] tty_open+0x0/0x380
> 0817faf4:  [<080afdce>] chrdev_open+0x9e/0x140
> 0817fb14:  [<080afd30>] chrdev_open+0x0/0x140
> 0817fb18:  [<080a57e0>] __dentry_open+0x90/0x190
> 0817fb34:  [<080a5a58>] nameidata_to_filp+0x38/0x50
> 0817fb50:  [<080a593c>] do_filp_open+0x5c/0x60
> 0817fb78:  [<080ec008>] get_request+0x238/0x2f0
> 0817fb98:  [<080a5b4c>] get_unused_fd+0x6c/0xc0
> 0817fbc0:  [<080a5cb1>] do_sys_open+0x51/0xa0
> 0817fbe0:  [<080a5d27>] sys_open+0x27/0x30
> 0817fbe8:  [<080ec008>] get_request+0x238/0x2f0
> 0817fbf4:  [<0805c5fc>] handle_syscall+0xec/0x100
> 0817fbf8:  [<080ec008>] get_request+0x238/0x2f0
> 0817fc14:  [<080ec008>] get_request+0x238/0x2f0
> 0817fc34:  [<080ec008>] get_request+0x238/0x2f0
> 0817fc64:  [<080658d8>] handle_trap+0x28/0x130
> 0817fc8c:  [<08065f44>] userspace+0x1c4/0x220
> 0817fcd8:  [<08054f10>] init+0x0/0x170
> 0817fce4:  [<0805c0c9>] new_thread_handler+0xe9/0x120
>
> sh-3.00#

Came up and ran, but looks really ugly.  Entirely reproducible so far...

Anybody got any ideas?

Rob
-- 
Never bet against the cheap plastic solution.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
