Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZYsO-00063X-JJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 11:11:24 -0800
Received: from smtp1.stanford.edu ([171.67.16.123])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EZYsN-0003dj-6o
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 11:11:24 -0800
In-Reply-To: <20051108154310.GA4131@ccure.user-mode-linux.org>
References: <200511061723.32848.rob@landley.net>
	<91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
	<20051108154310.GA4131@ccure.user-mode-linux.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E3EBEE81-52B5-4CA1-9DE2-76E71FF91B31@stanford.edu>
Content-Transfer-Encoding: 7bit
From: Can Sar <csar@stanford.edu>
Subject: Re: [uml-devel] Making UML Single Threader
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
Date: Tue, 8 Nov 2005 11:11:07 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


On Nov 8, 2005, at 7:43 AM, Jeff Dike wrote:

> On Mon, Nov 07, 2005 at 09:13:19PM -0800, Can Sar wrote:
>> Do the other threads (particularly the user thread) ever
>> do something else that would be important?
>
> The user thread doesn't.  The IO thread does, if you wish to do IO.
> And you can easily dispense with the sigio emulation thread.
>
>> Furthermore is the actual kernel process multi threaded?
>
> It does what amounts to user-level threads - i.e. there are multiple
> execution contexts in it, implemented with setjmp/longjmp, but that's
> not visible from the outside.

Thank you, that was all really helpful.
Can


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
