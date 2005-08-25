Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8EMq-00087V-1F	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Aug 2005 02:49:52 -0700
Received: from rimuhosting.com ([69.90.33.248])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E8EMo-0006DH-VI
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Aug 2005 02:49:52 -0700
Received: from [192.168.1.102] (60-234-157-72.bitstream.orcon.net.nz
	[60.234.157.72])	(authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id j7P9ngxq024722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 25 Aug 2005 09:49:45 GMT
Message-ID: <430D9435.2090809@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
References: <20050824155845.80549.qmail@web30709.mail.mud.yahoo.com>
	<430C9A3D.8010104@athon.me.uk>
In-Reply-To: <430C9A3D.8010104@athon.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: host kernel dump on 2.6.11.12-skas3-v8.2
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
Date: Thu, 25 Aug 2005 09:49:41 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Hi.  I just got this kernel dump on one particular host server that has 
been giving me some grief - it has paniced 3 times over the last month.

Would anyone on the list care to take a guess whether this looks like a 
hardware, skas or vanilla kernel problem.  Any recommendations appreciated.

Regards, Peter


[root@host ~]# uname -a
Linux 2.6.11.12-skas3-v8.2 #1 SMP Wed Aug 10 01:26:47 UTC 2005 i686 i686 
i386 GNU/Linux
[root@host ~]# cat /var/log/messages | grep kernel
Aug 23 03:25:04 host kernel: MCE: The hardware reports a non fatal, 
correctable incident occurred on CPU 2.
Aug 23 03:25:04 host kernel: Bank 0: b20000001020080f
Aug 25 07:41:32 host kernel: ------------[ cut here ]------------
Aug 25 07:41:32 host kernel: kernel BUG at mm/rmap.c:482!
Aug 25 07:41:32 host kernel: invalid operand: 0000 [#1]
Aug 25 07:41:32 host kernel: PREEMPT SMP
Aug 25 07:41:32 host kernel: Modules linked in: tun crc32 w83781d 
i2c_sensor ipv6 binfmt_misc video button battery ac i2c_piix4 i2c_core 
iptable_filter ip_tables e1000
Aug 25 07:41:32 host kernel: CPU:    1
Aug 25 07:41:32 host kernel: EIP:    0060:[<c014b793>]    Tainted: G   M 
  VLI
Aug 25 07:41:32 host kernel: EFLAGS: 00010286   (2.6.11.12-skas3-v8.2)
Aug 25 07:41:32 host kernel: EIP is at page_remove_rmap+0x44/0x4e
Aug 25 07:41:32 host kernel: eax: ffffffff   ebx: 00000000   ecx: 
c2033b18   edx: c2033b00
Aug 25 07:41:32 host kernel: esi: fffe0aa0   edi: 00008000   ebp: 
c2033b00   esp: f3081d44
Aug 25 07:41:32 host kernel: ds: 007b   es: 007b   ss: 0068
Aug 25 07:41:32 host kernel: Process linux (pid: 8175, 
threadinfo=f3080000 task=f786d550)
Aug 25 07:41:32 host kernel: Stack: c013fe77 00000000 c0144531 c2033b00 
00000007 00000001 c0359690 819d8067
Aug 25 07:41:32 host kernel:        00000000 a26a8000 c2e95400 a2aa8000 
f3d15a28 a26b0000 00000000 c014474e
Aug 25 07:41:32 host kernel:        c2e95400 f3d15a24 a26a8000 00008000 
00000000 a26a8000 f3d15a28 a26b0000
Aug 25 07:41:32 host kernel: Call Trace:
Aug 25 07:41:32 host kernel:  [<c013fe77>] mark_page_accessed+0x29/0x30
Aug 25 07:41:32 host kernel:  [<c0144531>] zap_pte_range+0x153/0x319
Aug 25 07:41:32 host kernel:  [<c014474e>] zap_pmd_range+0x57/0x75
Aug 25 07:41:32 host kernel:  [<c01447a6>] zap_pud_range+0x3a/0x5e
Aug 25 07:41:32 host kernel:  [<c014483e>] unmap_page_range+0x74/0x91
Aug 25 07:41:32 host kernel:  [<c014494c>] unmap_vmas+0xf1/0x271
Aug 25 07:41:32 host kernel:  [<c014975e>] exit_mmap+0xa0/0x189
Aug 25 07:41:32 host kernel:  [<c0119443>] mmput+0x2c/0x89
Aug 25 07:41:32 host kernel:  [<c011ddb6>] do_exit+0xab/0x2bf
Aug 25 07:41:32 host kernel:  [<c011e02b>] do_group_exit+0x32/0x99
Aug 25 07:41:32 host kernel:  [<c0126edb>] get_signal_to_deliver+0x271/0x30a
Aug 25 07:41:32 host kernel:  [<c0102dfa>] do_signal+0x64/0x117
Aug 25 07:41:32 host kernel:  [<c0306069>] _spin_unlock_irqrestore+0xf/0x23
Aug 25 07:41:32 host kernel:  [<c0200fb7>] tty_poll+0x72/0xb9
Aug 25 07:41:32 host kernel:  [<c0156210>] fget+0x3b/0x42
Aug 25 07:41:32 host kernel:  [<c013adb0>] free_hot_cold_page+0xca/0x135
Aug 25 07:41:32 host kernel:  [<c01674d1>] poll_freewait+0x38/0x40
Aug 25 07:41:32 host kernel:  [<c0168140>] sys_poll+0x18b/0x22b
Aug 25 07:41:32 host kernel:  [<c01674d9>] __pollwait+0x0/0x9d
Aug 25 07:41:32 host kernel:  [<c0102ee4>] do_notify_resume+0x37/0x3b
Aug 25 07:41:32 host kernel:  [<c010305e>] work_notifysig+0x13/0x15
Aug 25 07:41:32 host kernel: Code: 1c 8b 42 08 83 c0 01 78 22 c7 44 24 
04 ff ff ff ff c7 04 24 10 00 00 00 e8 ad 00 ff ff 83 c4 08 c3 0f 0b df 
01 68 c0 31 c0 eb ca <0f> 0b e2 01 68 c0 31 c0 eb d4 55 57 56 53 83 ec 
18 8b 74 24 30
Aug 25 07:41:32 host kernel:  <6>note: linux[8175] exited with 
preempt_count 2
Aug 25 07:41:32 host kernel: scheduling while atomic: linux/0x00000002/8175
Aug 25 07:41:32 host kernel:  [<c0304bbf>] schedule+0x97f/0xb79
Aug 25 07:41:32 host kernel:  [<c012edbb>] autoremove_wake_function+0x0/0x4b
Aug 25 07:41:32 host kernel:  [<c0229e20>] __generic_unplug_device+0x1f/0x3e
Aug 25 07:41:32 host kernel:  [<c0229e5a>] generic_unplug_device+0x1b/0x2a
Aug 25 07:41:32 host kernel:  [<c0271260>] unplug_slaves+0xd8/0x10d
Aug 25 07:41:32 host kernel:  [<c0305550>] io_schedule+0x26/0x30
Aug 25 07:41:32 host kernel:  [<c0156400>] sync_buffer+0x4d/0x53
Aug 25 07:41:32 host kernel:  [<c0305726>] __wait_on_bit+0x45/0x61
Aug 25 07:41:32 host kernel:  [<c01563b3>] sync_buffer+0x0/0x53
Aug 25 07:41:32 host kernel:  [<c01563b3>] sync_buffer+0x0/0x53
Aug 25 07:41:32 host kernel:  [<c03057d3>] out_of_line_wait_on_bit+0x91/0x99
Aug 25 07:41:32 host kernel:  [<c012ee06>] wake_bit_function+0x0/0x34
Aug 25 07:41:32 host kernel:  [<c012ee06>] wake_bit_function+0x0/0x34
Aug 25 07:41:32 host kernel:  [<c015786e>] __bread_slow+0x59/0x76
Aug 25 07:41:32 host kernel:  [<c0157b24>] __bread+0x3d/0x45
Aug 25 07:41:32 host kernel:  [<c01902f5>] read_block_bitmap+0x4c/0x80
Aug 25 07:41:32 host kernel:  [<c0190577>] ext3_free_blocks_sb+0xa5/0x675
Aug 25 07:41:32 host kernel:  [<c0157a21>] __find_get_block+0xbd/0xdb
Aug 25 07:41:32 host kernel:  [<c0190b87>] ext3_free_blocks+0x40/0xbf
Aug 25 07:41:32 host kernel:  [<c01966d2>] ext3_free_data+0xb8/0x160
Aug 25 07:41:32 host kernel:  [<c0196f1d>] ext3_truncate+0x52c/0x58c
Aug 25 07:41:32 host kernel:  [<c01a5a04>] journal_start+0x99/0xc0
Aug 25 07:41:32 host kernel:  [<c0210db1>] poke_blanked_console+0xaf/0xbd
Aug 25 07:41:32 host kernel:  [<c019409b>] start_transaction+0x23/0x55
Aug 25 07:41:32 host kernel:  [<c019420b>] ext3_delete_inode+0xe9/0xee
Aug 25 07:41:32 host kernel:  [<c0305ce0>] _spin_lock+0xe/0x70
Aug 25 07:41:32 host kernel:  [<c0194122>] ext3_delete_inode+0x0/0xee
Aug 25 07:41:32 host kernel:  [<c016e5c4>] generic_delete_inode+0x9c/0x15d
Aug 25 07:41:32 host kernel:  [<c016e806>] iput+0x3c/0x7b
Aug 25 07:41:32 host kernel:  [<c016b881>] dput+0x5a/0x1cb
Aug 25 07:41:32 host kernel:  [<c015617e>] __fput+0x84/0xdb
Aug 25 07:41:32 host kernel:  [<c0154a4a>] filp_close+0x49/0x7b
Aug 25 07:41:32 host kernel:  [<c011d0e5>] put_files_struct+0x83/0xfc
Aug 25 07:41:32 host kernel:  [<c011dded>] do_exit+0xe2/0x2bf
Aug 25 07:41:32 host kernel:  [<c0104558>] do_invalid_op+0x0/0xab
Aug 25 07:41:32 host kernel:  [<c0104244>] do_trap+0x0/0xd7
Aug 25 07:41:33 host kernel:  [<c01045fa>] do_invalid_op+0xa2/0xab
Aug 25 07:41:33 host kernel:  [<c014b793>] page_remove_rmap+0x44/0x4e
Aug 25 07:41:33 host kernel:  [<c012bb01>] rcu_process_callbacks+0x54/0x5a
Aug 25 07:41:33 host kernel:  [<c01206c0>] tasklet_action+0x55/0xba
Aug 25 07:41:33 host kernel:  [<c012036b>] __do_softirq+0x7b/0xc6
Aug 25 07:41:33 host kernel:  [<c0103a1c>] apic_timer_interrupt+0x1c/0x24
Aug 25 07:41:33 host kernel:  [<c0103ac3>] error_code+0x2b/0x30
Aug 25 07:41:33 host kernel:  [<c013007b>] cpu_up+0xf/0xd7
Aug 25 07:41:33 host kernel:  [<c014b793>] page_remove_rmap+0x44/0x4e
Aug 25 07:41:33 host kernel:  [<c013fe77>] mark_page_accessed+0x29/0x30
Aug 25 07:41:33 host kernel:  [<c0144531>] zap_pte_range+0x153/0x319
Aug 25 07:41:33 host kernel:  [<c014474e>] zap_pmd_range+0x57/0x75
Aug 25 07:41:33 host kernel:  [<c01447a6>] zap_pud_range+0x3a/0x5e
Aug 25 07:41:33 host kernel:  [<c014483e>] unmap_page_range+0x74/0x91
Aug 25 07:41:33 host kernel:  [<c014494c>] unmap_vmas+0xf1/0x271
Aug 25 07:41:33 host kernel:  [<c014975e>] exit_mmap+0xa0/0x189
Aug 25 07:41:33 host kernel:  [<c0119443>] mmput+0x2c/0x89
Aug 25 07:41:33 host kernel:  [<c011ddb6>] do_exit+0xab/0x2bf
Aug 25 07:41:33 host kernel:  [<c011e02b>] do_group_exit+0x32/0x99
Aug 25 07:41:33 host kernel:  [<c0126edb>] get_signal_to_deliver+0x271/0x30a
Aug 25 07:41:33 host kernel:  [<c0102dfa>] do_signal+0x64/0x117
Aug 25 07:41:33 host kernel:  [<c0306069>] _spin_unlock_irqrestore+0xf/0x23
Aug 25 07:41:33 host kernel:  [<c0200fb7>] tty_poll+0x72/0xb9
Aug 25 07:41:33 host kernel:  [<c0156210>] fget+0x3b/0x42
Aug 25 07:41:33 host kernel:  [<c013adb0>] free_hot_cold_page+0xca/0x135
Aug 25 07:41:33 host kernel:  [<c01674d1>] poll_freewait+0x38/0x40
Aug 25 07:41:33 host kernel:  [<c0168140>] sys_poll+0x18b/0x22b
Aug 25 07:41:33 host kernel:  [<c01674d9>] __pollwait+0x0/0x9d
Aug 25 07:41:33 host kernel:  [<c0102ee4>] do_notify_resume+0x37/0x3b
Aug 25 07:41:33 host kernel:  [<c010305e>] work_notifysig+0x13/0x15
Aug 25 07:41:33 host kernel: scheduling while atomic: linux/0x00000002/8175
Aug 25 07:41:33 host kernel:  [<c0304bbf>] schedule+0x97f/0xb79
Aug 25 07:41:33 host kernel:  [<c0228142>] elv_next_request+0x3a/0xfc
Aug 25 07:41:33 host kernel:  [<c0229e20>] __generic_unplug_device+0x1f/0x3e
Aug 25 07:41:33 host kernel:  [<c0229e5a>] generic_unplug_device+0x1b/0x2a
Aug 25 07:41:33 host kernel:  [<c0271260>] unplug_slaves+0xd8/0x10d
Aug 25 07:41:33 host kernel:  [<c0305550>] io_schedule+0x26/0x30
Aug 25 07:41:33 host kernel:  [<c0156400>] sync_buffer+0x4d/0x53
Aug 25 07:41:33 host kernel:  [<c0305726>] __wait_on_bit+0x45/0x61
Aug 25 07:41:33 host kernel:  [<c01563b3>] sync_buffer+0x0/0x53
Aug 25 07:41:33 host kernel:  [<c01563b3>] sync_buffer+0x0/0x53
Aug 25 07:41:33 host kernel:  [<c03057d3>] out_of_line_wait_on_bit+0x91/0x99
Aug 25 07:41:33 host kernel:  [<c012ee06>] wake_bit_function+0x0/0x34
Aug 25 07:41:33 host kernel:  [<c012ee06>] wake_bit_function+0x0/0x34
Aug 25 07:41:33 host kernel:  [<c0197255>] __ext3_get_inode_loc+0x18a/0x258
Aug 25 07:41:33 host kernel:  [<c019734d>] ext3_get_inode_loc+0x2a/0x2e
Aug 25 07:41:33 host kernel:  [<c0197fcb>] 
ext3_reserve_inode_write+0x25/0xa9
Aug 25 07:41:33 host kernel:  [<c01add05>] 
journal_add_journal_head+0x1a2/0x1ce
Aug 25 07:41:33 host kernel:  [<c0198071>] ext3_mark_inode_dirty+0x22/0x44
Aug 25 07:41:33 host kernel:  [<c019810c>] ext3_dirty_inode+0x79/0x7b
Aug 25 07:41:33 host kernel:  [<c0176265>] __mark_inode_dirty+0xb5/0x1c8
Aug 25 07:41:33 host kernel:  [<c0305ce0>] _spin_lock+0xe/0x70
Aug 25 07:41:33 host kernel:  [<c015e8ad>] inode_sub_bytes+0x1e/0x83
Aug 25 07:41:33 host kernel:  [<c0190bda>] ext3_free_blocks+0x93/0xbf
Aug 25 07:41:33 host kernel:  [<c01966d2>] ext3_free_data+0xb8/0x160
Aug 25 07:41:33 host kernel:  [<c0196f1d>] ext3_truncate+0x52c/0x58c
Aug 25 07:41:33 host kernel:  [<c01a5a04>] journal_start+0x99/0xc0
Aug 25 07:41:33 host kernel:  [<c0210db1>] poke_blanked_console+0xaf/0xbd
Aug 25 07:41:33 host kernel:  [<c019409b>] start_transaction+0x23/0x55
Aug 25 07:41:33 host kernel:  [<c019420b>] ext3_delete_inode+0xe9/0xee
Aug 25 07:41:33 host kernel:  [<c0305ce0>] _spin_lock+0xe/0x70
Aug 25 07:41:33 host kernel:  [<c0194122>] ext3_delete_inode+0x0/0xee
Aug 25 07:41:33 host kernel:  [<c016e5c4>] generic_delete_inode+0x9c/0x15d
Aug 25 07:41:33 host kernel:  [<c016e806>] iput+0x3c/0x7b
Aug 25 07:41:33 host kernel:  [<c016b881>] dput+0x5a/0x1cb
Aug 25 07:41:33 host kernel:  [<c015617e>] __fput+0x84/0xdb
Aug 25 07:41:33 host kernel:  [<c0154a4a>] filp_close+0x49/0x7b
Aug 25 07:41:33 host kernel:  [<c011d0e5>] put_files_struct+0x83/0xfc
Aug 25 07:41:33 host kernel:  [<c011dded>] do_exit+0xe2/0x2bf
Aug 25 07:41:33 host kernel:  [<c0104558>] do_invalid_op+0x0/0xab
Aug 25 07:41:33 host kernel:  [<c0104244>] do_trap+0x0/0xd7
Aug 25 07:41:33 host kernel:  [<c01045fa>] do_invalid_op+0xa2/0xab
Aug 25 07:41:33 host kernel:  [<c014b793>] page_remove_rmap+0x44/0x4e
Aug 25 07:41:33 host kernel:  [<c012bb01>] rcu_process_callbacks+0x54/0x5a
Aug 25 07:41:33 host kernel:  [<c01206c0>] tasklet_action+0x55/0xba
Aug 25 07:41:33 host kernel:  [<c012036b>] __do_softirq+0x7b/0xc6
Aug 25 07:41:33 host kernel:  [<c0103a1c>] apic_timer_interrupt+0x1c/0x24
Aug 25 07:41:33 host kernel:  [<c0103ac3>] error_code+0x2b/0x30
Aug 25 07:41:34 host kernel:  [<c013007b>] cpu_up+0xf/0xd7
Aug 25 07:41:34 host kernel:  [<c014b793>] page_remove_rmap+0x44/0x4e
Aug 25 07:41:34 host kernel:  [<c013fe77>] mark_page_accessed+0x29/0x30
Aug 25 07:41:34 host kernel:  [<c0144531>] zap_pte_range+0x153/0x319
Aug 25 07:41:34 host kernel:  [<c014474e>] zap_pmd_range+0x57/0x75
Aug 25 07:41:34 host kernel:  [<c01447a6>] zap_pud_range+0x3a/0x5e
Aug 25 07:41:34 host kernel:  [<c014483e>] unmap_page_range+0x74/0x91
Aug 25 07:41:34 host kernel:  [<c014494c>] unmap_vmas+0xf1/0x271
Aug 25 07:41:34 host kernel:  [<c014975e>] exit_mmap+0xa0/0x189
Aug 25 07:41:34 host kernel:  [<c0119443>] mmput+0x2c/0x89
Aug 25 07:41:34 host kernel:  [<c011ddb6>] do_exit+0xab/0x2bf
Aug 25 07:41:34 host kernel:  [<c011e02b>] do_group_exit+0x32/0x99
Aug 25 07:41:34 host kernel:  [<c0126edb>] get_signal_to_deliver+0x271/0x30a
Aug 25 07:41:34 host kernel:  [<c0102dfa>] do_signal+0x64/0x117
Aug 25 07:41:34 host kernel:  [<c0306069>] _spin_unlock_irqrestore+0xf/0x23
Aug 25 07:41:34 host kernel:  [<c0200fb7>] tty_poll+0x72/0xb9
Aug 25 07:41:34 host kernel:  [<c0156210>] fget+0x3b/0x42
Aug 25 07:41:34 host kernel:  [<c013adb0>] free_hot_cold_page+0xca/0x135
Aug 25 07:41:34 host kernel:  [<c01674d1>] poll_freewait+0x38/0x40
Aug 25 07:41:34 host kernel:  [<c0168140>] sys_poll+0x18b/0x22b
Aug 25 07:41:34 host kernel:  [<c01674d9>] __pollwait+0x0/0x9d
Aug 25 07:41:34 host kernel:  [<c0102ee4>] do_notify_resume+0x37/0x3b
Aug 25 07:41:34 host kernel:  [<c010305e>] work_notifysig+0x13/0x15
Aug 25 07:41:34 host kernel: scheduling while atomic: linux/0x00000002/8175
Aug 25 07:41:34 host kernel:  [<c0304bbf>] schedule+0x97f/0xb79
Aug 25 07:41:34 host kernel:  [<c012edbb>] autoremove_wake_function+0x0/0x4b
Aug 25 07:41:34 host kernel:  [<c0229e20>] __generic_unplug_device+0x1f/0x3e
Aug 25 07:41:34 host kernel:  [<c0271260>] unplug_slaves+0xd8/0x10d
Aug 25 07:41:34 host kernel:  [<c0305550>] io_schedule+0x26/0x30
Aug 25 07:41:34 host kernel:  [<c0156400>] sync_buffer+0x4d/0x53
Aug 25 07:41:34 host kernel:  [<c0305726>] __wait_on_bit+0x45/0x61
Aug 25 07:41:34 host kernel:  [<c01563b3>] sync_buffer+0x0/0x53
Aug 25 07:41:34 host kernel:  [<c01563b3>] sync_buffer+0x0/0x53
Aug 25 07:41:34 host kernel:  [<c03057d3>] out_of_line_wait_on_bit+0x91/0x99
Aug 25 07:41:34 host kernel:  [<c012ee06>] wake_bit_function+0x0/0x34
Aug 25 07:41:34 host kernel:  [<c012ee06>] wake_bit_function+0x0/0x34
Aug 25 07:41:34 host kernel:  [<c015786e>] __bread_slow+0x59/0x76
Aug 25 07:41:34 host kernel:  [<c0157b24>] __bread+0x3d/0x45
Aug 25 07:41:34 host kernel:  [<c0192c1d>] read_inode_bitmap+0x4d/0x82
Aug 25 07:41:34 host kernel:  [<c019f568>] ext3_dquot_drop+0x0/0x4e
Aug 25 07:41:34 host kernel:  [<c0192de5>] ext3_free_inode+0x193/0x433
Aug 25 07:41:34 host kernel:  [<c019808c>] ext3_mark_inode_dirty+0x3d/0x44
Aug 25 07:41:34 host kernel:  [<c01941ed>] ext3_delete_inode+0xcb/0xee
Aug 25 07:41:34 host kernel:  [<c0194122>] ext3_delete_inode+0x0/0xee
Aug 25 07:41:34 host kernel:  [<c016e5c4>] generic_delete_inode+0x9c/0x15d
Aug 25 07:41:34 host kernel:  [<c016e806>] iput+0x3c/0x7b
Aug 25 07:41:34 host kernel:  [<c016b881>] dput+0x5a/0x1cb
Aug 25 07:41:34 host kernel:  [<c015617e>] __fput+0x84/0xdb
Aug 25 07:41:34 host kernel:  [<c0154a4a>] filp_close+0x49/0x7b
Aug 25 07:41:34 host kernel:  [<c011d0e5>] put_files_struct+0x83/0xfc
Aug 25 07:41:34 host kernel:  [<c011dded>] do_exit+0xe2/0x2bf
Aug 25 07:41:34 host kernel:  [<c0104558>] do_invalid_op+0x0/0xab
Aug 25 07:41:34 host kernel:  [<c0104244>] do_trap+0x0/0xd7
Aug 25 07:41:34 host kernel:  [<c01045fa>] do_invalid_op+0xa2/0xab
Aug 25 07:41:34 host kernel:  [<c014b793>] page_remove_rmap+0x44/0x4e
Aug 25 07:41:34 host kernel:  [<c012bb01>] rcu_process_callbacks+0x54/0x5a
Aug 25 07:41:34 host kernel:  [<c01206c0>] tasklet_action+0x55/0xba
Aug 25 07:41:34 host kernel:  [<c012036b>] __do_softirq+0x7b/0xc6
Aug 25 07:41:34 host kernel:  [<c0103a1c>] apic_timer_interrupt+0x1c/0x24
Aug 25 07:41:34 host kernel:  [<c0103ac3>] error_code+0x2b/0x30
Aug 25 07:41:34 host kernel:  [<c013007b>] cpu_up+0xf/0xd7
Aug 25 07:41:34 host kernel:  [<c014b793>] page_remove_rmap+0x44/0x4e
Aug 25 07:41:34 host kernel:  [<c013fe77>] mark_page_accessed+0x29/0x30
Aug 25 07:41:34 host kernel:  [<c0144531>] zap_pte_range+0x153/0x319
Aug 25 07:41:34 host kernel:  [<c014474e>] zap_pmd_range+0x57/0x75
Aug 25 07:41:34 host kernel:  [<c01447a6>] zap_pud_range+0x3a/0x5e
Aug 25 07:41:34 host kernel:  [<c014483e>] unmap_page_range+0x74/0x91
Aug 25 07:41:34 host kernel:  [<c014494c>] unmap_vmas+0xf1/0x271
Aug 25 07:41:34 host kernel:  [<c014975e>] exit_mmap+0xa0/0x189
Aug 25 07:41:34 host kernel:  [<c0119443>] mmput+0x2c/0x89
Aug 25 07:41:34 host kernel:  [<c011ddb6>] do_exit+0xab/0x2bf
Aug 25 07:41:34 host kernel:  [<c011e02b>] do_group_exit+0x32/0x99
Aug 25 07:41:34 host kernel:  [<c0126edb>] get_signal_to_deliver+0x271/0x30a
Aug 25 07:41:34 host kernel:  [<c0102dfa>] do_signal+0x64/0x117
Aug 25 07:41:34 host kernel:  [<c0306069>] _spin_unlock_irqrestore+0xf/0x23
Aug 25 07:41:34 host kernel:  [<c0200fb7>] tty_poll+0x72/0xb9
Aug 25 07:41:34 host kernel:  [<c0156210>] fget+0x3b/0x42
Aug 25 07:41:34 host kernel:  [<c013adb0>] free_hot_cold_page+0xca/0x135
Aug 25 07:41:34 host kernel:  [<c01674d1>] poll_freewait+0x38/0x40
Aug 25 07:41:34 host kernel:  [<c0168140>] sys_poll+0x18b/0x22b
Aug 25 07:41:34 host kernel:  [<c01674d9>] __pollwait+0x0/0x9d
Aug 25 07:41:34 host kernel:  [<c0102ee4>] do_notify_resume+0x37/0x3b
Aug 25 07:41:34 host kernel:  [<c010305e>] work_notifysig+0x13/0x15
Aug 25 07:41:34 host kernel: scheduling while atomic: linux/0x00000002/8175
Aug 25 07:41:34 host kernel:  [<c0304bbf>] schedule+0x97f/0xb79
Aug 25 07:41:34 host kernel:  [<c02594b4>] ide_do_request+0x216/0x3ad
Aug 25 07:41:34 host kernel:  [<c025966e>] do_ide_request+0x23/0x27
Aug 25 07:41:34 host kernel:  [<c0229e5a>] generic_unplug_device+0x1b/0x2a
Aug 25 07:41:34 host kernel:  [<c0271260>] unplug_slaves+0xd8/0x10d
Aug 25 07:41:34 host kernel:  [<c0305550>] io_schedule+0x26/0x30
Aug 25 07:41:35 host kernel:  [<c0156400>] sync_buffer+0x4d/0x53
Aug 25 07:41:35 host kernel:  [<c0305726>] __wait_on_bit+0x45/0x61
Aug 25 07:41:35 host kernel:  [<c01563b3>] sync_buffer+0x0/0x53
Aug 25 07:41:35 host kernel:  [<c01563b3>] sync_buffer+0x0/0x53
Aug 25 07:41:35 host kernel:  [<c03057d3>] out_of_line_wait_on_bit+0x91/0x99
Aug 25 07:41:35 host kernel:  [<c012ee06>] wake_bit_function+0x0/0x34
Aug 25 07:41:35 host kernel:  [<c012ee06>] wake_bit_function+0x0/0x34
Aug 25 07:41:35 host kernel:  [<c0197255>] __ext3_get_inode_loc+0x18a/0x258
Aug 25 07:41:35 host kernel:  [<c019734d>] ext3_get_inode_loc+0x2a/0x2e
Aug 25 07:41:35 host kernel:  [<c0197fcb>] 
ext3_reserve_inode_write+0x25/0xa9
Aug 25 07:41:35 host kernel:  [<c019b884>] ext3_orphan_del+0xd2/0x220
Aug 25 07:41:35 host kernel:  [<c019418a>] ext3_delete_inode+0x68/0xee
Aug 25 07:41:35 host kernel:  [<c0194122>] ext3_delete_inode+0x0/0xee
Aug 25 07:41:35 host kernel:  [<c016e5c4>] generic_delete_inode+0x9c/0x15d
Aug 25 07:41:35 host kernel:  [<c016e806>] iput+0x3c/0x7b
Aug 25 07:41:35 host kernel:  [<c016b881>] dput+0x5a/0x1cb
Aug 25 07:41:35 host kernel:  [<c015617e>] __fput+0x84/0xdb
Aug 25 07:41:35 host kernel:  [<c0154a4a>] filp_close+0x49/0x7b
Aug 25 07:41:35 host kernel:  [<c011d0e5>] put_files_struct+0x83/0xfc
Aug 25 07:41:35 host kernel:  [<c011dded>] do_exit+0xe2/0x2bf
Aug 25 07:41:35 host kernel:  [<c0104558>] do_invalid_op+0x0/0xab
Aug 25 07:41:35 host kernel:  [<c0104244>] do_trap+0x0/0xd7
Aug 25 07:41:35 host kernel:  [<c01045fa>] do_invalid_op+0xa2/0xab
Aug 25 07:41:35 host kernel:  [<c014b793>] page_remove_rmap+0x44/0x4e
Aug 25 07:41:35 host kernel:  [<c012bb01>] rcu_process_callbacks+0x54/0x5a
Aug 25 07:41:35 host kernel:  [<c01206c0>] tasklet_action+0x55/0xba
Aug 25 07:41:35 host kernel:  [<c012036b>] __do_softirq+0x7b/0xc6
Aug 25 07:41:35 host kernel:  [<c0103a1c>] apic_timer_interrupt+0x1c/0x24
Aug 25 07:41:35 host kernel:  [<c0103ac3>] error_code+0x2b/0x30
Aug 25 07:41:35 host kernel:  [<c013007b>] cpu_up+0xf/0xd7
Aug 25 07:41:35 host kernel:  [<c014b793>] page_remove_rmap+0x44/0x4e
Aug 25 07:41:35 host kernel:  [<c013fe77>] mark_page_accessed+0x29/0x30
Aug 25 07:41:35 host kernel:  [<c0144531>] zap_pte_range+0x153/0x319
Aug 25 07:41:35 host kernel:  [<c014474e>] zap_pmd_range+0x57/0x75
Aug 25 07:41:35 host kernel:  [<c01447a6>] zap_pud_range+0x3a/0x5e
Aug 25 07:41:35 host kernel:  [<c014483e>] unmap_page_range+0x74/0x91
Aug 25 07:41:35 host kernel:  [<c014494c>] unmap_vmas+0xf1/0x271
Aug 25 07:41:35 host kernel:  [<c014975e>] exit_mmap+0xa0/0x189
Aug 25 07:41:35 host kernel:  [<c0119443>] mmput+0x2c/0x89
Aug 25 07:41:35 host kernel:  [<c011ddb6>] do_exit+0xab/0x2bf
Aug 25 07:41:35 host kernel:  [<c011e02b>] do_group_exit+0x32/0x99
Aug 25 07:41:35 host kernel:  [<c0126edb>] get_signal_to_deliver+0x271/0x30a
Aug 25 07:41:35 host kernel:  [<c0102dfa>] do_signal+0x64/0x117
Aug 25 07:41:35 host kernel:  [<c0306069>] _spin_unlock_irqrestore+0xf/0x23
Aug 25 07:41:35 host kernel:  [<c0200fb7>] tty_poll+0x72/0xb9
Aug 25 07:41:35 host kernel:  [<c0156210>] fget+0x3b/0x42
Aug 25 07:41:35 host kernel:  [<c013adb0>] free_hot_cold_page+0xca/0x135
Aug 25 07:41:35 host kernel:  [<c01674d1>] poll_freewait+0x38/0x40
Aug 25 07:41:35 host kernel:  [<c0168140>] sys_poll+0x18b/0x22b
Aug 25 07:41:35 host kernel:  [<c01674d9>] __pollwait+0x0/0x9d
Aug 25 07:41:35 host kernel:  [<c0102ee4>] do_notify_resume+0x37/0x3b
Aug 25 07:41:35 host kernel:  [<c010305e>] work_notifysig+0x13/0x15
Aug 25 07:41:35 host kernel: scheduling while atomic: linux/0x10000002/8175
Aug 25 07:41:35 host kernel:  [<c0304bbf>] schedule+0x97f/0xb79
Aug 25 07:41:35 host kernel:  [<c01447a6>] zap_pud_range+0x3a/0x5e
Aug 25 07:41:35 host kernel:  [<c014d2cb>] 
free_pages_and_swap_cache+0x5f/0x85
Aug 25 07:41:35 host kernel:  [<c030548e>] cond_resched+0x2a/0x46
Aug 25 07:41:35 host kernel:  [<c01449c2>] unmap_vmas+0x167/0x271
Aug 25 07:41:35 host kernel:  [<c014975e>] exit_mmap+0xa0/0x189
Aug 25 07:41:35 host kernel:  [<c0119443>] mmput+0x2c/0x89
Aug 25 07:41:35 host kernel:  [<c01532c9>] release_proc_mm+0x15/0x1b
Aug 25 07:41:35 host kernel:  [<c01561b6>] __fput+0xbc/0xdb
Aug 25 07:41:35 host kernel:  [<c0154a4a>] filp_close+0x49/0x7b
Aug 25 07:41:35 host kernel:  [<c011d0e5>] put_files_struct+0x83/0xfc
Aug 25 07:41:35 host kernel:  [<c011dded>] do_exit+0xe2/0x2bf
Aug 25 07:41:35 host kernel:  [<c0104558>] do_invalid_op+0x0/0xab
Aug 25 07:41:35 host kernel:  [<c0104244>] do_trap+0x0/0xd7
Aug 25 07:41:35 host kernel:  [<c01045fa>] do_invalid_op+0xa2/0xab
Aug 25 07:41:35 host kernel:  [<c014b793>] page_remove_rmap+0x44/0x4e
Aug 25 07:41:35 host kernel:  [<c012bb01>] rcu_process_callbacks+0x54/0x5a
Aug 25 07:41:35 host kernel:  [<c01206c0>] tasklet_action+0x55/0xba
Aug 25 07:41:35 host kernel:  [<c012036b>] __do_softirq+0x7b/0xc6
Aug 25 07:41:35 host kernel:  [<c0103a1c>] apic_timer_interrupt+0x1c/0x24
Aug 25 07:41:35 host kernel:  [<c0103ac3>] error_code+0x2b/0x30
Aug 25 07:41:35 host kernel:  [<c013007b>] cpu_up+0xf/0xd7
Aug 25 07:41:35 host kernel:  [<c014b793>] page_remove_rmap+0x44/0x4e
Aug 25 07:41:35 host kernel:  [<c013fe77>] mark_page_accessed+0x29/0x30
Aug 25 07:41:35 host kernel:  [<c0144531>] zap_pte_range+0x153/0x319
Aug 25 07:41:35 host kernel:  [<c014474e>] zap_pmd_range+0x57/0x75
Aug 25 07:41:35 host kernel:  [<c01447a6>] zap_pud_range+0x3a/0x5e
Aug 25 07:41:35 host kernel:  [<c014483e>] unmap_page_range+0x74/0x91
Aug 25 07:41:35 host kernel:  [<c014494c>] unmap_vmas+0xf1/0x271
Aug 25 07:41:35 host kernel:  [<c014975e>] exit_mmap+0xa0/0x189
Aug 25 07:41:35 host kernel:  [<c0119443>] mmput+0x2c/0x89
Aug 25 07:41:35 host kernel:  [<c011ddb6>] do_exit+0xab/0x2bf
Aug 25 07:41:35 host kernel:  [<c011e02b>] do_group_exit+0x32/0x99
Aug 25 07:41:35 host kernel:  [<c0126edb>] get_signal_to_deliver+0x271/0x30a
Aug 25 07:41:35 host kernel:  [<c0102dfa>] do_signal+0x64/0x117
Aug 25 07:41:36 host kernel:  [<c0306069>] _spin_unlock_irqrestore+0xf/0x23
Aug 25 07:41:36 host kernel:  [<c0200fb7>] tty_poll+0x72/0xb9
Aug 25 07:41:36 host kernel:  [<c0156210>] fget+0x3b/0x42
Aug 25 07:41:36 host kernel:  [<c013adb0>] free_hot_cold_page+0xca/0x135
Aug 25 07:41:36 host kernel:  [<c01674d1>] poll_freewait+0x38/0x40
Aug 25 07:41:36 host kernel:  [<c0168140>] sys_poll+0x18b/0x22b
Aug 25 07:41:36 host kernel:  [<c01674d9>] __pollwait+0x0/0x9d
Aug 25 07:41:36 host kernel:  [<c0102ee4>] do_notify_resume+0x37/0x3b
Aug 25 07:41:36 host kernel:  [<c010305e>] work_notifysig+0x13/0x15


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
