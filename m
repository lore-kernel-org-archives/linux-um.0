Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSjlv-00026t-DQ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 15:52:15 -0700
Received: from www.scgiservices.com ([198.107.3.66] helo=www.sterlingcgi.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DSjlt-0007cJ-OQ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 15:52:15 -0700
Message-ID: <20050502155212.gfil42buedk4w8w4@www.scgiservices.com>
From: Anthony Brock <brocka@sterlingcgi.com>
Subject: Re: [uml-devel] Kernel panic with 2.6.11.6
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
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
Date: Mon,  2 May 2005 15:52:12 -0700
To: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Okay, I was in the process of attempting to recreate this when I
encountered the
following. Is this your "stack trace"? It occured on a slightly newer version
of both the host kernel and guest kernel.

This guest is 2.6.11.7 with the bs4 patches applied. The host is
2.6.11.7-skas3-v8. Of course, I'm now baffled by why THIS instance
would dump a
stack trace while the other instance doesn't. *sigh*

This crashed occurred immediately after boot. I had entered login credentials
and was typing a "cat /proc/cmdline" command when it crashed (I never made it
to the <enter> key). I can supply a kernel config file or other information if
requested. Also, I've removed the /lib/tls directory.

Tony


Kernel panic - not syncing: Kernel mode fault at addr 0xcfcfcfd7, ip 0x0

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
     Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
Call Trace:
08297338:  [<0808c30d>] notifier_call_chain+0x2d/0x50
08297348:  [<0818fe16>] bust_spinlocks+0x46/0x50
08297358:  [<0807d131>] panic+0x71/0x120
08297378:  [<08066997>] segv+0x217/0x250
08297390:  [<0806505d>] set_signals+0x7d/0x130
082973d8:  [<08064eb5>] change_signals+0x65/0x90
08297468:  [<08066cb7>] segv_handler+0xd7/0xe0
08297488:  [<080697f0>] sig_handler_common_skas+0x90/0xe0
082974b8:  [<08075e87>] sig_handler+0x17/0x20
08297508:  [<0806b21f>] chan_interrupt+0xf/0x130
08297530:  [<08064f70>] enable_mask+0x50/0x70
08297550:  [<08064fc3>] get_signals+0x33/0x50
082975a0:  [<081c3bf4>] kfree_skbmem+0x24/0x30
082975b0:  [<081c3c95>] __kfree_skb+0x95/0x150
082975d0:  [<0806d14c>] uml_net_start_xmit+0x6c/0x110
082975f0:  [<08082a98>] local_bh_enable+0x8/0x90
08297610:  [<081c9c25>] dev_queue_xmit+0x145/0x220
08297630:  [<081cf7f8>] neigh_resolve_output+0xe8/0x1c0
08297670:  [<0c85cb46>] ip6_output2+0x176/0x280 [ipv6]
08297680:  [<0c86caae>] ndisc_fill_addr_option+0x1e/0xc0 [ipv6]
08297690:  [<0c85d28a>] ip6_nd_hdr+0xaa/0x100 [ipv6]
082976b0:  [<0c86dec8>] ndisc_send_rs+0x2a8/0x4d0 [ipv6]
082976e0:  [<08064eb5>] change_signals+0x65/0x90
08297750:  [<08064e2a>] change_sig+0x6a/0x90
082977d0:  [<0806b85f>] line_interrupt+0x2f/0x40
082977f0:  [<08099900>] handle_IRQ_event+0x30/0x80
08297820:  [<080999f8>] __do_IRQ+0xa8/0xf0
08297840:  [<0805fea3>] do_IRQ+0x33/0x50
08297850:  [<0806004a>] sigio_handler+0xda/0x140
08297870:  [<080697f0>] sig_handler_common_skas+0x90/0xe0
08297894:  [<080690e0>] start_kernel_proc+0x0/0x40
0829789c:  [<08068cc0>] new_thread_handler+0x0/0x120
082978a0:  [<08075e87>] sig_handler+0x17/0x20
082978cc:  [<080690e0>] start_kernel_proc+0x0/0x40
082978d0:  [<08068cc0>] new_thread_handler+0x0/0x120
08297a40:  [<08068937>] switch_threads+0x87/0x90
08297a70:  [<08064eb5>] change_signals+0x65/0x90
08297b10:  [<08064f0f>] unblock_signals+0xf/0x20
08297b20:  [<080799e7>] finish_task_switch+0x27/0x70
08297b40:  [<08244353>] schedule+0x2e3/0x4e0
08297b90:  [<08065e93>] idle_sleep+0x23/0x30
08297bac:  [<08068cc0>] new_thread_handler+0x0/0x120
08297bb0:  [<08062f37>] default_idle+0x67/0x70
08297bd0:  [<080690d8>] init_idle_skas+0x28/0x30
08297bd4:  [<0805f210>] init+0x0/0x110
08297be0:  [<080495b3>] start_kernel+0x163/0x1a0
08297bf4:  [<08049130>] unknown_bootoption+0x0/0x200
08297c00:  [<0806910b>] start_kernel_proc+0x2b/0x40
08297c04:  [<080690e0>] start_kernel_proc+0x0/0x40
08297c10:  [<08062978>] run_kernel_thread+0x78/0x80
08297c28:  [<080690e0>] start_kernel_proc+0x0/0x40
08297c30:  [<08068cc0>] new_thread_handler+0x0/0x120
08297c38:  [<08062940>] run_kernel_thread+0x40/0x80
08297cd4:  [<080690e0>] start_kernel_proc+0x0/0x40
08297cdc:  [<08068cc0>] new_thread_handler+0x0/0x120
08297ce0:  [<08068d8e>] new_thread_handler+0xce/0x120
08297ce4:  [<080690e0>] start_kernel_proc+0x0/0x40
08297d40:  [<08068cc0>] new_thread_handler+0x0/0x120


Quoting Jeff Dike <jdike@addtoit.com>:
> On Wed, Apr 27, 2005 at 01:33:24PM -0700, Anthony Brock wrote:
>> Kernel panic - not syncing: Kernel mode fault at addr 0x19, ip 0x402eb2d2
>>
>> This only happens when I reconnect to the guest console by attaching to the
>> associated "screen" session. Also, it is erradic at best and happens
>> about once
>> out of every 15-20 times I reconnect to the screen. Fortunately, the
>> apparent
>> trigger (connecting to the console) ensures that I'm aware of the crash and
>> able to immediately restart the instance.
>>
>> Any ideas on how to troubleshoot this? Is it a known issue that I've somehow
>> missed on the list? Thanks!
>
> My usual request - can you get a stack trace from it?
>
> 				Jeff
>






-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
