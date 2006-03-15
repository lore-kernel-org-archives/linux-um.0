Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJVii-0001qs-Vk for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Mar 2006 05:07:20 -0800
Received: from s93.xrea.com ([218.216.67.44])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FJVih-0001Wr-AH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Mar 2006 05:07:20 -0800
Message-Id: <200603151307.AA00817@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Subject: Re: [uml-devel] Sharing code pages between host and guest
In-Reply-To: <20060314202739.GC22286@ccure.user-mode-linux.org>
References: <20060314202739.GC22286@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 15 Mar 2006 22:07:07 +0900
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

>> I am studying now for how you share same content page between host and guest.
>> In other words, if host and guest use just very same binary of glibc,
>> then, how to share code pages of glibc (or bash or...).
>> I think one of the biggest problem of virtualization is memory,
>> and one common technique to solve it is sharing pages, dont you?
>
>That would certainly help, although you are giving up one advantage of
>virtualization this way, which is the ability to have the guest and host
>be running different versions of the kernel and/or userspace.
>

I dont think so. It can be solved easyily with using UnionFS.


>> My question is, if you share /lib through HostFS,
>> can I share code pages of /lib/libc.6.so between host and guest?
>
>If hostfs mmaps pages (which it currently doesn't, but is planned).
>

Good to hear! I am waiting it in hope.


            --- Okajima, Jun. Tokyo, Japan.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
