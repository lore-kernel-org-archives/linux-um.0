Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXXru-0003sF-22 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 21:05:46 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BXXrt-0007oV-7l
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Jun 2004 21:05:45 -0700
Message-Id: <200406080455.i584tad2023374@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Mon, 07 Jun 2004 19:49:03 +0200."
	<200406071949.04220.blaisorblade_spam@yahoo.it> 
References: <200406071949.04220.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 08 Jun 2004 00:55:36 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> Hi Jeff, I would like to ask you to make the current form of the SKAS4
> patch,  even if incomplete, public on the -devel mailing list, even if
> it is not yet  ready;

Yeah, that's something I just haven't got around to doing.

> You said you sometimes feel you have too much work to do; just ask for
> help!  If you want to give some tasks away, just ask for help! 

Thanks to your prodding, I have things set up so that other people can
make official releases of things.  So, if anyone wanted to contribute 
filesystems or binary packages, work on the site, or take over host patches or
the utilities, that is now more workable.

> But just now, I've read on your  diary you planned to have only 1
> process for each UML processor; would that  guarantee 0
> context-switches or not? 

Yes, it would.

> Also, this requires coming back to  having a
> 2,5G TASK_SIZE inside UML, with the upper part for the UML and the
> lower to the host process. Would you accept it?

It might.  With the scheme you outline, it would.  I was also considering
a plan where there would be a memory switch in there as well.  Then, you
replace full process switches with memory switches, which may not be too
much of a win.  Your scheme has problems too, see below.

> In detail (skip this if you got what I mean): to do a syscall, without
> SYSEMU  there is a CS to the guest kernel (which invalidates tons of
> TLBs, i.e. is  the heavier of all ones) + a few instruction + the two
> useless CS's deleted  by SYSEMU, which invalidate a very few TLB
> entries (I think that only 1-2  pages of code + data will have be
> accessed) + the syscall execution (using a  lot of memory) + the final
> context switch to the userspace program, which  will now take a lot of
> time to refill its TLB. 

On x86, which doesn't have tagged TLBs IIRC, there has to be a full tlb
flush no matter how large the processes involved in the switch.  What I'm
not clear on is whether small full flushes are faster than big ones.

> The hard part is the  segmentation protection, since I need to change
> the whole GDT and the whole  LDT!

Yeah.  This is slow, plus using segments will cost you a cycle or something
on every memory reference.  Alan Cox warned me off very strongly against
doing this.  So, you have a tradeoff between a cost taken at system call time
vs a smaller cost plus every memory reference being slower.

> DS points to a struct desc_struct in memory  (which is decoded by the
> CPU) which can say: refuse access to virtual  addresses > 2,5G (or
> whatever, I think that the UML kernel should pass its  bottom
> address). At the moment, I'm studying it and the exec-shield patch:
> that patch keeps track of the maximum possible value of EIP for a task
> and  sets the code segment limit to that value. This can be applied
> straight-forwardly. But here a malicious software could modify the ?S
> (CS,  DS...) registers and point them anywhere inside the LDT and the
> GDT. So,  sadly, making this work means reducing the size limit in
> each valid entry of  the LDT and the GDT (for the GDT this is about 1
> entry, actually); and the  LDT can be modified by the user through
> sys_modify_ldt, so we must be  especially careful there (i.e. restrict
> the limit the user has told us).

Yup, this is what you would do.  Some extra checking in UMLs sys_modify_ldt
would prevent the user from resetting DS.

> Any comments or ideas? 

I would prefer that you look at a full memory switch in PTRACE_SYSEMU rather
than segmentation tricks.  Playing with segments has a variety of 
disadvantages -
	the performance hit on memory references
	the modifying of LDT and GDT, which are slow
	non-portability
	consumption of .5G of process address space
	very limited UML low mem

But in any case, I'm glad you're looking at this.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
