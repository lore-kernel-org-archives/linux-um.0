Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMtTP-0001CX-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 10:24:11 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AMtT9-0001nb-Co
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 10:23:55 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311201915.29188.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Host panic triggered by UML
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
Date: Thu, 20 Nov 2003 19:15:29 +0100
To: user-mode-linux-devel@lists.sourceforge.net

I reported that if I leave an UML sleeping, it segfaults(once I saw the killed 
by SIGSEGV from the shell, the other time nothing, maybe I had detached the 
job from the shell).

Now I've seen that what happens is that the host kernel oopses. I'm posting it 
here to collect a bit more infos before posting it to the LKML, and to know 
why only UML is able to trigger it. Since the bug seems related only to 
/dev/shm, maybe you could have some enlightenment about it and how UML uses 
shared memory to make this happen.

Nov 19 04:40:24 blaisorblade kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Nov 19 04:40:24 blaisorblade kernel:  printing eip:
Nov 19 04:40:24 blaisorblade kernel: c015421b
Nov 19 04:40:24 blaisorblade kernel: *pde = 00000000
Nov 19 04:40:24 blaisorblade kernel: Oops: 0002
Nov 19 04:40:24 blaisorblade kernel: CPU:    0
Nov 19 04:40:24 blaisorblade kernel: EIP:    0010:[dcache_dir_lseek+299/384]    
Tainted: PF
Nov 19 04:40:24 blaisorblade kernel: EIP:    0010:[<c015421b>]    Tainted: PF
Nov 19 04:40:24 blaisorblade kernel: EFLAGS: 00010286
Nov 19 04:40:24 blaisorblade kernel: eax: 00000000   ebx: c0d24160   ecx: 
d6b15f08   edx: c0d24160
Nov 19 04:40:24 blaisorblade kernel: esi: 00000002   edi: 00000000   ebp: 
c0d24140   esp: d67cbf84
Nov 19 04:40:24 blaisorblade kernel: ds: 0018   es: 0018   ss: 0018
Nov 19 04:40:24 blaisorblade kernel: Process linux (pid: 18847, 
stackpage=d67cb000)
Nov 19 04:40:24 blaisorblade kernel: Stack: fffffff2 c0d24140 00000000 
00000000 c01540f0 d2473f20 c01433f8 d2473f20 
Nov 19 04:40:24 blaisorblade kernel:        00000002 00000000 00000000 
d67ca000 4014b008 00000002 a2533abc c01075b7 
Nov 19 04:40:24 blaisorblade kernel:        0000002f 00000002 00000000 
4014b008 00000002 a2533abc 00000013 0000002b 
Nov 19 04:40:24 blaisorblade kernel: Call Trace:    [dcache_dir_lseek+0/384] 
[sys_lseek+120/192] [system_call+51/56]
Nov 19 04:40:24 blaisorblade kernel: Call Trace:    [<c01540f0>] [<c01433f8>] 
[<c01075b7>]
Nov 19 04:40:24 blaisorblade kernel: 
Nov 19 04:40:24 blaisorblade kernel: Code: 89 10 89 42 04 b8 00 e0 ff ff 21 e0 
ff 48 04 8b 50 14 39 50 

(I've had another oops in the same call path and point, so I guess this was 
the reason even the other time).

This means that it crashes in fs/readdir.c:dcache_dir_lseek; after some checks 
on the disassembled code, I could see that it happens here, about line 80:

                         list_del(&cursor->d_child);
                         list_add_tail(&cursor->d_child, p);

and exactly, on list_add_tail: the offending EIP means p->prev->next = 
cursor->d_child, but it fails when trying to dereference p->prev, which is 
NULL. This means that very likely, the bug happens when the list p points 
into(d_subdirs) was built.

The dumped code is correct, as long as I see, so the kernel text section 
hasn't been corrupted.

When this oops happens, a semaphore is held, and so I guess it never gets 
released(I don't think the oops handler would be able to do anything or does 
anything).
In fact I've had, once, an astonishing number of processes in D state: I could 
guess that they were all trying to access /dev/shm. I don't remember if any 
UML had crashed, but I think it's very likely. Anyhow, that time I found a 
UML and a process(msec_find from Mandrake) which was walking on the whole 
filesystem. I could start any find / and it always stopped and went into D 
state a bit before going to /dev/shm.

So, probably the oops happened while working on that folder: what needs to be 
checked is if the tmpfs code creates an inconsistent list(exactly, an 
inconsistent struct dentry.d_subdirs one, since p walks into it). Do you 
think this is reasonable or not?

-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
