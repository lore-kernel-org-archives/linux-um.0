Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1YmcFt-00062N-9S
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Apr 2015 06:10:57 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YmcFr-0001Wv-O2
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Apr 2015 06:10:57 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=falkor.sigsegv.cx) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Ymbtt-0007yD-AW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Apr 2015 05:48:13 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
	by falkor.sigsegv.cx with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1Ymbts-0006zr-Pn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Apr 2015 06:48:12 +0100
Message-ID: <553DCD8F.7030007@kot-begemot.co.uk>
Date: Mon, 27 Apr 2015 06:47:59 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <E1Xg9cr-0007LK-S6@www17.your-server.de>
	<5444DC3F.20601@nod.at>		<1429905520.157088.6.camel@m3y3r.de>		<CAFLxGvxq900TTuJ1jAfNx3xTrUTbE3vZkMZ_H=FvsPg3eck9ww@mail.gmail.com>	<1430081853.603436.7.camel@m3y3r.de>
	<553D51F1.9010900@nod.at>
In-Reply-To: <553D51F1.9010900@nod.at>
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
To: user-mode-linux-devel@lists.sourceforge.net

On 26/04/15 22:00, Richard Weinberger wrote:
>
>>> Can you give the attached patch a try?
>>> Let's see if it proves my theory.
>>> Looks like UML's clocksource needs fixing.
>> Hi Richard,
>>
>> I did run this for an hour and did 4 suspend/resume cycles and it seems
>> not to hang any more!
> Yay!
> BTW: Changing the host's time should also work for testing...
>
>> I'll test your other patch the next week, but AFAIU using clock_gettime
>> should solve this hangs in a sane way.
> Yep. I have no idea why UML is currently using gettimeofday() as clocksource,
> this is completely bogus. ;-\

It is even more bogus than you think - read time.c, it is using itimer
on the virtual clock for all timers for extra spice so the timers are
dependent on how much cpu it uses at any given time.

It does not need to be - I wrote a patchset for it to use posix timers
and CLOCK_MONOTONIC. It went into Richard's queue ~ a year ago along
with an epoll based IRQ controller and some vNIC drivers.

Have not heard of it since.

A.

>
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> One dashboard for servers and applications across Physical-Virtual-Cloud 
> Widest out-of-the-box monitoring support with 50+ applications
> Performance metrics, stats and reports that give you Actionable Insights
> Deep dive visibility with transaction tracing using APM Insight.
> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
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

