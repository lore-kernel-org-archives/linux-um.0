Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BadS6-0004aK-2J for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Jun 2004 09:39:54 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BadS5-0002V0-DF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Jun 2004 09:39:53 -0700
Message-ID: <25d101c453c1$9978f090$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040615113816.02b911c5.schpoo@dartmouth.edu>
	<87zn73biui.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [BUG!?] Re: [uml-user] TUNSETIFF failed,
	errno = 16SIOCSIFFLAGS: Device or resource busy
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
Date: Wed, 16 Jun 2004 18:47:17 +0200
To: Naomi Fox <schpoo@Dartmouth.EDU>, Nix <nix@esperi.org.uk>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

hi!

> > When I start up my UML, the networking works fine.  If I bring down my
> > interface and attempt to bring it back up again, I get the following
> > message.
> >
> > # ifconfig eth0 down
> > # ifconfig eth0 up
> > TUNSETIFF failed, errno = 16SIOCSIFFLAGS: Device or resource busy

> ... which it is: it's a component of the bridge, and doesn't have its
> own independent existence anymore.

yes - and that is why we should somewhat call it a "bug" - because a uml user indeed is allowed to bring down/up eth0, but he
(usually) isn't allowed to do something outside the uml.

so - what could he do?
call his uml provider to tell him he should fix the tun/tap/bridge for him?

no - uml should handle this itself,IMHO.

> Either bring down br0, or bring down the UML side of the link.
that is a workaround , not a solution.
i think UML needs some fix to handle tun/tap via bridge appropriately.

regards
roland






----- Original Message ----- 
From: "Nix" <nix@esperi.org.uk>
To: "Naomi Fox" <schpoo@Dartmouth.EDU>
Cc: <user-mode-linux-user@lists.sourceforge.net>
Sent: Wednesday, June 16, 2004 5:52 PM
Subject: Re: [uml-user] TUNSETIFF failed, errno = 16SIOCSIFFLAGS: Device or resource busy


> On Tue, 15 Jun 2004, Naomi Fox stated:
> > I am running a uml using a tuntap device connected to a bridge.
> >
> > # brctl show
> > bridge name     bridge id               STP enabled     interfaces
> > br0             8000.000255ffc0ce       no              eth0
> >                                                         tap0
> >
> > When I start up my UML, the networking works fine.  If I bring down my
> > interface and attempt to bring it back up again, I get the following
> > message.
> >
> > # ifconfig eth0 down
> > # ifconfig eth0 up
> > TUNSETIFF failed, errno = 16SIOCSIFFLAGS: Device or resource busy
>
> ... which it is: it's a component of the bridge, and doesn't have its
> own independent existence anymore.
>
> Either bring down br0, or bring down the UML side of the link.
>
> Example, from my startup scripts, using the brctl and ip tools instead
> of ageing ifconfig:
>
> brctl addbr adsl
> brctl stp adsl off
> brctl setfd adsl 1
> brctl sethello adsl 1
>
> brctl addif adsl adsl-phys
> brctl addif adsl tap0
>
> ip link set dev adsl mtu 1458 up
>
> -- 
> `We in no way believe that this Christ was a space alien.'
>                     --- A creationist website goes completely bonkers
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
> Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
> Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
> REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
>



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
