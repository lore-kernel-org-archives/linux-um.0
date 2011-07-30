Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1QnCbH-0006T7-TB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2011 16:41:19 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QnCbG-0004tO-Tu
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2011 16:41:19 +0000
Received: by vxh2 with SMTP id 2so5046186vxh.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 30 Jul 2011 09:41:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1312042478-26012-1-git-send-email-zdevai@gmail.com>
References: <1312042478-26012-1-git-send-email-zdevai@gmail.com>
Date: Sat, 30 Jul 2011 18:41:12 +0200
Message-ID: <CAFLxGvyGQ3Ao4BLHzuZOraOTf=PMFG67OgjTR3J8_-dFp_tf8w@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH] Remove remaining references of
	CONFIG_GENERIC_TIME
To: Zoltan Devai <zdevai@gmail.com>
Cc: chris@zankel.net, linux-am33-list@redhat.com, trivial@kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-arm-kernel@lists.infradead.org

On Sat, Jul 30, 2011 at 6:14 PM, Zoltan Devai <zdevai@gmail.com> wrote:
> Commit 592913ecb87a9e06f98ddb55b298f1a66bf94c6b has killed off any
> use of this config option long ago.
>
> Signed-off-by: Zoltan Devai <zdevai@gmail.com>

For arch/um/:
Acked-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

