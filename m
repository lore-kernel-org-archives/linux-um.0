Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrNap-00008A-4m for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 13:42:23 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CrNal-0002Hy-A4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 13:42:23 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] question about udp fragmentation under UML
References: <200501180728.13533.mustang@yadan.org>
In-Reply-To: <200501180728.13533.mustang@yadan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200501192254.24207.blaisorblade@yahoo.it>
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
Date: Wed, 19 Jan 2005 22:54:24 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Yari =?iso-8859-15?q?Ad=E1n_Petralanda?= <mustang@yadan.org>

On Tuesday 18 January 2005 07:28, Yari Ad=E1n Petralanda wrote:
> Hi,
>
> I'm developing a network block device, which uses both TCP and UDP sockets
> to transmit it's data. When I try to send UDP frames bigger than the MTU,
> they are dropped before they hit the wire.

This exact problem (a checksum corruption in fragmented UDP packets) was=20
already debugged and solved, and even vanilla 2.6.9 includes the fix...=20
currently the recommended tree is 2.6.9-bb4 on my homepage.

I assume that you should first try 2.6.9-bb and, if you still have problems=
,=20
ask again... Anyway please post an ack about whether 2.6.9-bb solves this=20
bug, ok? Thanks.

> Trying to debug the problem, I=20
> ran netcat using udp under a UML. It uses writes of 8192 bytes over a UDP
> socket. The scenario that made me post here is this:
> running UML on tracing thread mode, host kernel is 2.6.10, uml kernel is
> 2.6.8.1-1um,

> if I set the MTU of the localhost device (same problem on=20
> tun/tap) to 1500 bytes, netcat doesn't receive any frames sent to the
> loopback interface. path_mtu_no_discover is 0. The same scenario, on my
> host computer, runs fine.

> Seems to me that IP is refusing to fragment the udp datagrams, and drops
> them.
I've debugged this with ethereal and the result was that the checksum, in t=
he=20
case of fragmented packets, was wrong - so the receiving side dropped the=20
packets...

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
