Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMv4A-0002Xb-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 12:06:14 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AMv4A-0006OT-1B
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 12:06:14 -0800
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id 0EEF43EC
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 15:06:12 -0500 (EST)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1AMv47-00036S-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 15:06:11 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Host panic triggered by UML
Message-ID: <20031120200611.GK9377@dijkstra.csh.rit.edu>
References: <200311201915.29188.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311201915.29188.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 20 Nov 2003 15:06:11 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 20, 2003 at 07:15:29PM +0100, BlaisorBlade wrote:

> Nov 19 04:40:24 blaisorblade kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000000
> Nov 19 04:40:24 blaisorblade kernel:  printing eip:
> Nov 19 04:40:24 blaisorblade kernel: c015421b
> Nov 19 04:40:24 blaisorblade kernel: *pde = 00000000
> Nov 19 04:40:24 blaisorblade kernel: Oops: 0002
> Nov 19 04:40:24 blaisorblade kernel: CPU:    0
> Nov 19 04:40:24 blaisorblade kernel: EIP:    0010:[dcache_dir_lseek+299/384]    
> Tainted: PF
> Nov 19 04:40:24 blaisorblade kernel: EIP:    0010:[<c015421b>]    Tainted: PF
> Nov 19 04:40:24 blaisorblade kernel: EFLAGS: 00010286
> Nov 19 04:40:24 blaisorblade kernel: eax: 00000000   ebx: c0d24160   ecx: 
> d6b15f08   edx: c0d24160
> Nov 19 04:40:24 blaisorblade kernel: esi: 00000002   edi: 00000000   ebp: 
> c0d24140   esp: d67cbf84
> Nov 19 04:40:24 blaisorblade kernel: ds: 0018   es: 0018   ss: 0018
> Nov 19 04:40:24 blaisorblade kernel: Process linux (pid: 18847, 
> stackpage=d67cb000)
> Nov 19 04:40:24 blaisorblade kernel: Stack: fffffff2 c0d24140 00000000 
> 00000000 c01540f0 d2473f20 c01433f8 d2473f20 
> Nov 19 04:40:24 blaisorblade kernel:        00000002 00000000 00000000 
> d67ca000 4014b008 00000002 a2533abc c01075b7 
> Nov 19 04:40:24 blaisorblade kernel:        0000002f 00000002 00000000 
> 4014b008 00000002 a2533abc 00000013 0000002b 
> Nov 19 04:40:24 blaisorblade kernel: Call Trace:    [dcache_dir_lseek+0/384] 
> [sys_lseek+120/192] [system_call+51/56]
> Nov 19 04:40:24 blaisorblade kernel: Call Trace:    [<c01540f0>] [<c01433f8>] 
> [<c01075b7>]
> Nov 19 04:40:24 blaisorblade kernel: 
> Nov 19 04:40:24 blaisorblade kernel: Code: 89 10 89 42 04 b8 00 e0 ff ff 21 e0 
> ff 48 04 8b 50 14 39 50 

I've seen this same crash many times; I sent it to lkml but got no response.

> (I've had another oops in the same call path and point, so I guess this
> was the reason even the other time).
> 
> This means that it crashes in fs/readdir.c:dcache_dir_lseek; after some
> checks So, probably the oops happened while working on that folder: what
> needs to be checked is if the tmpfs code creates an inconsistent
> list(exactly, an inconsistent struct dentry.d_subdirs one, since p walks
> into it). Do you think this is reasonable or not?

It only happened for me using UML hostfs on a tmpfs filesystem, so I believe
it is a tmpfs bug, yes.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
