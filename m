Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bp6Ip-00020u-9E for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 07:18:07 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1Bp6Io-0005Up-Mb for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 07:18:07 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] I ported skas3 to fc2 kernel
References: <Pine.LNX.4.44.0407221901400.1382-100000@hfuhruhurr.iostream.com>
In-Reply-To: <Pine.LNX.4.44.0407221901400.1382-100000@hfuhruhurr.iostream.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407261620.23840.blaisorblade_spam@yahoo.it>
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
Date: Mon, 26 Jul 2004 16:20:23 +0200
Content-Transfer-Encoding: quoted-printable
To: Jinnah Dylan Hosein <jdh66+spam@jdh.org>, user-mode-linux-devel@lists.sourceforge.net

Alle 01:13, venerd=EC 23 luglio 2004, Jinnah Dylan Hosein ha scritto:
> I ported the host-skas3-2.6.7-v1.patch to the Fedora Core 2 kernel.
>
> I used the latest fc2 2.6.6-1.435.2.3 kernel rpm.
>
> I've tested it and I was able to run a 2.4.19 uml kernel with a redhat
> 7.2 rootfs. I wasn't able to make it leak memory by running the "while
> true" bash line, but I don't understand exactly what triggers the leak so
> it's likely I didn't properly test.

Well, it's a bit difficult to trigger; to the best of my understanding, it =
can=20
be triggered if UML is a child or grandchild of a multi-threaded process=20
using the TLS, i.e. Thread-Local Storage (as KDE Konsole) running either wi=
th=20
LinuxThreads support (i.e. either glibc is not NPTL-aware or is running ont=
o=20
a 2.4 host kernel).

More technically, if any process modifies its LDT (by using the modify_ldt(=
)=20
syscall), any of its child processes will have the LDT set, and if UML has =

the LDT set it will then leak memory.

That said, I don't have time to look at it well but I don't see anything ba=
d,=20
at a quick look; the port is not a simple rediff so there could be some=20
little changes needed, but if it runs Ok, I wouldn't worry.

For the SKAS + UML patch: it's easy to rebuild it from the splitout version=
=20
(you must browse the folders to find it, should be something like=20
patches/2.6.7-v1), but you can get by without it, so I'll build it only if =
I=20
get free time. I've not even had the time to join the SKAS - leak fix with =

the rest of the patch!
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
