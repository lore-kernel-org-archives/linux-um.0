Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ZKCce-0007DC-OL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 21:41:16 +0000
Received: from mail-ob0-f178.google.com ([209.85.214.178])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZKCcd-0003jT-Vn
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Jul 2015 21:41:16 +0000
Received: by obnw1 with SMTP id w1so94510313obn.3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 28 Jul 2015 14:41:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <034b3bc80c078d8a8f7b2850924c033b@hilses.de>
References: <3faa85268de72e64ff74175f2cf74021@hilses.de>
	<1435571432-21125-1-git-send-email-hwhilse@gmail.com>
	<1435571432-21125-2-git-send-email-hwhilse@gmail.com>
	<034b3bc80c078d8a8f7b2850924c033b@hilses.de>
Date: Tue, 28 Jul 2015 23:41:10 +0200
Message-ID: <CAFLxGvynqeDp52ne_8f=gshQuLu902LDHqn8VmsU1S+FihZ8Ug@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH v2] um: Do not rely on libc to provide
	modify_ldt()
To: Hans-Werner Hilse <hwhilse@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Jul 27, 2015 at 1:30 PM, Hans-Werner Hilse <hwhilse@gmail.com> wrote:
> Hi,
>
> Richard, might I ping you about this one?
>
> Reading other mails on this ML, I reckon' you're quite busy - no
> problem, it's not really critical anyway. Just want to make sure the
> updated patch got noticed.

Thanks for the heads up! Your patch looks good, it will be part if the next
pull request (target -rc5).

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

