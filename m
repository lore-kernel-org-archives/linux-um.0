Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMcs2-0006Eb-LX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 19:21:50 -0800
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FMcs0-0003Yr-PT
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 19:21:50 -0800
Received: by zproxy.gmail.com with SMTP id n29so645595nzf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 23 Mar 2006 19:21:48 -0800 (PST)
Message-ID: <442366BA.3080902@gmail.com>
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Resend: how to debug module on UML kernel 2.6.15.6 + SKAS
	mode?
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
Date: Fri, 24 Mar 2006 10:25:46 +0700
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


- - How can I debug loadable modules at run time?

Here is my way:

  ( /tmp/mymodule.ko exists on both [Host] and [UML] )
  + [Host] # gdb linux
  + [Host] (gdb) ...
  + [Host] (gdb) r <params>
  + [UML] # insmod /tmp/mymodule.ko
  + [UML] # cat /sys/module/mymodule/sections/{.text,.bss,.data}
  + [Host] (gdb) add-symbol-file /tmp/mymodule.ko <.text_addr> -s .bss
<.bss_addr> -s .data <.data_addr>
  + ...

Tell me if I was wrong, thanks!

- - How can I set breakpoint at module's init function?

After add module's symbol, I set breakpoint at init function then
'rmmod' then re-'insmod' but gdb didn't break at init function. What was
wrong?

- - Sometimes gdb can't follow source codes in '.h' header files. Did I
miss something?

Thanks in advance,
Mikado.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEI2a6NWc9T2Wr2JcRAiHtAJ0eenkXD5OpYyh6NgIalIqjYleU+ACfWn3i
ivKO51h+ATarQaxt+VNhhxs=
=cvsa
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
