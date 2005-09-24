Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJERQ-0001Vs-1q	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 11:08:04 -0700
Received: from zproxy.gmail.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EJERN-0001XU-E2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 11:08:04 -0700
Received: by zproxy.gmail.com with SMTP id i11so948318nzh
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 24 Sep 2005 11:07:49 -0700 (PDT)
Message-ID: <229e70f20509241107392fd4e5@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Reply-To: Etay Meiri <etay.meiri@gmail.com>
Subject: Re: [uml-devel] 2.6.13.2 + gcc 4.01 link error
In-Reply-To: <200509241854.53536.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_10079_19447309.1127585268772"
References: <229e70f2050924085215707921@mail.gmail.com>
	 <200509241854.53536.blaisorblade@yahoo.it>
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
Date: Sat, 24 Sep 2005 21:07:48 +0300
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

------=_Part_10079_19447309.1127585268772
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks, it worked.

-Etay

On 9/24/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> On Saturday 24 September 2005 17:52, Etay Meiri wrote:
> > Hi,
> >
> > I'm trying to compile UML on FC4 using kernel source
> > 2.6.13.2 <http://2.6.13.2><http://2.6.13.2/> and gcc-4.0.1-4.fc4 and
> getting the following
> > errors:
> Disable CONFIG_HIGHMEM as a workaround (you likely don't need it), I'll
> fix it
> later.
> >
> > CC lib/string.o
> > CC lib/vsprintf.o
> > AR lib/lib.a
> > CC [M] lib/crc-ccitt.o
> > CC [M] lib/libcrc32c.o
> > GEN .version
> > CHK include/linux/compile.h
> > dnsdomainname: Unknown host
> > UPD include/linux/compile.h
> > CC init/version.o
> > LD init/built-in.o
> > LD .tmp_vmlinux1
>
> > arch/um/sys-i386/built-in.o(*ABS*+0xde77d105): In function
> `__crc_kunmap':
> > : multiple definition of `__crc_kunmap'
> >
> > arch/um/sys-i386/built-in.o(*ABS*+0x26792e7): In function
>
> > `__crc_kmap_atomic':
> > : multiple definition of `__crc_kmap_atomic'
> >
> > arch/um/sys-i386/built-in.o(*ABS*+0x7d922e4a): In function
> >
> > `__crc_kmap_atomic_to_page':
> > : multiple definition of `__crc_kmap_atomic_to_page'
> >
> > arch/um/sys-i386/built-in.o(*ABS*+0xf3c4062c): In function `__crc_kmap'=
:
> > : multiple definition of `__crc_kmap'
> >
> > collect2: ld returned 1 exit status
> > KSYM .tmp_kallsyms1.S
> > nm: '.tmp_vmlinux1': No such file
> > No valid symbol.
> > make: *** [.tmp_kallsyms1.S] Error 1
> >
> > Any idea?
> >
> > Thanks,
> >
> > --
> > ------------------------------------------------------
> > Etay Meiri
> > etay.meiri@gmail.com
>
> --
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ
> 215621894)
> http://www.user-mode-linux.org/~blaisorblade
>
>
> ___________________________________
> Yahoo! Messenger: chiamate gratuite in tutto il mondo
> http://it.messenger.yahoo.com
>
>


--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_10079_19447309.1127585268772
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks, it worked.<br>
<br>
-Etay<br><br><div><span class=3D"gmail_quote">On 9/24/05, <b class=3D"gmail=
_sendername">Blaisorblade</b> &lt;<a href=3D"mailto:blaisorblade@yahoo.it">=
blaisorblade@yahoo.it</a>&gt; wrote:</span><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;">
On Saturday 24 September 2005 17:52, Etay Meiri wrote:<br>&gt; Hi,<br>&gt;<=
br>&gt; I'm trying to compile UML on FC4 using kernel source<br>&gt; <a hre=
f=3D"http://2.6.13.2">2.6.13.2</a>&lt;<a href=3D"http://2.6.13.2/">http://2=
.6.13.2/
</a>&gt; and gcc-4.0.1-4.fc4 and getting the following<br>&gt; errors:<br>D=
isable CONFIG_HIGHMEM as a workaround (you likely don't need it), I'll fix =
it<br>later.<br>&gt;<br>&gt; CC lib/string.o<br>&gt; CC lib/vsprintf.o<br>
&gt; AR lib/lib.a<br>&gt; CC [M] lib/crc-ccitt.o<br>&gt; CC [M] lib/libcrc3=
2c.o<br>&gt; GEN .version<br>&gt; CHK include/linux/compile.h<br>&gt; dnsdo=
mainname: Unknown host<br>&gt; UPD include/linux/compile.h<br>&gt; CC init/=
version.o
<br>&gt; LD init/built-in.o<br>&gt; LD .tmp_vmlinux1<br><br>&gt; arch/um/sy=
s-i386/built-in.o(*ABS*+0xde77d105): In function `__crc_kunmap':<br>&gt; : =
multiple definition of `__crc_kunmap'<br>&gt;<br>&gt; arch/um/sys-i386/buil=
t-
in.o(*ABS*+0x26792e7): In function<br><br>&gt; `__crc_kmap_atomic':<br>&gt;=
 : multiple definition of `__crc_kmap_atomic'<br>&gt;<br>&gt; arch/um/sys-i=
386/built-in.o(*ABS*+0x7d922e4a): In function<br>&gt;<br>&gt; `__crc_kmap_a=
tomic_to_page':
<br>&gt; : multiple definition of `__crc_kmap_atomic_to_page'<br>&gt;<br>&g=
t; arch/um/sys-i386/built-in.o(*ABS*+0xf3c4062c): In function `__crc_kmap':=
<br>&gt; : multiple definition of `__crc_kmap'<br>&gt;<br>&gt; collect2: ld=
 returned 1 exit status
<br>&gt; KSYM .tmp_kallsyms1.S<br>&gt; nm: '.tmp_vmlinux1': No such file<br=
>&gt; No valid symbol.<br>&gt; make: *** [.tmp_kallsyms1.S] Error 1<br>&gt;=
<br>&gt; Any idea?<br>&gt;<br>&gt; Thanks,<br>&gt;<br>&gt; --<br>&gt; -----=
-------------------------------------------------
<br>&gt; Etay Meiri<br>&gt; <a href=3D"mailto:etay.meiri@gmail.com">etay.me=
iri@gmail.com</a><br><br>--<br>Inform me of my mistakes, so I can keep imit=
ating Homer Simpson's &quot;Doh!&quot;.<br>Paolo Giarrusso, aka Blaisorblad=
e (Skype ID &quot;PaoloGiarrusso&quot;, ICQ 215621894)
<br><a href=3D"http://www.user-mode-linux.org/~blaisorblade">http://www.use=
r-mode-linux.org/~blaisorblade</a><br><br><br>_____________________________=
______<br>Yahoo! Messenger: chiamate gratuite in tutto il mondo<br><a href=
=3D"http://it.messenger.yahoo.com">
http://it.messenger.yahoo.com</a><br><br></blockquote></div><br><br clear=
=3D"all"><br>-- <br>------------------------------------------------------<=
br>Etay Meiri<br><a href=3D"mailto:etay.meiri@gmail.com">etay.meiri@gmail.c=
om
</a>

------=_Part_10079_19447309.1127585268772--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
