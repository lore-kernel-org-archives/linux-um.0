Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZRiqa-0006KI-Vs
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 15:30:44 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZRiqY-0006YP-KH
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 15:30:44 +0000
Message-ID: <55D34F8C.5030702@kot-begemot.co.uk>
Date: Tue, 18 Aug 2015 16:30:20 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1439142802.559700.2.camel@m3y3r.de>	<55CEF513.90604@nod.at>	<55CF6886.2020100@kot-begemot.co.uk>
	<CAFLxGvzqmw-fO=nZ19LfBjWyr=ub1CnayyjJYtj_j2AbrPSY2w@mail.gmail.com>
In-Reply-To: <CAFLxGvzqmw-fO=nZ19LfBjWyr=ub1CnayyjJYtj_j2AbrPSY2w@mail.gmail.com>
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

If Thomas is busy I can pick it up ~ middle of next week and finish it.

A.

On 18/08/15 10:34, Richard Weinberger wrote:
> On Sat, Aug 15, 2015 at 6:27 PM, Anton Ivanov
> <anton.ivanov@kot-begemot.co.uk> wrote:
>> On 15/08/15 09:15, Richard Weinberger wrote:
>>> Am 09.08.2015 um 19:53 schrieb Thomas Meyer:
>>>> Switch the UML clocksource from interval timers to posix interval timers and
>>>> move to a monotonic timer.
>>>>
>>>> This fixes suspend&resume related timer issues and improves network performance
>>>> as TCP state machines are now fed with the correct time; also correct QoS and
>>>> traffic shaping.
>>> The patch is rather big. Please describe in your commit message how exactly
>>> it works and why.
>>> It changes many internals.
>> Tom, I will be happy to assist with the drafting, feel free to take the
>> draft conversation off-list until we are ready.
> BTW: I'm definitely willing to merge this patch, I you miss the merge window
> I can also merge it in -rc2 or -rc3 as it fixes some nasty issues.
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

