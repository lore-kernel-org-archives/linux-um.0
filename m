Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1aIIQ5-0003Tl-0A
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Jan 2016 16:00:41 +0000
Received: from mail-oi0-f67.google.com ([209.85.218.67])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aIIQ3-0005ji-GV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Jan 2016 16:00:40 +0000
Received: by mail-oi0-f67.google.com with SMTP id a202so2775625oib.3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 10 Jan 2016 08:00:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56784D28.8090103@kot-begemot.co.uk>
References: <1450724041-708451-1-git-send-email-aivanov@brocade.com>
	<1450724041-708451-2-git-send-email-aivanov@brocade.com>
	<56784D28.8090103@kot-begemot.co.uk>
Date: Sun, 10 Jan 2016 17:00:33 +0100
Message-ID: <CAFLxGvzKv7jjiid8eKa5=-=PmS-mdWH=PZZsipXOvDG1r-SkWg@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] [PATCH 2/2] Bulk IO Transaction support part 1
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

On Mon, Dec 21, 2015 at 8:04 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> Hi list, hi Richard,
>
> This rather primitive patchset pushes disk IO by ~ 15%.
>
> dd to /dev/null on a host memory cached 16G sparse disk image with
> ubuntu on it goes from 512MB/s on my machine to 580MB/s.
>
> Part 2 will be ring buffers and read/write poll loop in the io_thread as
> well as elimination of "partial read/write" workarounds. While it does
> not push disk benchmarks a lot it makes UML more responsive.
>
> Part 3 will be merging adjacent IO transactions (by file location) via
> vector IO. This pushes trhoughput even further by quite a bit.
>
> While I can try to submit all of that in one go, I'd rather submit it in
> chunks so it is easier to review even if this will result in patch churn
> (the whole do_safe_read malarkey will bite the bullet once part 2 is out).

Is this already stable enough for this merge window?
At least checkpatch.pl dislikes part 1. :(

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

