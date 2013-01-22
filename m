Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1TxX1L-0005qI-4E
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jan 2013 06:07:43 +0000
Received: from i01.ip.uk.com ([86.54.60.3])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TxX1F-0002WZ-GR
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jan 2013 06:07:43 +0000
Received: from [194.164.232.154] (helo=[10.0.1.129])
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>) id 1TxX14-0000iv-BM
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jan 2013 06:07:26 +0000
Message-ID: <50FE2C9D.5090503@bob-the-boat.me.uk>
Date: Tue, 22 Jan 2013 06:07:25 +0000
From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
MIME-Version: 1.0
References: <2817249.1YofB9goZl@vault01>
In-Reply-To: <2817249.1YofB9goZl@vault01>
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
Subject: Re: [uml-devel] UML Network Related Crashing
To: user-mode-linux-devel@lists.sourceforge.net

I'm wondering whether this was useful?
Is there any other testing that I can do to help the cause, and to help
fix this problem?

Regards,
David


On 19/01/2013 18:59, Dave Humphreys (Bob) wrote:
> I have experimented further with the network related crashing problem that I 
> have had for some time with UML.
>
> I have been using 3.8.0-rc3 UML kernels with Debian root filesystems.
>
> I have been running two UML instances side-by-side on the same host and 
> communicationg via mcast networking.
>
> My current testing uses a 64 bit UML from which i copy data using rsync 
> (because this is how I found the original problem).
>
> I seem to be able to copy from 64 bit to 64 bit, but when I copy from 64 bit 
> to 32 bit I get a crash.
>
> The oringinal problem that I had was a 32 bit UML that I access via a real 
> ethernet network connection and it crashes occasionally. i find that I can 
> crash it regularly bu rsyncing data from it.
>
> I can therefore say that the problem does not seems to occur when using both 
> mcast and tuntap networking; and when the bulk of the network traffic is 
> received or transmitted.
>
> It does appear to be a problem with the 32 bit variant and not the 64 bit.
>
> As an aside, I also find that I can crash the 32 bit UML by rsyncing between 
> the UML and the host via a hostfs mount. I have a copy of the crash output for 
> this if it is of any interest. I mention this in case there could be a link, 
> but my current principle concern is to cure the networking problem.
>
> Here is what happens when it crashes:
>
>
>  map/@DEB1-32:~# rsync --archive --delete --progress 10.0.10.30:/var/imap/ 
> /var/imap/
> The authenticity of host '10.0.10.30 (10.0.10.30)' can't be established.
> RSA key fingerprint is b8:5d:e0:69:bc:61:d9:88:e4:12:80:84:c9:94:81:2f.
> Are you sure you want to continue connecting (yes/no)? yes
> Warning: Permanently added '10.0.10.30' (RSA) to the list of known hosts.
> receiving incremental file list
> ./
> .bash_history
>         1970 100%    1.88MB/s    0:00:00 (xfer#1, to-check=1005/1007)
> config/
> config/annotations.db
>          144 100%    3.70kB/s    0:00:00 (xfer#2, to-check=1356/1362)
> config/deliver.db
>            0   0%    0.00kB/s    0:00:00  ------------[ cut here ]------------
> WARNING: at net/core/skbuff.c:573 skb_release_head_state+0x60/0x6c()
> Modules linked in:
>
> 2367232c:  [<082050f7>] dump_stack+0x16/0x1a
>
> 23672340:  [<08070515>] warn_slowpath_common+0x48/0x5e
>
> 23672358:  [<08070540>] warn_slowpath_null+0x15/0x19
>
> 23672368:  [<081a1f93>] skb_release_head_state+0x60/0x6c
>
> 23672380:  [<081a3705>] __kfree_skb+0xe/0x72
>
> 2367238c:  [<081a3791>] consume_skb+0x28/0x2b
>
> 23672398:  [<080615e2>] uml_net_start_xmit+0xd5/0xdf
>
> 236723b8:  [<081ac85b>] dev_hard_start_xmit+0x26c/0x374
>
> 236723e4:  [<081bac2c>] sch_direct_xmit+0x35/0x10d
>
> 23672408:  [<081acb0b>] dev_queue_xmit+0xd6/0x203
>
> 23672438:  [<081c519a>] ip_finish_output+0x272/0x2d9
>
> 23672470:  [<081c5f9b>] ip_output+0x4b/0x50
>
> 23672484:  [<081c5a18>] ip_local_out+0x1d/0x23
>
> 23672494:  [<081c5ccd>] ip_queue_xmit+0x2af/0x2f7
>
> 236724d0:  [<081d70a7>] tcp_transmit_skb+0x697/0x6fb
>
> 23672520:  [<081d8e65>] tcp_send_ack+0xcc/0xd4
>
> 23672534:  [<081cfabb>] __tcp_ack_snd_check+0x42/0x7a
>
> 23672548:  [<081d47f1>] tcp_rcv_established+0x36e/0x594
>
> 23672570:  [<081da56f>] tcp_v4_do_rcv+0x5d/0x18e
>
> 2367259c:  [<081dcbcc>] tcp_v4_rcv+0x6a0/0x6f7
>
> 236725d4:  [<081c2195>] ip_local_deliver+0x11d/0x1b8
>
> 236725f0:  [<081c25f7>] ip_rcv+0x3c7/0x410
>
> 23672608:  [<081aa94e>] __netif_receive_skb+0x34a/0x3e4
>
> 23672650:  [<081aaa47>] process_backlog+0x5f/0xe1
>
> 2367266c:  [<081aadd5>] net_rx_action+0x49/0x121
>
> 23672690:  [<080757c9>] __do_softirq+0x84/0x129
>
> 236726b8:  [<080758d0>] do_softirq+0x30/0x3c
>
> 236726c8:  [<08075a6a>] irq_exit+0x35/0x6d
>
> 236726d4:  [<0805af16>] do_IRQ+0x24/0x34
>
> 236726e4:  [<0805af68>] sigio_handler+0x42/0x56
>
> 236726f8:  [<08068db7>] sig_handler_common+0x79/0x8c
>
> 23672978:  [<08068d2d>] unblock_signals+0x48/0x59
>
> 23672984:  [<0808accf>] finish_task_switch.isra.63+0x1b/0x51
>
> 2367299c:  [<08208103>] __schedule+0x234/0x28a
>
> 236729c0:  [<08208250>] schedule+0x57/0x59
>
> 236729cc:  [<082078ce>] schedule_hrtimeout_range_clock+0x33/0x128
>
> 23672a18:  [<082079d6>] schedule_hrtimeout_range+0x13/0x15
>
> 23672a30:  [<080d497f>] poll_schedule_timeout+0x2a/0x51
>
> 23672a4c:  [<080d5136>] do_select+0x4cd/0x504
>
> 23672d3c:  [<080d539b>] core_sys_select+0x22e/0x24b
>
> 23672e7c:  [<080d5416>] sys_select+0x5e/0x86
>
> 23672eb0:  [<0805d742>] handle_syscall+0x6a/0x80
>
> 23672ef4:  [<0806aee8>] userspace+0x362/0x488
>
> 23672fe4:  [<0805b3d6>] fork_handler+0x56/0x5b
>
> 23672ffc:  [<00746f6f>] 0x746f6f
>
> ---[ end trace 8e9ba3f2efd7a2c6 ]---
> ------------[ cut here ]------------
> WARNING: at kernel/softirq.c:160 local_bh_enable+0x2f/0x83()
>
> Modules linked in:
> 236723f4:  [<082050f7>] dump_stack+0x16/0x1a
>
> 23672408:  [<08070515>] warn_slowpath_common+0x48/0x5e
> 23672420:  [<08070540>] warn_slowpath_null+0x15/0x19
> 23672430:  [<0807598e>] local_bh_enable+0x2f/0x83
> 23672444:  [<081c51b1>] ip_finish_output+0x289/0x2d9
> 23672470:  [<081c5f9b>] ip_output+0x4b/0x50
> 23672484:  [<081c5a18>] ip_local_out+0x1d/0x23
> 23672494:  [<081c5ccd>] ip_queue_xmit+0x2af/0x2f7
> 236724d0:  [<081d70a7>] tcp_transmit_skb+0x697/0x6fb
> 23672520:  [<081d8e65>] tcp_send_ack+0xcc/0xd4
> 23672534:  [<081cfabb>] __tcp_ack_snd_check+0x42/0x7a
> 23672548:  [<081d47f1>] tcp_rcv_established+0x36e/0x594
> 23672570:  [<081da56f>] tcp_v4_do_rcv+0x5d/0x18e
> 2367259c:  [<081dcbcc>] tcp_v4_rcv+0x6a0/0x6f7
> 236725d4:  [<081c2195>] ip_local_deliver+0x11d/0x1b8
> 236725f0:  [<081c25f7>] ip_rcv+0x3c7/0x410
> 23672608:  [<081aa94e>] __netif_receive_skb+0x34a/0x3e4
> 23672650:  [<081aaa47>] process_backlog+0x5f/0xe1
> 2367266c:  [<081aadd5>] net_rx_action+0x49/0x121
> 23672690:  [<080757c9>] __do_softirq+0x84/0x129
> 236726b8:  [<080758d0>] do_softirq+0x30/0x3c
> 236726c8:  [<08075a6a>] irq_exit+0x35/0x6d
> 236726d4:  [<0805af16>] do_IRQ+0x24/0x34
> 236726e4:  [<0805af68>] sigio_handler+0x42/0x56
> 236726f8:  [<08068db7>] sig_handler_common+0x79/0x8c
> 23672978:  [<08068d2d>] unblock_signals+0x48/0x59
> 23672984:  [<0808accf>] finish_task_switch.isra.63+0x1b/0x51
> 2367299c:  [<08208103>] __schedule+0x234/0x28a
> 236729c0:  [<08208250>] schedule+0x57/0x59
> 236729cc:  [<082078ce>] schedule_hrtimeout_range_clock+0x33/0x128
> 23672a18:  [<082079d6>] schedule_hrtimeout_range+0x13/0x15
> 23672a30:  [<080d497f>] poll_schedule_timeout+0x2a/0x51
> 23672a4c:  [<080d5136>] do_select+0x4cd/0x504
> 23672d3c:  [<080d539b>] core_sys_select+0x22e/0x24b
> 23672e7c:  [<080d5416>] sys_select+0x5e/0x86
> 23672eb0:  [<0805d742>] handle_syscall+0x6a/0x80
> 23672ef4:  [<0806aee8>] userspace+0x362/0x488
> 23672fe4:  [<0805b3d6>] fork_handler+0x56/0x5b
> 23672ffc:  [<00746f6f>] 0x746f6f
>
> ---[ end trace 8e9ba3f2efd7a2c7 ]---
> huh, entered softirq 3 NET_RX 081aad8c preempt_count 00000100, exited with 
> fffffe01?
>
> EIP: 0023:[<080d9e01>] CPU: 0 Tainted: G        W    ESP: 002b:23672a44 
> EFLAGS: 00010202
>     Tainted: G        W   
> EAX: 00082a40 EBX: 23672ac4 ECX: 00fffffe EDX: 00000003
> ESI: 00000005 EDI: 23672d54 EBP: 23672a50 DS: 002b ES: 002b
> 082a4750:  [<0806d29a>] show_regs+0xc0/0xc6
> 082a477c:  [<0805ceef>] segv+0x57/0x218
> 082a481c:  [<0805d102>] segv_handler+0x52/0x5d
> 082a4848:  [<08068db7>] sig_handler_common+0x79/0x8c
> 082a4ac8:  [<08068ea5>] sig_handler+0x34/0x43
> 082a4ad4:  [<08068b3a>] hard_handler+0x5a/0x88
> 082a4afc:  [<ffffe410>] 0xffffe410
>
> Kernel panic - not syncing: Segfault with no mm
> 082a474c:  [<082050f7>] dump_stack+0x16/0x1a
> 082a4760:  [<08205181>] panic+0x67/0x149
> 082a4778:  [<0805cef9>] segv+0x61/0x218
> 082a481c:  [<0805d102>] segv_handler+0x52/0x5d
> 082a4848:  [<08068db7>] sig_handler_common+0x79/0x8c
> 082a4ac8:  [<08068ea5>] sig_handler+0x34/0x43
> 082a4ad4:  [<08068b3a>] hard_handler+0x5a/0x88
> 082a4afc:  [<ffffe410>] 0xffffe410
>
>
> EIP: 0000:[<00000000>] CPU: 0 Tainted: G        W    EFLAGS: 00000000
>     Tainted: G        W   
> EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
> 082a46bc:  [<0806d29a>] show_regs+0xc0/0xc6
> 082a46e8:  [<0805d32b>] panic_exit+0x20/0x36
> 082a46fc:  [<08088c3b>] notifier_call_chain+0x20/0x4b
> 082a4724:  [<08088c7d>] __atomic_notifier_call_chain+0x17/0x19
> 082a4734:  [<08088c94>] atomic_notifier_call_chain+0x15/0x17
> 082a4750:  [<08205199>] panic+0x7f/0x149
> 082a4778:  [<0805cef9>] segv+0x61/0x218
> 082a481c:  [<0805d102>] segv_handler+0x52/0x5d
> 082a4848:  [<08068db7>] sig_handler_common+0x79/0x8c
> 082a4ac8:  [<08068ea5>] sig_handler+0x34/0x43
> 082a4ad4:  [<08068b3a>] hard_handler+0x5a/0x88
> 082a4afc:  [<ffffe410>] 0xffffe410
>
> Terminated
>  
>
> ------------------------------------------------------------------------------
> Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
> MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
> with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
> MVPs and experts. SALE $99.99 this month only -- learn more at:
> http://p.sf.net/sfu/learnmore_122912
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
>


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

