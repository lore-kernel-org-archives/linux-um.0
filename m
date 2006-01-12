Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ewv2J-0003r1-KO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Jan 2006 21:30:11 -0800
Received: from htr2.enterasys.com ([63.160.138.51] ident=firewall-user)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ewv2H-0000kW-7j
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Jan 2006 21:30:11 -0800
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2 [134.141.79.124])
	by htr2.enterasys.com (0.25.1/8.12.6) with ESMTP id k0C5NgPO013903
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 12 Jan 2006 00:23:42 -0500 (EST)
Message-ID: <43C5E957.707@enterasys.com>
From: "D. Bahi" <dbahi@enterasys.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] tls incrementals for 2.6.15 breaking build ... still?
References: <200511161100.31053.rob@landley.net>
	<200511180858.43760.blaisorblade@yahoo.it>
	<200511180259.59589.rob@landley.net>
	<200511190335.06204.blaisorblade@yahoo.it>
	<43C57E08.5000501@enterasys.com>
In-Reply-To: <43C57E08.5000501@enterasys.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE6EE1EE40204DCED5CD702DC"
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
Date: Thu, 12 Jan 2006 00:29:59 -0500
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6EE1EE40204DCED5CD702DC
Content-Type: multipart/mixed; boundary="------------010409010502070102040608"

This is a multi-part message in MIME format.
--------------010409010502070102040608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

so instead of just my usual whining attached is a suggested fix ;)

D. Bahi wrote:
> i'm trying to build an 'uptodate' UML guest and see exactly this
> 'undefined reference to indirect_set_thread_area' (reported in November=
)
> with 2.6.15 and all the incrementals from the patch tarball for
> 2006-01-08 on user-mode-linux.sf.net.
>
> the comment related to this patch says CONFIG_MODE_ TT 'off' ... but
> this email says try it 'on' and that just leads to:
>
>   CC      arch/um/os-Linux/tls.o
> arch/um/os-Linux/tls.c:48: error: syntax error before "get_thread_area"=

> arch/um/os-Linux/tls.c:48: warning: type defaults to `int' in
> declaration of `_syscall1'
> arch/um/os-Linux/tls.c:48: warning: function declaration isn't a protot=
ype
> arch/um/os-Linux/tls.c:48: warning: data definition has no type or
> storage class
> arch/um/os-Linux/tls.c:49: error: syntax error before "set_thread_area"=

> arch/um/os-Linux/tls.c:49: warning: type defaults to `int' in
> declaration of `_syscall1'
> arch/um/os-Linux/tls.c:49: warning: function declaration isn't a protot=
ype
> arch/um/os-Linux/tls.c:49: warning: data definition has no type or
> storage class
> arch/um/os-Linux/tls.c:51: warning: "struct user_desc" declared inside
> parameter list
> arch/um/os-Linux/tls.c:51: warning: its scope is only this definition o=
r
> declaration, which is probably not what you want
> arch/um/os-Linux/tls.c: In function `do_set_thread_area_tt':
> arch/um/os-Linux/tls.c:55: warning: implicit declaration of function
> `set_thread_area'
> arch/um/os-Linux/tls.c: At top level:
> arch/um/os-Linux/tls.c:62: warning: "struct user_desc" declared inside
> parameter list
> arch/um/os-Linux/tls.c: In function `do_get_thread_area_tt':
> arch/um/os-Linux/tls.c:66: warning: implicit declaration of function
> `get_thread_area'
> make[1]: *** [arch/um/os-Linux/tls.o] Error 1
>
>
> Blaisorblade wrote:
>  =20
>> On Friday 18 November 2005 09:59, Rob Landley wrote:
>>  =20
>>    =20
>>> On Friday 18 November 2005 01:58, Blaisorblade wrote:
>>>    =20
>>>      =20
>>>>> arch/um/sys-i386/built-in.o(.text+0x3b60): In function `load_TLS':
>>>>> : undefined reference to `indirect_set_thread_area'
>>>>>
>>>>> collect2: ld returned 1 exit status
>>>>>   KSYM    .tmp_kallsyms1.S
>>>>> nm: '.tmp_vmlinux1': No such file
>>>>> No valid symbol.
>>>>> make[2]: *** [.tmp_kallsyms1.S] Error 1
>>>>> make[1]: *** [_all] Error 2
>>>>> make: *** [all] Error 2
>>>>>
>>>>> This is progress!
>>>>>        =20
>>>>>          =20
>>>> Disable TT mode or play with such things IIRC
>>>>      =20
>>>>        =20
>>> Nope, tt mode already is disabled.
>>>    =20
>>>      =20
>> Be creative - enable it then... yep, indirect_... is defined only when=
 TT is=20
>> active, but is also used otherwise.
>>
>>  =20
>>    =20
>>>> - actually there's a proper
>>>> fix along lines of "move #ifdef's inside sys-i386/tls.c to properly =
cater
>>>> to dependencies" if you want.
>>>>
>>>> This comes from the TLS patches btw...
>>>>      =20
>>>>        =20
>>  =20
>>    =20
>>> I'll be banging on this more in a bit...
>>>    =20
>>>      =20
>>  =20
>>    =20
>>> Rob
>>>    =20
>>>      =20
>>  =20
>>    =20
>
>  =20

--------------010409010502070102040608
Content-Type: text/x-patch;
 name="tls_no_tt.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="tls_no_tt.patch"

--- linux-2.6.15/arch/um/sys-i386/tls.c~	2006-01-11 20:04:35.528386774 -0=
500
+++ linux-2.6.15/arch/um/sys-i386/tls.c	2006-01-11 20:05:45.600027039 -05=
00
@@ -134,7 +134,7 @@ int load_TLS(int flags, struct task_stru
 		if (!(flags & O_FORCE) && curr->flushed)
 			continue;
=20
-		ret =3D (flags & O_INDIRECT) ? indirect_set_thread_area(&curr->tls): d=
o_set_thread_area(&curr->tls);
+		ret =3D CHOOSE_MODE_PROC( indirect_set_thread_area, do_set_thread_area=
, &curr->tls );
 		if (ret)
 			goto out;
=20

--------------010409010502070102040608--

--------------enigE6EE1EE40204DCED5CD702DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iD8DBQFDxelc3XQ4zakZ3z4RAqyRAJwLCa1zJ13RJySwwAZv33OiFt33TwCfeLom
3LYZ9gkLaxpqiYcKZ/4BY14=
=DtaE
-----END PGP SIGNATURE-----

--------------enigE6EE1EE40204DCED5CD702DC--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
