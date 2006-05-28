Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkV1g-0008PM-KK for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 May 2006 16:50:28 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FkV1g-0002Qi-Nr for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 May 2006 16:50:28 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FkV1g-0007F8-5o
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 May 2006 16:50:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 590B83C5A7
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 28 May 2006 16:50:24 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14343-09 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 28 May 2006 16:50:23 -0700 (PDT)
Received: from sterling (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 0D64E3C553
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 28 May 2006 16:50:23 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Message-ID: <CBELIFGMBIEPIEOFCJFAGENACAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Warnings compiling linux-2.6.17-rc5
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
Date: Sun, 28 May 2006 16:50:33 -0700
To: UML Developer's List <user-mode-linux-devel@lists.sourceforge.net>

I just tried to compile a new guest kernel using the linux-2.6.17-rc5 kernel
source and encountered the following warnings.

I can post the .config file if needed.

Tony


  SYMLINK arch/um/include/sysdep
make[1]: `arch/um/sys-i386/user-offsets.s' is up to date.
  CHK     include/linux/version.h
  Building modules, stage 2.
  MODPOST
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_nosmp
from .bss between 'stderr@@GLIBC_2.0' (at offset 0x82607c4) and
'completed.4463'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .plt
after '' (at offset 0x8260590)
WARNING: vmlinux - Section mismatch: reference to .init: from .plt after ''
(at offset 0x82605b0)
WARNING: vmlinux - Section mismatch: reference to .init.setup: from .plt
after '' (at offset 0x82605e0)
WARNING: vmlinux - Section mismatch: reference to .init.ramfs: from .plt
after '' (at offset 0x8260600)
WARNING: vmlinux - Section mismatch: reference to .init.text:nosmp from .plt
after '' (at offset 0x826066c)
WARNING: vmlinux - Section mismatch: reference to .init.text:maxcpus from
.plt after '' (at offset 0x8260670)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_maxcpus from .plt after '' (at offset 0x8260678)
WARNING: vmlinux - Section mismatch: reference to
.init.text:obsolete_checksetup from .plt after '' (at offset 0x8260680)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_debug_kernel from .plt after '' (at offset 0x8260690)
WARNING: vmlinux - Section mismatch: reference to .init.text:debug_kernel
from .plt after '' (at offset 0x8260694)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_quiet_kernel from .plt after '' (at offset 0x826069c)
WARNING: vmlinux - Section mismatch: reference to .init.text:quiet_kernel
from .plt after '' (at offset 0x82606a0)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_loglevel from .plt after '' (at offset 0x82606a8)
WARNING: vmlinux - Section mismatch: reference to
.init.text:unknown_bootoption from .plt after '' (at offset 0x82606b0)
WARNING: vmlinux - Section mismatch: reference to .init.text:init_setup from
.plt after '' (at offset 0x82606b8)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_init_setup from .plt after '' (at offset 0x82606c0)
WARNING: vmlinux - Section mismatch: reference to .init.text:rdinit_setup
from .plt after '' (at offset 0x82606c4)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_rdinit_setup from .plt after '' (at offset 0x82606d0)
WARNING: vmlinux - Section mismatch: reference to .init.text:do_early_param
from .plt after '' (at offset 0x82606dc)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_initcall_debug_setup from .plt after '' (at offset
0x82606ec)
WARNING: vmlinux - Section mismatch: reference to
.init.text:initcall_debug_setup from .plt after '' (at offset 0x82606f0)
WARNING: vmlinux - Section mismatch: reference to .init.text:do_initcalls
from .plt after '' (at offset 0x82606f4)
WARNING: vmlinux - Section mismatch: reference to .init.text:do_basic_setup
from .plt after '' (at offset 0x82606fc)
WARNING: vmlinux - Section mismatch: reference to .init.text:load_ramdisk
from .plt after '' (at offset 0x8260710)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_load_ramdisk from .plt after '' (at offset 0x8260714)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_readonly from .plt after '' (at offset 0x826071c)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_readwrite from .plt after '' (at offset 0x8260724)
WARNING: vmlinux - Section mismatch: reference to .init.text:readwrite from
.plt after '' (at offset 0x8260728)
WARNING: vmlinux - Section mismatch: reference to .init.text:root_dev_setup
from .plt after '' (at offset 0x8260730)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_root_dev_setup from .plt after '' (at offset 0x8260738)
WARNING: vmlinux - Section mismatch: reference to
.init.text:root_delay_setup from .plt after '' (at offset 0x826073c)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_root_data_setup from .plt after '' (at offset 0x8260748)
WARNING: vmlinux - Section mismatch: reference to .init.text:root_data_setup
from .plt after '' (at offset 0x826074c)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_fs_names_setup from .plt after '' (at offset 0x8260754)
WARNING: vmlinux - Section mismatch: reference to .init.text:fs_names_setup
from .plt after '' (at offset 0x8260758)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_root_delay_setup from .plt after '' (at offset
0x8260760)
WARNING: vmlinux - Section mismatch: reference to .init.text:get_fs_names
from .plt after '' (at offset 0x8260764)
WARNING: vmlinux - Section mismatch: reference to .init.text:do_mount_root
from .plt after '' (at offset 0x8260770)
WARNING: vmlinux - Section mismatch: reference to .init.text:prompt_ramdisk
from .plt after '' (at offset 0x8260778)
WARNING: vmlinux - Section mismatch: reference to
.init.text:ramdisk_start_setup from .plt after '' (at offset 0x826077c)
WARNING: vmlinux - Section mismatch: reference to
.init.setup:__setup_ramdisk_start_setup from .plt after '' (at offset
0x8260784)
WARNING: vmlinux - Section mismatch: reference to
.init.text:identify_ramdisk_image from .plt after '' (at offset 0x8260788)
WARNING: vmlinux - Section mismatch: reference to .init.text:huft_build from
.plt after '' (at offset 0x82607a8)
WARNING: vmlinux - Section mismatch: reference to .exit.text: from .plt
after '' (at offset 0x82605fc)
WARNING: "strcpy" [net/ipv6/ipv6.ko] undefined!
WARNING: "strcpy" [net/ipv4/netfilter/ipt_recent.ko] undefined!
WARNING: "strcpy" [net/ipv4/netfilter/ip_conntrack_tftp.ko] undefined!
WARNING: "strcpy" [net/ipv4/netfilter/ip_conntrack_irc.ko] undefined!
WARNING: "strcpy" [net/ipv4/netfilter/ip_conntrack_ftp.ko] undefined!
WARNING: "strcpy" [fs/nfsd/nfsd.ko] undefined!
WARNING: "strcpy" [fs/cifs/cifs.ko] undefined!
WARNING: "strcpy" [fs/binfmt_misc.ko] undefined!
WARNING: "strcpy" [drivers/net/bonding/bonding.ko] undefined!
  INSTALL crypto/cast5.ko
  INSTALL crypto/crc32c.ko

<TRIMMED OUTPUT>

  INSTALL net/sched/sch_teql.ko
  INSTALL net/sunrpc/auth_gss/rpcsec_gss_spkm3.ko
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map -b /mnt -r 2.6.17-rc5; fi
WARNING: /mnt/lib/modules/2.6.17-rc5/kernel/net/ipv6/ipv6.ko needs unknown
symbol strcpy
WARNING: /mnt/lib/modules/2.6.17-rc5/kernel/net/ipv4/netfilter/ipt_recent.ko
needs unknown symbol strcpy
WARNING:
/mnt/lib/modules/2.6.17-rc5/kernel/net/ipv4/netfilter/ip_conntrack_tftp.ko
needs unknown symbol strcpy
WARNING:
/mnt/lib/modules/2.6.17-rc5/kernel/net/ipv4/netfilter/ip_conntrack_irc.ko
needs unknown symbol strcpy
WARNING:
/mnt/lib/modules/2.6.17-rc5/kernel/net/ipv4/netfilter/ip_conntrack_ftp.ko
needs unknown symbol strcpy
WARNING: /mnt/lib/modules/2.6.17-rc5/kernel/fs/nfsd/nfsd.ko needs unknown
symbol strcpy
WARNING: /mnt/lib/modules/2.6.17-rc5/kernel/fs/cifs/cifs.ko needs unknown
symbol strcpy
WARNING: /mnt/lib/modules/2.6.17-rc5/kernel/fs/binfmt_misc.ko needs unknown
symbol strcpy
WARNING: /mnt/lib/modules/2.6.17-rc5/kernel/drivers/net/bonding/bonding.ko
needs unknown symbol strcpy
#



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
