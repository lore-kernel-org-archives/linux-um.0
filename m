Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEtwo-0003Of-AY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 11:22:02 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CEtwM-0006Sv-VD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 11:22:02 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] slow execution in uml?
References: <BAY22-F38Fm15k4R9xC00023711@hotmail.com>
In-Reply-To: <BAY22-F38Fm15k4R9xC00023711@hotmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410052021.25170.blaisorblade_spam@yahoo.it>
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
Date: Tue, 5 Oct 2004 20:21:25 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Young K <young_uml@hotmail.com>

On Monday 04 October 2004 23:35, Young K wrote:
> hi, folks,
>
> i was comparing uml network performance with genuine linux. the experiment
> i did was to insert time-stamping code in network stack, and see how slower
> uml is. i was sending 32-byte udp packets to another machine every 10 msec,
> and used rdtsc to measure the elapsed cpu cycles between sendto() and
> nf_hook_slow() (which is called inside ip_build_xmit()).

> what i found was that it took around 29,000 cycles from sendto() to
> nf_hook_slow() in uml whereas only 2,000 cycles in genuine linux. it looks
> like a big difference. but i think it's purely code execution without any
> I/O operation between sendto() to nf_hook_slow(). then, why is it so slow
> in uml? is there any possible factors that make uml slower?

> (more cache 
> misses?)

What is slower in UML (a lot slower) is (at least):
- syscall execution
- page fault

At a first glance, I wouldn't be surprised if the syscall itself took 26,000 
cycles (they are rdtsc units, right?). Please check by running either 
getpid() or a non-existing syscall (with the _syscall0 macro from 
<asm/unistd.h>). With SKAS mode and without SYSEMU for each syscall, 4 host 
context switches are needed. This number drops down to 2 with SYSEMU, and 
pure getpid() loops show 66% improvement from this. I also remember one test 
(I think they were ByteBench result against an host system) where the exec() 
throughput was various order of magnitude lower than the host, as the syscall 
throughput.

> i used 2.4.22 for guest os(tt mode)

Well, using TT mode is a sure recipe for slow execution. And, quite frankly, 
almost nobody cares about TT mode performance. It's too much slower. Don't 
ask me why (I've read on the web-site that signal delivery is very slow, even 
slower than a context switch, so TT mode is slower than SKAS, even if in TT 
mode there are no context switches at all). So the syscall cost is your 
problem. Try to run anything which is purely userspace, and if it does not do 
a lot of page faults (which are VERY slow), it will run at full speed.

If you want to do any test in SKAS mode, they are welcome. For the host patch, 
go to http://www.user-mode-linux.org/~blaisorblade/

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
