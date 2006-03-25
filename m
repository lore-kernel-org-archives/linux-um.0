Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNB9G-0004Xq-K9 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Mar 2006 07:57:54 -0800
Received: from zproxy.gmail.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FNB9C-0005eB-Fq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Mar 2006 07:57:51 -0800
Received: by zproxy.gmail.com with SMTP id n29so969911nzf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 25 Mar 2006 07:57:48 -0800 (PST)
Message-ID: <44256976.9010003@gmail.com>
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
MIME-Version: 1.0
Subject: Re: [uml-devel] Resend: how to debug module on UML kernel 2.6.15.6
	+ SKAS mode?
References: <442366BA.3080902@gmail.com>
	<200603241544.23878.blaisorblade@yahoo.it>
In-Reply-To: <200603241544.23878.blaisorblade@yahoo.it>
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
Date: Sat, 25 Mar 2006 23:01:58 +0700
To: Blaisorblade <blaisorblade@yahoo.it>, "D.Bahi" <dbahi@enterasys.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thank D. Bahi and Blaisorblade for your replies.

Blaisorblade wrote:
> On Friday 24 March 2006 04:25, Mikado wrote:
>> - Sometimes gdb can't follow source codes in '.h' header files. Did I
>> miss something?
> 
> What happens? Maybe gdb is stepping there but the calls are inlined and it's 
> not apparent that it's looking at source code. However I've not clear what 
> you describe, anyway.

Sometimes gdb can't access macros included in header files and it dumped
"some_header.h: No such file or directory". Those macros can contain
function calls so that I cannot trace that calls. Got any ideas?

Cheers,
Mikado.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJWl2NWc9T2Wr2JcRAib5AJ0TNyrDrXzhiu+l6scUBokqOJ03ggCgp0+3
bMnAeWM3wMQPfFgHB3vJRp8=
=SLX8
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
