Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxUDn-0004mL-JJ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 08:55:19 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AxTm7-0004Dz-LI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 08:26:43 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] fix writing into /dev/kmem
References: <20040229023636.GB8272@ccure.user-mode-linux.org>
In-Reply-To: <20040229023636.GB8272@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DFhQA4AZhKjErNi"
Message-Id: <200402291720.19359.blaisorblade_spam@yahoo.it>
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
Date: Sun, 29 Feb 2004 17:20:19 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>



--Boundary-00=_DFhQA4AZhKjErNi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Alle 03:36, domenica 29 febbraio 2004, Jeff Dike ha scritto:
> The patch below fixes a bug in the /dev/kmem driver which causes UML to
> die if you write to it.

Also, I forgot one thing, about this Oops:

the i386 Oopses, normally, kill only the thread which triggered the fault - 
while instead Uml panics altogether. Cannot this be changed at 
arch/um/kernel/trap_kern.c:segv()?

        if(!is_user)
-                panic("Kernel mode fault at addr 0x%lx, ip 0x%lx",
-                      address, ip);
+		 die("Oops".....) //some printk calls... can be omitted
+		 do_exit(SIGKILL);

like arch/i386/mm/fault.c: do_page_fault() ?
With the above change, cat /dev/kmem could only create an Oops on the cat 
process (and possibly some deadlock, but better than a straight crash).

By the way: in handle_page_fault(), there is some dead code (attached is the 
removal patch).

I also do not understand the loop around handle_mm_fault call, but I could be 
wrong: are you sure that after a successful handle_mm_fault (i.e. a major or 
minor fault) pte_present(*pte) could be false? If handle_mm_fault is not 
successful, we exit the loop anyway.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_DFhQA4AZhKjErNi
Content-Type: text/x-diff; charset="iso-8859-1"; name="Dead-trap-code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Dead-trap-code.patch"

--- ./arch/um/kernel/trap_kern.c.fix	2004-02-20 18:43:26.000000000 +0100
+++ ./arch/um/kernel/trap_kern.c	2004-02-29 17:12:49.000000000 +0100
@@ -74,13 +74,7 @@
 			err = -ENOMEM;
 			goto out_of_memory;
 		default:
-			if (current->pid == 1) {
-				up_read(&mm->mmap_sem);
-				yield();
-				down_read(&mm->mmap_sem);
-				goto survive;
-			}
-			goto out;
+			BUG();
 		}
 		pte = pte_offset_kernel(pmd, page);
 	} while(!pte_present(*pte));

--Boundary-00=_DFhQA4AZhKjErNi--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
