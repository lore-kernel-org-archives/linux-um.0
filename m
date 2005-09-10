Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EE9jO-0006o0-6n	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:05:38 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EE9jM-0006zY-JX
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:05:38 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] NPTL status?
References: <20050909162442.GA11934@trixie.casa.cgf.cx>
In-Reply-To: <20050909162442.GA11934@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200509101619.38922.blaisorblade@yahoo.it>
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
Date: Sat, 10 Sep 2005 16:19:38 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Christopher Faylor <me@cgf.cx>

On Friday 09 September 2005 18:24, Christopher Faylor wrote:
> As I understand it NPTL support in UML is still a work in progress.  Is
> this correct?  If so, is there an experimental patch set which works
> better with NPTL
Yes, but I'd really underline _experimental_.
> and might allow things like RHEL4 to boot=20
> out-of-the-box?
Basically, no. At least nothing you'd rely onto.
There is something like that, but it doesn't work very well yet.

If you browse my website, in the patches directory:

http://www.user-mode-linux.org/~blaisorblade/patches/devel-guest/

there are some test trees which include TLS support code.

It depends - at this stage, because of the difference between distros (glib=
c=20
version mainly), with the same code I can see one behaviour (say "nothing=20
works") and somebody else have no problem.

My Debian Sarge appears to be very picky, while Jeff, with more or less the=
=20
same patches, has FC4 working "well enough" (there are still some spurious =

segfaults, however).

And S=E9bastien Dugu=E9 tried LinuxFromScratch 6.1 with glibc 2.3.5 and it =
worked=20
well - but I think LFS is not a heavy stress tool for NPTL.

> I am currently using a 2.6.12 guest kernel with RH9 rootfs and have
> moved things around in /lib so as to avoid problems with NPTL but
> I was hoping that there might be some improvements which would allow
> me to use later versions of glibc without modification.
RH9 is entirely different - that wouldn't even work with a plain 2.6 kernel=
 on=20
i386, I think.

In fact, I've seen some early NPTL code on Ingo Molnar's site and it isn't =
at=20
all compatible with current API. So RH9's NPTL will never be supported.
> Is this possible?

> cgf

--=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

=09

=09
	=09
___________________________________=20
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB=20
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
