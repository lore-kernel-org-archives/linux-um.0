Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EwntH-0007LT-1x for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Jan 2006 13:52:23 -0800
Received: from htr2.enterasys.com ([63.160.138.51] ident=firewall-user)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EwntC-0000oz-Pf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Jan 2006 13:52:23 -0800
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2 [134.141.79.124])
	by htr2.enterasys.com (0.25.1/8.12.6) with ESMTP id k0BLjpPO014864
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 11 Jan 2006 16:45:52 -0500 (EST)
Message-ID: <43C57E08.5000501@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
References: <200511161100.31053.rob@landley.net>
	<200511180858.43760.blaisorblade@yahoo.it>
	<200511180259.59589.rob@landley.net>
	<200511190335.06204.blaisorblade@yahoo.it>
In-Reply-To: <200511190335.06204.blaisorblade@yahoo.it>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB3FCD6580FE851699A4B59FF"
Subject: [uml-devel] tls incrementals for 2.6.15 breaking build ... still?
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
Date: Wed, 11 Jan 2006 16:52:08 -0500
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3FCD6580FE851699A4B59FF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

i'm trying to build an 'uptodate' UML guest and see exactly this
'undefined reference to indirect_set_thread_area' (reported in November)
with 2.6.15 and all the incrementals from the patch tarball for
2006-01-08 on user-mode-linux.sf.net.

the comment related to this patch says CONFIG_MODE_ TT 'off' ... but
this email says try it 'on' and that just leads to:

  CC      arch/um/os-Linux/tls.o
arch/um/os-Linux/tls.c:48: error: syntax error before "get_thread_area"
arch/um/os-Linux/tls.c:48: warning: type defaults to `int' in
declaration of `_syscall1'
arch/um/os-Linux/tls.c:48: warning: function declaration isn't a prototyp=
e
arch/um/os-Linux/tls.c:48: warning: data definition has no type or
storage class
arch/um/os-Linux/tls.c:49: error: syntax error before "set_thread_area"
arch/um/os-Linux/tls.c:49: warning: type defaults to `int' in
declaration of `_syscall1'
arch/um/os-Linux/tls.c:49: warning: function declaration isn't a prototyp=
e
arch/um/os-Linux/tls.c:49: warning: data definition has no type or
storage class
arch/um/os-Linux/tls.c:51: warning: "struct user_desc" declared inside
parameter list
arch/um/os-Linux/tls.c:51: warning: its scope is only this definition or
declaration, which is probably not what you want
arch/um/os-Linux/tls.c: In function `do_set_thread_area_tt':
arch/um/os-Linux/tls.c:55: warning: implicit declaration of function
`set_thread_area'
arch/um/os-Linux/tls.c: At top level:
arch/um/os-Linux/tls.c:62: warning: "struct user_desc" declared inside
parameter list
arch/um/os-Linux/tls.c: In function `do_get_thread_area_tt':
arch/um/os-Linux/tls.c:66: warning: implicit declaration of function
`get_thread_area'
make[1]: *** [arch/um/os-Linux/tls.o] Error 1


Blaisorblade wrote:
> On Friday 18 November 2005 09:59, Rob Landley wrote:
>  =20
>> On Friday 18 November 2005 01:58, Blaisorblade wrote:
>>    =20
>>>> arch/um/sys-i386/built-in.o(.text+0x3b60): In function `load_TLS':
>>>> : undefined reference to `indirect_set_thread_area'
>>>>
>>>> collect2: ld returned 1 exit status
>>>>   KSYM    .tmp_kallsyms1.S
>>>> nm: '.tmp_vmlinux1': No such file
>>>> No valid symbol.
>>>> make[2]: *** [.tmp_kallsyms1.S] Error 1
>>>> make[1]: *** [_all] Error 2
>>>> make: *** [all] Error 2
>>>>
>>>> This is progress!
>>>>        =20
>>> Disable TT mode or play with such things IIRC
>>>      =20
>> Nope, tt mode already is disabled.
>>    =20
>
> Be creative - enable it then... yep, indirect_... is defined only when =
TT is=20
> active, but is also used otherwise.
>
>  =20
>>> - actually there's a proper
>>> fix along lines of "move #ifdef's inside sys-i386/tls.c to properly c=
ater
>>> to dependencies" if you want.
>>>
>>> This comes from the TLS patches btw...
>>>      =20
>
>  =20
>> I'll be banging on this more in a bit...
>>    =20
>
>  =20
>> Rob
>>    =20
>
>  =20


--------------enigB3FCD6580FE851699A4B59FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iD8DBQFDxX4N3XQ4zakZ3z4RArzpAJ4qQDNwtVk3Q9J+02cC7T7Wsva9vwCdETSM
AMYuGhvd70RU0xEnxz2LGN4=
=nNEc
-----END PGP SIGNATURE-----

--------------enigB3FCD6580FE851699A4B59FF--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
