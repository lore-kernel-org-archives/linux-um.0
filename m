Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cydqv-0004O4-Ho for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 14:29:01 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cydqu-00042W-W8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 14:29:01 -0800
Message-Id: <200502090017.j190Hds0014277@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: UML tuntap driver problem with queueing 
In-Reply-To: Your message of "Tue, 08 Feb 2005 21:37:06 +0200."
	<87zmyej125.fsf@aka.i.naked.iki.fi> 
References: <87hdks5y35.fsf@aka.i.naked.iki.fi>
	<87zmyej125.fsf@aka.i.naked.iki.fi> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 08 Feb 2005 19:17:39 -0500
To: Nuutti Kotivuori <naked@iki.fi>
Cc: user-mode-linux-devel@lists.sourceforge.net, McGroarty <mcgroarty@gmail.com>

naked@iki.fi said:
> ust a heads up here to the UML folks in case it was missed - with the
> current code, packet delivery to UML machines using tuntap driver
> *will* mess up (stall totally or major bursts of lag) if more than 10
> packets are queued to UML at a time. 

It wasn't missed.  Someone else posted 
(http://marc.theaimsgroup.com/?l=user-mode-linux-user&m=110752781409419&w=2)
that networking freezes until a character is typed on the console.

This is a clear sign of the SIGIO missing some traffic and letting it sit
on the host until some other IO happens.

> Ofcourse, the actual cause for this should be fixed (SIGIO mess up or
> whatever it is). 

Yup.  It does look like there's some sort of race in the SIGIO handler.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
