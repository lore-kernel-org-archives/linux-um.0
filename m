Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: uml <uml@dot1q.net>
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
	3.3.3 similarities to 2.6.6!?
Message-id: <005201c45496$51bd3b00$dd02a8c0@ferraro>
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
References: <114001c44bf7$b69ca120$2000000a@schlepptopp>
	<200406162109.57341.blaisorblade_spam@yahoo.it>
	<001e01c45480$c6e99380$dd02a8c0@ferraro>
	<200406171925.27567.blaisorblade_spam@yahoo.it>
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
Date: Thu, 17 Jun 2004 14:10:06 -0400
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net
Cc: roland <for_spam@gmx.de>

Ah, I only tried adding the -fno-unit-at-a-time switch to -O2.. it seemed to
work quite cleanly, and as well as expected by simply replacing the -O2
with -O1 as I was previously doing.

I'm really unsure about the attribute_used declaration, but if you can tell
me how or what to test, I'm more than willing to give it a few dozen
recompiles.

----- Original Message -----=20
From: "BlaisorBlade" <blaisorblade_spam@yahoo.it>
To: "uml" <uml@dot1q.net>; "uml-user"
<user-mode-linux-user@lists.sourceforge.net>;
<user-mode-linux-devel@lists.sourceforge.net>
Cc: "roland" <for_spam@gmx.de>
Sent: Thursday, June 17, 2004 1.25 PM
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
3.3.3 similarities to 2.6.6!?


Alle 17:35, gioved=EC 17 giugno 2004, uml ha scritto:
> Oops, I tried this the other day at the beginning of this thread -- it
> worked great for me.

Sorry for the silly question, but I was speaking about a *lot* of things, so
what did you try?

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-user mailing list
User-mode-linux-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
