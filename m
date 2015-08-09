Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1ZOUo6-0004Ff-HB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 17:54:50 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZOUo2-0000D0-Tr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 17:54:50 +0000
Message-ID: <1439142879.559700.3.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 09 Aug 2015 19:54:39 +0200
In-Reply-To: <CAFLxGvyFmg8r=jYo1TAwFonNvMyeyoOV=gUutXJJFNSQ5zSh7A@mail.gmail.com>
References: <1436874312.3096.6.camel@m3y3r.de>
	<CAFLxGvyFmg8r=jYo1TAwFonNvMyeyoOV=gUutXJJFNSQ5zSh7A@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH v2] um: Switch clocksource to hrtimers
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am Sonntag, den 09.08.2015, 12:31 +0200 schrieb Richard Weinberger:
> On Tue, Jul 14, 2015 at 1:45 PM, Thomas Meyer <thomas@m3y3r.de> 
> wrote:
> > Switch the UML clocksource from interval timers to posix interval 
> > timers and
> > move to a monotonic timer.
> > 
> > This fixes suspend&resume related timer issues and improves network
> > performance
> > as TCP state machines are now fed with the correct time; also 
> > correct
> > QoS and
> > traffic shaping.
> > 
> > v2:
> > Fixed a hang in copy_context_skas0() by disabling signals.
> 
> Sorry for the long delay.
> I wanted to try the patch but it does not apply,
> your mailer broke some lines.
> Can you please resend using git send-email?
> 
Hi,

Sorry!

I did rebase and resend. Hopefully evolution did not messup git format
-patch this time. Please check again.

with kind regards
thomas


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

