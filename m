Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8e69-0000mT-3y for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 05:13:49 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1C8e67-00009p-Mb
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 05:13:49 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] uml, ptrace, and BKL
Message-ID: <20040918131814.GA2942@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0409171920470.1171@gradall.private.brainfood.com>
	<20040918033012.GA1618@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0409172129180.1171@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409172129180.1171@gradall.private.brainfood.com>
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
Date: Sat, 18 Sep 2004 09:18:14 -0400
To: Adam Heath <doogie@brainfood.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Sep 17, 2004 at 09:30:53PM -0500, Adam Heath wrote:
> No, I'm not.
> 
> UML ptraces it's children, to do it's emulation.  However, only one UML
> tracing thread can be doing a ptrace of one of it's children at a time.  If
> there are 50 UML instances running on the host, then that BKL inside
> sys_ptrace is a bottleneck.

OK, just your comment on preemption was a bit strange.

You're still wrong, just for different reasons.

The scalability of a lock depends on the number of processors on the system,
not the number of processes.  So, for a given host, increasing the number of
UMLs on the system won't increase the pressure on the BKL, assuming that
number is greater than the number of processors.  And in any case, on a UP
system, there is no BKL.

Increasing the number of processors will increase the pressure on the BKL,
again assuming there are more UMLs than processors.  So, 50 UMLs on a 2P
system won't be a problem, but 50 UMLs on a 50P system could be.

The UML systems that I am aware of are 2P, at most.  I think that it is
generally OK to run with the entire kernel under the BKL with 2 processors.
This being the case, it follows that ptrace won't be an issue either.

Also, the ptrace paths are pretty short.  Get in, copy a small amount of data
or change some state of the child, and get out.  On a 2P system, I have a 
hard time seeing that being a bottleneck.

However, it would be interesting to see if UML is causing lock contention
anywhere.  Running lockmeter on an SMP box running UMLs would show if there's
any problems.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
