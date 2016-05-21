Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@gmail.com>) id 1b47JC-0002Qe-7u
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 13:51:14 +0000
Received: from mail-vk0-f68.google.com ([209.85.213.68])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b47JB-0000u9-Ca
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 13:51:14 +0000
Received: by mail-vk0-f68.google.com with SMTP id e126so20746675vkb.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 21 May 2016 06:51:13 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 21 May 2016 15:51:07 +0200
Message-ID: <CAOMGZ=GpWk1=9HeTxz6NBVh-Y8TZS8ZBHaaqDdxOqvRHD+f_TQ@mail.gmail.com>
From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: [uml-devel] current_thread_info() returns invalid pointer in early
	UML boot code
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
To: Richard Weinberger <richard@nod.at>, Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi people,

I'm having some trouble with using current_thread_info() during UML
early boot. Sometimes it works just fine, but often I get segfaults
because current_thread_info() is returning an invalid pointer. It
looks random: 0x202118, 0x1003e0003, 0xd33b90b3, 0x6db043, etc.

I found an earlier thread which described the same problem:
http://permalink.gmane.org/gmane.linux.uml.devel/14642

However, I think the patch there is a bit hacky/papers over an
underlying bug, since it just uses is_kernel_addr() before deciding
whether to return the pointer from current_thread_info() or not. The
fact that the crash is random leads me to think it's some sort of race
during the UML boot.

Does anybody understand fully what's going on here, why it returns
those invalid (seemingly random) values? If the problem is that we're
on a wrong stack, can we switch stacks earlier during boot or
something to make current_thread_info() always return a valid
thread_info pointer?

Thanks,


Vegard

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

