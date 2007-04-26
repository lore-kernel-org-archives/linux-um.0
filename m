Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hh4is-0007t0-VZ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 07:13:27 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Hh4ir-0000YA-8G
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 07:13:26 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 26 Apr 2007 16:12:40 +0200
References: <462BACC9.7010303@nagafix.co.uk>
	<20070425204849.GA9505@c2.user-mode-linux.org>
	<462FC142.1010907@nagafix.co.uk>
In-Reply-To: <462FC142.1010907@nagafix.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704261612.40356.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] regression: pcap broken in 2.6.20.x
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On mercoled=EC 25 aprile 2007, Antoine Martin wrote:
> Jeff Dike wrote:
> > On Sun, Apr 22, 2007 at 07:43:21PM +0100, Antoine Martin wrote:
> >> Using the exact same kernel config with 2.6.19.x works but not with
> >> 2.6.20.x
> >>
> >> # ifconfig eth1 0.0.0.0 promisc up
> >> SIOCSIFADDR: No such device
> >> eth1: unknown interface: No such device
> >> eth1: unknown interface: No such device
> >> eth1: unknown interface: No such device
> >
> > Works here - what do ifconfig -a and dmesg say?
>
> Ah, DOH!
> Could it be that the randomization of the mac address made it appear as
> eth4 and not eth1... (why eth4 and not eth3 or eth2, beats me)
> Until now all kernels made it appear as eth1.

Hmm... Ubuntu renames interfaces based on their MAC address, which are list=
ed=20
in /etc/iftab. Dunno about other distributions.

If there are so many interfaces and they were just reordered, this could be=
=20
caused by a (non-existant) change in link order. Or (I don't know how) it=20
could derive some way from the fact that interfaces are initialized later=20
(instead of __initcall, late_initcall is now used).
--=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

