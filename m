Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DnHpH-0000Zo-Q0	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Jun 2005 08:16:39 -0700
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DnHpG-00033v-Ft	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Jun 2005 08:16:39 -0700
Message-ID: <42C169D0.50206@tuxrocks.com>
From: Frank Sorenson <frank@tuxrocks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Kernel panic in dump fpu with 2.6.11.11
References: <6028.1119969442@www81.gmx.net>
In-Reply-To: <6028.1119969442@www81.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
Date: Tue, 28 Jun 2005 09:16:32 -0600
To: Dominik Vogt <dominik.vogt@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dominik Vogt wrote:
> in dump_fpu(), so that copy_fpu_fxsave_tt() is never called.  The
> application always coredumps in
> 
>   /lib/tls/libc.so.6(__clone+0x5a)[0x4026118a]
> 
> which I guess is part of the threading library in libc.  This
> crash is 100% reproducable.

UML doesn't support TLS yet.  Try disabling it by moving /lib/tls out of
the way ("mv /lib/tls /lib/tls.disabled" for example).

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCwWnPaI0dwg4A47wRAru0AJ9O8ujVdcAXHhwooL6mo73YYWA6RwCfXx0z
TQzlSlf8JZhWgQEkHan/L+E=
=Lp4a
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
