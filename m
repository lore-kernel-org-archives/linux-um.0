Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJYyh-0002f1-So for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Mar 2006 08:36:03 -0800
Received: from the-doors.enix.org ([193.19.211.1])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FJYyg-0002Dd-9h
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Mar 2006 08:36:03 -0800
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
Subject: Re: [uml-devel] Soft lockup with 2.6.15+bs3-tls
Message-ID: <20060315173556.62f206af@thomas.toulouse>
In-Reply-To: <20060315162130.GB4186@ccure.user-mode-linux.org>
References: <20060315135915.63d0443e@thomas.toulouse>
	<20060315162130.GB4186@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Wed, 15 Mar 2006 17:35:56 +0100
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi,

Thanks for your quick answer !

Le Wed, 15 Mar 2006 11:21:30 -0500,
Jeff Dike <jdike@addtoit.com> a =E9crit :

> Soft lockups are easy to reproduce with any heavy I/O load, but I
> haven't figured out what is going on.  They are harmless, though.  If
> you don't like the messages, you can just disable them in the config.

Ok.

> The OOM is more interesting.  Is that reproducable?

Yep. Fully. In fact, it's because I haven't given enough memory to
UML:

UML# cat /proc/meminfo | grep MemTotal
MemTotal:        27724 kB

With "mem=3D64M", it now works.

Sincerly,

Thomas
--=20
Thomas Petazzoni - thomas.petazzoni@enix.org
http://{thomas,sos,kos}.enix.org - http://www.toulibre.org
http://www.{livret,agenda}dulibre.org


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd________________________________________=
_______
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
