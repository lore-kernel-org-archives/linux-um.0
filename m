Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BT7dO-0000EH-OH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 May 2004 16:16:30 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BT7dN-0005eS-Tx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 May 2004 16:16:30 -0700
Message-ID: <0e6d01c44378$7a05e640$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <pan.2004.05.17.20.30.18.825415@sipsolutions.de>
	<016101c442cb$b4ae1b80$0201a8c0@hawk>
	<0d5701c44321$6f8649f0$2000000a@schlepptopp>
	<002101c4434a$ad9cc5b0$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] mlock discussion is back - was: Re: [uml-user] odd ping
	problems
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
Date: Thu, 27 May 2004 01:23:37 +0200
To: "Christopher S. Aker" <caker@theshore.net>, Johannes Berg <johannes@sipsolutions.de>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, matthew-list@bytemark.co.uk, michel@pollet.net, Jeff Dike <jdike@addtoit.com>

hi!
since i had problems with those ping delays, too - i spent some time on that and i think 
i probably have found a relationship between uml ping delays and page-faults of the uml 
process.

if you don`t see the ping delays, you should be able to produce them with the following 
"receipe" - at least i`m able to reproduce it very easily this way:

get eatmem.c from http://www.theshore.net/~caker/patches/eatmem.c and compile.

now check your free memory (vmstat / top / free....) and let eatmem eat it up almost completely. 
(eatmem bigvalue loop)

after that, run "dd if=/dev/hda of=/dev/null" in a separate window.

you should see ping time (pinging from host to uml) go up from ~0.15ms to very much higher values.

watch your uml process with "sar" (install sysstat rpm - should be delivered with your distro - 
or get it from : http://perso.wanadoo.fr/sebastien.godard/)

sar -x umlpid1 -x umlpid2 -x umlpid3 -x umlpid4  1 0  (on skas host)

for at least two of the uml-pid`s you should see minor and major pagefaults (minflt/majflt) - i would 
say there is a releationship between those pagefaults and the ping delays. (i had turned off swap 
completely - so my host was not able to swap at all!)

can somebody acknowledge this ?

so - the question is: if those pagefaults cause that ping delays - how to stop them from happening
entirely ? paging is a quite common thing happening to processes - in every OS.

there was a controversial discussion about (optional) mlocking uml by a patch:
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107090239400338&w=2
at:
http://marc.theaimsgroup.com/?t=108150683900001&r=1&w=2

since we see, that this annoying effect happens over and over again and nobody can do something about
that - i`m not sure - but this patch probably could solve that obscure ping-delay/pagefault problem, 
too. so - why the hell not using and recommending it ?

reading into http://www.die.net/doc/linux/man/man2/mlockall.2.html:

>Memory locking has two main applications: real-time algorithms and high-security data processing. 
>Real-time applications require deterministic timing, and, like scheduling, !!!---> paging is one 
>major cause of unexpected program execution delays.<---!!! Real-time applications will usually also 
>switch to a real-time scheduler with sched_setscheduler. 

sorry if some people will roll their eyes now - but i`d like to bring michel pollet`s patch back into 
discussion again - because the ping (and probably other) delay effect(s) seem to be a result of paging 
(and not only swapping).  so, making sure that a host has enough RAM and making sure, that he won`t swap 
is definetly NOT enough to make sure that a uml runs smoothly.  some pagefaults on the uml process - pooof 
- and we have significant delays....

michel - if you are reading this - and if your mlock patch solves this problem - i`m sure some people would 
be happy if the mlock patch would be actively maintained separately and a port to 2.6.x would be done, too.
at least i`m very interested in a port to 2.6.x 
the discussion about this patch being merged or not can be made at a later time.....

regards
roland


----- Original Message ----- 
From: "Christopher S. Aker" <caker@theshore.net>
To: "roland" <for_spam@gmx.de>; "Johannes Berg" <johannes@sipsolutions.de>
Cc: <user-mode-linux-user@lists.sourceforge.net>
Sent: Wednesday, May 26, 2004 7:55 PM
Subject: Re: [uml-user] odd ping problems


> > hi !
> > maybe this is interesting for you:
> > http://marc.theaimsgroup.com/?t=108150683900001&r=1&w=2
> > http://marc.theaimsgroup.com/?t=108153567000002&r=1&w=2
> > ??
> 
> Thanks for the links.  This wasn't an ARP or I/O problem -- My testing was done
> from the host to a guest within the same subnet, avoiding the switch/networking
> gear all together.  The host had nothing in swap, the guest wasn't swapping or
> doing anything but responding to my pings along with an ssh session.
> 
> I'm pretty sure this is some weirdness in the host and/or UML kernel.  If I find
> the time, I'll try to reproduce.
> 
> Thanks!
> -Chris
> 


> johannes:~$ ping uml
> PING uml (172.17.16.100) 56(84) bytes of data.
> 64 bytes from uml (172.17.16.100): icmp_seq=2 ttl=64 time=10008 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=3 ttl=64 time=9008 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=4 ttl=64 time=8008 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=5 ttl=64 time=7009 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=6 ttl=64 time=6009 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=7 ttl=64 time=5009 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=8 ttl=64 time=4008 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=9 ttl=64 time=3009 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=10 ttl=64 time=2009 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=11 ttl=64 time=1010 ms
> 64 bytes from uml (172.17.16.100): icmp_seq=12 ttl=64 time=2.67 ms

Just a "me too" reply.  I noticed this tonight, while nmap'ing a guest.  Pings
start out very long and consistantly return back to normal response times.  Very
strange.  Using bridging/tuntap setup.

I haven't look farther into this.  Jeff, any thoughts?

-Chris



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
