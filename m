Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <OF2C0F2572.688466F1-ON65257018.00480279-65257018.0048CBFD@in.ibm.com>
From: Sriram Raghunathan <sraghuna@in.ibm.com>
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: [uml-devel] Problem running SMP-UML (both skas & tt)
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
Date: Mon, 6 Jun 2005 18:56:41 +0530
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net





Hi,
  We're having problems running UML with SMP enabled...(ie ncpus>1) on Suse
Linux 9.0 with
2.6.5-7.97-smp (host kernel)

We've built UML with linux-2.6.11.7 & have been unsuccessful running linux
in either skas nor tt modes
for SMP. Of-course, we have absolutely no problems when we're in single cpu
mode with npcus=1.

Here I would need to mention that when we enable debug, we get the
following error message during
linking stage:
kernel/profile.c:387: undefined reference to `profile_pc".

We went ahead & commented this out to get the build to work..would
appreciate if somebody could point
 us to a patch. However this is not the crux of the problem we're facing.

Here's what happens when we try to start up UML in tt mode for
multi-cpu's...

./linux ubd0=/cics/SLES9/root.img ubd1=/cics/SLES9/swap.img umid=first
con=pty con0=fd:0,
fd:1 con1=xterm ncpus=4 mode=tt
Checking PROT_EXEC mmap in /tmp...OK
tracing thread pid = 27309

And the process just comes out...

Pl note that the linux process that we run above is built with kernel debug
enabled. (We've commented out
the reference to profile_pc)

   /*
        if (!user_mode(regs) && cpu_isset(smp_processor_id(),
prof_cpu_mask))
                profile_hit(type, (void *)profile_pc(regs));
  */

We did run with the debug option as well but did not get much out of the
gdb session..

Of-course...we would love to get the skas mode to work with SMP...but I've
read through in
many a discussion that we have issues with this. Is there a patch in place
that we could
use? Pl note that we did try with 2.6.9 with the bs7 patch but this did not
work.

We hit upon

panic("skas mode doesn't support SMP");


Here's what we see currently for skas...in linux-2.6.11.7.

umluser@lincoln:~/linux_src/src> ./linux ubd0=/cics/SLES9/root.img
ubd1=/cics/SLES9/swap.img umid=first con=pty con0=fd:0,fd:1 con1=xterm
ncpus=4
Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK

And the process comes out.

Would appreciate if we could get any help to sort this out. If these are
know issues, perhaps a link to kernel version
 which does not have these problems(preferably skas) would be helpful.

Thanks,
Sriram







-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
