Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FM41y-0001pC-Ol for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 06:09:46 -0800
Received: from zproxy.gmail.com ([64.233.162.199])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FM41y-00058E-1G
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 06:09:46 -0800
Received: by zproxy.gmail.com with SMTP id n29so162638nzf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 22 Mar 2006 06:09:45 -0800 (PST)
Message-ID: <44215B8F.6060400@gmail.com>
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
MIME-Version: 1.0
Subject: Re: [uml-devel] Cannot debug UML
References: <44215200.8020708@gmail.com> <20060322135015.GC8115@SteX>
In-Reply-To: <20060322135015.GC8115@SteX>
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
Date: Wed, 22 Mar 2006 21:13:35 +0700
To: stefano.melchior@openlabs.it
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefano Melchior wrote:
> On Wed, Mar 22, 2006 at 08:32:48PM +0700, Mikado wrote:
> Hi Mikado,

Hi Stex

> same problem as mine:
> ./linux mode=tt debug ubd0=root_fs ubd1=swap mem=128MB eth0=tuntap,,,192.168.0.254
> 
> You wrongly used "mem" option!

I've checked my UML's memory, it's exactly 128MB. But thank you, I will
follow UML rules.

> First, see man user-mode-linux, you can not specify "mem=128MB", at least
> "mem=128M". But for issue tied to TT option sometimes you need to use
> "mem=xxxm" and sometimes "mem=xxxM".
> Please de-select TT in the uml kernel, then try again

Debugging UML requires running it under TT mode. Normally I run UML
under SKAS mode, everything is OK. I cannot get into GDB under SKAS mode
whenever I use 'debug' option.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEIVuPNWc9T2Wr2JcRAjsWAKDZqL/h6J/aPez9thhcgF2+Ee7BNwCeMaxh
tLYonH5TOq0yg/7A6lCq3ag=
=etco
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
