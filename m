Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ZONtX-0000b7-Ly
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 10:31:59 +0000
Received: from mail-ob0-f180.google.com ([209.85.214.180])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZONtW-0002ar-UI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 10:31:59 +0000
Received: by obbhe7 with SMTP id he7so9966256obb.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 09 Aug 2015 03:31:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1436874312.3096.6.camel@m3y3r.de>
References: <1436874312.3096.6.camel@m3y3r.de>
Date: Sun, 9 Aug 2015 12:31:53 +0200
Message-ID: <CAFLxGvyFmg8r=jYo1TAwFonNvMyeyoOV=gUutXJJFNSQ5zSh7A@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH v2] um: Switch clocksource to hrtimers
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Jul 14, 2015 at 1:45 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Switch the UML clocksource from interval timers to posix interval timers and
> move to a monotonic timer.
>
> This fixes suspend&resume related timer issues and improves network
> performance
> as TCP state machines are now fed with the correct time; also correct
> QoS and
> traffic shaping.
>
> v2:
> Fixed a hang in copy_context_skas0() by disabling signals.

Sorry for the long delay.
I wanted to try the patch but it does not apply,
your mailer broke some lines.
Can you please resend using git send-email?

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

