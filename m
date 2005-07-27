Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxowH-000859-4n	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jul 2005 09:39:25 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1DxowD-0001IY-HX
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jul 2005 09:39:25 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Slower system call with SMP
References: <29D15BBCA340DA4D8146D38B4924FC7A105059@zcarhxm0.corp.nortel.com>
In-Reply-To: <29D15BBCA340DA4D8146D38B4924FC7A105059@zcarhxm0.corp.nortel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507271806.50285.blaisorblade@yahoo.it>
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
Date: Wed, 27 Jul 2005 18:06:50 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Majid Salame <msalame@nortel.com>, "'stian@nixia.no'" <stian@nixia.no>

On Monday 30 May 2005 20:58, Majid Salame wrote:
> > UML uses multiple processes for it's buisness.

> With Skas UML is just one process as it appears on the Host, or do you mean
> something else.
No, it's at least two (+ possible service threads): one is the thread 
executing kernel code, which ptraces another thread which executes userspace 
code.
> >When host is
> > SMP, these can be mapped to different cpu's, and when
> > interprocess stuff is to occure, cpu's have to sync.
It's not just interprocess comunication. Those two threads could be running on 
two different processors (which will happen very likely, I fear, if UML is 
the only thing running, and can happen even without this - I don't think 
scheduler optimizations consider ptrace() as something needing to join 
threads together).

> I saw the syscall about 300% slower, it does not make sense due to
> interprocess.
> IT should not be that slow, unless missing UML implementation
I think it could, if the two threads run on different processors. Luckily, you 
can stop the host kernel from doing that: there should be a control option 
in /proc/<pid>, something like cpus_allowed.

Ok, let's assume you talk about SKAS (I'm not expert in TT implementation, 
should check a couple of things, but you said you use SKAS).

Well, it makes sense. In late days I've been studying signal delivery code, 
and for UML operations, to have a page fault in the guest, what happens is 
that the guest takes a SIGSEGV. That signal must be intercepted by the UML 
kernel thread. Sadly, this is largely suboptimal in Linux. In fact, you have, 
at signal delivery time, to wake up the guest thread (possibly via 
inter-processor comunication, which is an IPI), which will then have to wake 
up its tracer (and if that's on a different CPU, that's through an IPI), and 
then get back to wake up the thread itself.

> > Also, some few kernel things is slower on SMP, while
> > user-space things that are not related, and multithreaded
> > apps run faster.

> > Stian

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
