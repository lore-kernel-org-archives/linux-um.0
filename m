Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApUmJ-0003uB-7D
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 07 Feb 2004 07:53:55 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1ApUmI-0001re-LU
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 07 Feb 2004 07:53:54 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] ANSWER: Basics of compiling and running UML 2.6.[1,2]
References: <20040207145149.GK4203@erizo.shearer.org>
In-Reply-To: <20040207145149.GK4203@erizo.shearer.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402071655.13934.blaisorblade_spam@yahoo.it>
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
Date: Sat, 7 Feb 2004 16:55:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 15:51, sabato 7 febbraio 2004, Dan Shearer ha scritto:
> There's been a few questions on and off-list about this, hopefully this
> will help until there's some tidying up done. The short version is that
> UML on 2.6.[1,2] works quite well, even before Jeff's done a stable
> release. I've probably missed things, please let me know.
>
> These instructions are for those new to UML, not new to kernels and
> distributions. The following might make your system unusable if you
> don't know what you're doingi to a basic level. But enough detail is
> given that if you *are* new to all this you aren't excluded from
> destroying your system in the process of learning.
>
> First, make sure you can compile a standard 2.6.x kernel without any UML
> at all. You may need to upgrade your binutils. gcc 3.2.3 and 3.3.0 is
> known to work.
>
> You can get assorted patch sets for UML 2.6.[1,2] from
> http://user-mode-linux.sourceforge.net/dl-uml-org.html and some a bit
> more recent from http://web.tiscali.it/blaisorblade/index.html. These
> don't quite compile for most people, but with the following twiddles it
> should work:
>
> 1. The default config for um isn't set up correctly. Do 'make menuconfig
> ARCH=um' and uncheck the following, all of which will prevent
> compilation or linking:
>
> 	a) SCSI support / SCSI support
>
> 	b) UML-specific options / Highmem support
Yes, for now it's so.

> 	c) Loadable modules support / Enable loadable module support

> 	d) Security options / Enable different security models

For this two, instead, in my patches 
(http://web.tiscali.it/blaisorblade/index.html, as you quote) there are the 
fixes. However disable CONFIG_MODVERSIONS (that should work, but I don't test 
it heavily + it's useless).

> 3. If you are running a 2.6.x host kernel and your new 2.6.x UML kernel
> appears to hang just after initialising the console driver (eg by all
> measures including commands such as 'uml_mconsole config con0' hanging
> it seems to have stopped) then check to see if you have a NPTL-enabled
> glibc. On RedHat or Debian systems running the 2.6 kernel you probably
> have, and if this is the case UML will not work under any circumstances
> (UML does not use the Native Posix Threading Library but glibc thinks
> it should... see the archives for a sparse description of the problem.)
>
> But never fear! Just recompile your own glibc without NPTL. Under Debian
> this is done by:

Wouldn't be better to suggest renaming /lib/tls to /lib/tls.off, as I've heard 
many times?
Also: check this site: http://uml.harlowhill.com/
that's a Wiki, i.e. anyone can edit it (no HTML-much simpler syntax). If you 
can put this guide in that site, people will probably use it very soon.

Bye
-- 
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
