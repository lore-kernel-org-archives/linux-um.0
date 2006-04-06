Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FROky-0000h1-1u for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 00:18:16 -0700
Received: from imap.epfl.ch ([128.178.50.10])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FROkw-00084Q-Kt
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 00:18:16 -0700
Received: from [128.178.52.94] (labospc31.epfl.ch [128.178.52.94])
	by imap.epfl.ch (iPlanet Messaging Server 5.0 Patch 3 (built Mar 23
	2001)) with ESMTPA id <0IXA00F0AHM5HR@imap.epfl.ch> for
	user-mode-linux-devel@lists.sourceforge.net; Thu,
	06 Apr 2006 09:18:05 +0200 (MET DST)
From: Olivier Crameri <olivier.crameri@epfl.ch>
Subject: Re: [uml-devel] system call accessing the host os
In-reply-to: <20060406014338.GB6924@ccure.user-mode-linux.org>
Message-id: <3F937E83-6ED4-496D-9883-24C3909B30AA@epfl.ch>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-transfer-encoding: 7BIT
References: <8F963598-0F1A-464A-991A-2FE95F9B418C@epfl.ch>
	<20060405181812.GA5684@ccure.user-mode-linux.org>
	<b54af0b00604051320l54bab57ag311746325c887d7f@mail.gmail.com>
	<20060406014338.GB6924@ccure.user-mode-linux.org>
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
Date: Thu, 06 Apr 2006 09:18:04 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

>
>> Then, when I use fread to read
>> my file into this buffer, if I read a small number of bytes, it  
>> works.
>> However when I try to fread the entire file (38k), fread returns 0.
>
> What's the break point between working and non-working?

It looks like it's on a page boundary. 4095 bytes is ok, 4096 is not
I'm using 2.6.15.6 with the latest 2.6.15 patch from Blaisorblade's  
website.

Regards,

Olivier


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
