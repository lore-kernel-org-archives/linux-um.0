Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1b4BsZ-0004Hb-BK
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 18:44:03 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b4BsX-00037V-F0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 18:44:03 +0000
References: <CAOMGZ=GpWk1=9HeTxz6NBVh-Y8TZS8ZBHaaqDdxOqvRHD+f_TQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CAOMGZ=GpWk1=9HeTxz6NBVh-Y8TZS8ZBHaaqDdxOqvRHD+f_TQ@mail.gmail.com>
Message-Id: <6AAB4FAC-99C2-4B3C-88CA-C210193E74EF@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sat, 21 May 2016 20:18:07 +0200
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
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi,

Mhh. Strange. Do you have a stack trace to call to current thread info which ends up with a wrong value. I wonder from were it originates.

With kind regards 
Thomas


With kind regards
Thomas

> Am 21.05.2016 um 15:51 schrieb Vegard Nossum <vegard.nossum@gmail.com>:
> 
> Hi people,
> 
> I'm having some trouble with using current_thread_info() during UML
> early boot. Sometimes it works just fine, but often I get segfaults
> because current_thread_info() is returning an invalid pointer. It
> looks random: 0x202118, 0x1003e0003, 0xd33b90b3, 0x6db043, etc.
> 
> I found an earlier thread which described the same problem:
> http://permalink.gmane.org/gmane.linux.uml.devel/14642
> 
> However, I think the patch there is a bit hacky/papers over an
> underlying bug, since it just uses is_kernel_addr() before deciding
> whether to return the pointer from current_thread_info() or not. The
> fact that the crash is random leads me to think it's some sort of race
> during the UML boot.
> 
> Does anybody understand fully what's going on here, why it returns
> those invalid (seemingly random) values? If the problem is that we're
> on a wrong stack, can we switch stacks earlier during boot or
> something to make current_thread_info() always return a valid
> thread_info pointer?
> 
> Thanks,
> 
> 
> Vegard
> 
> ------------------------------------------------------------------------------
> Mobile security can be enabling, not merely restricting. Employees who
> bring their own devices (BYOD) to work are irked by the imposition of MDM
> restrictions. Mobile Device Manager Plus allows you to control only the
> apps on BYO-devices by containerizing them, leaving personal data untouched!
> https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

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

