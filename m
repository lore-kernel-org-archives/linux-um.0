Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <theartlav@gmail.com>) id 1bM1hT-0000Iy-QZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jul 2016 23:30:19 +0000
Received: from mail-yw0-f196.google.com ([209.85.161.196])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bM1hT-0003A5-27
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jul 2016 23:30:19 +0000
Received: by mail-yw0-f196.google.com with SMTP id i12so10787034ywa.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 09 Jul 2016 16:30:19 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0JDRgNGC0ZHQvCDQm9C40YLQstC40L3QvtCy0LjRhw==?=
	<theartlav@gmail.com>
Date: Sun, 10 Jul 2016 02:30:13 +0300
Message-ID: <CAJRVQkDmE4PTPAU8L524LrbeumhwSMyLzrQ78cOWq16YsUZY7Q@mail.gmail.com>
Subject: Re: [uml-devel] ubd is slow. I want to try fixing it
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

Ah, thanks.
I rebuilt it with sync off, and the performance jumped up to something
close to the host one.
Would that actually put ext4 guest fs in any danger in case of a crash?

Sadly, it developed that the 64bit UML can't run 32bit programs, which
is a deal breaker to me.
While it's something that was working at one point and apparently also
fixable with some effort, the sum total of problems makes qemu-kvm
look more attractive in the end.

It's peculiar to see UML in such a state of disrepair - for a long
while i thought it was a widely used lean virtualization platform,
powering things like containers, docker and so on.
Some research and disillusionment later, i'm left wondering what went wrong.
Even the ultra-useful Windows port, CoLinux, seems to be abandoned.

In any case, good luck with the patches!


> 2016-07-09 1:15 GMT+03:00  <user-mode-linux-devel-request@lists.sourceforge.net>:
> Check if you have sync turned on.
>
> Form of async IO - very similar to what posix async IO implementations
> do. If done correctly it can speed up things quite a bit. For it however
> actual files need to be opened async. The number you quoted makes me
> think you have sync enabled (it is enabled in some distros by default
> via kernel config options).

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

