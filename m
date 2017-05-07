Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1d7SS1-0005xY-6R
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 May 2017 20:06:41 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d7SS0-0002i8-ED
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 May 2017 20:06:41 +0000
Received: from [95.222.30.43] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.85_2)
	(envelope-from <thomas@m3y3r.de>) id 1d7SRu-0006Nd-D3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 May 2017 22:06:34 +0200
Message-ID: <1494187593.2984.2.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 07 May 2017 22:06:33 +0200
Mime-Version: 1.0
Subject: [uml-devel] warning at vma_merge
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

with the current rw/linux-next I see a lot of those:

Mai 07 22:01:34 bifrst kernel: ------------[ cut here ]------------
Mai 07 22:01:34 bifrst kernel: WARNING: CPU: 0 PID: 505 at mm/mmap.c:1112 vma_merge+0x323/0x3c0
Mai 07 22:01:34 bifrst kernel: Modules linked in:
Mai 07 22:01:34 bifrst kernel: CPU: 0 PID: 505 Comm: less Tainted: G        W       4.11.0-00006-gce45860 #279
Mai 07 22:01:34 bifrst kernel: Stack:
Mai 07 22:01:34 bifrst kernel:  9e69da50 600c5bf4 00000009 00000000
Mai 07 22:01:34 bifrst kernel:  6015c8e6 00000000 9e69da60 604f536c
Mai 07 22:01:34 bifrst kernel:  9e69dac0 600671ae 45800000000 601a38d3
Mai 07 22:01:34 bifrst kernel: Call Trace:
Mai 07 22:01:34 bifrst kernel:  [<601a38d3>] ? vma_merge+0x323/0x3c0
Mai 07 22:01:34 bifrst kernel:  [<6015c8e6>] ? printk+0x0/0x94
Mai 07 22:01:34 bifrst kernel:  [<60044ac9>] show_stack+0x129/0x190
Mai 07 22:01:34 bifrst kernel:  [<600c5bf4>] ? dump_stack_print_info+0xe4/0xf0
Mai 07 22:01:34 bifrst kernel:  [<6015c8e6>] ? printk+0x0/0x94
Mai 07 22:01:34 bifrst kernel:  [<604f536c>] dump_stack+0x2a/0x2e
Mai 07 22:01:34 bifrst kernel:  [<600671ae>] __warn+0x11e/0x150
Mai 07 22:01:34 bifrst kernel:  [<601a38d3>] ? vma_merge+0x323/0x3c0
Mai 07 22:01:34 bifrst kernel:  [<6006732f>] warn_slowpath_null+0x1f/0x30
Mai 07 22:01:34 bifrst kernel:  [<601a38d3>] vma_merge+0x323/0x3c0
Mai 07 22:01:34 bifrst kernel:  [<601a5140>] ? may_expand_vm+0x0/0x170
Mai 07 22:01:34 bifrst kernel:  [<601a781d>] mprotect_fixup+0x14d/0x2e0
Mai 07 22:01:34 bifrst kernel:  [<601de54c>] setup_arg_pages+0x10c/0x470
Mai 07 22:01:34 bifrst kernel:  [<6083cb34>] ? _raw_spin_unlock+0x34/0x40
Mai 07 22:01:34 bifrst kernel:  [<604fe410>] ? memcmp+0x0/0x50
Mai 07 22:01:34 bifrst kernel:  [<60837704>] ? mutex_unlock+0x14/0x20
Mai 07 22:01:34 bifrst kernel:  [<602545aa>] load_elf_binary+0x47a/0xfe0
Mai 07 22:01:34 bifrst kernel:  [<600ba966>] ? lock_release+0x736/0x7f0
Mai 07 22:01:34 bifrst kernel:  [<600ba1e3>] ? lock_acquire+0x203/0x250
Mai 07 22:01:34 bifrst kernel:  [<600b4c3e>] ? lock_acquired+0x4ae/0x530

any idea what is going on here?


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

