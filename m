Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiuSj-0002NJ-ET for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 03:54:29 -0800
Received: from mekong.darkman.de ([217.69.160.53] helo=mail.darkman.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiuSg-0005tl-0Z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 03:54:29 -0800
Received: from darkman.de (ezri.darkman.de [23.23.23.42])
	by mail.darkman.de (Postfix) with ESMTP id 4392C2EF84
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Jan 2004 12:51:27 +0100 (CET)
Message-ID: <400D16C5.4010709@darkman.de>
From: "Sven 'Darkman' Michels" <sven@darkman.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] skas mode panic - ltrace strace
References: <20040120112042.GA2916@localhost>
In-Reply-To: <20040120112042.GA2916@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 20 Jan 2004 12:53:41 +0100
To: user-mode-linux-devel@lists.sourceforge.net

nsb034@lostrealm.com wrote:
> Hi
> 
> I have a reproducible kernel panic running the ltrace program.  The
> panic only occurs when running the uml kernel in skas mode.  mode=tt
> does not panic.
> 
> Running as a normal (non root) user:
>    $ ltrace strace ls
> results in:
>    Kernel panic: Kernel mode signal 5
> 
> Is anyone else able to reproduce this?

Yes, but not everytime:
Host: 2.4.22 with skas patch
UML: 2.4.23-um1
First test: uml crashed.
Second: uml didn't crash, finished the ltrace just fine
(i did the ltrace strace ls two times, just to be sure)
Third test: uml crashed.

(reboot between every test).

So it may be some kind of race condition?

Regards,
Sven



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
