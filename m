Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Subject: Re: [uml-devel] Re: [uml-user] SuSE 9.1 host + 2.4.26 Kernel + GCC
	3.3.3 similarities to 2.6.6!?
References: <114001c44bf7$b69ca120$2000000a@schlepptopp>
	<200406142109.45156.blaisorblade_spam@yahoo.it>
	<87oenle40x.fsf@amaterasu.srvr.nix>
	<200406162109.57341.blaisorblade_spam@yahoo.it>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200406162109.57341.blaisorblade_spam@yahoo.it> (BlaisorBlade's
	message of "Wed, 16 Jun 2004 21:09:57 +0200")
Message-ID: <87pt7yuidy.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Thu, 17 Jun 2004 19:52:25 +0100
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: uml <uml@dot1q.net>, roland <for_spam@gmx.de>, uml-user <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

On Wed, 16 Jun 2004, BlaisorBlade stated:
> Alle 08:20, marted=EC 15 giugno 2004, Nix ha scritto:
>> On Mon, 14 Jun 2004, BlaisorBlade mused:
>=20
>> > Well, ok, more hints, the first possible answer to this one seems to be
>> > that SuSE enables -funit-at-a-time:
>>
>> (unsurprising, given that -funit-at-a-time's primary author is jh@suse ;=
} )
>=20
> Well, someone following gcc development! Compliments! Do you think, too t=
hat=20
> SuSE gcc is a pre-release or heavily patched?

I think SuSE are using the `hammer branch' of GCC (described at
<http://gcc.gnu.org/cvs.html#devbranches>) with a few local patches.
unit-at-a-time was first implemented in this branch.

(hammer is a branch of GCC 3.3, and will eventually die: there are no
plans to forward-port it. Forward porting it to 3.5 would be horrible
anyway.)

>> Yep, -funit-at-a-time will definitely break kernels that aren't
>> expecting it, both because of elision of unused statics and because some
>> arches depend on emission of asm's at the top level to emit stuff in the
>> same order in generated code, and with -funit-at-a-time this just
>> doesn't happen anymore. (I don't think i386 is such an architecture,
>> though.)
>=20
> However, I would like to see a successful test-case with
> -fno-unit-at-a-time, plus understanding what are the faulting
> declaration (i.e. adding attribute_used where needed), before saying
> this bug is over.

Yep; just because there's one problem doesn't mean there aren't others
hiding underneath it.

>> > static const int hello ATTRIBUTE_USED  =3D 56;
>> >
>> > int main()
>> > {
>> >         asm(
>> >         "mov hello, %eax\n"
>> >         );
>>
>> Well, in this *specific* case, hello should be marked as clobbered,
>=20
> If you mean should be marked by the coder, ok (gcc is not smart).

GCC knows nothing whatever about the string in asm statements, so yes,
you have to mark it yourself.

--=20
`We in no way believe that this Christ was a space alien.'
                    --- A creationist website goes completely bonkers


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
