Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1YXUzO-0007Tu-Ek
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 13:23:26 +0000
Received: from mout.gmx.net ([212.227.17.21])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YXUzM-0003Hb-Nl
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 13:23:26 +0000
Message-ID: <5506D945.809@gmx.de>
Date: Mon, 16 Mar 2015 14:23:17 +0100
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <54FCBB88.70605@gmx.de>
	<CAFLxGvy8mLg9R9J38uAGFdZA_QdN=qZ3L-_niYoX8+n7GA0+Vg@mail.gmail.com>
	<54FCCFF8.3030209@gmx.de> <54FCD0DB.4060308@nod.at>
	<54FF01F3.5060203@gmx.de> <54FF03DE.1080206@nod.at>
	<54FF09B5.5020707@gmx.de> <54FF1281.7070709@nod.at>
	<54FF2D3B.5090301@gmx.de> <54FF2F89.604@nod.at>
	<54FF36CC.4010401@gmx.de> <54FF3910.8060502@nod.at>
	<54FF3A7A.4010606@gmx.de> <54FF3B6C.9060808@nod.at>
	<54FF3E5D.8040204@gmx.de> <54FF606E.5050109@nod.at>
	<5502E8D5.8040500@gmx.de> <5502F4A4.6070201@nod.at>
	<550564D2.5070103@gmx.de> <55056CA7.1080700@nod.at>
	<55057604.6050308@gmx.de> <55059907.9060408@nod.at>
	<5505B889.4020401@gmx.de> <5505B9A4.8030304@nod.at>
In-Reply-To: <5505B9A4.8030304@nod.at>
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
Subject: Re: [uml-devel] starting an 32 bit x86 chroot uml image at a
 ahrdened Gentoo amd64 system fails
To: Richard Weinberger <richard@nod.at>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On 03/15/2015 05:56 PM, Richard Weinberger wrote:
> Then please move the hardened gcc to /dev/null. ;-)

yes, at least to compile the UML linux

> If you can tell me what hardening feature is the root cause I can think of a solution.
Will be a longer way I fear.
Every 2nd or 3rd attempt the UML guest hangs during boot, an immediate attempt works - so really hard to dig into the root cause.

But I'll try it.

In moment my biggest problem is, that I get the following error as soon as I try to send out an network package from eth0 (DHCP works, but the first ping to an ip address outside triggers the error):

Mar 16 14:10:32 trinity logger[1423]: haha
Mar 16 14:10:32 trinity logger[1427]: PING 192.168.1.143 (192.168.1.143) 56(84) bytes of data.
Mar 16 14:10:32 trinity logger[1427]: 64 bytes from 192.168.1.143: icmp_seq=1 ttl=64 time=0.059 ms
Mar 16 14:10:33 trinity logger[1427]: 64 bytes from 192.168.1.143: icmp_seq=2 ttl=64 time=0.045 ms
Mar 16 14:10:34 trinity logger[1427]: 64 bytes from 192.168.1.143: icmp_seq=3 ttl=64 time=0.056 ms
Mar 16 14:10:34 trinity logger[1427]: 
Mar 16 14:10:34 trinity logger[1427]: --- 192.168.1.143 ping statistics ---
Mar 16 14:10:34 trinity logger[1427]: 3 packets transmitted, 3 received, 0% packet loss, time 2007ms
Mar 16 14:10:34 trinity logger[1427]: rtt min/avg/max/mdev = 0.045/0.053/0.059/0.008 ms
Mar 16 14:10:34 trinity logger[1428]: hoho
Mar 16 14:10:34 trinity kernel: Device 'eth0' read returned -107, shutting it down
Mar 16 14:10:34 trinity kernel: ------------[ cut here ]------------
Mar 16 14:10:34 trinity kernel: WARNING: CPU: 0 PID: 1429 at kernel/workqueue.c:1360 __queue_work+0x138/0x250()
Mar 16 14:10:34 trinity kernel: CPU: 0 PID: 1429 Comm: ping Not tainted 4.0.0-rc4 #3
Mar 16 14:10:34 trinity kernel: Stack:
Mar 16 14:10:34 trinity kernel:  084c7678 084c7678 08528547 00000000 83e0e000 00000000 83e0f538 0844315b
Mar 16 14:10:34 trinity kernel:  00000000 83e0f510 83e0f570 0807c42e 084d2fec 00000000 00000595 084d1c08
Mar 16 14:10:34 trinity kernel:  00000550 0808e668 00000550 0808e668 00000000 09bc2300 84d17c98 84c51400
Mar 16 14:10:34 trinity kernel: Call Trace:
Mar 16 14:10:34 trinity kernel:  [<08060a36>] show_stack+0xd6/0x1a0
Mar 16 14:10:34 trinity kernel:  [<0844315b>] dump_stack+0x26/0x28
Mar 16 14:10:34 trinity kernel:  [<0807c42e>] warn_slowpath_common+0x7e/0xc0
Mar 16 14:10:34 trinity kernel:  [<0808e668>] ? __queue_work+0x138/0x250
Mar 16 14:10:34 trinity kernel:  [<0808e668>] ? __queue_work+0x138/0x250
Mar 16 14:10:34 trinity kernel:  [<0807c523>] warn_slowpath_null+0x23/0x30
Mar 16 14:10:34 trinity kernel:  [<0808e668>] __queue_work+0x138/0x250
Mar 16 14:10:34 trinity kernel:  [<0808eb7f>] queue_work_on+0x2f/0x50
Mar 16 14:10:34 trinity kernel:  [<0843fda2>] ? printk+0x1a/0x1c
Mar 16 14:10:34 trinity kernel:  [<080675bb>] uml_net_interrupt+0x9b/0xa0
Mar 16 14:10:34 trinity kernel:  [<080a67cf>] handle_irq_event_percpu+0x2f/0x110
Mar 16 14:10:34 trinity kernel:  [<080a68e4>] handle_irq_event+0x34/0x50
Mar 16 14:10:34 trinity kernel:  [<080a8e4e>] handle_edge_irq+0x9e/0x130
Mar 16 14:10:34 trinity kernel:  [<080a619b>] generic_handle_irq+0x2b/0x30
Mar 16 14:10:34 trinity kernel:  [<0805ed95>] do_IRQ+0x25/0x40
Mar 16 14:10:34 trinity kernel:  [<0805ee0b>] sigio_handler+0x5b/0x80
Mar 16 14:10:34 trinity kernel:  [<080711b7>] sig_handler_common+0x57/0xd0
Mar 16 14:10:34 trinity kernel:  [<08071140>] unblock_signals+0x50/0x70
Mar 16 14:10:34 trinity kernel:  [<08071370>] set_signals+0x30/0x40
Mar 16 14:10:34 trinity kernel:  [<0844633c>] _raw_spin_unlock_irqrestore+0x1c/0x20
Mar 16 14:10:34 trinity kernel:  [<08066736>] uml_net_start_xmit+0x96/0x160
Mar 16 14:10:34 trinity kernel:  [<083a1c5d>] dev_hard_start_xmit+0x1ed/0x330
Mar 16 14:10:34 trinity kernel:  [<08071370>] ? set_signals+0x30/0x40
Mar 16 14:10:34 trinity kernel:  [<083bc5aa>] sch_direct_xmit+0xda/0x1b0
Mar 16 14:10:34 trinity kernel:  [<083a1f60>] __dev_queue_xmit+0x1c0/0x4f0
Mar 16 14:10:34 trinity kernel:  [<083a22ed>] dev_queue_xmit+0xd/0x10
Mar 16 14:10:34 trinity kernel:  [<083f83e6>] arp_send.part.9+0x46/0x50
Mar 16 14:10:34 trinity kernel:  [<083f8c89>] arp_solicit+0xb9/0x240
Mar 16 14:10:34 trinity kernel:  [<083946f9>] ? skb_copy+0x99/0xe0
Mar 16 14:10:34 trinity kernel:  [<083abe25>] neigh_probe+0x45/0x70
Mar 16 14:10:34 trinity kernel:  [<083aee7f>] __neigh_event_send+0x7f/0x220
Mar 16 14:10:34 trinity kernel:  [<08446644>] ? _raw_write_unlock_bh+0x24/0x30
Mar 16 14:10:34 trinity kernel:  [<083aeca8>] ? __neigh_create+0x4c8/0x620
Mar 16 14:10:34 trinity kernel:  [<083afd57>] neigh_resolve_output+0x127/0x210
Mar 16 14:10:34 trinity kernel:  [<083cdf60>] ip_finish_output+0x2c0/0x9a0
Mar 16 14:10:34 trinity kernel:  [<083ce7de>] ip_output+0x6e/0x80
Mar 16 14:10:34 trinity kernel:  [<083ce770>] ? ip_output+0x0/0x80
Mar 16 14:10:34 trinity kernel:  [<083ccdda>] ip_local_out_sk+0x2a/0x30
Mar 16 14:10:34 trinity kernel:  [<083cf318>] ip_send_skb+0x18/0x80
Mar 16 14:10:34 trinity kernel:  [<083cf3c4>] ip_push_pending_frames+0x44/0x50
Mar 16 14:10:34 trinity kernel:  [<083f185f>] raw_sendmsg+0x7af/0x8d0
Mar 16 14:10:34 trinity kernel:  [<083f0a30>] ? raw_getfrag+0x0/0xf0
Mar 16 14:10:34 trinity kernel:  [<08062c06>] ? do_op_one_page+0x136/0x190
Mar 16 14:10:34 trinity kernel:  [<080521a0>] ? __reserve+0x10/0xc6
Mar 16 14:10:34 trinity kernel:  [<080521a0>] ? __reserve+0x10/0xc6
Mar 16 14:10:34 trinity kernel:  [<08062bcb>] ? do_op_one_page+0xfb/0x190
Mar 16 14:10:34 trinity kernel:  [<08062c99>] ? buffer_op+0x39/0xe0
Mar 16 14:10:34 trinity kernel:  [<08062980>] ? copy_chunk_from_user+0x0/0x30
Mar 16 14:10:34 trinity kernel:  [<083fe108>] inet_sendmsg+0x38/0x60
Mar 16 14:10:34 trinity kernel:  [<0838ad25>] do_sock_sendmsg+0x75/0x90
Mar 16 14:10:34 trinity kernel:  [<0838b925>] ___sys_sendmsg+0x1f5/0x220
Mar 16 14:10:34 trinity kernel:  [<080533e0>] ? kmem_cache_init+0x55/0xd8
Mar 16 14:10:34 trinity kernel:  [<08072fd9>] ? map+0xf9/0x110
Mar 16 14:10:34 trinity kernel:  [<0804b000>] ? eth_setup+0x2c/0x84
Mar 16 14:10:34 trinity kernel:  [<0804b000>] ? eth_setup+0x2c/0x84
Mar 16 14:10:34 trinity kernel:  [<080629a3>] ? copy_chunk_from_user+0x23/0x30
Mar 16 14:10:34 trinity kernel:  [<08062c06>] ? do_op_one_page+0x136/0x190
Mar 16 14:10:34 trinity kernel:  [<080a00b1>] ? up_read+0x11/0x20
Mar 16 14:10:34 trinity kernel:  [<0811d870>] ? __fdget+0x10/0x20
Mar 16 14:10:34 trinity kernel:  [<0838afa5>] ? sockfd_lookup_light+0x15/0x70
Mar 16 14:10:34 trinity kernel:  [<0838d2a6>] __sys_sendmsg+0x36/0x70
Mar 16 14:10:34 trinity kernel:  [<080521c8>] ? __reserve+0x38/0xc6
Mar 16 14:10:34 trinity kernel:  [<0838d950>] SyS_socketcall+0xe0/0x2d0
Mar 16 14:10:34 trinity kernel:  [<080521a8>] ? __reserve+0x18/0xc6
Mar 16 14:10:34 trinity kernel:  [<080521a8>] ? __reserve+0x18/0xc6
Mar 16 14:10:34 trinity kernel:  [<080aae62>] ? SyS_gettimeofday+0x32/0x80
Mar 16 14:10:34 trinity kernel:  [<080521a8>] ? __reserve+0x18/0xc6
Mar 16 14:10:34 trinity kernel:  [<08062960>] handle_syscall+0x60/0x80
Mar 16 14:10:34 trinity kernel:  [<08073dff>] userspace+0x4af/0x5e0
Mar 16 14:10:34 trinity kernel:  [<08079276>] ? os_set_thread_area+0x26/0x40
Mar 16 14:10:34 trinity kernel:  [<0807829c>] ? do_set_thread_area+0x1c/0x50
Mar 16 14:10:34 trinity kernel:  [<0807841d>] ? arch_switch_tls+0xad/0xf0
Mar 16 14:10:34 trinity kernel:  [<0805f6a0>] fork_handler+0x60/0x70
Mar 16 14:10:34 trinity kernel: 
Mar 16 14:10:34 trinity kernel: ---[ end trace 00741791a3b2d845 ]---
Mar 16 14:10:46 trinity logger[1430]: PING 192.168.1.254 (192.168.1.254) 56(84) bytes of data.
Mar 16 14:10:46 trinity logger[1430]: 
Mar 16 14:10:46 trinity logger[1430]: --- 192.168.1.254 ping statistics ---
Mar 16 14:10:46 trinity logger[1430]: 3 packets transmitted, 0 received, 100% packet loss, time 2006ms
Mar 16 14:10:46 trinity logger[1430]: 
Mar 16 14:10:46 trinity logger[1431]: hihi
Mar 16 14:10:46 trinity logger[1435]: Kernel IP routing table
Mar 16 14:10:46 trinity logger[1435]: Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
Mar 16 14:10:46 trinity logger[1435]: 0.0.0.0         192.168.1.254   0.0.0.0         UG    2      0        0 eth0
Mar 16 14:10:46 trinity logger[1435]: 127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
Mar 16 14:10:46 trinity logger[1435]: 127.0.0.0       127.0.0.1       255.0.0.0       UG    0      0        0 lo
Mar 16 14:10:46 trinity logger[1435]: 192.168.0.0     0.0.0.0         255.255.0.0     U     0      0        0 eth0
Mar 16 14:10:46 trinity logger[1437]: eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
Mar 16 14:10:46 trinity logger[1437]:         inet 192.168.1.143  netmask 255.255.0.0  broadcast 192.168.255.255
Mar 16 14:10:46 trinity logger[1437]:         ether 72:ef:3d:9f:c3:5a  txqueuelen 1000  (Ethernet)
Mar 16 14:10:46 trinity logger[1437]:         RX packets 1  bytes 28 (28.0 B)
Mar 16 14:10:46 trinity logger[1437]:         RX errors 0  dropped 0  overruns 0  frame 0
Mar 16 14:10:46 trinity logger[1437]:         TX packets 4  bytes 336 (336.0 B)
Mar 16 14:10:46 trinity logger[1437]:         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
Mar 16 14:10:46 trinity logger[1437]:         device interrupt 5
Mar 16 14:10:46 trinity logger[1437]: 
Mar 16 14:10:46 trinity logger[1437]: lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
Mar 16 14:10:46 trinity logger[1437]:         inet 127.0.0.1  netmask 255.0.0.0
Mar 16 14:10:46 trinity logger[1437]:         loop  txqueuelen 0  (Local Loopback)
Mar 16 14:10:46 trinity logger[1437]:         RX packets 18  bytes 1440 (1.4 KiB)
Mar 16 14:10:46 trinity logger[1437]:         RX errors 0  dropped 0  overruns 0  frame 0
Mar 16 14:10:46 trinity logger[1437]:         TX packets 18  bytes 1440 (1.4 KiB)
Mar 16 14:10:46 trinity logger[1437]:         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
Mar 16 14:10:46 trinity logger[1437]: 
Mar 16 14:10:46 trinity shutdown[1438]: shutting down for system halt


FWIW this is the job which is run automatically by an rc script after boot :

t44 / # cat /etc/local.d/c.start                    
logger haha
ping -c3 192.168.1.143  2>&1 | logger
logger hoho
ping -c3 192.168.1.254  2>&1 | logger
logger hihi
route -n | logger
ifconfig | logger
halt

-- 
Toralf
pgp key: 7B1A 07F4 EC82 0F90 D4C2  8936 872A E508 0076 E94E


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

