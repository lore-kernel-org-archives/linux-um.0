Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5IFR-0004pr-RP for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 23:17:33 -0700
Received: from webhosting.rdsbv.ro ([213.157.185.164] helo=hosting.rdsbv.ro)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C5IFO-0007wR-Tt
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 23:17:33 -0700
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
Subject: Re: [uml-devel] Host: 2.6.7, guest: 2.6.8.1, without SKAS
In-Reply-To: <413F0ADE.80103@almahdi.cc>
Message-ID: <Pine.LNX.4.61.0409090915170.3396@hosting.rdsbv.ro>
References: <Pine.LNX.4.61.0409071058020.25003@hosting.rdsbv.ro>
	<12503.1094564116@camelot-054> <200409071754.25380.ralph@debianbase.de>
	<Pine.LNX.4.61.0409081516240.2035@hosting.rdsbv.ro>
	<413F0ADE.80103@almahdi.cc>
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
Date: Thu, 9 Sep 2004 09:17:21 +0300 (EEST)
To: Ali Almahdi <ali@almahdi.cc>
Cc: =?ISO-8859-1?Q?Ralph_Pa=DFgang?= <ralph@debianbase.de>, user-mode-linux-devel@lists.sourceforge.net

>> The kernel is not reaching the point to mount root filesystem.
>> I just ran ./linux without parameters and I get that.
>
> Mount it as a loop back device to rename /lib/tls

Seems I'm not able to describe the problem correctly. :(
I intentionaly ran ./linux without parameters. Why? Because I tried with 
parameters and the same problem is still there.

So, the ./linux doesn't reach the point to mount the filesystem.
It crashed _before_!

How I can "read" the oops. What to do?
Thank you!

>
>> 
>>> 
>>> --Ralph
>>> 
>>> 
>>> -------------------------------------------------------
>>> This SF.Net email is sponsored by BEA Weblogic Workshop
>>> FREE Java Enterprise J2EE developer tools!
>>> Get your free copy of BEA WebLogic Workshop 8.1 today.
>>> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
>>> _______________________________________________
>>> User-mode-linux-devel mailing list
>>> User-mode-linux-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>>> 
>> 
>> ---
>> Catalin(ux aka Dino) BOIE
>> catab at deuroconsult.ro
>> http://kernel.umbrella.ro/
>> 
>> 
>> -------------------------------------------------------
>> This SF.Net email is sponsored by BEA Weblogic Workshop
>> FREE Java Enterprise J2EE developer tools!
>> Get your free copy of BEA WebLogic Workshop 8.1 today.
>> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
>> _______________________________________________
>> User-mode-linux-devel mailing list
>> User-mode-linux-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
>

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
