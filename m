Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <theartlav@gmail.com>) id 1bLc0J-0003QK-8n
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Jul 2016 20:04:03 +0000
Received: from mail-yw0-f174.google.com ([209.85.161.174])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bLc0H-0003yY-Gg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Jul 2016 20:04:03 +0000
Received: by mail-yw0-f174.google.com with SMTP id l125so45389174ywb.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 08 Jul 2016 13:04:01 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0JDRgNGC0ZHQvCDQm9C40YLQstC40L3QvtCy0LjRhw==?=
	<theartlav@gmail.com>
Date: Fri, 8 Jul 2016 23:03:55 +0300
Message-ID: <CAJRVQkAexcnHwnRb+uKgr_RQNdr2s-GVf5x-SjJivSHwx3Kxiw@mail.gmail.com>
Subject: [uml-devel] ubd is slow. I want to try fixing it
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
To: user-mode-linux-devel@lists.sourceforge.net

Greetings.

Apparently, ubd is too slow for practical use.
I'm getting 0.8 Mb/s write speed, while hostfs does 25 Mb/s (and on
the host itself it's similar).
This is rather frustrating for such a great project as UML is, and i'd
like to try fixing this.

So, two questions.

First, am i missing something?
Is it actually normal for ubd to be that slow?
I looked around, and apparently it is slow due to design. There even
were some ancient patches to try to fix that.

Second, why is this problem hard?
This was going on for over a decade, and no one made a better version,
which implies a hard problem.
I would love to hear from someone who is familiar with how the code
works, about what the problems are (instead of hitting my head against
them later).
Specifically, why use the IO thread?
Hostfs seem to work just fine with calling the native read/write directly.

------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

