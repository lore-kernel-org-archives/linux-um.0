Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1a0zXm-0008M4-4P
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Nov 2015 22:25:06 +0000
Received: from mail-oi0-f45.google.com ([209.85.218.45])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a0zXl-000843-6Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Nov 2015 22:25:06 +0000
Received: by oige206 with SMTP id e206so141495956oig.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 23 Nov 2015 14:24:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <564F6ADE.8030701@kot-begemot.co.uk>
References: <1446996012-31444-1-git-send-email-aivanov@brocade.com>
	<564F6ADE.8030701@kot-begemot.co.uk>
Date: Mon, 23 Nov 2015 23:24:59 +0100
Message-ID: <CAFLxGvzjOVC9aNcNurVOS4w-ESBjdiX2ufd6rcmpBLu-fRPrXQ@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH] Update UBD to use pread/pwrite family of
	functions
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Nov 20, 2015 at 7:47 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> Hi list, hi Richard.
>
> Have you had time to review this one? I think it is not contentious - it
> is something QEMU has been doing for a very long time now. It also gives
> a measurable speed up, especially for random IO.
>
> I am going to hold off on the rest of the ubd patches because they bulk
> up the transactions. This is dangerous if you end up in a reentrant
> situation.

Sorry for the delay.
The patch looks useful! Thanks a lot!

Please CC me in future such that patches don't get lost.
I handle CC'ed mails with higher priority.
(This is my way to deal with the LKML storm ;))

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741551&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

