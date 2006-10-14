Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYXcO-0007so-RQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 17:43:13 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GYXcM-0000CD-5x
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 17:43:12 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 14 Oct 2006 02:42:59 +0200
References: <452C29F2.8050908@theshore.net>
	<20061013200747.GB5517@ccure.user-mode-linux.org>
In-Reply-To: <20061013200747.GB5517@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610140243.00086.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x92c00000, ip 0x80bcead
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, "Christopher S. Aker" <caker@theshore.net>

On Friday 13 October 2006 22:07, Jeff Dike wrote:
> On Tue, Oct 10, 2006 at 06:17:06PM -0500, Christopher S. Aker wrote:
> > This is 2.6.18-um, on top of a 2.6.16.29-skas3-v8.2 host.
> >
> > Kernel file is here:
> > http://www.theshore.net/~caker/uml/kernels/2.6.18-linode25
> >
> >
> > Kernel panic - not syncing: Kernel mode fault at addr 0x92c00000, ip
> > 0x80bcead
Jeff, are these addresses normal? They tell that the binary is a statically 
linked one - but what is the memory layout? Chris, can you post 
cat /proc/<pid>/maps on a running instance of that kernel, together with host 
and guest config (the guest's one is contained there, I know, but I don't 
have the time to extract).

I'm suspiscious about memory layout problems (say host with unusual splits, 
like 1G/3G, or some problem with memory mappings anyhow).

> The stack I get from that is:
I.e. all the rest are bogus functions?

There are automated solutions for this - compiling with frame pointers allows 
correct backtracing with a runtime penalty but is implemented; however, we 
could reuse (not copy, please, we cannot maintain it) the x86 DWARF unwinder 
(instead of using frame pointer and to slow down fast paths, additional 
out-of-line debug info are used when the stack trace is output) - but we 
should implement this latter one. Jeff, can you take a look at it?

> 85a0f49c:  [<800350cf>] csum_partial+0xdb/0xe8
> 85a0f74c:  [<802aafe2>] skb_checksum+0xe7/0x28f
> 85a0f788:  [<802afd31>] skb_checksum_help+0x9c/0x13e
> 85a0f7ac:  [<803292fc>] ip_nat_fn+0x1d2/0x1e7
> 85a0f7e0:  [<80329528>] ip_nat_local_fn+0x75/0xf3
> 85a0f808:  [<802d8569>] nf_iterate+0x63/0x7b
> 85a0f830:  [<802d85ec>] nf_hook_slow+0x6b/0xe4
> 85a0f86c:  [<802e4a44>] ip_queue_xmit+0x3d7/0x4c2
> 85a0f944:  [<802f7668>] tcp_transmit_skb+0x2b8/0x4b1
> 85a0f984:  [<802f91fd>] tcp_push_one+0xde/0x159
> 85a0f9ac:  [<802eca55>] tcp_sendmsg+0x438/0xe54
> 85a0fa30:  [<8030a718>] inet_sendmsg+0x4a/0x56
> 			__sock_sendmsg
> 85a0fa48:  [<802a4aad>] do_sock_write+0xbb/0xc5
> 85a0fa6c:  [<802a4c5f>] sock_aio_write+0x95/0x99
> 85a0fae0:  [<80082978>] do_sync_write+0xde/0x124
> 85a0fb90:  [<80082b81>] vfs_write+0x1c3/0x23d
> 85a0fbc8:  [<80082ccc>] sys_write+0x51/0x80
> 85a0fbf0:  [<80022bda>] handle_syscall+0x11a/0x138
> 85a0fc6c:  [<80033b68>] handle_trap+0x31/0x12d
> 85a0fc94:  [<80034192>] userspace+0x1c7/0x21e
> 85a0fcf0:  [<80022808>] fork_handler+0xef/0xff
> 85a0fd1c:  [<8039a828>] __restore+0x0/0x8
> 85a0fd5c:  [<8039aa81>] kill+0x11/0x20

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
