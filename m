Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1ZmKB7-0003hK-9W
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Oct 2015 11:25:05 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZmKB5-000257-Mq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Oct 2015 11:25:05 +0000
Date: Wed, 14 Oct 2015 13:22:23 +0200
Message-ID: <049772dd-6225-4782-a5ac-007f892417fa@email.android.com>
In-Reply-To: <561E1EF7.1060505@kot-begemot.co.uk>
From: Thomas Meyer <thomas@m3y3r.de>
MIME-Version: 1.0
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

Am 14.10.2015 11:23 vorm. schrieb Anton Ivanov <anton.ivanov@kot-begemot.co.uk>:
>
> On 14/10/15 09:25, Thomas Meyer wrote: 
> > Hello everyone, 
> > 
> > I would like to finish this patch, but I'm currently very busy. Sorry! 
>
> No worries :) I am barely keeping my head above water too :) 
>
> Is the most up-to-date revision the one you last posted to the list?

Yes,the post on the list was the latest version.

> If 
> you have a more up-to-date one, please post it even if it does not patch 
> cleanly and needs work. I will work on it. 
>
> A. 
>
> > 
> > Anton: it would be great if you could finish this patch! Much appreciated! 
> > 
> > With kind regards 
> > Thomas 
> > 
> > Am 14.10.2015 8:12 vorm. schrieb Anton Ivanov <anton.ivanov@kot-begemot.co.uk>: 
> >> Thomas, I need to know if you have the time-slices for this or I should 
> >> take over and finish it. 
> >> 
> >> In addition to what Richard said I have the epoll based IRQ controller 
> >> and high-performance network pipeline which depend on it in the queue. 
> >> 
> >> Brgds, 
> >> 
> >> A. 
> >> 
> >> On 13/10/15 22:45, Richard Weinberger wrote: 
> >>> On Tue, Aug 18, 2015 at 6:04 PM, Thomas Meyer <thomas@m3y3r.de> wrote: 
> >>>> Am 15.08.2015 10:15 vorm. schrieb Richard Weinberger <richard@nod.at>: 
> >>>>> Am 09.08.2015 um 19:53 schrieb Thomas Meyer: 
> >>>>>> Switch the UML clocksource from interval timers to posix interval timers and 
> >>>>>> move to a monotonic timer. 
> >>>>>> 
> >>>>>> This fixes suspend&resume related timer issues and improves network performance 
> >>>>>> as TCP state machines are now fed with the correct time; also correct QoS and 
> >>>>>> traffic shaping. 
> >>>>> The patch is rather big. Please describe in your commit message how exactly 
> >>>>> it works and why. 
> >>>>> It changes many internals. 
> >>>> Will do so! 
> >>> Can I get an updated version of that patch? 
> >>> I really want to merge it in the next merge window. 
> >>> 
> >> 
> >> ------------------------------------------------------------------------------ 
> >> _______________________________________________ 
> >> User-mode-linux-devel mailing list 
> >> User-mode-linux-devel@lists.sourceforge.net 
> >> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel 
>
------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

