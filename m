Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1aIIJa-0002Rj-V3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Jan 2016 15:53:58 +0000
Received: from mail-ob0-f171.google.com ([209.85.214.171])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aIIJa-0006zx-5B
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Jan 2016 15:53:58 +0000
Received: by mail-ob0-f171.google.com with SMTP id bx1so362568437obb.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 10 Jan 2016 07:53:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5677E8C9.7040904@kot-begemot.co.uk>
References: <564F0C6D.8000806@kot-begemot.co.uk>
	<CAFLxGvywFjhSwUAsAGtV3FQLvFCS+UaP4rJCDzbvZ3p+4nvjTQ@mail.gmail.com>
	<566A73FF.6080306@kot-begemot.co.uk> <566A8667.1040808@nod.at>
	<566AB280.4020109@kot-begemot.co.uk> <566B1812.3080002@nod.at>
	<5677E8C9.7040904@kot-begemot.co.uk>
Date: Sun, 10 Jan 2016 16:53:52 +0100
Message-ID: <CAFLxGvxYJkFJstRVAb=oy0DAwFd4JifYj++P3KQEqmDwV_r8ig@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] IRQ handler reentrancy
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Dec 21, 2015 at 12:55 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> Patch in your queue, current code looks OK.
>
> I will try to assemble the full ubd acceleration sequence of patches
> this afternoon to submit that as well.

Applied. Let's see how much will explode. :-)

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

