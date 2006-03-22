Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FM5yS-0000Ot-HN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 08:14:16 -0800
Received: from zproxy.gmail.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FM5yR-0004go-5E
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 08:14:16 -0800
Received: by zproxy.gmail.com with SMTP id n29so199573nzf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 22 Mar 2006 08:14:13 -0800 (PST)
Message-ID: <442178BA.9080302@gmail.com>
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
MIME-Version: 1.0
Subject: Re: [uml-devel] Cannot debug UML
References: <44215200.8020708@gmail.com> <20060322135015.GC8115@SteX>
	<44215B8F.6060400@gmail.com>
	<200603221640.50362.blaisorblade@yahoo.it>
In-Reply-To: <200603221640.50362.blaisorblade@yahoo.it>
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
Date: Wed, 22 Mar 2006 23:18:02 +0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, jdike@addtoit.com, stefano.melchior@openlabs.it

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Blaisorblade wrote:
> For SKAS mode use the normal debug sequence:
> 
> $ gdb vmlinux
> (gdb) <set breakpoints, do what you want>
> (gdb) run <params>
> 
> More info at the "debugging UML" link, "SKAS" subsection on the main site.

Thank you Blaisorblade,

Oh sorry, I didn't keep my eyes open. It's easy to miss the "Kernel
debugging in skas mode" (
http://user-mode-linux.sourceforge.net/debugging-skas.html ) link on
"Kernel debugging" (
http://user-mode-linux.sourceforge.net/debugging.html ) section.

I wonder why "kernel debugging (under TT mode)" is accessed directly on
UML homepage when TT mode is "old".

Thank you all.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEIXi6NWc9T2Wr2JcRAlIeAKCLvElfMxfWgSDMRJSSO7Xv7M5ndwCfY4qk
MwW+qvmOQMOAQGgWyoPB7g8=
=yJ4o
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
