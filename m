Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYBs7-0002CE-Kw for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jun 2004 15:48:39 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BYBs7-0007ZE-08 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jun 2004 15:48:39 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <200406071949.04220.blaisorblade_spam@yahoo.it>
	<200406080455.i584tad2023374@ccure.user-mode-linux.org>
In-Reply-To: <200406080455.i584tad2023374@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406092305.24447.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: The SKAS4 patch?? + ideas for 0 context-switch
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
Date: Wed, 9 Jun 2004 23:05:24 +0200
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 06:55, marted=EC 8 giugno 2004, Jeff Dike ha scritto:

> > But just now, I've read on your  diary you planned to have only 1
> > process for each UML processor; would that  guarantee 0
> > context-switches or not?
>
> Yes, it would.

Hmmm, I meant "would that guarantee 0 memory switches"? And I guess the ans=
wer=20
to *this* question is "NO".

Yes, actually a Context Switch is different, but I confused them... you say:

> I was also considering a plan where there would be a memory switch
> in there as well
Which is the single-process with memory switches, isn't it?

> > In detail (skip this if you got what I mean): to do a syscall, without
> > SYSEMU  there is a CS to the guest kernel (which invalidates tons of
> > TLBs, i.e. is  the heavier of all ones) + a few instruction + the two
> > useless CS's deleted  by SYSEMU, which invalidate a very few TLB
> > entries (I think that only 1-2  pages of code + data will have be
> > accessed) + the syscall execution (using a  lot of memory) + the final
> > context switch to the userspace program, which  will now take a lot of
> > time to refill its TLB.
>
> On x86, which doesn't have tagged TLBs IIRC, there has to be a full tlb
> flush no matter how large the processes involved in the switch.  What I'm
> not clear on is whether small full flushes are faster than big ones.

I don't think that a flush of fewer TLBs would be faster; what (In My Ignor=
ant=20
Opinion) slows things down is not clearing a buffer (it will probably cost =
1=20
cycle, if they put a RESET pin in the TLBs), but reloading its content when=
=20
memory is read; with SYSEMU, we avoid to reload PTE's for 1-2 host kernel=20
pages + the UML kernel pages involved in running the syscall. With this=20
approach, instead, we avoid the time for reloading the PTE's for each page =
in=20
the working set of the calling process (which will probably be a much bigge=
r=20
win).

> > The hard part is the  segmentation protection, since I need to change
> > the whole GDT and the whole  LDT!
>
> Yeah.  This is slow,

Well, actually it comes to changing 2 segments descriptors (the ones for=20
USER_CS and USER_DS) and firewalling sys_modify_ldt which is used almost=20
never. Plus the TLS segments, which can be a bit more... but they can be=20
"firewalled" too.

> plus using segments will cost you a cycle or something
> on every memory reference.  Alan Cox warned me off very strongly against
> doing this.  So, you have a tradeoff between a cost taken at system call
> time vs a smaller cost plus every memory reference being slower.

Well, using segments here means that the CS and DS descriptor limit are=20
lowered, not that I increase base_addr - are you sure that this would have =
a=20
cost? Currently the check is not "disabled" - just the check value is MAX_P=
TR=20
(0xffff....). Yes, the CPUs could be smart enough to optimize the check=20
out... I'll try to see if Intel manuals say anything about this.

> > DS points to a struct desc_struct in memory  (which is decoded by the
> > CPU) which can say: refuse access to virtual  addresses > 2,5G (or
> > whatever, I think that the UML kernel should pass its  bottom
> > address). At the moment, I'm studying it and the exec-shield patch:
> > that patch keeps track of the maximum possible value of EIP for a task
> > and  sets the code segment limit to that value. This can be applied
> > straight-forwardly. But here a malicious software could modify the ?S
> > (CS,  DS...) registers and point them anywhere inside the LDT and the
> > GDT. So,  sadly, making this work means reducing the size limit in
> > each valid entry of  the LDT and the GDT (for the GDT this is about 1
> > entry, actually); and the  LDT can be modified by the user through
> > sys_modify_ldt, so we must be  especially careful there (i.e. restrict
> > the limit the user has told us).
>
> Yup, this is what you would do.  Some extra checking in UMLs sys_modify_l=
dt
> would prevent the user from resetting DS.

Yes, I thought this, too.

> > Any comments or ideas?
>
> I would prefer that you look at a full memory switch in PTRACE_SYSEMU
> rather than segmentation tricks.

> Playing with segments has a variety of
> disadvantages -
> 	the performance hit on memory references

Well, this is the most important one... I'll try to investigate on this.

> 	the modifying of LDT and GDT, which are slow
I hope this is faster than flushing + reloading TLB (by reloading I mean th=
e=20
implicit refilling).
> 	non-portability

Well, x86_64 should support this... and anyway each porting would be MUCH=20
different in low level details. Yes, since this could be a 3rd mode beyond =
TT=20
and SKAS4 + SYSEMU (joining them will ease a lot porting to other archs... =

SYSEMU is probably easier to implement than the ability to change syscall=20
numbers, IMHO), it could be a whole unportable mode, which is not beautiful.

> 	consumption of .5G of process address space
> 	very limited UML low mem
>
> But in any case, I'm glad you're looking at this.

Thanks a lot!
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
