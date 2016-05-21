Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1b4Em1-0004HS-0O
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 21:49:29 +0000
Received: from mail-oi0-f52.google.com ([209.85.218.52])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b4Em0-00071z-7H
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 21:49:28 +0000
Received: by mail-oi0-f52.google.com with SMTP id x19so228363115oix.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 21 May 2016 14:49:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMGZ=GpWk1=9HeTxz6NBVh-Y8TZS8ZBHaaqDdxOqvRHD+f_TQ@mail.gmail.com>
References: <CAOMGZ=GpWk1=9HeTxz6NBVh-Y8TZS8ZBHaaqDdxOqvRHD+f_TQ@mail.gmail.com>
Date: Sat, 21 May 2016 23:49:22 +0200
Message-ID: <CAFLxGvzX30-hW-ARifhsKrOp4L91rV7GH4heC-w7b3fucaYfEw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] current_thread_info() returns invalid pointer in
 early UML boot code
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
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, Thomas Meyer <thomas@m3y3r.de>

On Sat, May 21, 2016 at 3:51 PM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
> Hi people,
>
> I'm having some trouble with using current_thread_info() during UML
> early boot. Sometimes it works just fine, but often I get segfaults
> because current_thread_info() is returning an invalid pointer. It
> looks random: 0x202118, 0x1003e0003, 0xd33b90b3, 0x6db043, etc.

Where do you use it?
Can you rule out a bad compiler optimization?
(We had such an issue a few years ago)

> Does anybody understand fully what's going on here, why it returns
> those invalid (seemingly random) values? If the problem is that we're
> on a wrong stack, can we switch stacks earlier during boot or
> something to make current_thread_info() always return a valid
> thread_info pointer?

Can't say much without more details.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

