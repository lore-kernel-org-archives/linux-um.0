Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuAVn-0006kc-Or
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 05:16:11 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AuAHB-0006MD-VQ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 05:01:06 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040220125413.GA15930@bytesex.org>
References: <40338C1B.1070800@meisterwerk.net> <c1360l$eei$1@sea.gmane.org> <87llmy3vr5.fsf@bytesex.org> <4035FDFE.6010402@upb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <4035FDFE.6010402@upb.de>
Subject: [uml-devel] Re: skas3 patch fails against vanilla-2.4.25
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 20 Feb 2004 13:54:13 +0100
Content-Transfer-Encoding: quoted-printable
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Feb 20, 2004 at 01:30:54PM +0100, Sven K=F6hler wrote:
> >You didn't apply the second patch, did you?
>=20
> Should i?

Yes.

> The description of the second path was:
> 	Various fixups to make the whole tree build for all
> 	architectures.
>=20
> So i thought it is to make it compile on PPC or whatever.

"all architectures" includes both ppc and i386 ;)

  Gerd

--=20
Es geht darum, da=DF ein Haufen Scriptkiddies gerade dabei sind, USENET in
Bunt neu zu erfinden, und sie derzeit einen Haufen Fehler neu machen,
die schon seit 20 Jahren nicht mehr Gegenstand der Forschung sind.
	-- Kristian K=F6hntopp =FCber blogs und blogger


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
