Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcGWz-0003Jx-H6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 21:07:57 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CcGWx-0005mX-CI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Dec 2004 21:07:56 -0800
Message-ID: <001301c4dd96$2ad3c110$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20041207163711.8475.qmail@web26103.mail.ukl.yahoo.com>
Subject: Re: [uml-devel] No DNS resolution on uml guest
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
Date: Thu, 9 Dec 2004 03:24:10 +0100
To: Roland Kaeser <roli8200@yahoo.de>, user-mode-linux-devel@lists.sourceforge.net

Hi Roland,
> The guest os (Fedora 2) cannot make any name resolution but the "normal" network
> works properly.
and you can ping the nameserver from inside the uml ?
do you see any udp-packets leaving the uml (do a tcpdump on the uml`s eth0 and on the hosts bridge interface) ?
if not, can you try to send some udp packets from/to the uml with "nc" (netcat - network admins swiss army knife) to make sure, that
it probably isn`t a problem with the resolver ?

> The guest file system and the machine installation have exactly
> the same files. When I try to make the dns resolution on the original machine it
> works well.  The resolution on the uml guest doesn't works event when the whole
> package filter (iptables) is disabled and set to accept.
You use different IPs for them , do you ?
If not, and if you use the machines one after each other, keep in mind that the ARP-Cache of the DNS-Server (if on the same lan) or
the first Hop(Router) between your UML and the DNS Server need to expire the MAC/IP pair it has learned before, until it can
communicate with the same IP "on another MAC" again.

Roland(/too)


----- Original Message ----- 
From: "Roland Kaeser" <roli8200@yahoo.de>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Tuesday, December 07, 2004 5:37 PM
Subject: [uml-devel] No DNS resolution on uml guest


> Hello All
>
> I have a very strange behaviour on a uml guest system.
> The guest os (Fedora 2) cannot make any name resolution but the "normal" network
> works properly.
> I'm using the guest file system which i have snapshoted from a special installation
> on a "real" machine. The guest file system and the machine installation have exactly
> the same files. When I try to make the dns resolution on the original machine it
> works well.  The resolution on the uml guest doesn't works event when the whole
> package filter (iptables) is disabled and set to accept.
> I use a linux bridge to communicate with the outside world.
>
> Roland
>
>
>
>
>
>
> ___________________________________________________________
> Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
