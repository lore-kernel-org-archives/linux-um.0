Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6EW5-0007g7-Qz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 11:58:21 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B6EW3-0004ZT-N0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 11:58:19 -0800
Message-ID: <050901c411db$33d65110$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <c3skqj$st3$1@sea.gmane.org>
Subject: Re: [uml-devel] [RFE] con=port
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Wed, 24 Mar 2004 21:04:22 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net, =?iso-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>

hi !
i think specifying a tcp-port on a commandline should generally be possible=
 by specifying the interface adress,too.

let`s say - you have a tcp listening port at "xxxx"
ok - here we go - but what, if we have a host with multiple interfaces?

this port "xxxx" can be opened for listening on

ALL
ONE
or
SEVERAL

of them.

this is completely independend - but many apps just blindly bind to 0.0.0.0=
, which means "ALL".
not a very flexible thing (and from the point of security: insecure!), but =
it`s easier for the programmer - this must be the reason,
why we have 0.0.0.0 that often.

i like applications, which let me say: use port xxxx on interface (ip) W.X.=
Y.Z,
i.e. instead of "port=3D6000"  i would like  "port=3D127.0.0.1:6000,10.0.0.=
1:6000"

apache does, samba does (via config-files) - and many other apps do.

i had such "controversial" discussion a while ago on Xfree86: http://marc.t=
heaimsgroup.com/?t=3D106900961500001&r=3D1&w=3D2

regards
roland



----- Original Message -----=20
From: "Sven K=F6hler" <skoehler@upb.de>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Wednesday, March 24, 2004 7:39 PM
Subject: [uml-devel] [RFE] con=3Dport


> Hi,
>
> it seem that one has to use con=3Dport:<number> to have UML listening on a
> TCP/IP-port. UML also seems to bind to 0.0.0.0
> I'd like UML to bind on 127.0.0.1 only and to bind the socket to a free
> port chosen by the TCP/IP-stack.
>
> i would than do "con=3Dport" and UML would bind each console to another
> TCP/IP-Port. I should than be abled to use mconsole to query which the
> port-number con1-9 are using.
>
> Another point is, that "con1=3Dport:9000" doesn't seem to work with a
> 2.6.4-um1 kernel. I was abled to connect with telnet, but no matter
> which key i pressed, i saw nothing. In additon, the mconsole didn't
> work. I could attach mconsole to the UML, but any command blocked and
> never returned to the prompt again.
>
> Another point would be security. Even if UML only binds to 127.0.0.1,
> the port is accessable by any user logged in. But i have no clever idea
> for that.
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
