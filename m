Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cf5uM-0004Ar-5C for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 16:23:46 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cf5uL-0005bk-EV for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 16:23:46 -0800
Message-ID: <001e01c4e3ce$c873fff0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <000601c4e3cc$119a1280$0201a8c0@hawk>
	<200412170115.15731.blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] unable to unmount tmpfs problem lives on
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Thu, 16 Dec 2004 18:24:32 -0600
To: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

> Well, this is yet undiagnosed, but definitely it's not a UML bug... you should
> certainly run a 2.6.8.1 based kernel...

That is unfortunate.

> There is some kind of security bug fixed in 2.6.9, but it was a littler one
> probably (an overflow when handling file position...).
>
> Do you remember when UML crashed and left the unkillable 'D' thread? That's a
> local DoS bug, and this one you're speaking about is a worse one... I and
> Bodo have complained about this one (not on LKML) and didn't get any answer
> yet...

I could try and get a response from LKML, but you would probably present the problem
better...

-Chris



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
