Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.58.0403300053230.28775@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] New UML project on 64 bit
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
Date: Tue, 30 Mar 2004 01:33:44 -0500 (EST)
To: ML-uml-user <User-mode-linux-user@lists.sourceforge.net>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

Good day, all,
	As many of you already know, a group of individuals and I have run
a shared server named Zaphod with each of us having our own UML virtual
machine for just under two years.  The setup is described at
http://www.stearns.org/slartibartfast/uml-coop.current.html .  I recently
added a "Lessons learned" section and will add some comments from users of
the system at some point.
	The project has been a success on a number of levels, largely
because of Jeff's efforts and assistance.  We've identified some bugs and
bottlenecks, put out some documentation on how to run a shared server more
efficiently, run a number of services on 25+ virtual machines, tested 2.4
and 2.6 kernels and tried all manner of patches.  The users have generally
been quite happy with the way the server has performed.

	Jeff has recently had some good luck with running UML on a 64 bit 
architecture.  The code holds promise, but like all code will need some 
exercising to shake out the bugs.  The architecture will also have 
performance improvements, configuration issues, and quirks that will need 
to be documented or worked around.

	For this reason, I'm considering starting a similar project on a
64 bit architecture.  People interested in taking part would split the
cost of a 64 bit machine and the ongoing hosting costs.  In exchange, we'd
all get virtual machines on the box, with the ability to run services and
host users.  (For more details on the process, see the above paper).  I
expect we'd have ready-to-run Fedora Core 2 and Debian virtual machines,
but certainly allowing other VM types if the user supplies the root
filesystem.

	This email is a preliminary call for interest.  I expect the
purchase price for the system would run between $150 (US) and $350 per
participant, with probably $75 - $125 per year in hosting per participant.  
Taking part will also involve taking part in some aspect of the project,
such as: documentation, new user setup, hardware purchase, setup and
maintenance, bug reporting, root filesystem generation, performance
tuning, testing advanced features, kernel features, kernel debugging,
kernel updates, finances, team communication, etc.

	If you have interest in taking part in an early 64 bit CPU test of
UML, please get back to me personally with some thoughts about what kind
of contribution you'd like to make.
	Cheers,
	- Bill

---------------------------------------------------------------------------
First snow, then silence.
This thousand dollar screen dies
so beautifully.
        -- Error messages in haiku
(Courtesy of Rasmus Andersen <rasmus@jaquet.dk>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
