Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFGpo-0006tw-Co for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 11:48:20 -0700
Received: from nudl.linbit.com ([212.69.162.21] helo=mail.linbit.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CFGpl-00050S-B0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 11:48:20 -0700
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
Subject: Re: [uml-devel] uml "ip header error" for large (fragmented) udp
	packets
Message-ID: <vm4cST3zEEx6OdPLK17ocyg=lge@web.de>
References: </ydgn6vAKqzNNA6XYwRcEgI=lge@web.de>
	<200410061938.06648.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <200410061938.06648.blaisorblade_spam@yahoo.it>
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
Date: Wed, 6 Oct 2004 20:48:23 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: lmb@suse.de, ak@suse.de

> So this could help you for now, while we try to find a clue about this. Q=
uite=20
> frankly, I must say that I'm not seeing any network kernel hacker here=20
> (correct me if I'm wrong), so it will take some time to debug it. Maybe G=
erd=20
> Knorr is an exception, actually.

Well, then I take Andi Kleen and Lars Marowsky-Br=E9e into CC for now.
Lars, because I expect him to be interessted in having UML as full
featured cluster simulation tool available, and Andi because I hope he
might know the network code much better than me...

FYI, full thread can be found for example at
http://thread.gmane.org/gmane.linux.uml.devel/4607

Thanks,

	Lars Ellenberg

/ 2004-10-06 19:50:46 +0200
\ BlaisorBlade:
> On Sunday 03 October 2004 04:36, Lars Ellenberg wrote:
> > in the upcomming new heartbeat design of linux-ha, we use relatively
> > large udp packets (passing large xml blobs back and forth between the
> > nodes). now, cluster development and testing is convenient on UML.
>=20
> > but:
> >  uml seems to silently and systematically lose all fragmented
> >  udp packets, that is packages larger than mtu, and 1480 byte
> >  max for xml blobs just does not work out too good ...
>=20
> > I investigated a little bit (using two simple perl snippets to
> > generate/[not]receive the udp packets), and it turns out that:
>=20
> >  sending large (up to 64K; fragmented) udp packets
> >  using tuntap:
> >   HOST -> UML  works.
> >   UML  -> HOST nope :(
> >   UML <-> UML  nope :( [ neither with mcast or other ]
> >
> >  looking into /proc/net/snmp on the UMLs and the HOST
> >  show on the not receiving side an increase of
> >  InHdrError!
> >  (it never is reassembled into a proper udp packet)
> >
> > this is easy to reproduce (because it just happens all the time)
> > tested with 2.6.6 and 2.6.8 plus respective UML patches.
> >
> > it seems to me that UML corrupts the ip header of
> > fragmented udp packets somehow at sending time.
>=20
> I've traced this with Ethereal (v0.10.5) running on tap0 and it complains=
 that=20
> the IP header checksum is always incorrect when the packet is fragmented.=
=20
> This does not happen when running both programs on the host; I've set an =
mtu=20
> of 1500 for "lo" fot this test.
>=20
> However, it seems that Ethereal always shows the UDP checksum, which is=20
> different, as incorrect for not fragmented packets, when they are sent ov=
er=20
> the "lo" link (on my 2.6.7 host kernel); by comparison, when sending them=
=20
> over local network it never complains. The Ethereal doc say that when=20
> capturing on an interface that supports TCP checksum offloading (i.e.=20
> hardware checksumming), this is normal for TCP checksums, so I guess this=
 can=20
> happen for UDP checksums, too.
>=20
> But why the loopback driver should mark itself as capable of doing "hardw=
are=20
> checksum"? However, it seems that actually this is the situation. In the =

> source code, the loopback driver is marked as "needing no checksum at all=
=20
> because it's safe (see NETIF_F_NO_CSUM in include/linux/skbuff.h).
>=20
> Also, it seems that the UML code happily ignores specifying what checksum=
=20
> support. And this could help us.
>=20
> include/linux/skbuff.h describes the Checksum flags, and UML does not use=
=20
> them: these two commands return no output.
>=20
> find arch/um/ -name '*.[ch]'|xargs grep NETIF
> find arch/um/ -name '*.[ch]'|xargs grep CHECKSUM
>=20
> Actually I've never done any work *at all* on the networking code, so thi=
s is=20
> just a wild guess.
> > the way it is now we probably need to reanimate some of our old
> > boxes to form a real test cluster. and believe me, that is no fun :(
>=20
> I've tried UML 2.4, and it does not seem to experience this bug: it does =
not=20
> increases the host error count in /proc/net/snmp, UdpRecv receives all=20
> packet sizes (I stopped the test at 49100 bytes), and even Ethereal shows=
=20
> correct datas. The test were run sending=20
> the packets from UML to the Host, as you say.
>=20
> So this could help you for now, while we try to find a clue about this. Q=
uite=20
> frankly, I must say that I'm not seeing any network kernel hacker here=20
> (correct me if I'm wrong), so it will take some time to debug it. Maybe G=
erd=20
> Knorr is an exception, actually.
>=20
> > if some kind soul would be able to fix that...
> > would make cluster testing as we do it
> > so much more convenient :-)
>=20
> --=20
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
