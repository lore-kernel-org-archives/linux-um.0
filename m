Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRKS5-000643-7e for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 19:42:29 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRKS4-0004oF-MQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 19:42:29 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] system call accessing the host os
Message-ID: <20060406014338.GB6924@ccure.user-mode-linux.org>
References: <8F963598-0F1A-464A-991A-2FE95F9B418C@epfl.ch>
	<20060405181812.GA5684@ccure.user-mode-linux.org>
	<b54af0b00604051320l54bab57ag311746325c887d7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54af0b00604051320l54bab57ag311746325c887d7f@mail.gmail.com>
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
Date: Wed, 5 Apr 2006 21:43:38 -0400
To: olivier.crameri@epfl.ch
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 05, 2006 at 10:20:44PM +0200, Olivier Crameri wrote:
> Thanks for the answer. I bumped CONFIG_KERNEL_STACK_ORDER to 3, but it
> doesn't help.

I didn't think so, since the symptoms were wrong.  However, keep that
in the back of your mind since you're dealing with some piggy parts of
libc.

> When I said that using malloc didn't work, I meant the following: I'm
> using malloc to allocate a buffer in the UML kernel. I'm not passing a
> user level buffer to the system call. 

38K isn't big enough for it to fall back to vmalloc, so the pages not
being present probably isn't an issue.

> Then, when I use fread to read
> my file into this buffer, if I read a small number of bytes, it works.
> However when I try to fread the entire file (38k), fread returns 0.

What's the break point between working and non-working?

> Later on, I use sscanf to parse my buffer. No matter what happens,
> sscanf returns 0, which is wrong even if there is no error. The exact
> same code compiled in the host works perfectly.

This, I don't understand.

What version of UML are you using?

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
