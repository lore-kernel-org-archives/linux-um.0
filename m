Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNyCl-0001lV-TY for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 11:11:43 -0700
Received: from stclair.eecs.umich.edu ([141.213.8.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BNyCl-0004Ho-CT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 11:11:43 -0700
Received: from stclair.eecs.umich.edu (localhost.eecs.umich.edu [127.0.0.1])
	by stclair.eecs.umich.edu (8.12.10/8.12.10) with ESMTP id
	i4CIBfuu013470 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 May 2004 14:11:41 -0400
Received: from localhost (dunlapg@localhost)
	by stclair.eecs.umich.edu (8.12.10/8.12.10/Submit) with ESMTP id
	i4CIBfKT013466 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 May 2004 14:11:41 -0400
From: George Washington Dunlap III <dunlapg@umich.edu>
Message-ID: <Pine.LNX.4.60.0405121355060.12720@stclair.eecs.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] Seeking real kernel bugs mirrored in UML
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
Date: Wed, 12 May 2004 14:11:41 -0400 (EDT)
To: user-mode-linux-devel@lists.sourceforge.net

I'm looking for a bug in any recent version of linux (probably 2.4.18+) 
that would be mirrored in User Mode Linux.  We were thinking probably a 
filesystem bug, but anything would do.  Preferred are bugs that are very 
difficult using traditional iterative debugging techniques: namely, ones 
that involve
  * a race condition
  * corruption of the stack / data

I need to know:
  * What version of linux / UML the bug is in.
  * The conditions needed to trigger it.

I'm working on the ReVirt project at the University of Michigan.  ReVirt 
is a system to log the complete execution of a virtual machine (currently 
UML) so that we can replay it exactly as before: this includes all 
non-deterministic data from the network, keyboard, RDTSC values, as well 
as re-delivering interrupts exactly the same way.  This means that any 
"heisenbug" is now repeatable.

We're working now on using ReVirt for debugging.  We implemented some very 
useful new features to gdb:
  * reverse instruction breakpoint (i.e., "Go back to the *last* time this 
instruction was executed")
  * reverse data breakpoint (i.e., "Find the last time this value was 
changed")
  * reverse step -- go backwards one instruction.

We've already used it to find some bugs in an older version of UML, but 
unfortunately those were in UML-specific code.  We'd ideally like to show 
that this would be useful for mainline kernel bugs.

Any help you can give would be appreciated.

Peace,
  -George


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
