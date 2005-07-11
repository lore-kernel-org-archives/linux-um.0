Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds4dT-0003HF-1Z	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 13:12:15 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1Ds4dR-0006lQ-DW	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 13:12:14 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] SKAS0 test tree against 2.6.12
References: <200507062011.58619.blaisorblade@yahoo.it>
In-Reply-To: <200507062011.58619.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507102330.12790.rob@landley.net>
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
Date: Sun, 10 Jul 2005 23:30:12 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>

On Wednesday 06 July 2005 13:11, Blaisorblade wrote:
> Ok, it's there. I've simply adapted the two SKAS0 patches for 2.6.12

I still haven't figured out how to get it to run in skas0 mode, but 2.6.12.2 
with your -skas0 patch still seems to work in tt mode.  (With the usual 
bootup idiosyncrasies, such as)...

VFS: Mounted root (hostfs filesystem).
idr_remove called for id=3 which is not allocated.
a08fb980:  [<a009af8f>] sub_remove+0xef/0x100
a08fb9e0:  [<a009afcf>] idr_remove+0x2f/0xc0
a08fba00:  [<a00a35e2>] release_dev+0x5d2/0x6f0
a08fba80:  [<a00a2aa5>] init_dev+0x1b5/0x5b0
a08fbad0:  [<a00a385c>] tty_open+0x15c/0x3a0
a08fbae0:  [<a009b69a>] kobject_get+0x1a/0x30
a08fbaf0:  [<a006333f>] cdev_get+0xf/0x20
a08fbb00:  [<a006350f>] exact_lock+0xf/0x20
a08fbb10:  [<a00ad0a0>] kobj_lookup+0xe0/0xf0
a08fbb38:  [<a00a3700>] tty_open+0x0/0x3a0
a08fbb40:  [<a006340e>] chrdev_open+0x9e/0x120
a08fbb70:  [<a00593da>] dentry_open+0x10a/0x190
a08fbb90:  [<a00592c8>] filp_open+0x68/0x70
a08fbbf0:  [<a0059609>] sys_open+0x49/0x90
a08fbc00:  [<a0011ef5>] change_signals+0x65/0x90
a08fbc10:  [<a00167a3>] execute_syscall_tt+0xa3/0xb0
a08fbc90:  [<a00167df>] syscall_handler_tt+0x2f/0x60
a08fbca0:  [<a0011f4f>] unblock_signals+0xf/0x20
a08fbcb0:  [<a001798b>] sig_handler_common_tt+0xbb/0x150
a08fbd10:  [<a001c337>] sig_handler+0x17/0x20
a08fbd20:  [<a00b9bd8>] __restore+0x0/0x8

But once past that, it gives me my shell prompt and I can mount /proc and 
confirm this is indeed UML running.  Haven't played with it much beyond that 
yet...

Rob

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
