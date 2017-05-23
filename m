Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1dDFVg-0006hZ-1C
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2017 19:30:24 +0000
Received: from mail-oi0-f53.google.com ([209.85.218.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dDFVe-0000zT-Va
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2017 19:30:24 +0000
Received: by mail-oi0-f53.google.com with SMTP id b204so214998894oii.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 23 May 2017 12:30:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1dDE2Y-0002Kh-CQ@www17.your-server.de>
References: <E1dDE2Y-0002Kh-CQ@www17.your-server.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 23 May 2017 21:30:17 +0200
Message-ID: <CAFLxGvxto5SDA+Ty-G7vc_uEf1dmcN7Ea0r3cohgc2eAKz7SWQ@mail.gmail.com>
Subject: Re: [uml-devel] um: xstate changes breaks my UML setup
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
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Thomas,

On Tue, May 23, 2017 at 7:56 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Hi,
>
>
>
> to make UML work again with the latest Fedora Installation I Need to revert
> those commits:
>
> b6024b21fec8367ef961a771cc9dde31f1831965
>
> a78ff1112263fdd871d3506dbcff44f6f12e8423
>
>
>
> A reproducer script/config is available here:
>
> https://github.com/thomasmey/uml/blob/master/fedora-26-install.sh

Please start using the CC feature of your mailer. :-)

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

