Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWbyG-0001E6-Dj for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 06:48:44 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWbyF-0004kJ-Gr for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 06:48:44 -0800
Message-ID: <41A34DC5.3000807@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <000901c4d0e1$e7f998d0$0201a8c0@hawk>
	<200411222346.36960.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411222346.36960.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: 2.6.9-bb3 creates zombie threads in SKAS
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
Date: Tue, 23 Nov 2004 15:48:37 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: "Christopher S. Aker" <caker@theshore.net>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Monday 22 November 2004 23:23, Christopher S. Aker wrote:
> 
>>Hello,
> 
> Btw, question: what about your I/O token limiter? Actively using it? Could 
> start being worked on for merge (there is at least one bug-report on it by 
> "roland" on a strange but valid test-case).
> 
>>I thought I'd give 2.6.9-bb3 a shot, and I had a bunch of users report the
>>accumiluation of zombies.
> 
> What the hell! This should *not* happen. What did we (I mean developers) do?
Don't know, on my 2.6.9-skas3-v7 host it doesn't happen. And on the
2.6.7-skas3-v7 it doesn't also. Not in SKAS and not in TT.
By the way: why should SKAS produce lots of zombies? Maybe in TT we could have
missed something, but in SKAS I can't see any possible reason.
>
>>This is on a 2.6.7 host, using your 
>>host-skas3-2.6.7-v1 patch.
> 
> ??? There is a ton of bugs in that patch (see the changelogs on my site). 
> Actually, it's likely you're not going to be hurt by them if you're using 
> NPTL on the host (it is *hard* to get them in that case), but you'd better 
> upgrade.
> 
> I have been releasing tons of updates, and even too quickly (most times I was 
> not introducing new bugs, just fixing the ones I and Bodo Stroesser was 
> finding) but -V1 is "a bit" old. That said, this should not happen.
> 
>>I'm not sure if it happened on newer host 
>>kernels, since I had to revert it back quickly.
> 
> 
> Back to what? To 2.6.9-bb2 or to 2.6.9?
> 
> I'll check in these days what's going on... it was hyper-tested on 2.6.9 host 
> (not by me, but I trust Bodo Stroesser normally), but not on other hosts, I 
> guess.
I tested on 2.6.9 and 2.6.7, but not on 2.4. For info: my latest patch, as
included in bb3, changes more than necessary. I tested, which parts of the
previous patches from BlaisorBlade and me really are needed. But the tests were
wrong, since I missed the fact, that make doesn't work correctly for USER_OBJS.
Thus I had a inconsistent kernel and saw UML exiting in boot. Since UML accidentally
worked fine after inserting a further part of my changes, I incorrectly assumed
this part to be needed.
Thus, Jeff posted a new, further stripped patch with the subject
"The current fix-kill patch". It has to be applied on top of BlaisorBlade's
"uml-hang-on-2.6.9-host.patch". I have tested this again, with hosts
2.6.7-skas3-v7 and 2.6.9-skas3-v7 in SKAS and TT. For me it works fine.

Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
