Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AooXu-0000dW-1e
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 10:48:14 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AooXt-00050p-DN
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 10:48:13 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML & 2.6.2
References: <20040204173846.7522.qmail@praize.com>
In-Reply-To: <20040204173846.7522.qmail@praize.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200402051800.19582.blaisorblade_spam@yahoo.it>
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
Date: Thu, 5 Feb 2004 18:00:19 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: gboutwel <gboutwel@praize.com>

Alle 18:38, mercoled=EC 4 febbraio 2004, gboutwel ha scritto:
> Hey!

>   Here we go again.  I just checked out the 2.6.2 release ChangeLog.
>  Only thing I can see in there related to UML is a minor compile
> fix.

>   Do get an SKAS3/4 2.6.2 Host, and a 2.6.2 guest.  What do I
> need?  the Kernel Source, Ingos' combo patch (for SKAS), and
> the um-patch-2.6.1?

Mainly ok, only some notes:

1) Use Ingo's combo only for the host kernel (since the UML part for itself=
 is=20
out-of-date).

2) Now I've tested uml-patch-2.6.2 and there are a few minor rejects with t=
hat=20
patch. They are solved properly in this patch (I'm going to upload it, not =

yet done):

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/UML/2=
.6.2-v1/uml-patch-2.6.2-0.bz2

I've given it a quick test and it compiles and boots correctly, at least in=
=20
the reduced configuration I tried.

If you don't find it, that should mean that Jeff Dike already posted his pa=
tch=20
(which has also some functional changes).

That one has not any real change from Jeff Dike one; so with it don't enabl=
e=20
modules. If you want to use modules, read instructions at:

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/

you will probably choose to download:

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/UML/2=
.6.2-v1/00-Combo-v1.bz2

Bye
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
