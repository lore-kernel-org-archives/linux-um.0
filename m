Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: uml <uml@dot1q.net>
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
	3.3.3 similarities to 2.6.6!?
Message-id: <008001c454a5$c3663950$dd02a8c0@ferraro>
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
References: <114001c44bf7$b69ca120$2000000a@schlepptopp>
	<200406171925.27567.blaisorblade_spam@yahoo.it>
	<005201c45496$51bd3b00$dd02a8c0@ferraro>
	<200406172046.21192.blaisorblade_spam@yahoo.it>
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
Date: Thu, 17 Jun 2004 16:00:38 -0400
Content-Transfer-Encoding: quoted-printable
To: uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net
Cc: roland <for_spam@gmx.de>

OOps.. can't 'strip linux' before using nm... heh

It was 786K so I compressed it to 168K and it's available at
https://p0lar.dot1q.net/theChanges.bz2

I compiled both cleanly with the only change I made from the default config
was turning on module support for both.

Here's a quick transcript of the procedure:

cd /tmp
rm -rf /tmp/linux-2.6.6
tar -jxvf linux-2.6.6.tar.bz2
cd linux-2.6.6
bzcat ../uml-patch-2.6.6-1.bz2 | patch -p1
make menuconfig ARCH=3Dum
perl -e 's/-O2/-O2 -fno-unit-at-a-time/' -p -i.bak Makefile arch/um/Makefile
make linux modules ARCH=3Dum
cp linux ../uml/linux-2.6.6-working
cd /tmp
rm -rf /tmp/linux-2.6.6
tar -jxvf linux-2.6.6.tar.bz2
cd linux-2.6.6
bzcat ../uml-patch-2.6.6-1.bz2 | patch -p1
make menuconfig ARCH=3Dum
make linux modules ARCH=3Dum
cp linux ../uml/linux-2.6.6-broken
cd /tmp/uml
nm linux-2.6.6-broken > broken.list
nm linux-2.6.6-working > working.list
diff -u broken.list working.list > theChanges
bzip2 theChanges

Let me know if you need anything else!

----- Original Message -----=20
From: "BlaisorBlade" <blaisorblade_spam@yahoo.it>
To: "uml" <uml@dot1q.net>; "uml-user"
<user-mode-linux-user@lists.sourceforge.net>;
<user-mode-linux-devel@lists.sourceforge.net>
Cc: "roland" <for_spam@gmx.de>
Sent: Thursday, June 17, 2004 2.46 PM
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
3.3.3 similarities to 2.6.6!?


Alle 20:10, gioved=EC 17 giugno 2004, hai scritto:
> Ah, I only tried adding the -fno-unit-at-a-time switch to -O2.. it seemed
> to work quite cleanly, and as well as expected by simply replacing the -O2
> with -O1 as I was previously doing.

Wow! Now we know what to do... thanks a lot!

> I'm really unsure about the attribute_used declaration, but if you can
tell
> me how or what to test, I'm more than willing to give it a few dozen
> recompiles.

Well, thanks a lot for your effort and availability... but the
attribute_used
thing will be a series of little code changes, adding attribute_used to a
lot
of "static" simbols which gcc is somehow deleting. However, I cannot test
anything since I haven't the buggy gcc. Since you have, take a broken binary
and a working one (the only difference must be the -fno-unit-at-a-time
switch
in the right places) and run:

nm broken > list1
nm working > list2
diff -u list1 list2 > theChanges

and send me "theChanges" (I don't need nor want list1 or list2 for now, they
are too big maybe for a 56k modem to download). With that at hand, it will
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
