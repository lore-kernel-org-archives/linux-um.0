Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cc7pJ-00062L-7I for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 11:50:17 -0800
Received: from bay24-f30.bay24.hotmail.com ([64.4.18.80] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cc7pH-0006mP-01 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 11:50:15 -0800
Message-ID: <BAY24-F3095F190F005AC385C24ED83B60@phx.gbl>
In-Reply-To: <7044.1102525892@marajade.sandelman.ottawa.on.ca>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Subject: Re: [uml-devel] Re: What to do with uml_switch?
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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
Date: Wed, 08 Dec 2004 19:49:09 +0000
To: mcr@sandelman.ottawa.on.ca
Cc: blaisorblade_spam@yahoo.it, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Michael Richardson wrote:
>     Steve> Strip down the UML kernel's daemon_user.c and what you have
>     Steve> is a framework to talk socket datagrams to a uml_switch.  Add
>
>   That's probably not the best idea. We put the interfaces in two places
>right now... Best would be if a refactored uml_switch exported an
>interface that replaced daemon_user.c :-)

It would be useful if daemon_user.c could be run in a synchronous mode such 
that packets are guaranteed delivered to the switch and guaranteed delivered 
to a host.  The switch could then mangle packets in a deterministic fashion 
for testing.

It would also be interesting if packets could be passed in shared memory.  
I'm wondering if it would be faster and more reliable at the same time.

Steve Schmidtke




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
