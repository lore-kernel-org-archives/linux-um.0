Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EpupY-0003Da-9G for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Dec 2005 13:52:04 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EpupW-000854-KC
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Dec 2005 13:52:04 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512232251.49006.blaisorblade@yahoo.it>
Subject: [uml-devel] uml_mconsole hotunplug crash
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
Date: Fri, 23 Dec 2005 22:51:47 +0100
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

This is just to make this known - on 2.6.14.3-bs3 I did the following:

uml_mconsole umid
config ubd2=toms.cow
config ubd3=toms.cow2
remove ubd2
remove ubd3

this simple sequence leads to a kernel Oops. Complete output below (with 
printk timestamping enabled, as you see :-( ).

(The first is another debug trace, already known)

Note that 
[42949386.950000] Debug: sleeping function called from invalid context 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.14/mm/slab.c:2459
[42949386.950000] in_atomic():1, irqs_disabled():0
[42949386.950000] a1fedefc:  [<a0014672>] dump_stack+0x22/0x30
[42949386.950000] a1fedf1c:  [<a003558c>] __might_sleep+0xac/0xd0
[42949386.950000] a1fedf3c:  [<a006aa21>] __kmalloc+0xc1/0x110
[42949386.950000] a1fedf6c:  [<a0011a39>] um_kmalloc+0x19/0x20
[42949386.950000] a1fedf7c:  [<a001017d>] __wrap_malloc+0x2d/0x80
[42949386.950000] a1fedf8c:  [<a01f6c59>] execvp+0x79/0x2b0
[42949386.950000] a1fedfbc:  [<a000ed3f>] helper_child+0x2f/0xc0
[42949386.950000] a1fedfdc:  [<a01f914a>] clone+0x6a/0x80


[42949386.950000]
[42949415.820000]  ubdc: unknown partition table
[42949423.360000]  ubdd: unknown partition table
[42949429.550000]  ubdc: unknown partition table
[42949432.250000]  ubdd: unknown partition table

(The additions - don't know why duplicated, I notice only now, maybe in this 
time I played a bit more)

[42949436.050000] Kernel panic - not syncing: Segfault with no mm
[42949436.050000]
[42949436.050000] EIP: 0023:[<a01e0341>] CPU: 0 Not tainted ESP: 002b:40000fac 
EFLAGS: 00000202

[42949436.050000]     Not tainted
[42949436.050000] EAX: 00000000 EBX: 00003c02 ECX: 00000013 EDX: 00003c02
[42949436.050000] ESI: 00003bfc EDI: 00000000 EBP: 40000fb8 DS: 002b ES: 002b
[42949436.050000] a08ab2ac:  [<a0032f7a>] show_regs+0x21a/0x230
[42949436.050000] a08ab2dc:  [<a0016edc>] panic_exit+0x2c/0x50
[42949436.050000] a08ab2ec:  [<a004ac85>] notifier_call_chain+0x25/0x40
[42949436.050000] a08ab30c:  [<a0037c01>] panic+0x71/0x100
[42949436.050000] a08ab32c:  [<a00162c5>] segv+0x285/0x2f0
[42949436.050000] a08ab41c:  [<a001660e>] segv_handler+0x9e/0x100
[42949436.050000] a08ab44c:  [<a001d1a2>] sig_handler_common_skas+0xf2/0x130
[42949436.050000] a08ab47c:  [<a002c1b3>] sig_handler+0x33/0x40
[42949436.050000] a08ab48c:  [<ffffe500>] _etext+0x5fdd0b4a/0x0
[42949436.050000] a08ab7ec:  [<a0149c9c>] kobject_unregister+0x2c/0x50
[42949436.050000] a08ab80c:  [<a016184c>] elv_unregister_queue+0x1c/0x30
[42949436.050000] a08ab81c:  [<a01669cd>] blk_unregister_queue+0x2d/0x60
[42949436.050000] a08ab83c:  [<a0167f72>] unlink_gendisk+0x12/0x30
[42949436.050000] a08ab85c:  [<a00ba52e>] del_gendisk+0x5e/0x110
[42949436.050000] a08ab87c:  [<a0026948>] ubd_remove+0x58/0x130
[42949436.050000] a08ab9dc:  [<a0024ff2>] mconsole_remove+0x152/0x180
[42949436.050000] a08abb1c:  [<a002450c>] mc_work_proc+0x4c/0x70
[42949436.050000] a08abb2c:  [<a004edde>] worker_thread+0x21e/0x2f0
[42949436.050000] a08abbdc:  [<a00531da>] kthread+0xaa/0xe0
[42949436.050000] a08abc1c:  [<a002c169>] run_kernel_thread+0x39/0x50
[42949436.050000] a08abcdc:  [<a001c7b4>] new_thread_handler+0xc4/0x120
[42949436.050000] a08abd1c:  [<ffffe500>] _etext+0x5fdd0b4a/0x0
[42949436.050000]
[42949436.050000]  * route del -host 192.168.0.6 dev tap1
[42949436.050000] * bash -c echo 0 > /proc/sys/net/ipv4/conf/tap1/proxy_arp
[42949436.050000] * arp -i eth0 -d 192.168.0.6 pub
deactivate_all_fds failed, errno = 9

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
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
