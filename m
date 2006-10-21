Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gb70M-0002h7-PC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 19:54:34 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gb70J-0005Zn-UE
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Oct 2006 19:54:34 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 21 Oct 2006 04:54:23 +0200
References: <v0r6x41bnb.fsf@marajade.sandelman.ca>
	<200610210238.16557.blaisorblade@yahoo.it>
	<17462.1161394764@sandelman.ottawa.on.ca>
In-Reply-To: <17462.1161394764@sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610210454.23887.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Xen 3.0.2 and UML guest
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Saturday 21 October 2006 03:39, Michael Richardson wrote:
> >>>>> "Blaisorblade" == Blaisorblade  <blaisorblade@yahoo.it> writes:
>     >> I built a tree on my laptop as I normally do. It runs etch, and as
>     >> does my debian XenU.  With 2.6.15 UML guest on my laptop, everything
>     >> is fine.
Can you also check other (later) UML versions?

>     >> Same binary running under a XenU, goes into R state under XenU:
>
>     Blaisorblade> I forget - XenU is an unprivileged guest, and Xen0 is
>     Blaisorblade> the main one IIRC  (vaguely) - if that is an
>     Blaisorblade> unprivileged guest have you tried on the root one?
>
>   Xen0/Dom0 is the "host" if you like, and XenU/DomU is the "child".
>
>   You are asking if I can run a UML child on the Xen0? I have not tried
> it, and I'd have to mess around a bit to do so, but I can try.
>
>     >> <BIG PAUSE ******>

This is SKAS0 mode (since you said that TT mode works ok), right?
I really guess that the problem here is not the VTALARM handling (any UML 
strace is cluttered by such calls - but Jeff, didn't you remove all of them 
with the soft-irq patch? maybe that was after 2.6.15, in fact I do not get 
such a loop), but the extraordinarious number of munmap calls - each of them, 
if done after the munmapped page implies a distinct transiction to the Dom0 
Xen kernel. At that point of UML boot, this is nonsense; there are many 
series like this (but much longer), without any hole in each of them.
I can find a single such sequence in a 2.6.18 boot - and it seems a call to 
flush_tlb_kernel_range_common() (they do such things) - it should be modified 
to be like fix_range_common but passing down a different do_ops.

munmap(0xa2800000, 4096)                = 0 <0.000015>
mmap2(0xa2800000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x955) = 0xa2800000 <0.000013>
munmap(0xa2801000, 4096)                = 0 <0.000013>
mmap2(0xa2801000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x956) = 0xa2801000 <0.000013>
munmap(0xa2802000, 4096)                = 0 <0.000013>
mmap2(0xa2802000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x957) = 0xa2802000 <0.000011>
munmap(0xa2803000, 4096)                = 0 <0.000012>
mmap2(0xa2803000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x958) = 0xa2803000 <0.000012>
munmap(0xa2804000, 4096)                = 0 <0.000012>
mmap2(0xa2804000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x959) = 0xa2804000 <0.000012>
munmap(0xa2805000, 4096)                = 0 <0.000013>
mmap2(0xa2805000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x95a) = 0xa2805000 <0.000012>
munmap(0xa2806000, 4096)                = 0 <0.000012>
mmap2(0xa2806000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x95b) = 0xa2806000 <0.000012>
munmap(0xa2807000, 4096)                = 0 <0.000012>
mmap2(0xa2807000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x95c) = 0xa2807000 <0.000011>
munmap(0xa2808000, 4096)                = 0 <0.000013>
mmap2(0xa2808000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x95d) = 0xa2808000 <0.000012>
munmap(0xa2809000, 4096)                = 0 <0.000013>
mmap2(0xa2809000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x95e) = 0xa2809000 <0.000012>
munmap(0xa280a000, 4096)                = 0 <0.000012>
mmap2(0xa280a000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x95f) = 0xa280a000 <0.000012>
munmap(0xa280b000, 4096)                = 0 <0.000010>
mmap2(0xa280b000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x860) = 0xa280b000 <0.000011>
munmap(0xa280c000, 4096)                = 0 <0.000010>
munmap(0xa280d000, 4096)                = 0 <0.000012>
mmap2(0xa280d000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x894) = 0xa280d000 <0.000011>
munmap(0xa280e000, 4096)                = 0 <0.000012>
mmap2(0xa280e000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x895) = 0xa280e000 <0.000011>
munmap(0xa280f000, 4096)                = 0 <0.000009>
munmap(0xa2810000, 4096)                = 0 <0.000011>
mmap2(0xa2810000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x89c) = 0xa2810000 <0.000010>
munmap(0xa2811000, 4096)                = 0 <0.000010>
munmap(0xa2812000, 4096)                = 0 <0.000022>
mmap2(0xa2812000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x89d) = 0xa2812000 <0.000011>
munmap(0xa2813000, 4096)                = 0 <0.000010>
munmap(0xa2814000, 4096)                = 0 <0.000009>
mmap2(0xa2814000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED|MAP_FIXED, 
3, 0x89e) = 0xa2814000 <0.000011>
 

munmap(0xa2ae0000, 4096)                = 0 <0.000011>
munmap(0xa2ae1000, 4096)                = 0 <0.000010>
munmap(0xa2ae2000, 4096)                = 0 <0.000010>
munmap(0xa2ae3000, 4096)                = 0 <0.000010>
munmap(0xa2ae4000, 4096)                = 0 <0.000009>
munmap(0xa2ae5000, 4096)                = 0 <0.000009>
munmap(0xa2ae6000, 4096)                = 0 <0.000010>
munmap(0xa2ae7000, 4096)                = 0 <0.000010>
munmap(0xa2ae8000, 4096)                = 0 <0.000010>
munmap(0xa2ae9000, 4096)                = 0 <0.000010>
munmap(0xa2aea000, 4096)                = 0 <0.000009>
munmap(0xa2aeb000, 4096)                = 0 <0.000010>
munmap(0xa2aec000, 4096)                = 0 <0.000010>
munmap(0xa2aed000, 4096)                = 0 <0.000010>
munmap(0xa2aee000, 4096)                = 0 <0.000010>
munmap(0xa2aef000, 4096)                = 0 <0.000010>

>     >> Linux version 2.6.15 (mcr@marajade.sandelman.ca) (gcc version 4.1.2
>     >> 20060901 (pr                      erelease) (Debian 4.1.1-13)) #2
>     >> Thu Oct 19 17:29:21 EDT 2006 Built 1 zonelists
>
>     Blaisorblade> A strace -t (or whichever option shows the timings)
>     Blaisorblade> would help finding _where_
>     Blaisorblade> is the big pause...
>
>   I think you mean -T?
Actually -t prints timestamps, which can be more useful to look at "when are 
we?".
>   I ran:
>
> strace -f -o /tmp/east.trace -T
> /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux
> initrd=/0i/sandboxes/UMLPOOL/260ocf/umlbuild/initrd.uml
> umlroot=/0i/sandboxes/UMLPOOL/260ocf/umlbuild/east/root root=/dev/ram0 rw
> ssl=pty umid=east $net $UML_DEBUG_OPT $UML_east_OPT  init=/linuxrc $*
>
>   It never actually boots far enough with this option to print anything.

Child tracing stops UML at all (both UML and strace try to trace the same 
process, but they can't).

>   It was a big message (11MB), so, see
>      http://www.sandelman.ca/tmp/xen-uml-50.txt

> strace -o /tmp/east.trace -T
> /0i/sandboxes/UMLPOOL/260ocf/umlbuild/swan26/linux
> initrd=/0i/sandboxes/UMLPOOL/260ocf/umlbuild/initrd.uml
> umlroot=/0i/sandboxes/UMLPOOL/260ocf/umlbuild/east/root root=/dev/ram0 rw
> ssl=pty umid=east $net $UML_DEBUG_OPT $UML_east_OPT  init=/linuxrc $*
>
> without the child tracing, it makes it as it would normally, but we get
> nothing about what the child processes are doing, of course.
>
> I guess maybe that there are problems with the VT ALARMs on the XenU...
> Can we build a simpler test case for the Xen folks?

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
