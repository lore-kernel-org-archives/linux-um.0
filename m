Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] uml responsivenes or "AS vs DEADLINE Scheduler on
	uml-host" - was: [uml-user] Network lags
In-Reply-To: <1fb601c4219d$ee592c20$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0404140254330.20676-100000@filer.marasystems.com>
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
Date: Wed, 14 Apr 2004 03:02:45 +0200 (CEST)
To: roland <for_spam@gmx.de>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>, Joern Bredereck <jb@bw-networx.net>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Tue, 13 Apr 2004, roland wrote:

> mmhh - i didn`t really recognize that i got a big improvement of i/o
> performance in general. i just recognized, that my uml was more
> responsive to ping (no more "sendmsg: no buffer space available,no
> network lags of values like 60s anymore). btw: my uml didn`t access the
> disk at all, while answering the pings (why should it? all that
> network-stuff happens in uml-kernel space)

Heavy host I/O can cause the inactive portions of your UMLs to be swapped 
out..

> thats a point. will try that if i find some time. does somebody have some more details
> what was changed exactly? (i dont know much about bitkeeper - but maybe i can view the
> changelog like in cvs, for every single file?)

You can view which changesets applies to a given file, and from there the
log messages of those, much the same as in CVS but not as simple 
operation.

> i think he guessed wrong. it doesnt matter if my uml is idle or not - no difference
> if i run a vmstat (and some more) inside my uml( i.e. it is not idle)

only running a vmstat is effectively idle.

you need to be running something which really uses the CPU within your UML 
to not make it idle. A simple "perl -e '$i++ while(1);'" should do nicely 
as a CPU hog..

> while pinging. the effect i experience doesnt`t seem to be an effect
> which is caused by a uml being swapped out and in again - because i
> didn`t see a single byte being swapped out/in on the host. so this
> effect remains....strange for me.

What did "vmstat 1" on the host report for the period around your strange
ping results?

Are you using TT or SKAS? If TT then swapping of UML does not show up in
swap in/out as the UML is then running from memory mapped files and not
using the host swap. I think SKAS uses the host swap for the UML memory,
but I am not sure..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
