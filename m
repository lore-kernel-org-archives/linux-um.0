Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1aIIMi-0002Ys-FY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Jan 2016 15:57:12 +0000
Received: from mail-ob0-f196.google.com ([209.85.214.196])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aIIMh-0005f7-Nu
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Jan 2016 15:57:12 +0000
Received: by mail-ob0-f196.google.com with SMTP id tr5so26269079obc.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 10 Jan 2016 07:57:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1450724041-708451-1-git-send-email-aivanov@brocade.com>
References: <1450724041-708451-1-git-send-email-aivanov@brocade.com>
Date: Sun, 10 Jan 2016 16:57:06 +0100
Message-ID: <CAFLxGvyBqp5SKxE9tkokiL7PEz8sqrgoiQ2PxCfJNzkzY=pB5Q@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] [PATCH 1/2] Update UBD to use pread/pwrite family
	of functions
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
To: Anton Ivanov <aivanov@brocade.com>
Cc: Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Dec 21, 2015 at 7:54 PM, Anton Ivanov <aivanov@brocade.com> wrote:
> This decreases the number of syscalls per read/write by half.
>
> Signed-off-by: Anton Ivanov <aivanov@brocade.com>

Applied!

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

