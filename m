Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Ugcq4-00012O-SW
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 May 2013 15:26:28 +0000
Received: from mail-wg0-f52.google.com ([74.125.82.52])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ugcq3-0004qk-QQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 May 2013 15:26:28 +0000
Received: by mail-wg0-f52.google.com with SMTP id z11so3720531wgg.31
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 May 2013 08:26:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAN-KreN2SQV6Y=6kV7U5DmhxDctQCn-ocJHL=Jst7i7uhE3eOg@mail.gmail.com>
References: <CAN-KreM81NDbqZ+XhxD_BjsM=VJz=+nJQ0B1fFTNk69cTSV_8g@mail.gmail.com>
	<CAFLxGvy_SvjdTJ97DtCFubUAPgJ4tSgZi8LFYNHEwN94cUZLFQ@mail.gmail.com>
	<CAN-KreN2SQV6Y=6kV7U5DmhxDctQCn-ocJHL=Jst7i7uhE3eOg@mail.gmail.com>
Date: Sun, 26 May 2013 17:26:21 +0200
Message-ID: <CAFLxGvzucTj7i_74VWstfSizWGR30auax6buSO47aSFbmFmtnA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] How is Preemption implemented in User Mode Linux?
To: Hopsing K <hopsingk@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sun, May 26, 2013 at 4:48 PM, Hopsing K <hopsingk@gmail.com> wrote:
> Hi, Ok, thanks. I got a little better picture. Is the following true:
> - The ptrace-ing parent waits in waitpid() called from within the
> userspace() loops.

Correct.

> - The SIGVTALRM comes in and the signal handler is executed, it'll end up
>   in scheduler_tick() and set need_resched() true.

Yeah. We use SIGVTALRM timer tick.

> - Because of the signal the waitpid() system call is interrupted and the
>   ptrace-ing parent returnes from waitpid().

Correct.

> - At the same time the ptraced userspace slave is stopped (is this the
>   case?) therefore the condition WIFSTOPPED(status) is true and
>   therefore you end up calling interrupt_end() ?

Correct.

--
Thanks,
//richard

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

