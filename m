Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTNJB-0005AA-0V for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 09:00:41 -0700
Received: from bigben.vm.bytemark.co.uk ([212.13.198.58])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BTNJA-0000DH-20 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 May 2004 09:00:40 -0700
From: Michel <michel@pollet.net>
Reply-To: michel@pollet.net
Subject: Re: [uml-devel] mlock discussion is back - was: Re: [uml-user] odd
	ping problems
References: <pan.2004.05.17.20.30.18.825415@sipsolutions.de>
	<0e6d01c44378$7a05e640$2000000a@schlepptopp>
	<114b01c44400$e023fc40$2000000a@schlepptopp>
In-Reply-To: <114b01c44400$e023fc40$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405271700.22389.michel@pollet.net>
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
Date: Thu, 27 May 2004 17:00:22 +0100
To: roland <for_spam@gmx.de>
Cc: "Christopher S. Aker" <caker@theshore.net>, Johannes Berg <johannes@sipsolutions.de>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, matthew-list@bytemark.co.uk, Jeff Dike <jdike@addtoit.com>

(sorry for the top-reply, it's pretty out of context anyway)

Hi Roland,

mlockall is not what you want, mlockall will lock all current pages, but also 
FUTURE pages *including memory mappings* so you definitly don't want to do 
that, thats totaly uncontrolable.
AFAIK the mlock patch works great (you remembered you needed to launch the UML 
kernel as root?) we've been using it on lots of UMLs at Bytemarks and it 
definitly totaly cured the problem of the long pings, and also makes all of 
the VM much, much more responsive in general.

What that patch solves is an issue that would be very, very difficult to fix 
without the uml-kernel having access to which host-kernel pages are in or out 
of swap.
The problem is that the uml-kernel assumes that his memory pages are... in 
memory so it has immediate access to them, so when it (uml-kernel) knows 
about a page fault for a particular task, it can just suspend *that task* 
until the page is available, and continue doing whatever it was doing 
(including responding to ping, and scheduling the other tasks) in the 
meantime.
In our case, the uml-kernel thinks it has immediate access to it's "memory" 
page, SAVE that the host-kernel has decided to page it. Therefore the 
uml-kernel gets locked by host-kernel, including all it's tasks. Thats how 
you end up with massive lockups on the UMLs, because everything gets stopped.

So that mlock patch prevents that by ensuring that the uml-kernel is always 
rigth when it thinks a memory page is... in memory. I agree it's a fairly 
large gun to kill a seemingly simple problem...

I really don't know how one would make the system work without giving a notion 
of the host-kernel page layout to the uml-kernel, and that I think would be a 
massive task to implement, as well as a potentialy fatal security risk.

For the patch itself, I was one of the early user having that particular issue 
at Bytemark, and therefore made a proof-of-concept patch to test, it worked 
so well that Matthew Bloch "cleaned" the patch, added the command line option 
etc. It's been running perfectly well on hundreds of VMs on production 
machines for months now.
So technicaly Matthew's more of the maintainer than I am :-)

Feel free to forward this to appropriate lists, I am not on them.

Thanks
Michel

On Thursday 27 May 2004 16:39, roland wrote:
> hi!
> i tried to forward-port the mlock patch to 2.6.6 - and succeeded so far,
> because it`s a small patch and i just needed reading through the lines and
> adjust them to the right lines in  uml code.
>
> unfortunately, it doesn`t seem to cure the ping-problem.
> using sar,  i still see major pagefaults for the uml "master/root" process,
> while "hogging" the host vm (eatmem, dd ....). btw: how can we distinguish
> between the different uml processes at runtime?
>
> furthermore, i intuitively tried  mlockall(MCL_CURRENT| MCL_FUTURE) instead
> of mlock(addr,next_len) (see
> http://www.die.net/doc/linux/man/man2/mlockall.2.html) and it seems this
> gives good results (no major pagefaults anymore) - but i don`t really know
> what i`m doing here and if i`m doing it right  - because i`m no kernel
> hacker :)
> someone with more detailed knowledge could give a comment to this?
>
> regards
> roland
>
>
> ----- Original Message -----
> From: "roland" <for_spam@gmx.de>
> To: "Christopher S. Aker" <caker@theshore.net>; "Johannes Berg"
> <johannes@sipsolutions.de> Cc:
> <user-mode-linux-user@lists.sourceforge.net>;
> <user-mode-linux-devel@lists.sourceforge.net>;
> <matthew-list@bytemark.co.uk>; <michel@pollet.net>; "Jeff Dike"
> <jdike@addtoit.com>
> Sent: Thursday, May 27, 2004 1:23 AM
> Subject: [uml-devel] mlock discussion is back - was: Re: [uml-user] odd
> ping problems
>
> > hi!
> > since i had problems with those ping delays, too - i spent some time on
> > that and i think i probably have found a relationship between uml ping
> > delays and page-faults of the uml process.
> >
> > if you don`t see the ping delays, you should be able to produce them with
> > the following "receipe" - at least i`m able to reproduce it very easily
> > this way:
> >
> > get eatmem.c from http://www.theshore.net/~caker/patches/eatmem.c and
> > compile.
> >
> > now check your free memory (vmstat / top / free....) and let eatmem eat
> > it up almost completely. (eatmem bigvalue loop)
> >
> > after that, run "dd if=/dev/hda of=/dev/null" in a separate window.
> >
> > you should see ping time (pinging from host to uml) go up from ~0.15ms to
> > very much higher values.
> >
> > watch your uml process with "sar" (install sysstat rpm - should be
> > delivered with your distro - or get it from :
> > http://perso.wanadoo.fr/sebastien.godard/)
> >
> > sar -x umlpid1 -x umlpid2 -x umlpid3 -x umlpid4  1 0  (on skas host)
> >
> > for at least two of the uml-pid`s you should see minor and major
> > pagefaults (minflt/majflt) - i would say there is a releationship between
> > those pagefaults and the ping delays. (i had turned off swap completely -
> > so my host was not able to swap at all!)
> >
> > can somebody acknowledge this ?
> >
> > so - the question is: if those pagefaults cause that ping delays - how to
> > stop them from happening entirely ? paging is a quite common thing
> > happening to processes - in every OS.
> >
> > there was a controversial discussion about (optional) mlocking uml by a
> > patch:
> > http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107090239400338&w
> >=2 at:
> > http://marc.theaimsgroup.com/?t=108150683900001&r=1&w=2
> >
> > since we see, that this annoying effect happens over and over again and
> > nobody can do something about that - i`m not sure - but this patch
> > probably could solve that obscure ping-delay/pagefault problem, too. so -
> > why the hell not using and recommending it ?
> >
> > reading into http://www.die.net/doc/linux/man/man2/mlockall.2.html:
> > >Memory locking has two main applications: real-time algorithms and
> > > high-security data processing. Real-time applications require
> > > deterministic timing, and, like scheduling, !!!---> paging is one major
> > > cause of unexpected program execution delays.<---!!! Real-time
> > > applications will usually also switch to a real-time scheduler with
> > > sched_setscheduler.
> >
> > sorry if some people will roll their eyes now - but i`d like to bring
> > michel pollet`s patch back into discussion again - because the ping (and
> > probably other) delay effect(s) seem to be a result of paging (and not
> > only swapping).  so, making sure that a host has enough RAM and making
> > sure, that he won`t swap is definetly NOT enough to make sure that a uml
> > runs smoothly.  some pagefaults on the uml process - pooof - and we have
> > significant delays....
> >
> > michel - if you are reading this - and if your mlock patch solves this
> > problem - i`m sure some people would be happy if the mlock patch would be
> > actively maintained separately and a port to 2.6.x would be done, too. at
> > least i`m very interested in a port to 2.6.x
> > the discussion about this patch being merged or not can be made at a
> > later time.....
> >
> > regards
> > roland
> >
> >
> > ----- Original Message -----
> > From: "Christopher S. Aker" <caker@theshore.net>
> > To: "roland" <for_spam@gmx.de>; "Johannes Berg"
> > <johannes@sipsolutions.de> Cc:
> > <user-mode-linux-user@lists.sourceforge.net>
> > Sent: Wednesday, May 26, 2004 7:55 PM
> > Subject: Re: [uml-user] odd ping problems
> >
> > > > hi !
> > > > maybe this is interesting for you:
> > > > http://marc.theaimsgroup.com/?t=108150683900001&r=1&w=2
> > > > http://marc.theaimsgroup.com/?t=108153567000002&r=1&w=2
> > > > ??
> > >
> > > Thanks for the links.  This wasn't an ARP or I/O problem -- My testing
> > > was done from the host to a guest within the same subnet, avoiding the
> > > switch/networking gear all together.  The host had nothing in swap, the
> > > guest wasn't swapping or doing anything but responding to my pings
> > > along with an ssh session.
> > >
> > > I'm pretty sure this is some weirdness in the host and/or UML kernel. 
> > > If I find the time, I'll try to reproduce.
> > >
> > > Thanks!
> > > -Chris
> > >
> > >
> > >
> > > johannes:~$ ping uml
> > > PING uml (172.17.16.100) 56(84) bytes of data.
> > > 64 bytes from uml (172.17.16.100): icmp_seq=2 ttl=64 time=10008 ms
> > > 64 bytes from uml (172.17.16.100): icmp_seq=3 ttl=64 time=9008 ms
> > > 64 bytes from uml (172.17.16.100): icmp_seq=4 ttl=64 time=8008 ms
> > > 64 bytes from uml (172.17.16.100): icmp_seq=5 ttl=64 time=7009 ms
> > > 64 bytes from uml (172.17.16.100): icmp_seq=6 ttl=64 time=6009 ms
> > > 64 bytes from uml (172.17.16.100): icmp_seq=7 ttl=64 time=5009 ms
> > > 64 bytes from uml (172.17.16.100): icmp_seq=8 ttl=64 time=4008 ms
> > > 64 bytes from uml (172.17.16.100): icmp_seq=9 ttl=64 time=3009 ms
> > > 64 bytes from uml (172.17.16.100): icmp_seq=10 ttl=64 time=2009 ms
> > > 64 bytes from uml (172.17.16.100): icmp_seq=11 ttl=64 time=1010 ms
> > > 64 bytes from uml (172.17.16.100): icmp_seq=12 ttl=64 time=2.67 ms
> >
> > Just a "me too" reply.  I noticed this tonight, while nmap'ing a guest. 
> > Pings start out very long and consistantly return back to normal response
> > times.  Very strange.  Using bridging/tuntap setup.
> >
> > I haven't look farther into this.  Jeff, any thoughts?
> >
> > -Chris
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: Oracle 10g
> > Get certified on the hottest thing ever to hit the market... Oracle 10g.
> > Take an Oracle 10g class now, and we'll give you the exam FREE.
> > http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> > _______________________________________________
> > User-mode-linux-devel mailing list
> > User-mode-linux-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Linux yawn 2.6.5-mm6 #73 Sun May 9 18:19:52 BST 2004 i686


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
