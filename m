Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1adkxx-0007HF-8g
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2016 20:44:21 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1adkxv-0008S7-No
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2016 20:44:21 +0000
References: <1457274987-20078-1-git-send-email-elicooper@gmx.com>
	<1457274987-20078-2-git-send-email-elicooper@gmx.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56E08B1A.4080809@nod.at>
Date: Wed, 9 Mar 2016 21:44:10 +0100
MIME-Version: 1.0
In-Reply-To: <1457274987-20078-2-git-send-email-elicooper@gmx.com>
Subject: Re: [uml-devel] [PATCH 1/3] um: extend _fpstate to _xstate
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
To: Eli Cooper <elicooper@gmx.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Hi!

Am 06.03.2016 um 15:36 schrieb Eli Cooper:
> Extends _fpstate to _xstate, in order to hold AVX/YMM registers.
> Due to increased frame size, compilers might emit some warnings.

Hmm, this needs rework. Having everything on the stack is not good.
Can you also create a selftest such that this bug cannot happen again?

Thanks,
//richard

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

