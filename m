Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNEP5-0001yZ-1x for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Mar 2006 11:26:27 -0800
Received: from linux01.gwdg.de ([134.76.13.21] ident=root)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FNEP3-0003yM-JH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Mar 2006 11:26:27 -0800
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <20060324144535.37b3daf7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0603252021330.29793@yvahk01.tjqt.qr>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
	<20060324144535.37b3daf7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="1283855629-591466255-1143314768=:29793"
Subject: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
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
Date: Sat, 25 Mar 2006 20:26:08 +0100 (MET)
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-591466255-1143314768=:29793
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by linux01.gwdg.de id
	k2PJQ9b0004535


>> +	char buf[sizeof("18446744073709551615\0")];
>
>rofl.  We really ought to have a #define for "this architecture's maximu=
m
>length of an asciified int/long/s32/s64".  Generally people do
>guess-and-giggle-plus-20%, or they just get it wrong.

And this one seems wrong[*] to me too (making it a rofl=C2=B2).
It is two chars (or one[*]) too long.

Consider this test:

	#include <stdio.h>
	#include <string.h>
	int main(void) {
	    printf("%d\n", sizeof("18446744073709551615\0"));
	    printf("%d\n", sizeof("18446744073709551615"));
	    printf("%d\n", strlen("18446744073709551615"));
	}

Which will print, when executed,

	22
	21
	20	(the "pure string" length)

[*] Depending on what the original author wanted.



Jan Engelhardt
--=20
--1283855629-591466255-1143314768=:29793--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
