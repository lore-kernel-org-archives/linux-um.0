Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb24I-00042I-Th for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jun 2004 11:56:58 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Bb24I-0001Ke-2M for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jun 2004 11:56:58 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
	3.3.3 similarities to 2.6.6!?
References: <114001c44bf7$b69ca120$2000000a@schlepptopp>
	<200406171925.27567.blaisorblade_spam@yahoo.it>
	<005201c45496$51bd3b00$dd02a8c0@ferraro>
In-Reply-To: <005201c45496$51bd3b00$dd02a8c0@ferraro>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406172046.21192.blaisorblade_spam@yahoo.it>
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
Date: Thu, 17 Jun 2004 20:46:21 +0200
Content-Transfer-Encoding: quoted-printable
To: uml <uml@dot1q.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net
Cc: roland <for_spam@gmx.de>

Alle 20:10, gioved=EC 17 giugno 2004, hai scritto:
> Ah, I only tried adding the -fno-unit-at-a-time switch to -O2.. it seemed
> to work quite cleanly, and as well as expected by simply replacing the -O2
> with -O1 as I was previously doing.

Wow! Now we know what to do... thanks a lot!

> I'm really unsure about the attribute_used declaration, but if you can te=
ll
> me how or what to test, I'm more than willing to give it a few dozen
> recompiles.

Well, thanks a lot for your effort and availability... but the attribute_us=
ed=20
thing will be a series of little code changes, adding attribute_used to a l=
ot=20
of "static" simbols which gcc is somehow deleting. However, I cannot test=20
anything since I haven't the buggy gcc. Since you have, take a broken binar=
y=20
and a working one (the only difference must be the -fno-unit-at-a-time swit=
ch=20
in the right places) and run:

nm broken > list1
nm working > list2
diff -u list1 list2 > theChanges

and send me "theChanges" (I don't need nor want list1 or list2 for now, the=
y=20
are too big maybe for a 56k modem to download). With that at hand, it will =

take probably ten minutes for the fix.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
