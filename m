Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1Wio0h-0007ps-Od
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2014 16:50:59 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wio0g-0000Oz-H1
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2014 16:50:59 +0000
Received: from [192.168.178.21] ([80.171.220.243]) by mail.gmx.com (mrgmx102)
	with ESMTPSA (Nemesis) id 0MAkkB-1WY7YO3vp5-00Bwg9 for
	<user-mode-linux-devel@lists.sourceforge.net>; Fri, 09 May 2014 18:50:52
	+0200
Message-ID: <536D076B.5030303@gmx.de>
Date: Fri, 09 May 2014 18:50:51 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
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
Subject: [uml-devel] another example of the filemap issue of current kernel ?
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

At a 32 bit UML guest with recent kernel one of the processes became a zombie wgile fuzz testing with trinity:
The UML guest itself runs somehow but ssh into it was no longer possible.
The trinity log doesn't gave any info about that particular process, gdb tells :


tfoerste@n22 ~ $ date; pgrep -af 'linux earlyprintk' | cut -f1 -d' ' | xargs -n1 gdb /home/tfoerste/devel/linux/linux -n -batch -ex 'bt'
Fri May  9 18:40:18 CEST 2014                                                                                                                                         
                                                                                                                                                                      
Program received signal SIGSEGV, Segmentation fault.                                                                                                                  
                                                                                                                                                                      
warning: Could not load shared library symbols for linux-gate.so.1.                                                                                                   
Do you need "set solib-search-path" or "set sysroot"?                                                                                                                 
show_stack (task=0x0, stack=0x0) at arch/um/kernel/sysrq.c:93                                                                                                         
93                      printk(KERN_CONT " %08lx", *stack++);                                                                                                                           
#0  show_stack (task=0x0, stack=0x0) at arch/um/kernel/sysrq.c:93                                                                                                                       
#1  0x084eb015 in __dump_stack () at lib/dump_stack.c:15
#2  dump_stack () at lib/dump_stack.c:60
#3  0x084e7bda in dump_header (gfp_mask=0, order=1, memcg=0x0, nodemask=<optimized out>, p=<optimized out>) at mm/oom_kill.c:400
#4  0x080cfe03 in oom_kill_process (p=0x4534a080, gfp_mask=131546, order=0, points=0, totalpages=321692, memcg=0x0, nodemask=0x0, message=0x0) at mm/oom_kill.c:438
#5  0x080d0572 in out_of_memory (zonelist=0x86f1d50 <contig_page_data+1392>, gfp_mask=131546, order=0, nodemask=0x0, force_kill=96) at mm/oom_kill.c:672
#6  0x080d3c74 in __alloc_pages_may_oom (migratetype=<optimized out>, preferred_zone=<optimized out>, nodemask=<optimized out>, high_zoneidx=<optimized out>, zonelist=<optimized out>, order=<optimized out>, gfp_mask=<optimized out>) at mm/page_alloc.c:2216
#7  __alloc_pages_slowpath (migratetype=<optimized out>, preferred_zone=0x86f17e0 <contig_page_data>, nodemask=<optimized out>, high_zoneidx=<optimized out>, zonelist=<optimized out>, order=<optimized out>, gfp_mask=<optimized out>) at mm/page_alloc.c:2623
#8  __alloc_pages_nodemask (gfp_mask=141498336, order=0, zonelist=0x86f1d50 <contig_page_data+1392>, nodemask=0x0) at mm/page_alloc.c:2768
#9  0x080cd6e3 in __alloc_pages (zonelist=<optimized out>, order=<optimized out>, gfp_mask=<optimized out>) at include/linux/gfp.h:312
#10 alloc_pages_node (order=<optimized out>, gfp_mask=<optimized out>, nid=<optimized out>) at include/linux/gfp.h:322
#11 __page_cache_alloc (gfp=<optimized out>) at include/linux/pagemap.h:235
#12 page_cache_alloc_cold (x=<optimized out>) at include/linux/pagemap.h:246
#13 page_cache_read (offset=<optimized out>, file=<optimized out>) at mm/filemap.c:1794
#14 filemap_fault (vma=0x45317220, vmf=0x4762fd08) at mm/filemap.c:1969
#15 0x080e70cf in __do_fault (vma=0x0, address=1, pgoff=2768, flags=1, page=0x1) at mm/memory.c:3346
#16 0x080e96e6 in do_read_fault (vma=0x45317220, address=1075365528, pmd=0x45135400, pgoff=355, flags=168, orig_pte=<incomplete type>, mm=<optimized out>) at mm/memory.c:3526
#17 0x080e9e63 in do_nonlinear_fault (orig_pte=..., flags=1584, pmd=<optimized out>, address=<optimized out>, vma=<optimized out>, mm=<optimized out>, page_table=<optimized out>) at mm/memory.c:3695
#18 handle_pte_fault (flags=<optimized out>, pmd=<optimized out>, pte=<optimized out>, address=<optimized out>, vma=<optimized out>, mm=<optimized out>) at mm/memory.c:3825
#19 __handle_mm_fault (flags=<optimized out>, address=<optimized out>, vma=<optimized out>, mm=<optimized out>) at mm/memory.c:3945
#20 handle_mm_fault (mm=0x39f1fb00, vma=0x45317220, address=1075365528, flags=168) at mm/memory.c:3968
#21 0x08061d5a in handle_page_fault (address=1075365528, ip=1074507991, is_write=0, is_user=1, code_out=0x4762fe40) at arch/um/kernel/trap.c:75
#22 0x08061f8e in segv (fi=<incomplete type>, ip=1074507991, is_user=1, regs=0x4534afe0) at arch/um/kernel/trap.c:222
#23 0x08062233 in segv_handler (sig=11, unused_si=0x4762ff5c, regs=0x4534afe0) at arch/um/kernel/trap.c:191
#24 0x0807470a in userspace (regs=0x4534afe0) at arch/um/os-Linux/skas/process.c:420
#25 0x0805f770 in fork_handler () at arch/um/kernel/process.c:149
#26 0x00000000 in ?? ()



I'm unsure if this is worth to be reported or just another incarnation of an already observed/discussed issue - but who knows ?


-- 
Toralf


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

