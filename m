Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zfRQ-0000OI-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 09:46:08 -0700
Received: from stclair.eecs.umich.edu ([141.213.8.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19zfRN-0002KF-1Z
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 09:46:05 -0700
From: George Washington Dunlap III <dunlapg@umich.edu>
Subject: Re: [uml-devel] UML and Execution Replay
In-Reply-To: <oprvlw3zpw786kia@smtp.web.de>
Message-ID: <Pine.LNX.4.44.0309171159260.19821-100000@stclair.eecs.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 17 Sep 2003 12:45:59 -0400 (EDT)
To: Oliver Oppitz <o.oppitz@web.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Hello!  I just found this thread, and I thought you might be interested in 
our work on ReVirt:
  http://www.eecs.umich.edu/CoVirt/umlinux.html

Basically, last year we started a project with UMLinux (now FAUMachine,
from the University of Erlangen), to do complete VM logging and replay
using the performance counters.  We presented our work in December at
OSDI:

George W. Dunlap, Samuel T. King, Sukru Cinar, Murtaza Basrai, and Peter 
M. Chen.  ReVirt: Enabling Intrusion Analysis through Virtual-Machine 
Logging and Replay.  In Proceedings of the 2002 Symposium on Operating 
Systems Design and Implementation (OSDI), pags 211-224, December 2002.

Our main goal with ReVirt is security, not debugging; we have a paper 
about backtracking intrusions in this year's SOSP:

Samuel T. King and Peter M. Chen.  Backtracking Intrusions.  To appear in 
the Proceedings of the 19th ACM Symposium on Operating Systems Principles, 
November 2003.

We're now working to port our system over to Jeff Dike's UML.  It's a bit
more challenging: UMLinux is only a single process, so as long as we
re-deliver interrupts in the same way and answer system calls in the same
way, everything works.  UML is a bit more difficult because there are
multiple processes, and issues with shared memory and the host kernel
system calls.  We may have to make a few minor changes to UML to get 
ReVirt working, but we should have a basic system running in a month or 
two.

So, it looks like you're planning on doing your replay system in a 
different way than we are.  Do you want to do your work on your own 
system, or would you like to start with ours?  BackTracker already has 
some hooks for GDB, but I don't know exactly how they work (that's Sam 
King's area).  We're planning on focusing on security, so I don't think 
we'd be in competition if you were going to do debugging.

Anyway, let me know what you think, and keep us informed of how your work 
is coming along.  We'd be interested in how other ways of doing replay 
pan out.

Peace,
 -George

On Tue, 16 Sep 2003, Oliver Oppitz wrote:

> Hello *,
> 
> I have a new project proposal for applying UML in the deterministic (!) 
> debugging of parallel programs.
> 
> This concept is not new and called execution-replay (ER): the behaviour of 
> a (complicated, multi-threaded, buggy) program is recorded during an 
> *execution* phase. Later during a *replay* phase the exact behaviour is 
> reproduced -- including the bugs. Therefore the system is ideal to debug - 
> rarely occuring bugs in parallel systems, - race conditions, - any sort of 
> bugs that are (nearly) impossible to reproduce. All you need to do is to 
> record the behaviour once and then simply replay and debug it! Sounds 
> exciting? - you must be a hacker then ;-) And think of the consequences...
>  The role of UML will be a replayable virtual machine. By recording all 
> input to the UML keyboard, network, ... and feeding this same input into 
> the UML during replay, the exact internal behaviour will be reproduced. One 
> gets ER without modifying the code of the applications program. This is a 
> huge advantage over conventional approaches that require that the software 
> adheres strictly to certain protocols. Also the overhead should be minimal.
> 
> There is some more to the idea though. I presented a paper "A particular 
> bug trap: Execution replay for Virtual machines" on this idea at a 
> conference last week (http://aadebug2003.elis.rug.ac.be/). See link below.
> 
> I am working on the implementation myself but of course: any help is 
> welcome. I will put up a small website in the next weeks and post again. If 
> anyone is interested in the project already, get in contact with me via 
> o.oppitz at gmx d O T net. I'd be happy to share my ideas.
> 
> Regards,
> 
>   Oliver
> 
> 
> The paper "A particular bug trap: Execution replay for Virtual machines" 
> can be found at http://213.203.244.62/paper.short.pdf
> http://213.203.244.62/paper.long.pdf
> Note, that there is a way to work around the limitations of the Intel 
> architecture mentioned in the paper. So I am pursuing this project on x86.
> 
> Further information on Execution replay can be found at
> http://www.zealcore.com/
> http://www.mrtc.mdh.se/projects/getProject.php3?id=0044
> The approach is different but already applied in an industrial context 
> (VxWorks).
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 

-- 
+-------------------+----------------------------------------
| dunlapg@umich.edu | http://www-personal.umich.edu/~dunlapg 
+-------------------+----------------------------------------
| ...there be many, many ancient systems in the world, and it 
| is the decree of the dreaded god Murphy that thy next 
| employment just might be on one.  While thou sleepest, he 
| plotteth against thee.  Awake and take care.
|   - Henry Spencer, "The Ten Commandments for C Programmers"
+------------------------------------------------------------
| Outlaw Junk Email! Support HR 1748 (www.cauce.org)





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
