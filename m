Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8V05-0002kK-L0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 19:30:57 -0700
Received: from brown.brainfood.com ([146.82.138.61]
	helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C8V05-0007EM-12 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 19:30:57 -0700
From: Adam Heath <doogie@brainfood.com>
Subject: Re: [uml-devel] uml, ptrace, and BKL
In-Reply-To: <20040918033012.GA1618@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.58.0409172129180.1171@gradall.private.brainfood.com>
References: <Pine.LNX.4.58.0409171920470.1171@gradall.private.brainfood.com>
	<20040918033012.GA1618@ccure.user-mode-linux.org>
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
Date: Fri, 17 Sep 2004 21:30:53 -0500 (CDT)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 17 Sep 2004, Jeff Dike wrote:

> On Fri, Sep 17, 2004 at 07:23:01PM -0500, Adam Heath wrote:
> > What this means to UML, is that there is an upper-bounds on how many instances
> > can be on a server at once.  BKL also keeps preemption from occuring.
>
> Please.  UML is a normal process.  It can't do anything to prevent preemption.
>
> You're conflating the UML BKL and host BKL.  They're two separate things.

No, I'm not.

UML ptraces it's children, to do it's emulation.  However, only one UML
tracing thread can be doing a ptrace of one of it's children at a time.  If
there are 50 UML instances running on the host, then that BKL inside
sys_ptrace is a bottleneck.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
