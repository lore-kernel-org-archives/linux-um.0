Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3dqr-0001gR-Gl for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 09:57:21 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C3dqq-0001On-R2 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 09:57:21 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] PATCH - add crypto api config options to 2.4.x uml
References: <1094215272.22770.12.camel@develbox.linuxbox.cz>
In-Reply-To: <1094215272.22770.12.camel@develbox.linuxbox.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-15"
Message-Id: <200409041739.24688.blaisorblade_spam@yahoo.it>
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
Date: Sat, 4 Sep 2004 17:39:24 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nikola Ciprich <extmaillist@linuxbox.cz>, Jeff Dike <jdike@sonycom.com>

Alle 14:41, venerd=EC 3 settembre 2004, Nikola Ciprich ha scritto:
> Hi,
> this is just one-line change, cryptoapi seems to work well inside UML
> (I'm using it for ppp_mppe_mppc 1.1)
> Could someone apply it? btw are some special rules for patch submission?

Remember to cc: Jeff Dike, so it will see it sooner. In fact, I'm cc:ing th=
is=20
patch here to him.

diff -Naur linux-2.4.27/arch/um/config.in=20
linux-2.4.27-uml-cfg-cryptoapi/arch/um/config.in
--- linux-2.4.27/arch/um/config.in	2004-09-03 14:32:49.341551178 +0200
+++ linux-2.4.27-uml-cfg-cryptoapi/arch/um/config.in	2004-09-03=20
13:46:34.000000000 +0200
@@ -103,6 +103,8 @@
=20
 source lib/Config.in
=20
+source crypto/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 bool 'Debug memory allocations' CONFIG_DEBUG_SLAB

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idP47&alloc_id=10808&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
