Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApVL0-00011v-BF
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 07 Feb 2004 08:29:46 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1ApURF-0001RX-PV
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 07 Feb 2004 07:32:09 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] mconsole telinit design, worry about init standards?
References: <20040206003759.GY4203@erizo.shearer.org> <20040206054200.GC22141@patrick.wattle.id.au>
In-Reply-To: <20040206054200.GC22141@patrick.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402071633.18734.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 7 Feb 2004 16:33:18 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Cameron Patrick <cameron@patrick.wattle.id.au>

Alle 06:42, venerd=EC 6 febbraio 2004, Cameron Patrick ha scritto:
> Dan Shearer wrote:
> | I've got a rough implementation of an mcsonole telinit command, where
> | mconsole_kern opens /dev/initctl and sends a command to change
> | runlevels. Some small changes in arch/um/mconsole_kern.c.
> |
> | This raises a question about UML design.  UML shouldn't be dependent on
> | any specific program running inside the VM.
>
> How about having some kind of generic interface to allow the host to
> access files, send signals, etc inside the VM?  That would be overkill
> for a simple telinit but could open up other possibilities too.

Some time ago I posted an ugly but working patch to add this command to=20
mconsole:

exec <command line> - exec that command inside UML.

Thanks to cat, kill and so on, this patch extends to what you think and muc=
h=20
more - and reduces the code needed to implement that.

That patch didn't manage stdin and stdout (I first thought this) + was a bi=
t=20
bad and I haven't had time to correct it + Jeff Dike (and I agree with him)=
=20
didn't accept the patch, not because it was wrong (it worked) but because h=
e=20
felt that an exec command is useless (just open another console, even witho=
ut=20
login, to execute those commands), but if people are interested, I could=20
produce a 2.6 version with I/O support (maybe!). Note that I/O couldn't go =
to=20
mconsole - too much pain to do that, but to a "virtual" /dev/ttyN of user's=
=20
choice (one like the other virtual consoles).
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
