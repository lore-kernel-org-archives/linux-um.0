Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1YmTcW-0005iK-P8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Apr 2015 20:57:44 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YmTcU-0006Ov-1e
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Apr 2015 20:57:44 +0000
Message-ID: <1430081853.603436.7.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 26 Apr 2015 22:57:33 +0200
In-Reply-To: <CAFLxGvxq900TTuJ1jAfNx3xTrUTbE3vZkMZ_H=FvsPg3eck9ww@mail.gmail.com>
References: <E1Xg9cr-0007LK-S6@www17.your-server.de> <5444DC3F.20601@nod.at>
	<1429905520.157088.6.camel@m3y3r.de>
	<CAFLxGvxq900TTuJ1jAfNx3xTrUTbE3vZkMZ_H=FvsPg3eck9ww@mail.gmail.com>
Mime-Version: 1.0
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
Subject: Re: [uml-devel] [UM] Long loop in __getnsdayoftime() after resume
 from ram
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Am Sonntag, den 26.04.2015, 20:32 +0200 schrieb Richard Weinberger:
> On Fri, Apr 24, 2015 at 9:58 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> > Am Montag, den 20.10.2014, 11:56 +0200 schrieb Richard Weinberger:
> >> Am 20.10.2014 um 11:51 schrieb Thomas Meyer:
> >> >> Hmm, does this always happen?
> >> >
> >> > Yes, my single core system seems to trigger this every time after resume from ram.
> >>
> >> What is your host kernel?
> >>
> >> >> At least on my notebook it did not happen. I've started an UML yesterday
> >> >> suspended it and after more than 12h it worked fine today.
> >> >>
> >> >> BTW: Do you see the issue also then freezing UML using the freezer cgroup?
> >> >
> >> > I'm not sure what do you mean by this. Do I need to enable some special configs for this in the host or uml kernel?
> >>
> >> Create on the host side a new freezer cgroup, put UML into it and freeze/thaw it.
> >> i.e. mkdir /sys/fs/cgroup/freezer/uml ; echo <pid of a shell> >  /sys/fs/cgroup/freezer/uml/tasks.
> >> In the said shell run UML and then freeze it using echo FROZEN > /sys/fs/cgroup/freezer/uml/freezer.state.
> >> Later thaw it: echo THAWED > /sys/fs/cgroup/freezer/uml/freezer.state
> >>
> >
> > Sadly, this also happens with a cgroup freezer group :-(
> >
> > bt
> > #0  __iter_div_u64_rem (remainder=<optimized out>, divisor=<optimized out>, dividend=14641577537827850536) at include/linux/math64.h:12
> > 7
> > #1  timespec_add_ns (ns=<optimized out>, a=<optimized out>) at include/linux/time.h:235
> > #2  __getnstimeofday64 (ts=0xffffffffffffffff) at kernel/time/timekeeping.c:658
> > #3  0x0000000060098a00 in getnstimeofday64 (ts=<optimized out>) at kernel/time/timekeeping.c:678
> > #4  0x0000000060098a4c in do_gettimeofday (tv=0xab359e50) at kernel/time/timekeeping.c:897
> > #5  0x0000000060090d66 in SYSC_gettimeofday (tz=<optimized out>, tv=<optimized out>) at kernel/time/time.c:107
> > #6  SyS_gettimeofday (tv=-1, tz=2097152000) at kernel/time/time.c:102
> > #7  0x0000000060032cf3 in handle_syscall (r=0xa39db9e8) at arch/um/kernel/skas/syscall.c:35
> > #8  0x000000006004a247 in handle_trap (local_using_sysemu=<optimized out>, regs=<optimized out>, pid=<optimized out>) at arch/um/os-Lin
> > ux/skas/process.c:174
> > #9  userspace (regs=0xa39db9e8) at arch/um/os-Linux/skas/process.c:399
> > #10 0x000000006002f125 in fork_handler () at arch/um/kernel/process.c:149
> > #11 0x0000000000000000 in ?? ()
> >
> > It seems as only very few people running UML kernels and suspend their host systems...
> >
> > Any ideas?
> 
> Can you give the attached patch a try?
> Let's see if it proves my theory.
> Looks like UML's clocksource needs fixing.

Hi Richard,

I did run this for an hour and did 4 suspend/resume cycles and it seems
not to hang any more!

I'll test your other patch the next week, but AFAIU using clock_gettime
should solve this hangs in a sane way.

Thanks for your support.

kind regards
thomas


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

