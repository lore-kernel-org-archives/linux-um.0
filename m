Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8iiX-0004uH-Np for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:09:45 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1C8iiX-0003pL-1e for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:09:45 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] skas3(-v3) for 2.4.27 with exec-shield
References: <20040916210145.GJ24624@shell.blacknet.de>
	<200409172054.44049.blaisorblade_spam@yahoo.it>
In-Reply-To: <200409172054.44049.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409181242.04919.blaisorblade_spam@yahoo.it>
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
Date: Sat, 18 Sep 2004 12:42:04 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Goetz Bock <bock+uml@blacknet.de>

On Friday 17 September 2004 20:54, BlaisorBlade wrote:
> On Thursday 16 September 2004 23:01, Goetz Bock wrote:
> > Hi all,
> >
> > as I've no realy idea about the internal work of the skas patches, I'll
> > have to bother you.
Don't worry.
> > I'd like to run a 2.4.27 kernel with exec-shield patch and skas3, if
> > possible the -v3 version from BlaisorBlade, except that it does not
> > apply :-(

> > There are three conflicts in mm/mprotect.c but i suspect there are more
> > not working sections.
> >
> > The patch seams to mainly change current->mm to mm, after defining
> >
> >     struct mm_struct * mm = vma->vm_mm;
> >
> > unfortunately i've no idea how current-> mm and vma->vm_mm (aka mm)
> > relate. Are they the same?
>
> Not at all; they must be different.

> If you look below, you see that in the old code, sys_mprotect says: "I'm
> acting on current->mm"; the patch wants to be able to pass it any mm_struct
> (and this is done within mm/proc_mm.c), so I had to replace every reference
> to current->mm with a reference to the mm.

Sorry, I did not finish the message.

Actually, the idea is to make that substitution in everything inside 
mm/mprotect.c (but also for all calls invoked by mm/proc_mm.c - 
write_proc_mm(), i.e. mmap and munmap); however, this also means adding one 
more parameter to each of those calls, so I implemented it in a different 
way, the one you see.
I investigated a bit and discovered that if, inside the mm_struct* mm0, I pick 
one vm_area_struct (vma1), then vma1->vm_mm is always equal to mm0. So the 
implementation is the one above.

Also, some general VM info:
- one mm_struct contains all the memory mappings of one process; if you have 
more threads (which share the same memory), they share the mm_struct.
- inside a mm_struct, there are lots of vm_area_struct; when you call mmap() 
in userspace, one new vm_area_struct is created, containing the data to 
represent the created mapping. There are also some other situations in which 
a vm_area_struct is created, however this is enough. Also, a vm_area_struct 
(a VMA) is never shared between two mm_struct.

Also, when you do cat /proc/<aPid>/maps, what you see is a dump of the VMAs of 
that process (the one with <aPid>); each line contains the data of one VMA.

Finally, what the patch does:
- it allows one UML thread (the kernel thread) to do something like 
mmap()/munmap()/mprotect(), except that these calls have effect on the 
userspace thread (the one running the various process); also, it allows this 
process to have various mm_struct; the kernel thread, with PTRACE_SWITCH_MM, 
can make the userspace thread switch from one mm_struct to another (and this 
is done when a different guest process must run).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
