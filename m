Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9T2K-0002Rl-CP for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 11:37:16 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1C9T2I-0004tf-L7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 11:37:16 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [patch] host-skas3 for 2.6.9-rc2
References: <200409122004.41777.blaisorblade_spam@yahoo.it>
	<200409181856.44696.blaisorblade_spam@yahoo.it>
	<20040920153737.GA9823@bytesex>
In-Reply-To: <20040920153737.GA9823@bytesex>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409202034.20779.blaisorblade_spam@yahoo.it>
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
Date: Mon, 20 Sep 2004 20:34:20 +0200
To: Gerd Knorr <kraxel@bytesex.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 20 September 2004 17:37, Gerd Knorr wrote:
> > Without the SKAS patch, init_new_context does not call
> > arch_pick_mmap_layout(), so it should not after ( and init_new_context
> > calls, actually, init_new_empty_context()). I think that the proper place
> > to add the call is open_proc_mm(). Do you agree on this?
>
> Sounds ok, changed that, tested, works, new version below.
Yes, agreed.
> There is 
> also another fix in enter_lazy_tlb()
In switch_mm, actually.
> : use the per_cpu() macro (also 
> new in 2.6.9-rc I think).
Ah, yes, that is the only change which I had made when porting the SKAS patch 
to 2.6.9, while fixing the reject below. Basically, what we do is to make 
sure that the BUG_ON check that we remove cannot be triggered; that check is 
done if prev == next, so we must make sure to give to "prev" the value that 
"next" is supposed to have.

The reason is that with PTRACE_SWITCH_MM a thread can be scheduled away while 
having one MM and rescheduled while having a new MM; and if when it's 
scheduled away, a kernel thread goes executing, the kernel thread (using a 
lazy TLB) will keep using the old MM, the one switched away with 
PTRACE_SWITCH_MM, and the one you get with per_cpu(...). The "prev" and 
"next" args, instead, come from current->mm, so prev is wrong (the kernel 
code didn't notice that current->mm has changed). However, this can only be 
triggered on SMP, when the ptracing thread (the UML kernel thread) executes 
on a different CPU than the userspace thread.

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
