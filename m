Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1bcJRX-00021g-Et
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2016 21:41:11 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bcJRW-0003wS-8q
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2016 21:41:11 +0000
References: <CAFLxGvzB=WGNEdNJVvPpQLpwCqT6oNcvEQnyT2xk0Jv2L3FBaA@mail.gmail.com>
	<1471446611-16250-1-git-send-email-aryabinin@virtuozzo.com>
	<CACT4Y+bEnGV0X1MeGvdZM1VWqr25f61GyVqRKvQO46UGpE0VhA@mail.gmail.com>
	<995ff767-9220-f9c8-c052-2b717cc7e91d@virtuozzo.com>
	<CACT4Y+bMvLrg_PBrGYPok3j8Y90m2FNzTY9-LuRNNGR_3FgifA@mail.gmail.com>
	<627a7126-87e6-0a89-19c5-612c5fb9d18f@virtuozzo.com>
	<e9536af2-7e69-8a53-96d0-7a7a92dbea31@nod.at>
	<3bc79e3a-9604-3d61-fc68-443d8d8a70b6@virtuozzo.com>
	<CACT4Y+a+MagkN-sWkiVjYdRrvfnYmB8ewYsDBU-PcAD0FzQtdA@mail.gmail.com>
	<7ebc07c8-83fd-f5f7-4f80-f53f44ae4c55@nod.at>
	<496b07cd-2737-e828-3568-f319b9681386@virtuozzo.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <e3c5367b-0225-915a-31dd-67ab15160de7@nod.at>
Date: Tue, 23 Aug 2016 23:40:51 +0200
MIME-Version: 1.0
In-Reply-To: <496b07cd-2737-e828-3568-f319b9681386@virtuozzo.com>
Subject: Re: [uml-devel] [PATCH] UML: don't discard .text.exit section
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
To: Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: stable <stable@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On 23.08.2016 11:59, Andrey Ryabinin wrote:
>> Andrey, shall I carry this patch through the UML tree or
>> do you have something else in mind?
>>
> 
> Take it in the UML tree please.

Ok! Applied to -next.

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

