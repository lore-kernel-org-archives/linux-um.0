Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: uml <uml@dot1q.net>
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
	3.3.3 similarities to 2.6.6!?
Message-id: <001e01c45480$c6e99380$dd02a8c0@ferraro>
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
References: <114001c44bf7$b69ca120$2000000a@schlepptopp>
	<200406142109.45156.blaisorblade_spam@yahoo.it>
	<87oenle40x.fsf@amaterasu.srvr.nix>
	<200406162109.57341.blaisorblade_spam@yahoo.it>
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
Date: Thu, 17 Jun 2004 11:35:49 -0400
Content-Transfer-Encoding: quoted-printable
To: uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net
Cc: roland <for_spam@gmx.de>

Oops, I tried this the other day at the beginning of this thread -- it
worked great for me.

I'm afraid I just don't know enough about lower level compiling options or
gcc have ever diagnosed this myself; however, I don't mind recompiling a
kernel 100 times to see what works -- or doesn't. (=3D

Thanks!


----- Original Message -----=20
From: "BlaisorBlade" <blaisorblade_spam@yahoo.it>
To: "Nix" <nix@esperi.org.uk>
Cc: "uml" <uml@dot1q.net>; "roland" <for_spam@gmx.de>; "uml-user"
<user-mode-linux-user@lists.sourceforge.net>;
<user-mode-linux-devel@lists.sourceforge.net>
Sent: Wednesday, June 16, 2004 3.09 PM
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
3.3.3 similarities to 2.6.6!?


Alle 08:20, marted=EC 15 giugno 2004, Nix ha scritto:
> On Mon, 14 Jun 2004, BlaisorBlade mused:

> > Well, ok, more hints, the first possible answer to this one seems to be
> > that SuSE enables -funit-at-a-time:
>
> (unsurprising, given that -funit-at-a-time's primary author is jh@suse
;} )

Well, someone following gcc development! Compliments! Do you think, too that
SuSE gcc is a pre-release or heavily patched?

> Yep, -funit-at-a-time will definitely break kernels that aren't
> expecting it, both because of elision of unused statics and because some
> arches depend on emission of asm's at the top level to emit stuff in the
> same order in generated code, and with -funit-at-a-time this just
> doesn't happen anymore. (I don't think i386 is such an architecture,
> though.)

However, I would like to see a successful test-case
with -fno-unit-at-a-time,
plus understanding what are the faulting declaration (i.e. adding
attribute_used where needed), before saying this bug is over.

> -funit-at-a-time is enabled by default for C and C++ in GCC 3.4.
>
> > This is the trick:
> The sort of thing you want to stash away in a header file and never lay
> eyes on again. :)

Well, this is already done, in the kernel: see the definition of
attribute_used in linux/compiler-gcc*.h.

> > static const int hello ATTRIBUTE_USED  =3D 56;
> >
> > int main()
> > {
> >         asm(
> >         "mov hello, %eax\n"
> >         );
>
> Well, in this *specific* case, hello should be marked as clobbered,

If you mean should be marked by the coder, ok (gcc is not smart).

> which will also stop the compiler eliding it. But this *was* a contrived
> testcase...

Bye!
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
