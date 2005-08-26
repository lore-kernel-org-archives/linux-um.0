Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8kP7-0006Vi-7T	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 13:02:21 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E8kP3-00050e-F5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 13:02:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [RFC] [patch 0/18] remap_file_pages protection
	support (for UML), try 3
References: <200508262023.29170.blaisorblade@yahoo.it>
	<Pine.LNX.4.61.0508262000530.8803@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508262000530.8803@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508262158.11257.blaisorblade@yahoo.it>
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
Date: Fri, 26 Aug 2005 21:58:10 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Friday 26 August 2005 21:11, Hugh Dickins wrote:
> On Fri, 26 Aug 2005, Blaisorblade wrote:
> > This is a followup to my post of last week (Aug 12) about
> > remap_file_pages protection support. I've improved and consolidated the
> > patches and updated them against 2.6.13-rc6/rc7 (the same patches apply
> > against both versions). I'm sending the full patch series only to akpm,
> > mingo and LKML.
> >
> > I've also reduced them to only 18, and made the splitting more
> > significant. I'm not resending all the patches for foreign architectures,
> > because they're almost unchanged since last time (there's just a trivial
> > reject from ppc32, because one change has already been done after -rc4).
> >
> > I'm working on this to provide support for UML, which currently easily
> > creates more than 64K (the default limit) vma's for a single process.
> > Actually, it needs one VMA per each page. So, with this patch and
> > specific UML support, which Ingo wrote and which I'm porting to recent
> > UMLs.
>
> I'll try to take a look sometime next week - or, if I wait until
> next Friday, can we expect it to have come down to 9 patches ;-?
:-) Don't think so, unless you want just me to join patches together. However, 
there are still some oneliners, so the patchset is not so huge.

Well, diffstat seems to contradict me (on the joined-up patch):

 Documentation/feature-removal-schedule.txt |   12 +
 arch/i386/mm/fault.c                       |   19 ++
 arch/um/kernel/trap_kern.c                 |   52 ++++++-
 arch/x86_64/mm/fault.c                     |    6
 include/asm-i386/mman.h                    |    1
 include/asm-i386/pgtable-2level.h          |   15 +-
 include/asm-i386/pgtable-3level.h          |   11 +
 include/asm-i386/pgtable.h                 |    3
 include/asm-ia64/mman.h                    |    1
 include/asm-ppc/mman.h                     |    1
 include/asm-ppc64/mman.h                   |    1
 include/asm-s390/mman.h                    |    1
 include/asm-um/pgtable-2level.h            |   15 +-
 include/asm-um/pgtable-3level.h            |   21 ++-
 include/asm-um/pgtable.h                   |    3
 include/asm-x86_64/mman.h                  |    1
 include/asm-x86_64/pgtable.h               |   12 +
 include/linux/mm.h                         |   40 ++++--
 include/linux/pagemap.h                    |   32 ++++
 mm/filemap.c                               |   18 ++
 mm/fremap.c                                |  135 +++++++++++++++-----
 mm/madvise.c                               |    2
 mm/memory.c                                |  193 
++++++++++++++++++++++-------
 mm/mmap.c                                  |   14 +-
 mm/mprotect.c                              |    3
 mm/rmap.c                                  |    6
 mm/shmem.c                                 |   13 +

> I should say, my initial reaction is very much like Andi's last week.

> sys_remap_file_pages solves a real problem, but it does so by breaking
> lots of rules.  For more than a year after it came in, almost every
> development we tried in mm would come up against "but then what do we
> do about the nonlinear mappings?".

Nonuniform mappings are much less of a problem. Really. The reason nonlinear 
mappings reached mainline before nonuniform ones (and I don't know if they 
willl ever) is not simplicity, but the miss of uses until now. And also the 
fact that Ingo hadn't the time to finish it.

In fact, I've been playing a lot with the GIT history during this month of 
development, particularly with objrmap, so I've come across those problems 
quite a lot, but what I noticed is that you mostly don't care about the VMA 
to be uniform, just it to be linear or not (because nonlinear VMAs break 
objrmap).

This patch, in comparison, is just:

*) check permissions in the generic VM when faulting in pages, if and only if 
the vma is nonuniform (yes, nontrivial at all).

*) be anally picky to save the PTE protections together with the rest, and do 
it *everywhere*; but if you say "nonuniform implies linear", you lose this 
problem almost completely.

The only exception is that when you remap an address range with PROT_NONE 
(thus effectively unmapping those addressed), you can't clear the PTEs but 
you must use pfn_pte(0, __S000) to fill them in (this is done in the 
optimization-fixup patch #15).

> That has settled down now, but I don't look forward to extending it.
> On the other hand, UML does deserve better support.

> Hugh

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
