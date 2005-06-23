Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlOwo-00079f-6K	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Jun 2005 03:28:38 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DlOwm-000849-GJ	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Jun 2005 03:28:38 -0700
Message-ID: <42BA8ECC.2010102@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200506230238.35960.blaisorblade@yahoo.it>
	<20050623011255.GB15548@ccure.user-mode-linux.org>
In-Reply-To: <20050623011255.GB15548@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Skas0 general testing?
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
Date: Thu, 23 Jun 2005 12:28:28 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Thu, Jun 23, 2005 at 02:38:35AM +0200, Blaisorblade wrote:
> 
>>Would you start preparing a SKAS0 patch-set that I can merge into -bs for 
>>general testing and that can be merged into -mm at least?
> 
> 
> I'm working on it.  skas0 and skas0-clone are the first to go.  I just
> "fixed" skas0 so it gets mm->nr_ptes right without the change to
> exit_mmap that used to be there.  I'm banging on that patch now.
About skas0-clone:

Jeff, do you remember our discussion about RCX probably not being restored
correctly, in case a process is scheduled out on a interrupt, but is resumed
because of an other process going to sleep in a syscall?
You asked me, why you didn't see any problems here. Maybe, meanwhile I
know the answer: the problem will come up in skas3, but will be a rare
case in skas0. This is due to the fact, that the problem will happen only,
if the processes run in the same userspace process.
So, in skas0 it can happen only for threads sharing the same mm!
It will be simple, to build a test for this:
1) create a parent and a child process using clone(CLONE_VM)
2) let the child load a "magic number" into RCX, then let it loop for ever.
3) In the loop, child should compare RCX against "magic number" and should
    jump out of the loop, if RCX has changed. Now it should write an error
    message containing the changed RCX-value, and exit.
4) parent should go into a loop of short sleeps. After a certain number of
    sleeps, it should consider the test to not have found a problem. Then it
    should kill the child and exit.
Unfortunately, I have no x86_64 system to create and run the test.

I guess, it will need some modifications in x86_64-host to fix this.

To work around this probable problem, skas0 could have separate userspace-
processes even for threads sharing the same mm. Those processes could be
created by the clone-stub using clone(CLONE_VM), resulting in a new
skas0-clone.
A check of the form proposed above even could be done at UML startup to
make UML work with or without separate userspace-processes.

Maybe, the test and possible changes in the patches should be done before
merging into -mm.

> 
> The rest still need work.  The setup patches (where we make proc_mm et
> al settable on the command line and all combinations will work) are
> probably OK.
> 
> Some of the later ones are pretty sad.  The ldt patches are probably
> not too hard to clean up, but things like add-gate-vma are horrible.
That's true. add-gate-vma never was planned to go into mainline "as is".
I wrote that nasty thing to at the moment avoid changes in arch-independent
code (e.g. mm/memory.c).
For mainline, we need to create a new version, that does the changes for
adding "multi-gate-vma"-support properly in the common soure files. I have
no idea, if this change will be accepted. OTOH, I have no other idea how to
make skas0 consistent.

		Bodo
> 
> I'm not planning on having a whole good set before starting to send
> them to Andrew.  I'll send the ones I'm happiest about, and clean up
> the rest, sending them in during the course of 2.6.13.
> 
> 
>>I'd like it to be verifiably "don't touch" about SKAS3 working (i.e. no 
>>"little changes which won't hurt"). As I already said, I don't mean from the 
>>"code" viewpoint but from the "what's actually done" viewpoint (in terms of 
>>strace output, if you want so).
> 
> 
> That's a good goal, but we can't let it get in the way of keeping the
> code clean.  Certainly, anything which touches skas3 should be
> carefully looked at, but I don't want to state that we will not touch
> any skas3 code.  Bodo's patches which make any combination of
> PTRACE_LDT, PTRACE_FAULTINFO, and /proc/mm work are a good example.  I
> think that's a worthwhile patch, but it does touch skas3 code.
> 
> 				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
