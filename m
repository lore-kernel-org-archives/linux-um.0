Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UgW0B-0007mU-SU
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 May 2013 08:08:27 +0000
Received: from mail-we0-f179.google.com ([74.125.82.179])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UgW08-0000Xv-D2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 May 2013 08:08:27 +0000
Received: by mail-we0-f179.google.com with SMTP id m46so3680398wev.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 May 2013 01:08:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN-KreM81NDbqZ+XhxD_BjsM=VJz=+nJQ0B1fFTNk69cTSV_8g@mail.gmail.com>
References: <CAN-KreM81NDbqZ+XhxD_BjsM=VJz=+nJQ0B1fFTNk69cTSV_8g@mail.gmail.com>
Date: Sun, 26 May 2013 10:08:17 +0200
Message-ID: <CAFLxGvy_SvjdTJ97DtCFubUAPgJ4tSgZi8LFYNHEwN94cUZLFQ@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] How is Preemption implemented in User Mode Linux?
To: Hopsing K <hopsingk@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sun, May 26, 2013 at 1:01 AM, Hopsing K <hopsingk@gmail.com> wrote:
> I'm running UML in Linux 3.2 (Debian) in SKAS0 mode. I compiled UML with
> defconfig.
> Now I try to  poked in the source to figure out how Preemption is done
> in UML. I came so far to understand that there is a ptrace-ing parent and
> for each UML process a userspace-slave process on the host:
> arch/um/os-Linux/skas/process.c:userspace(). This routine also has the jump
> to
> interrupt_end() which calls schedule(). I saw that SIGALRM handler is
> installed
> for that ptrace-ing parent and the userspace() loop catches SIGALRM for the
> traced slave. However I didnt see it being called. Only the ptrace-ing
> parent
> gets SIGALRM and the signal handler arch/um/os-Linux/signal.c:hard_handler()
> is called directly. With my understanding there must be some connection
> between
> hard_handler() and the call to interrupt_end() inside the userspace() loop,
> but I
> cannot find any, I cannot figure out how Preemption is initiated when the
> SIGALRM arrives.
> I wonder: Is all kernel code implementing cooperative threading ? Is there
> no preemption when in kernel space?
> If a userspace process runs a loop "while(1);" and therefore never calls out
> to the kernel, how can another process been sheduled? The ptrace-ing
> parent's
> userspace() loop will never get control back.
> I can also see a variable userspace_pid[0] that I assume is the active
> slave-process and that there is only one such process running at any time,
> the others are stopped?
> I'm really curious how Preemption is done internally in UML, any insight
> would
> be welcome.
> Some question at the side: can you call longjmp from within a signal
> handler? My first assumption was that UML uses longjmp from within
> the SIGALRM handler to implement preemption, butseems not to .
> -- Thanks Konrad

UML installs a SIGVTALRM handler which feeds the TIMER_IRQ.
In the generic TIMER_IRQ handler Linux runs scheduler_tick() at some point.

Thanks,
//richard

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

