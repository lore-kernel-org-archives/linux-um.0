Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8jpJ-00030r-DN for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 11:20:49 -0700
Received: from brown.brainfood.com ([146.82.138.61]
	helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1C8jpI-0005hO-ON for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 11:20:49 -0700
From: Adam Heath <doogie@brainfood.com>
Subject: Re: [uml-devel] uml, ptrace, and BKL
In-Reply-To: <20040918131814.GA2942@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.58.0409181318020.1171@gradall.private.brainfood.com>
References: <Pine.LNX.4.58.0409171920470.1171@gradall.private.brainfood.com>
	<20040918033012.GA1618@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0409172129180.1171@gradall.private.brainfood.com>
	<20040918131814.GA2942@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sat, 18 Sep 2004 13:20:39 -0500 (CDT)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, 18 Sep 2004, Jeff Dike wrote:

> The scalability of a lock depends on the number of processors on the system,
> not the number of processes.  So, for a given host, increasing the number of
> UMLs on the system won't increase the pressure on the BKL, assuming that
> number is greater than the number of processors.  And in any case, on a UP
> system, there is no BKL.

This is true(and something I hadn't considered).  But with preemption, it's
possible for multiple threads to be running in the kernel(as I understand it).

However, yes, ptrace paths should be rather short, so the chances for lock
contention to occur are most likely small.

> However, it would be interesting to see if UML is causing lock contention
> anywhere.  Running lockmeter on an SMP box running UMLs would show if there's
> any problems.

Same for a preemptible box.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
