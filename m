Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BC0is-0005f1-Dn for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 11:27:26 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BC0ir-0007YW-OT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Apr 2004 11:27:25 -0700
Message-ID: <195901c41e61$3132cb90$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
	<189201c41e30$d434cc70$2000000a@schlepptopp>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] uml responsivenes or "AS vs DEADLINE Scheduler on
	uml-host" - was: [uml-user] Network lags
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
Date: Fri, 9 Apr 2004 20:33:39 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Joern Bredereck <jb@bw-networx.net>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu

Hi !
I think i found an interesting "scheduling issue" which led me to switch the subject of the thread.

joern reported network lags, i have seen some other mails reporting about this issue, i had experienced such lags myself and i
remember reading mails, that the first pings after "upping" the network interfaces in uml tend to give slow response time.

just for the fun, i switched to deadline i/o scheduler on the host (kernel param "elevator=deadline") and, after a first try, things
seem to behave better with that scheduler!

i generated the same i/o load on the host, hogged the cpu like hell, loadavg was >40) and i NEVER recognized the network-lags again.
i also cpu- and i/o-hogged the uml itself, which resulted in big increase of the ping-times (from average 0.2ms to 600ms), but i
NEVER saw that strange behaviour of uml responsiveness again (ping times >90s,"sendmsg: no buffer space available") , as when i did
use the standard AS (Anticipatory) Scheduler. there where _some_ pings >2000ms, too - but this didn`t happen often and not so
seriously as with "AS" & an "idle uml" - the uml seems to be more responsive in general when using deadline scheduler.

I cannot tell, if there is a bug in AS or this is a "uml<->AS issue" which causes uml network lags, but at least there should be
done some more testing to confirm, what i found.

so, i would like to encourage other people doing some more tests - especially those, who experience network-lags!

regards
roland


ps:
funny:
i have solved my "problem"  by switching to a different scheduler - joern has (probably) solved it by switching to a later
uml-release.
so is it a scheduler or a uml issue ? or both?

pps:
>This causes UML to get swapped out because it's not doing anything
> except answering a ping once in a while.
mhhh - as far as i remember i didn`t see(vmstat) a single byte of uml or any other process being swapped out when running my test.
general question: does heavy usage of buffers lead to processes being swapped out?


----- Original Message ----- 
From: "Jeff Dike" <jdike@addtoit.com>
To: "roland" <for_spam@gmx.de>
Cc: "Joern Bredereck" <jb@bw-networx.net>; <user-mode-linux-user@lists.sourceforge.net>;
<user-mode-linux-devel@lists.sourceforge.net>; <mingo@elte.hu>
Sent: Friday, April 09, 2004 6:26 PM
Subject: Re: [uml-user] Network lags


> for_spam@gmx.de said:
> > at least, i would be interested in getting to know:
> > - why this happens
> > - how to "tune" this, that it doesn`t happen
> > - if this is expected behavour on "heavy loaded systems" or probably a uml
> > or host-kernel bug
>
> As you said, you're making life hard for the host.
>
> My guess as to what's happening is this.
>
> You're generating a ton of IO which is pulling the host's memory into page
> cache.  This causes UML to get swapped out because it's not doing anything
> except answering a ping once in a while.  When it does have to answer a ping,
> it needs to be swapped back in, which might be hard since you're sucking down
> a lot of IO bandwidth.
>
> So, I don't think this says too much about whether anything's wrong with
> either the host or UML.
>
> Once thing you might try is do the same IO with O_DIRECT.  That won't pollute
> the page cache.
>
> Jeff
>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
