Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhvuO-0000Qn-CE for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:15:00 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AhvuN-0001pm-SN for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:15:00 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml-patch-2.6.0
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
In-Reply-To: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200401172009.50449.blaisorblade_spam@yahoo.it>
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
Date: Sat, 17 Jan 2004 20:09:50 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Alle 06:05, marted=EC 13 gennaio 2004, Jeff Dike ha scritto:
> This patch updates UML to 2.6.0 and pulls in all the changes that have
> accumulated in my 2.4 tree.

Thanks for that (it was really needed). However, about the various fixes I =

built, there is a lot of that that should go in. Go here:

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/UML/2=
.6.1-v1/

I've updated all the stuff that was there. You claimed you didn't want some=
=20
patches, now I've organized things so they can be easily excluded. Do *not*=
=20
use the combo.

This are some brief patches descriptions (in the 00-README).
C-03 (trivial, removes smplock.h which went away)
C-04 (sys-i386/fault.c shouldn't even compile for now, as the exception=20
handling has had a syntactic change)
G-01 (one-liner for SELinux build, from M A Young)
G-02 (makes /proc/kallsyms work well and cleanups link scripts)

H-01 (consider that for PCAP linking; you claim in Makefile comments kbuild=
=20
doesn't allow to link -lpcap, that show it's possible).
H-02 (when configuration is changed, the whole UML is rebuilt again because=
=20
all files depend on uml-config.h which depends on all configuration. Trivia=
l=20
fix).

Module support fix is trivial, and does not depend on anything controversia=
l,=20
until you don't enable CONFIG_MODVERSIONS. So apply the patch. I've also=20
infos (and some code) about fixing the panic you get on startup with it=20
enabled.

The patches you mustn't apply from there are the H-03 and H-04, since H-03 =
is=20
the USER_OBJ thing and the H-04 depends on it (even if is logically=20
independent).

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
