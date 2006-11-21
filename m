Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmfUJ-0002jU-Ak for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 15:57:15 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GmfUD-000333-SO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 15:57:15 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 22 Nov 2006 00:56:57 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JJ5YFfNslURzalg"
Message-Id: <200611220056.58012.blaisorblade@yahoo.it>
Subject: [uml-devel] Spinlock recursion dump from apache stress test
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

--Boundary-00=_JJ5YFfNslURzalg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've got it recently (with a threaded apache on a Sarge UML image, and with 
debug options enabled) and since I doubt I'll have time to look at it soon, 
I'm sending it here.

Some of the "sleeping inside atomic warnings" come from the exec of uml_net on 
shutdown (I built a vanilla -rc6+something kernel), which is fixed by the 
patch about my_execve I sent earlier and which is in -mm.

I know that some issues in style could be improved, but in this year I'm 
really busy with university courses (I'm writing a parser with Boost::Spirit 
for a project, which is cool but time-consuming), so I will not have time to 
clean it up soon.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_JJ5YFfNslURzalg
Content-Type: text/plain;
  charset="us-ascii";
  name="CrashTrace"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="CrashTrace"

[42966190.250000] BUG: spinlock recursion on CPU#0, apache2/664
[42966190.250000]  lock: 0838e768, .magic: dead4ead, .owner: apache2/664, .owner_cpu: 0
[42966190.250000] 09ba7ac4:  [<0805af02>] dump_stack+0x22/0x30
[42966190.250000] 09ba7adc:  [<081befb8>] spin_bug+0xa8/0xb0
[42966190.250000] 09ba7b08:  [<081bf134>] _raw_spin_lock+0x94/0xa0
[42966190.250000] 09ba7b24:  [<0829bcce>] _spin_lock+0xe/0x10
[42966190.250000] 09ba7b30:  [<080a7035>] __do_IRQ+0x25/0xe0
[42966190.250000] 09ba7b58:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7b68:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7ba0:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7bb8:  [<08072c7f>] sig_handler_common_skas+0xbf/0x100
[42966190.250000] 09ba7be0:  [<0806e57e>] real_alarm_handler+0x1e/0x60
[42966190.250000] 09ba7bf4:  [<0806e624>] alarm_handler+0x64/0x80
[42966190.250000] 09ba7c0c:  [<0807117a>] hard_handler+0x1a/0x20
[42966190.250000] 09ba7c1c:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7f1c:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7f2c:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7f64:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7f7c:  [<08072d33>] user_signal+0x73/0x80
[42966190.250000] 09ba7f94:  [<080724fd>] userspace+0x18d/0x230
[42966190.250000] 09ba7fe4:  [<0805d3c6>] fork_handler+0x76/0x90
[42966190.250000] 09ba7ffc:  [<a55a5a5a>] 0xa55a5a5a
[42966190.250000]
[42966190.250000] BUG: spinlock lockup on CPU#0, apache2/664, 0838e768
[42966190.250000] 09ba7ab0:  [<0805af02>] dump_stack+0x22/0x30
[42966190.250000] 09ba7ac8:  [<081bf078>] __spin_lock_debug+0xb8/0xe0
[42966190.250000] 09ba7b08:  [<081bf10f>] _raw_spin_lock+0x6f/0xa0
[42966190.250000] 09ba7b24:  [<0829bcce>] _spin_lock+0xe/0x10
[42966190.250000] 09ba7b30:  [<080a7035>] __do_IRQ+0x25/0xe0
[42966190.250000] 09ba7b58:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7b68:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7ba0:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7bb8:  [<08072c7f>] sig_handler_common_skas+0xbf/0x100
[42966190.250000] 09ba7be0:  [<0806e57e>] real_alarm_handler+0x1e/0x60
[42966190.250000] 09ba7bf4:  [<0806e624>] alarm_handler+0x64/0x80
[42966190.250000] 09ba7c0c:  [<0807117a>] hard_handler+0x1a/0x20
[42966190.250000] 09ba7c1c:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7f1c:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7f2c:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7f64:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7f7c:  [<08072d33>] user_signal+0x73/0x80
[42966190.250000] 09ba7f94:  [<080724fd>] userspace+0x18d/0x230
[42966190.250000] 09ba7fe4:  [<0805d3c6>] fork_handler+0x76/0x90
[42966190.250000] 09ba7ffc:  [<a55a5a5a>] 0xa55a5a5a
[42966190.250000]
[42966190.250000] BUG: warning at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/kernel/irq/manage.c:358/free_irq()
[42966190.250000] 09ba7760:  [<0805af02>] dump_stack+0x22/0x30
[42966190.250000] 09ba7778:  [<080a76ab>] free_irq+0x11b/0x120
[42966190.250000] 09ba77a8:  [<080641b7>] close_devices+0x27/0x70
[42966190.250000] 09ba77bc:  [<08059b53>] do_uml_exitcalls+0x13/0x30
[42966190.250000] 09ba77c8:  [<0805a312>] uml_cleanup+0x12/0x20
[42966190.250000] 09ba77d0:  [<0806ca4b>] last_ditch_exit+0xb/0x20
[42966190.250000] 09ba77dc:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7ac8:  [<081bf023>] __spin_lock_debug+0x63/0xe0
[42966190.250000] 09ba7b08:  [<081bf10f>] _raw_spin_lock+0x6f/0xa0
[42966190.250000] 09ba7b24:  [<0829bcce>] _spin_lock+0xe/0x10
[42966190.250000] 09ba7b30:  [<080a7035>] __do_IRQ+0x25/0xe0
[42966190.250000] 09ba7b58:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7b68:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7ba0:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7bb8:  [<08072c7f>] sig_handler_common_skas+0xbf/0x100
[42966190.250000] 09ba7be0:  [<0806e57e>] real_alarm_handler+0x1e/0x60
[42966190.250000] 09ba7bf4:  [<0806e624>] alarm_handler+0x64/0x80
[42966190.250000] 09ba7c0c:  [<0807117a>] hard_handler+0x1a/0x20
[42966190.250000] 09ba7c1c:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7f1c:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7f2c:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7f64:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7f7c:  [<08072d33>] user_signal+0x73/0x80
[42966190.250000] 09ba7f94:  [<080724fd>] userspace+0x18d/0x230
[42966190.250000] 09ba7fe4:  [<0805d3c6>] fork_handler+0x76/0x90
[42966190.250000] 09ba7ffc:  [<a55a5a5a>] 0xa55a5a5a
[42966190.250000]
[42966190.250000] BUG: sleeping function called from invalid context at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/mm/slab.c:3007
[42966190.250000] in_atomic():1, irqs_disabled():0
[42966190.250000] 09ba7670:  [<0805af02>] dump_stack+0x22/0x30
[42966190.250000] 09ba7688:  [<08079504>] __might_sleep+0xa4/0xe0
[42966190.250000] 09ba76a4:  [<080c8cac>] __kmalloc+0xdc/0x140
[42966190.250000] 09ba76cc:  [<08059a09>] um_kmalloc+0x19/0x20
[42966190.250000] 09ba76dc:  [<080649c3>] change+0xc3/0x120
[42966190.250000] 09ba7750:  [<08064a77>] close_addr+0x27/0x30
[42966190.250000] 09ba7768:  [<0806432e>] iter_addresses+0x3e/0x50
[42966190.250000] 09ba7790:  [<08070d1a>] tuntap_close+0x2a/0x50
[42966190.250000] 09ba77a8:  [<080641da>] close_devices+0x4a/0x70
[42966190.250000] 09ba77bc:  [<08059b53>] do_uml_exitcalls+0x13/0x30
[42966190.250000] 09ba77c8:  [<0805a312>] uml_cleanup+0x12/0x20
[42966190.250000] 09ba77d0:  [<0806ca4b>] last_ditch_exit+0xb/0x20
[42966190.250000] 09ba77dc:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7ac8:  [<081bf023>] __spin_lock_debug+0x63/0xe0
[42966190.250000] 09ba7b08:  [<081bf10f>] _raw_spin_lock+0x6f/0xa0
[42966190.250000] 09ba7b24:  [<0829bcce>] _spin_lock+0xe/0x10
[42966190.250000] 09ba7b30:  [<080a7035>] __do_IRQ+0x25/0xe0
[42966190.250000] 09ba7b58:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7b68:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7ba0:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7bb8:  [<08072c7f>] sig_handler_common_skas+0xbf/0x100
[42966190.250000] 09ba7be0:  [<0806e57e>] real_alarm_handler+0x1e/0x60
[42966190.250000] 09ba7bf4:  [<0806e624>] alarm_handler+0x64/0x80
[42966190.250000] 09ba7c0c:  [<0807117a>] hard_handler+0x1a/0x20
[42966190.250000] 09ba7c1c:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7f1c:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7f2c:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7f64:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7f7c:  [<08072d33>] user_signal+0x73/0x80
[42966190.250000] 09ba7f94:  [<080724fd>] userspace+0x18d/0x230
[42966190.250000] 09ba7fe4:  [<0805d3c6>] fork_handler+0x76/0x90
[42966190.250000] 09ba7ffc:  [<a55a5a5a>] 0xa55a5a5a
[42966190.250000]
[42966190.250000] * route del -host 192.168.0.6 dev tap1
[42966190.250000] * bash -c echo 0 > /proc/sys/net/ipv4/conf/tap1/proxy_arp
[42966190.250000] * arp -i eth0 -d 192.168.0.6 pub
[42966190.250000] BUG: warning at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/kernel/irq/manage.c:358/free_irq()
[42966190.250000] 09ba7750:  [<0805af02>] dump_stack+0x22/0x30
[42966190.250000] 09ba7768:  [<080a76ab>] free_irq+0x11b/0x120
[42966190.250000] 09ba7798:  [<08060d8a>] free_winch+0x4a/0x60
[42966190.250000] 09ba77ac:  [<08060e1b>] winch_cleanup+0x2b/0x50
[42966190.250000] 09ba77bc:  [<08059b53>] do_uml_exitcalls+0x13/0x30
[42966190.250000] 09ba77c8:  [<0805a312>] uml_cleanup+0x12/0x20
[42966190.250000] 09ba77d0:  [<0806ca4b>] last_ditch_exit+0xb/0x20
[42966190.250000] 09ba77dc:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7ac8:  [<081bf023>] __spin_lock_debug+0x63/0xe0
[42966190.250000] 09ba7b08:  [<081bf10f>] _raw_spin_lock+0x6f/0xa0
[42966190.250000] 09ba7b24:  [<0829bcce>] _spin_lock+0xe/0x10
[42966190.250000] 09ba7b30:  [<080a7035>] __do_IRQ+0x25/0xe0
[42966190.250000] 09ba7b58:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7b68:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7ba0:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7bb8:  [<08072c7f>] sig_handler_common_skas+0xbf/0x100
[42966190.250000] 09ba7be0:  [<0806e57e>] real_alarm_handler+0x1e/0x60
[42966190.250000] 09ba7bf4:  [<0806e624>] alarm_handler+0x64/0x80
[42966190.250000] 09ba7c0c:  [<0807117a>] hard_handler+0x1a/0x20
[42966190.250000] 09ba7c1c:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7f1c:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7f2c:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7f64:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7f7c:  [<08072d33>] user_signal+0x73/0x80
[42966190.250000] 09ba7f94:  [<080724fd>] userspace+0x18d/0x230
[42966190.250000] 09ba7fe4:  [<0805d3c6>] fork_handler+0x76/0x90
[42966190.250000] 09ba7ffc:  [<a55a5a5a>] 0xa55a5a5a
[42966190.250000]
[42966190.250000] BUG: warning at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/kernel/irq/manage.c:358/free_irq()
[42966190.250000] 09ba7750:  [<0805af02>] dump_stack+0x22/0x30
[42966190.250000] 09ba7768:  [<080a76ab>] free_irq+0x11b/0x120
[42966190.250000] 09ba7798:  [<08060d8a>] free_winch+0x4a/0x60
[42966190.250000] 09ba77ac:  [<08060e1b>] winch_cleanup+0x2b/0x50
[42966190.250000] 09ba77bc:  [<08059b53>] do_uml_exitcalls+0x13/0x30
[42966190.250000] 09ba77c8:  [<0805a312>] uml_cleanup+0x12/0x20
[42966190.250000] 09ba77d0:  [<0806ca4b>] last_ditch_exit+0xb/0x20
[42966190.250000] 09ba77dc:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7ac8:  [<081bf023>] __spin_lock_debug+0x63/0xe0
[42966190.250000] 09ba7b08:  [<081bf10f>] _raw_spin_lock+0x6f/0xa0
[42966190.250000] 09ba7b24:  [<0829bcce>] _spin_lock+0xe/0x10
[42966190.250000] 09ba7b30:  [<080a7035>] __do_IRQ+0x25/0xe0
[42966190.250000] 09ba7b58:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7b68:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7ba0:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7bb8:  [<08072c7f>] sig_handler_common_skas+0xbf/0x100
[42966190.250000] 09ba7be0:  [<0806e57e>] real_alarm_handler+0x1e/0x60
[42966190.250000] 09ba7bf4:  [<0806e624>] alarm_handler+0x64/0x80
[42966190.250000] 09ba7c0c:  [<0807117a>] hard_handler+0x1a/0x20
[42966190.250000] 09ba7c1c:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7f1c:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7f2c:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7f64:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7f7c:  [<08072d33>] user_signal+0x73/0x80
[42966190.250000] 09ba7f94:  [<080724fd>] userspace+0x18d/0x230
[42966190.250000] 09ba7fe4:  [<0805d3c6>] fork_handler+0x76/0x90
[42966190.250000] 09ba7ffc:  [<a55a5a5a>] 0xa55a5a5a
[42966190.250000]
[42966190.250000] BUG: warning at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/kernel/irq/manage.c:358/free_irq()
[42966190.250000] 09ba7718:  [<0805af02>] dump_stack+0x22/0x30
[42966190.250000] 09ba7730:  [<080a76ab>] free_irq+0x11b/0x120
[42966190.250000] 09ba7760:  [<0805ec1c>] close_one_chan+0x7c/0xa0
[42966190.250000] 09ba7774:  [<0805ec62>] close_chan+0x22/0x40
[42966190.250000] 09ba7790:  [<0806059d>] close_lines+0x3d/0x50
[42966190.250000] 09ba77ac:  [<0805e4d6>] console_exit+0x26/0x30
[42966190.250000] 09ba77bc:  [<08059b53>] do_uml_exitcalls+0x13/0x30
[42966190.250000] 09ba77c8:  [<0805a312>] uml_cleanup+0x12/0x20
[42966190.250000] 09ba77d0:  [<0806ca4b>] last_ditch_exit+0xb/0x20
[42966190.250000] 09ba77dc:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7ac8:  [<081bf023>] __spin_lock_debug+0x63/0xe0
[42966190.250000] 09ba7b08:  [<081bf10f>] _raw_spin_lock+0x6f/0xa0
[42966190.250000] 09ba7b24:  [<0829bcce>] _spin_lock+0xe/0x10
[42966190.250000] 09ba7b30:  [<080a7035>] __do_IRQ+0x25/0xe0
[42966190.250000] 09ba7b58:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7b68:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7ba0:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7bb8:  [<08072c7f>] sig_handler_common_skas+0xbf/0x100
[42966190.250000] 09ba7be0:  [<0806e57e>] real_alarm_handler+0x1e/0x60
[42966190.250000] 09ba7bf4:  [<0806e624>] alarm_handler+0x64/0x80
[42966190.250000] 09ba7c0c:  [<0807117a>] hard_handler+0x1a/0x20
[42966190.250000] 09ba7c1c:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7f1c:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7f2c:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7f64:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7f7c:  [<08072d33>] user_signal+0x73/0x80
[42966190.250000] 09ba7f94:  [<080724fd>] userspace+0x18d/0x230
[42966190.250000] 09ba7fe4:  [<0805d3c6>] fork_handler+0x76/0x90
[42966190.250000] 09ba7ffc:  [<a55a5a5a>] 0xa55a5a5a
[42966190.250000]
[42966190.250000] BUG: warning at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/kernel/irq/manage.c:358/free_irq()
[42966190.250000] 09ba7718:  [<0805af02>] dump_stack+0x22/0x30
[42966190.250000] 09ba7730:  [<080a76ab>] free_irq+0x11b/0x120
[42966190.250000] 09ba7760:  [<0805ec39>] close_one_chan+0x99/0xa0
[42966190.250000] 09ba7774:  [<0805ec62>] close_chan+0x22/0x40
[42966190.250000] 09ba7790:  [<0806059d>] close_lines+0x3d/0x50
[42966190.250000] 09ba77ac:  [<0805e4d6>] console_exit+0x26/0x30
[42966190.250000] 09ba77bc:  [<08059b53>] do_uml_exitcalls+0x13/0x30
[42966190.250000] 09ba77c8:  [<0805a312>] uml_cleanup+0x12/0x20
[42966190.250000] 09ba77d0:  [<0806ca4b>] last_ditch_exit+0xb/0x20
[42966190.250000] 09ba77dc:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7ac8:  [<081bf023>] __spin_lock_debug+0x63/0xe0
[42966190.250000] 09ba7b08:  [<081bf10f>] _raw_spin_lock+0x6f/0xa0
[42966190.250000] 09ba7b24:  [<0829bcce>] _spin_lock+0xe/0x10
[42966190.250000] 09ba7b30:  [<080a7035>] __do_IRQ+0x25/0xe0
[42966190.250000] 09ba7b58:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7b68:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7ba0:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7bb8:  [<08072c7f>] sig_handler_common_skas+0xbf/0x100
[42966190.250000] 09ba7be0:  [<0806e57e>] real_alarm_handler+0x1e/0x60
[42966190.250000] 09ba7bf4:  [<0806e624>] alarm_handler+0x64/0x80
[42966190.250000] 09ba7c0c:  [<0807117a>] hard_handler+0x1a/0x20
[42966190.250000] 09ba7c1c:  [<ffffe500>] _etext+0xf7d60155/0x0
[42966190.250000] 09ba7f1c:  [<08058341>] do_IRQ+0x31/0x50
[42966190.250000] 09ba7f2c:  [<0805b174>] timer_irq+0x124/0x180
[42966190.250000] 09ba7f64:  [<0805b4f1>] timer_handler+0x51/0x60
[42966190.250000] 09ba7f7c:  [<08072d33>] user_signal+0x73/0x80
[42966190.250000] 09ba7f94:  [<080724fd>] userspace+0x18d/0x230
[42966190.250000] 09ba7fe4:  [<0805d3c6>] fork_handler+0x76/0x90
[42966190.250000] 09ba7ffc:  [<a55a5a5a>] 0xa55a5a5a
[42966190.250000]

--Boundary-00=_JJ5YFfNslURzalg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_JJ5YFfNslURzalg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_JJ5YFfNslURzalg--

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

