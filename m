Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMPWn-00084x-Vw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Oct 2004 04:30:13 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CMPWm-00065f-PK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Oct 2004 04:30:13 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <20041024033801.EBDDE1D1489@sc8-sf-uberspam1.sourceforge.net>
	<200410260231.59697.blaisorblade_spam@yahoo.it>
	<d5d4185b041025220324d20c9e@mail.gmail.com>
In-Reply-To: <d5d4185b041025220324d20c9e@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200410261331.04030.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Re: 2.6.9 guest - no make linux target
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
Date: Tue, 26 Oct 2004 13:31:04 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-user@lists.sourceforge.net, Jeremy Utley <jerutley@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 26 October 2004 07:03, Jeremy Utley wrote:
> On Tue, 26 Oct 2004 02:31:59 +0200, BlaisorBlade
>
> <blaisorblade_spam@yahoo.it> wrote:
> > On Tuesday 26 October 2004 02:30, Sven K=F6hler wrote:
> > > >>This looks like a problem i had too! It was caused by
> > > >> compiling/running the kernel on a NPTL-enabled system. So i
> > > >> downgraded to a
> > > >>non-NPTL-glibc, and everything worked fine again.
> > > >
> > > > It would work also on a NPTL glibc, but it must be setup as in
> > > > mainstream distros - i.e. a non-NPTL glibc in /lib and the NPTL one
> > > > elsewhere, i.e. in /lib/tls. Otherwise, UML is linked against the
> > > > NPTL glibc and does not work.

> Which would mean that no binaries compiled on that system will be
> linked against NPTL, without modifying the LD_LIBRARY_PATH.  IMHO,
> this still needs to be resolved in some way.

No, this is (slightly) false. Or better, I've read directly the document on=
=20
LD_ASSUME_KERNEL on Ulrich Drepper's homepage=20
(http://people.redhat.com/drepper/). The doc is at:

http://people.redhat.com/drepper/assumekernel.html

What happens on RedHat/FedoraCore:
- ld-linux.so.2 searches first /lib/tls, then /lib/i686, then /lib (which i=
s=20
like modifying LD_LIBRARY_PATH, but hardcoded in the linker).

This is done to match the LD_ASSUME_KERNEL orderings - ld-linux.so will loa=
d a=20
library only if its ABI tag (which is stored inside the library and can be =

read with eu-readelf --notes) is not stricter than the running kernel. The =

linker does not search for the stricter requirements, so the search path mu=
st=20
be the above one.

$ eu-readelf --notes /lib/tls/libc.so.6

Note segment of 32 bytes at offset 0x00000154:
  Owner          Data size  Type
  GNU                   16  VERSION
    OS: Linux, ABI: 2.4.25

$ eu-readelf --notes /lib//libc.so.6

Note segment of 32 bytes at offset 0x00000134:
  Owner          Data size  Type
  GNU                   16  VERSION
    OS: Linux, ABI: 2.2.5

$ eu-readelf --notes /lib/i686/libc.so.6

Note segment of 32 bytes at offset 0x00000134:
  Owner          Data size  Type
  GNU                   16  VERSION
    OS: Linux, ABI: 2.4.1

> > > So UML will not run on NPTL-enabled gentoo-systems, since
> > > gentoo-ebuilds won't build two glibcs (actually they will in the
> > > future, but those ebuilds aren't stable yet).

> > Ah, so that is the only problem? And "not stable" means that it is
> > "~x86" (almost perfect) or "-*" (dangerous)? I'll check by myself anywa=
y.

> > > Will the right libc.so
> > > from /lib be loaded instead of the one from /lib/tls?
No, the /lib/tls one should get loaded, but in that case it seems to work.

Actually, I've never heard that UML has (unfixed) bugs when linked to NPTL.=
=20
Apart from link failures on recent glibc/toolchains :-(, which is not your =

case.

> > On my MDK it works quite fine. And it has glibc2.3.3 (actually this is
> > meaningless, since distros anyway must use snapshots).

> MDK's glibc, even in 10.0, is NOT using NPTL - it's still using
> linuxthreads - to see, run the /lib/libc.so.6 from a shell prompt, and
> see the output - you'll note there's no mention of NPTL.

You still refuse to take a look at my point. Look at the /lib/tls one, whic=
h=20
is NPTL-enabled. Neither RH/FC nor Mandrake, nor I guess SuSE, put a NPTL=20
enabled glibc in /lib. /lib/tls is the right location.

The only current distro without NPTL support, for what I know, is Slackware=
=20
10.0.

$ /lib/libc.so.6
[...]
Compiled by GNU CC version 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk).
Compiled on a Linux 2.6.0 system on 2004-02-16.
Available extensions:
        GNU libio by Per Bothner
        crypt add-on version 2.1 by Michael Glad and others

        linuxthreads-0.10 by Xavier Leroy

        BIND-8.2.3-T5B
        libthread_db work sponsored by Alpha Processor Inc
        NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
Thread-local storage support included.

$ /lib/tls/libc.so.6
[...]

Compiled by GNU CC version 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk).
Compiled on a Linux 2.6.0 system on 2004-02-16.
Available extensions:
        GNU libio by Per Bothner
        crypt add-on version 2.1 by Michael Glad and others

(Are you noticing this?)
        NPTL 0.60 by Ulrich Drepper

        BIND-8.2.3-T5B
        NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk

Thread-local storage support included.

> What needs to happen is for someone VERY familiar with the UML code to
> dig in, and find out why the binutils assertion failure keeps tripping
> up.  That's the only error that currently comes about, and it causes
> any UML kernel to segfault immediately upon execution.  I have straces
> available of the linux binary showing where it segfaults.

I can get the assertion failure on FC2 - 64bit. I think I could run the=20
binary, but I would not be surprised that I forgot to actually make sure of=
=20
that.

The first thing I'm trying to do is to add "executable_start" as in the=20
default ld linker scripts. When it will work, I'll let you know.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
