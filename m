Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Yukg6-0001Df-Fs
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 May 2015 16:47:38 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Yukg5-0005kK-HB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 May 2015 16:47:38 +0000
Message-ID: <555B691C.2010303@kot-begemot.co.uk>
Date: Tue, 19 May 2015 17:47:24 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1431854739.603436.45.camel@m3y3r.de>	<555B62A9.9000902@kot-begemot.co.uk>
	<CAFLxGvycaHXq52okh+nfihRqAm26uZG=Ax=G6=zfA5DwEJfDWw@mail.gmail.com>
In-Reply-To: <CAFLxGvycaHXq52okh+nfihRqAm26uZG=Ax=G6=zfA5DwEJfDWw@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH] um: Switch clocksource to hrtimers
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 19/05/15 17:39, Richard Weinberger wrote:
> On Tue, May 19, 2015 at 6:19 PM, Anton Ivanov
> <anton.ivanov@kot-begemot.co.uk> wrote:
>> Same story.
>>
>> Overall works quite well, the moment I give it the "dselect upgrade
>> test" the userspace hangs.
>>
>> Kernel continues to work - forwarding, icmp, uml_mconsole are fine.
> Do you know where it hangs?
> Maybe the kernel does not get any scheduler tick and does not schedule a task..,

Kernel continues to get ticks, timers increment, io also works.

If I strace the kernel I see a mix of SIGALRM (or in the oder version 
-USR2), SIGIO and SIGCHLD. Nothing out of the ordinary.

Uml mconsole works. I cannot get meaningful information because trying 
to invoke backtraces I get "SIGSEGV in SIGSEGV handler" for all 
processes. Memory looks OK too - 500MB+ free on a 1GB UML.

Syncronous vs asynchronous FS does not change it so it is not a variety 
of the writeout bug.

If I could get a bt for the userspace task and/or its stub we could have 
nailed it. I suspect it is spinning in skas/process.c for some reason. 
No idea why, but it takes 100% CPU.

A.

>


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

