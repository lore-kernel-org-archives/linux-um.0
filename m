Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9p4I-00065z-3R for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 10:41:02 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D9p4G-0001U6-Dj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 10:41:02 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503111935.40714.blaisorblade@yahoo.it>
Subject: [uml-devel] Sleeping function in atomic - 2.6.11
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
Date: Fri, 11 Mar 2005 19:35:40 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This happened with CONFIG_HIGHMEM enabled on a almost-vanilla 2.6.11... with 
that option disabled I don't see such problems (also tested on both the same 
exact kernel, and with nearby ones).

To sum up, there is a read() syscall, a copy_to_user() (which calls kmap()) 
with preemption disabled (in_atomic() == 1) and the might_sleep produces a 
warning... now, what's strange is that UML is always built with preemption 
disabled (will this mean in_atomic == 1 always?).

And also I don't understand what changes with HIGHMEM... it seems that kmap 
always calls might_sleep().

Debug: sleeping function called from invalid context at 
arch/um/sys-i386/highmem.c:5
in_atomic():1, irqs_disabled():0
Call Trace:
0bdd77a0:  [<08079cec>] __might_sleep+0xac/0xd0
0bdd77c0:  [<0807676d>] kmap+0x1d/0x40
0bdd77d0:  [<08061417>] do_op+0x37/0x70
0bdd77f0:  [<080614ca>] do_buffer_op+0x7a/0x1a0
0bdd7800:  [<08061780>] copy_chunk_to_user+0x0/0x40
0bdd7810:  [<08061780>] copy_chunk_to_user+0x0/0x40
0bdd7830:  [<0805f7e1>] setjmp_wrapper+0x51/0x60
0bdd783c:  [<08237b45>] sigemptyset+0x25/0x40
0bdd7868:  [<0805f7ac>] setjmp_wrapper+0x1c/0x60
0bdd78ac:  [<08237b45>] sigemptyset+0x25/0x40
0bdd78c0:  [<0805c17b>] change_signals+0x5b/0x90
0bdd7900:  [<08061631>] buffer_op+0x41/0x80
0bdd7904:  [<08061450>] do_buffer_op+0x0/0x1a0
0bdd7914:  [<08061780>] copy_chunk_to_user+0x0/0x40
0bdd7930:  [<0806183e>] copy_to_user_skas+0x7e/0xc0
0bdd7940:  [<08061780>] copy_chunk_to_user+0x0/0x40
0bdd7960:  [<080b053f>] file_read_actor+0xcf/0x150
0bdd7990:  [<080b02a7>] do_generic_mapping_read+0x607/0x7d0
0bdd79b0:  [<0805c219>] enable_mask+0x49/0x60
0bdd7a40:  [<080b0770>] __generic_file_aio_read+0x1b0/0x220
0bdd7a58:  [<080b0470>] file_read_actor+0x0/0x150
0bdd7a88:  [<080ba2ae>] poison_obj+0x2e/0x60
0bdd7aa0:  [<080b0953>] generic_file_read+0xd3/0x100
0bdd7b20:  [<080a2fe0>] autoremove_wake_function+0x0/0x60
0bdd7b50:  [<080e0534>] vfs_read+0xe4/0x180
0bdd7b80:  [<080e0901>] sys_read+0x51/0x80
0bdd7bb0:  [<08060c87>] execute_syscall_skas+0xd7/0x100
0bdd7bd0:  [<08280e04>] schedule+0x3a4/0x6f0
0bdd7c20:  [<0805cb79>] record_syscall_start+0x59/0x70
0bdd7c40:  [<08060ce9>] handle_syscall+0x39/0x70
0bdd7c60:  [<080600d1>] userspace+0x231/0x3b0
0bdd7c90:  [<080779d9>] finish_task_switch+0x79/0x110
0bdd7cd0:  [<080611e8>] force_flush_all_skas+0x38/0x40
0bdd7cf0:  [<080608dc>] fork_handler+0xbc/0xd0
0bdd7d20:  [<08237738>] __restore+0x0/0x8
0bdd7d60:  [<08237ab1>] kill+0x11/0x20


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
