Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1XIW-0003Ph-Nt for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:33:12 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C1XIU-0004Ha-R7 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:33:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id 4AAD9401A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 29 Aug 2004 23:33:07 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27460-13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 29 Aug 2004 23:33:06 +0200 (CEST)
Received: from [10.0.6.6] (pD9F6302F.dip.t-dialin.net [217.246.48.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id 2563A4011
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 29 Aug 2004 23:33:05 +0200 (CEST)
Message-ID: <41324B9B.5040100@exse.net>
From: Sebastian <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] creash of 2.6.7-bb6
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
Date: Sun, 29 Aug 2004 23:33:15 +0200
To: user-mode-linux-devel@lists.sourceforge.net

----------------------------------
Badness in sk_del_node_init at include/net/sock.h:333
Call Trace:  [<a01244d8>] __unix_remove_socket+0x68/0x70
 [<a0124824>] unix_release_sock+0x14/0x1f0
 [<a002c9ec>] local_bh_enable+0x1c/0x80
 [<a0019560>] do_buffer_op+0x0/0x150
 [<a0124ca7>] unix_release+0x27/0x30

    [<a00dd3ea>] sock_release+0x5a/0x70
 [<a00ddd14>] sock_close+0x34/0x50
 [<a00dea83>] sys_shutdown+0x43/0x50
 [<a005a96e>] __fput+0xbe/0xd0
 [<a00591f7>] filp_close+0x57/0x90
 [<a0059282>] sys_close+0x52/0x70

    [<a0018e6a>] execute_syscall_skas+0xaa/0xb0
 [<a0014832>] unblock_signals+0x12/0x20
 [<a0015359>] record_syscall_start+0x59/0x70
 [<a0018eab>] handle_syscall+0x3b/0x90
 [<a0017caf>] handle_trap+0x2f/0x140
 [<a00182df>] save_registers+0x3f/0x70

    [<a00180ca>] userspace+0x15a/0x1d0
 [<a0018b20>] fork_handler+0x0/0xb0
 [<a0018bc1>] fork_handler+0xa1/0xb0
 [<a0018b20>] fork_handler+0x0/0xb0
 [<a0018aed>] new_thread_proc+0x1d/0x30

KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc)) failed at 
net/unix/af_unix.c (333)
KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc)) failed at 
net/unix/af_unix.c (333)
KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc)) failed at 
net/unix/af_unix.c (333)
KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc)) failed at 
net/unix/af_unix.c (333)
KERNEL: assertion (sk_unhashed(sk)) failed at net/unix/af_unix.c (334)
-------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
