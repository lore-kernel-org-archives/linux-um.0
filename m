Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xtiW-0004qH-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 12:36:28 -0700
Received: from home.linuxhacker.ru ([194.67.236.68] helo=linuxhacker.ru)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19xtiV-00066d-HZ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 12:36:27 -0700
Received: from car.linuxhacker.ru (localhost.localdomain [127.0.0.1])
	by linuxhacker.ru (8.12.9/8.12.5) with ESMTP id h8CJWdg7003135
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 23:32:40 +0400
Message-Id: <200309121932.h8CJWdUs003131@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [uml-devel] Re: 2.6.0 uptime bug
References: <20030911180344.A96963BCE4@home.petschge.de>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 12 Sep 2003 23:32:39 +0400
To: user-mode-linux-devel@lists.sourceforge.net

Hello!

Patrick Kilian <petschge@gmx.de> wrote:
>>> I have a patch which gives the correct uptime. I don't know what the
>>> patch  breaks so please post any problems you have.
>> Have you been able to figure out whether this is also a problem for
>> other ports?  Your patch suggests that it is, and if it is, then you 
>> should send it to LKML so it can be fixed in mainline.
PK> Ok 2.6.0-test5 gives the correct uptime on i386 and the wrong huge uptime as uml. My patch doesn't break anything on i386 but I'm going to fix this bug in the uml part of the kernel.

Well, but we have HZ=1000 on i386 and HZ=100 in UML
that's different code paths in kernel.

Bye,
    Oleg


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
