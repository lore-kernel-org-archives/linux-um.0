Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cdwjf-0007C3-9I for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Dec 2004 12:23:59 -0800
Received: from pike.sandelman.ca ([205.150.200.164])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Cdwjc-0006A4-Ve
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Dec 2004 12:23:58 -0800
Subject: Re: [uml-devel] Re: What to do with uml_switch? 
In-Reply-To: Message from "Steve Schmidtke" <steve_schmidtke@hotmail.com> 
	of "Sun,
	12 Dec 2004 19:11:24 GMT." <BAY24-F3066C52785F7FFBF9E53EA83AA0@phx.gbl>
References: <BAY24-F3066C52785F7FFBF9E53EA83AA0@phx.gbl> 
Message-ID: <30083.1102884650@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
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
Date: Sun, 12 Dec 2004 15:50:50 -0500
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, kraxel@bytesex.org, uml@uxu.ch, jdike@addtoit.com

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Steve" == Steve Schmidtke <steve_schmidtke@hotmail.com> writes:
    Steve> uml_netjig changes than the other way around.  I found 5
    Steve> patches (1-5) for the uml_netjig foundation in the mailing
    Steve> list archive, and I'm OK with the basic premises I have seen:

  Great.
  Let me know when I should diff against what I have, and re-submit more
patches.

    Steve> for controlling those switches.  If we can agree that the
    Steve> other features like tcpdumps and fake ARPs, etc. are not core
    Steve> to the nature of a switch (but can be patched in when
    Steve> needed), then I would be happy to maintain the above premises
    Steve> as well.

  I'd rather see the multiple switch support in a seperate binary.
  You'll see that in my patches uml_netjig and uml_switch each have
their own poll(2)-loop. That's because the uml_switch is significantly
simpler.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQbyvKYqHRg3pndX9AQGwsAQA1U/+gyxKFjOfBeBSo1T4/9QUIYcK9QWS
h0NI8NWNMTWT3E/nHSms01ZjYfiusWf7eWba7FMs8d2jj09d7fojoSDYFHxslOw2
6voXfQwQdwAHhfvpPBgjA6+FZtQizliz7zH+pGgpnRIEOnvx7ZCpiZ5z/fDL08eL
z8TkqkSpvoU=
=rmIm
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
