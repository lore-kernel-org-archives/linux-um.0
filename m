Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AmxZs-0001A9-2Z for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Jan 2004 08:02:36 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AmxZr-0005Ga-EE for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Jan 2004 08:02:35 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel 2.6.1 uml 2.6.1-1 build failed with module
	support
References: <028501c3e1e2$aefcd6d0$6f01a8c0@alex>
In-Reply-To: <028501c3e1e2$aefcd6d0$6f01a8c0@alex>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Message-Id: <200401311703.37848.blaisorblade_spam@yahoo.it>
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
Date: Sat, 31 Jan 2004 17:03:37 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alexander Newald <alexander@newald.de>

Alle 19:57, venerd=EC 23 gennaio 2004, Alexander Newald ha scritto:
> Hello,

> I've updated to the latest uml patch,
> enabled module support
For now disable module support. That does not work in the releases on the s=
ite=20
(yet).
The needed patches have already been written and will be included in the ne=
xt=20
release, so you can wait for that (but *disable CONFIG_MODVERSIONS* with=20
that).

Or you can try this URL:
http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/UML/2=
.6.1-v1/

use the combo -v1 from that page. If you want absolutely to use the split=20
patches, take at least the C-02 and G-02 ones.

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
