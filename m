Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZJe2-0004bN-PI for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 18:55:34 -0800
Received: from sbx-01.invendra.net ([66.139.76.16] helo=mail.invendra.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EZJe2-00033Q-Pd
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 18:55:35 -0800
From: David Lang <dlang@invendra.net>
Subject: Re: [uml-devel] Does UML 2.6.14 work under x86-64?
In-Reply-To: <200511071853.40490.rob@landley.net>
Message-ID: <Pine.LNX.4.62.0511070646180.2799@qnivq.ynat.uz>
References: <200511061723.32848.rob@landley.net>
	<200511072032.27218.blaisorblade@yahoo.it>
	<200511071853.40490.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Mon, 7 Nov 2005 06:47:33 -0800 (PST)
To: Rob Landley <rob@landley.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 7 Nov 2005, Rob Landley wrote:

> Subject: Re: [uml-devel] Does UML 2.6.14 work under x86-64?
> 
> On Monday 07 November 2005 13:32, Blaisorblade wrote:
>> On Monday 07 November 2005 00:23, Rob Landley wrote:
>>> David Lang is trying to get my firmware build working under x86-64,
>>
>> proper x86-64 or a 32-bit binary?
>
> 64 bit.  Trying to build 32 bit on x86-64 died for him.
>
>>> He first tried with the LDT patch applied.
>>
>> When I last tried that patch doesn't compile on x86-64.
>
> Apparently that was fixed.  (I'm using the version that went to Andrew
> Morton.)
>
>> On the bug: there are some problems with the stub assembly code - it
>> miscompiles on some GCC releases. I'm trying to fix that - and -bs1 may or
>> may not help on this (for some people it refuses to compile on x86_64).
>>
>> GCC version?
>
> 4.0.2, hacked to link against uClibc.

does it use the GCC you include for the first compile, or the base 
compiler on the host OS?

David Lang


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
