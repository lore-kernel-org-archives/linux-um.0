Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2KQR-0007jO-NE for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 17:28:23 -0800
Received: from mekong.darkman.de
	([217.69.160.53] helo=mail.darkman.de ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B2KQP-000428-A3 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 17:28:21 -0800
Received: from darkman.de (ezri.darkman.de [23.23.23.42])
	by mail.darkman.de (Postfix) with ESMTP id 44EC52EF84
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Mar 2004 02:28:04 +0100 (CET)
Message-ID: <4053B523.10203@darkman.de>
From: "Sven 'Darkman' Michels" <sven@darkman.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] Cryptolook device?
References: <5.2.0.9.0.20040313192828.02fdaea0@crunch>
	<4053AD51.3030704@upb.de>
In-Reply-To: <4053AD51.3030704@upb.de>
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
Date: Sun, 14 Mar 2004 02:28:03 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Sven K=F6hler wrote:

> I'm talking about 2.6.4-um1 which doesn't include the CryptoLoop device=20
> although it is available in 2.6.4 without any additional patch.
> It seems to me, as if Jeff just forgot to put it into some file (i'm=20
> don't know much about how menuconfig works, and where the config for=20
> that is).

for 2.4.x:
add:

source crypto/Config.in

at the end of arch/um/config.in

to get the options... BUT:
i don't know if thats enough. I played with 2.4 and can't get it
to work. /proc/crypto is there and looks ok, but losetup doesn't
work. Probably because i'm using a non modular kernel.

Regards,
Sven (the other one ;)



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
