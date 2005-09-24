Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJCKa-0004ow-NS	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 08:52:52 -0700
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EJCKa-0007ex-M1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 08:52:52 -0700
Received: by zproxy.gmail.com with SMTP id x3so253178nzd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 24 Sep 2005 08:52:46 -0700 (PDT)
Message-ID: <229e70f2050924085215707921@mail.gmail.com>
From: Etay Meiri <etay.meiri@gmail.com>
Reply-To: Etay Meiri <etay.meiri@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9748_31158683.1127577166342"
Subject: [uml-devel] 2.6.13.2 + gcc 4.01 link error
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
Date: Sat, 24 Sep 2005 18:52:46 +0300
To: user-mode-linux-devel@lists.sourceforge.net

------=_Part_9748_31158683.1127577166342
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm trying to compile UML on FC4 using kernel source 2.6.13.2<http://2.6.13=
.2/>
and gcc-4.0.1-4.fc4 and getting the following errors:

CC lib/string.o
CC lib/vsprintf.o
AR lib/lib.a
CC [M] lib/crc-ccitt.o
CC [M] lib/libcrc32c.o
GEN .version
CHK include/linux/compile.h
dnsdomainname: Unknown host
UPD include/linux/compile.h
CC init/version.o
LD init/built-in.o
LD .tmp_vmlinux1
arch/um/sys-i386/built-in.o(*ABS*+0xde77d105): In function `__crc_kunmap':
: multiple definition of `__crc_kunmap'
arch/um/sys-i386/built-in.o(*ABS*+0x26792e7): In function
`__crc_kmap_atomic':
: multiple definition of `__crc_kmap_atomic'
arch/um/sys-i386/built-in.o(*ABS*+0x7d922e4a): In function
`__crc_kmap_atomic_to_page':
: multiple definition of `__crc_kmap_atomic_to_page'
arch/um/sys-i386/built-in.o(*ABS*+0xf3c4062c): In function `__crc_kmap':
: multiple definition of `__crc_kmap'
collect2: ld returned 1 exit status
KSYM .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: *** [.tmp_kallsyms1.S] Error 1

Any idea?

Thanks,

--
------------------------------------------------------
Etay Meiri
etay.meiri@gmail.com

------=_Part_9748_31158683.1127577166342
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>

<br>

I'm trying to compile UML on FC4 using kernel source <a href=3D"http://2.6.=
13.2/" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,=
this)">2.6.13.2</a><br>

and gcc-4.0.1-4.fc4 and getting the following errors:<br>

<br clear=3D"all">
&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lib/string.o<br>

&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lib/vsprintf.o<br>

&nbsp; AR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lib/lib.a<br>

&nbsp; CC [M]&nbsp; lib/crc-ccitt.o<br>

&nbsp; CC [M]&nbsp; lib/libcrc32c.o<br>

&nbsp; GEN&nbsp;&nbsp;&nbsp;&nbsp; .version<br>

&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/compile.h<br>

dnsdomainname: Unknown host<br>

&nbsp; UPD&nbsp;&nbsp;&nbsp;&nbsp; include/linux/compile.h<br>

&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init/version.o<br>

&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init/built-in.o<br>

&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tmp_vmlinux1<br>

arch/um/sys-i386/built-in.o(*ABS*+0xde77d105): In function `__crc_kunmap':<=
br>

: multiple definition of `__crc_kunmap'<br>

arch/um/sys-i386/built-in.o(*ABS*+0x26792e7): In function `__crc_kmap_atomi=
c':<br>

: multiple definition of `__crc_kmap_atomic'<br>

arch/um/sys-i386/built-in.o(*ABS*+0x7d922e4a): In function `__crc_kmap_atom=
ic_to_page':<br>

: multiple definition of `__crc_kmap_atomic_to_page'<br>

arch/um/sys-i386/built-in.o(*ABS*+0xf3c4062c): In function `__crc_kmap':<br=
>

: multiple definition of `__crc_kmap'<br>

collect2: ld returned 1 exit status<br>

&nbsp; KSYM&nbsp;&nbsp;&nbsp; .tmp_kallsyms1.S<br>

nm: '.tmp_vmlinux1': No such file<br>

No valid symbol.<br>

make: *** [.tmp_kallsyms1.S] Error 1<br>

<br>

Any idea?<br>

<br>

Thanks,<br clear=3D"all"><br>-- <br>---------------------------------------=
---------------<br>Etay Meiri<br><a href=3D"mailto:etay.meiri@gmail.com">et=
ay.meiri@gmail.com</a>

------=_Part_9748_31158683.1127577166342--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
