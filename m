Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FW9PZ-0001qy-1D for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:55:49 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FW9PW-0000zi-LZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Apr 2006 02:55:49 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: TLS, Debian and 2.6.16.5
References: <OJEEKGNKKDLJIEPBEJMIIEPCCAAA.brocka@sterlingcgi.com>
	<e1pae6$21m$1@sea.gmane.org>
In-Reply-To: <e1pae6$21m$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200604191158.34889.blaisorblade@yahoo.it>
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
Date: Wed, 19 Apr 2006 11:58:34 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>

On Saturday 15 April 2006 01:15, Sven K=F6hler wrote:
> > I'm in the process of setting up a new Debian box that needs a decent
> > source of entropy. So, I have downloaded and installed a relatively new
> > UML kernel:
> >
> > www:/usr/share/doc/rng-tools# uname -a
> > Linux www.myserver.com 2.6.16.5 #1 Fri Apr 14 11:44:51 PDT 2006 i686
> > GNU/Linux
> >
> > I then downloaded and installed the rng-tools package. Unfortunately,
> > this software segments everything I try to use it. However, when I rena=
me
> > /lib/tls to /lib/tls.disabled the issue disappears. Are the TLS patches
> > for UML included in this kernel? If not, is there a stable set of patch=
es
> > to add it?

> 2.6.17 includes TLS support.

> My Gentoo had some problems with iptables, so i had to revert to 2.6.16.

2.6.16-bb1 has TLS support, too.
--=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

=09

=09
	=09
___________________________________=20
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB=20
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd________________________________________=
_______
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
