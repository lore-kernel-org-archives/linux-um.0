Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2BEI-0002WV-Tm for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 07:39:14 -0800
Received: from mekong.darkman.de
	([217.69.160.53] helo=mail.darkman.de ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B2BEF-0003Zf-UY for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 07:39:12 -0800
Received: from darkman.de (ezri.darkman.de [23.23.23.42])
	by mail.darkman.de (Postfix) with ESMTP id 9AAFE2EF84
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 13 Mar 2004 16:39:04 +0100 (CET)
Message-ID: <40532B18.2030005@darkman.de>
From: "Sven 'Darkman' Michels" <sven@darkman.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] Cryptolook device?
References: <c2v5sr$k1b$1@sea.gmane.org>
In-Reply-To: <c2v5sr$k1b$1@sea.gmane.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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
Date: Sat, 13 Mar 2004 16:39:04 +0100
Content-Transfer-Encoding: quoted-printable
To: UML devel list <user-mode-linux-devel@lists.sourceforge.net>

Sven K=F6hler wrote:
> hi,
>=20
> menuconfig doesn't show the crypto loopback device. i'm just curious,=20
> but why is it disabled? or has it just been forgotten?

Good question, once i tried to add twofish support (by a manual
patch) but it doesn't seem to work (maybe its due to the lack
of module support, but i'm not sure about)

Regards,
Sven



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
