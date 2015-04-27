Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1YmdNj-0006ER-MA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Apr 2015 07:23:07 +0000
Received: from mail-vn0-f47.google.com ([209.85.216.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YmdNi-0002db-NB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Apr 2015 07:23:07 +0000
Received: by vnbf1 with SMTP id f1so10846342vnb.5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 27 Apr 2015 00:23:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <553DCD8F.7030007@kot-begemot.co.uk>
References: <E1Xg9cr-0007LK-S6@www17.your-server.de> <5444DC3F.20601@nod.at>
	<1429905520.157088.6.camel@m3y3r.de>
	<CAFLxGvxq900TTuJ1jAfNx3xTrUTbE3vZkMZ_H=FvsPg3eck9ww@mail.gmail.com>
	<1430081853.603436.7.camel@m3y3r.de> <553D51F1.9010900@nod.at>
	<553DCD8F.7030007@kot-begemot.co.uk>
Date: Mon, 27 Apr 2015 09:23:01 +0200
Message-ID: <CAFLxGvwD0s37G0GGi3BzBgAAbWRK6AjEPBUXE2yzQChBXQyjFA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Apr 27, 2015 at 7:47 AM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> On 26/04/15 22:00, Richard Weinberger wrote:
>>
>>>> Can you give the attached patch a try?
>>>> Let's see if it proves my theory.
>>>> Looks like UML's clocksource needs fixing.
>>> Hi Richard,
>>>
>>> I did run this for an hour and did 4 suspend/resume cycles and it seems
>>> not to hang any more!
>> Yay!
>> BTW: Changing the host's time should also work for testing...
>>
>>> I'll test your other patch the next week, but AFAIU using clock_gettime
>>> should solve this hangs in a sane way.
>> Yep. I have no idea why UML is currently using gettimeofday() as clocksource,
>> this is completely bogus. ;-\
>
> It is even more bogus than you think - read time.c, it is using itimer
> on the virtual clock for all timers for extra spice so the timers are
> dependent on how much cpu it uses at any given time.

Yep.

> It does not need to be - I wrote a patchset for it to use posix timers
> and CLOCK_MONOTONIC. It went into Richard's queue ~ a year ago along
> with an epoll based IRQ controller and some vNIC drivers.
>
> Have not heard of it since.

mea culpa!
If I forget a patch, just shout at me.

Can you please rebase your patches against 4.1-rc1?
Such that I can merge them ASAP...

-- 
Thanks,
//richard

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

