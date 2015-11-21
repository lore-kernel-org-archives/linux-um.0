Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@gmail.com>) id 1a0DXV-0000BS-Cx
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Nov 2015 19:09:37 +0000
Received: from mail-pa0-f54.google.com ([209.85.220.54])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a0DXU-0008BI-08
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Nov 2015 19:09:37 +0000
Received: by pabfh17 with SMTP id fh17so153835932pab.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 21 Nov 2015 11:09:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56426AED.8030005@nod.at>
References: <56426AED.8030005@nod.at>
Date: Sat, 21 Nov 2015 20:09:30 +0100
Message-ID: <CAOMGZ=Hz_jBY0rNUDsNUyJBMM1PVFsv2M4O=h-FJNE4GiNMvdA@mail.gmail.com>
From: Vegard Nossum <vegard.nossum@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5643487488555938785=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [GIT PULL] UML updates for 4.4-rc1
To: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <aivanov@brocade.com>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

--===============5643487488555938785==
Content-Type: multipart/alternative; boundary=047d7b6d8b58491f67052511bb0f

--047d7b6d8b58491f67052511bb0f
Content-Type: text/plain; charset=UTF-8

On 10 November 2015 at 23:08, Richard Weinberger <richard@nod.at> wrote:

> Linus,
>
> the following changes since commit
> 6a13feb9c82803e2b815eca72fa7a9f5561d7861:
>
>   Linux 4.3 (2015-11-01 16:05:25 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
> for-linus-4.4-rc1
>
> for you to fetch changes up to 2eb5f31bc4ea24bb293e82934cfa1cce9573304b:
>
>   um: Switch clocksource to hrtimers (2015-11-06 22:54:49 +0100)
>
> ----------------------------------------------------------------
> This pull request includes the following UML changes:
> * A new hrtimer based clocksource by Anton Ivanov
> * ptrace() enhancments by Richard Weinberger
> * random cleanups and bug fixes all over the place
>
> ----------------------------------------------------------------
> Anton Ivanov (1):
>       um: Switch clocksource to hrtimers
>

This commit (2eb5f31bc4) seems to have broken the UML defconfig build in
latest Linus master for me:

[...]
 LINK    vmlinux
 LD      vmlinux.o
 MODPOST vmlinux.o
 GEN     .version
 CHK     include/generated/compile.h
 UPD     include/generated/compile.h
 CC      init/version.o
 LD      init/built-in.o
arch/um/os-Linux/built-in.o: In function `os_timer_create':
/home/vegard/linux/arch/um/os-Linux/time.c:51: undefined reference to
`timer_create'
arch/um/os-Linux/built-in.o: In function `os_timer_set_interval':
/home/vegard/linux/arch/um/os-Linux/time.c:84: undefined reference to
`timer_settime'
arch/um/os-Linux/built-in.o: In function `os_timer_remain':
/home/vegard/linux/arch/um/os-Linux/time.c:109: undefined reference to
`timer_gettime'
arch/um/os-Linux/built-in.o: In function `os_timer_one_shot':
/home/vegard/linux/arch/um/os-Linux/time.c:132: undefined reference to
`timer_settime'
arch/um/os-Linux/built-in.o: In function `os_timer_disable':
/home/vegard/linux/arch/um/os-Linux/time.c:145: undefined reference to
`timer_settime'
collect2: error: ld returned 1 exit status
make: *** [vmlinux] Error 1


Vegard

--047d7b6d8b58491f67052511bb0f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On 10 November 2015 at 23:08, Richard Weinberger <span dir=
=3D"ltr">&lt;<a href=3D"mailto:richard@nod.at" target=3D"_blank">richard@no=
d.at</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Linus,<br>
<br>
the following changes since commit 6a13feb9c82803e2b815eca72fa7a9f5561d7861=
:<br>
<br>
=C2=A0 Linux 4.3 (2015-11-01 16:05:25 -0800)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/rw/u=
ml.git" rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm/linux/k=
ernel/git/rw/uml.git</a> for-linus-4.4-rc1<br>
<br>
for you to fetch changes up to 2eb5f31bc4ea24bb293e82934cfa1cce9573304b:<br=
>
<br>
=C2=A0 um: Switch clocksource to hrtimers (2015-11-06 22:54:49 +0100)<br>
<br>
----------------------------------------------------------------<br>
This pull request includes the following UML changes:<br>
* A new hrtimer based clocksource by Anton Ivanov<br>
* ptrace() enhancments by Richard Weinberger<br>
* random cleanups and bug fixes all over the place<br>
<br>
----------------------------------------------------------------<br>
Anton Ivanov (1):<br>
=C2=A0 =C2=A0 =C2=A0 um: Switch clocksource to hrtimers<br></blockquote><di=
v><br></div><div>This commit (2eb5f31bc4) seems to have broken the UML defc=
onfig build in latest Linus master for me:<br><br>[...]<br>=C2=A0LINK =C2=
=A0 =C2=A0vmlinux<br> =C2=A0LD =C2=A0 =C2=A0 =C2=A0vmlinux.o<br> =C2=A0MODP=
OST vmlinux.o<br> =C2=A0GEN =C2=A0 =C2=A0 .version<br> =C2=A0CHK =C2=A0 =C2=
=A0 include/generated/compile.h<br> =C2=A0UPD =C2=A0 =C2=A0 include/generat=
ed/compile.h<br> =C2=A0CC =C2=A0 =C2=A0 =C2=A0init/version.o<br> =C2=A0LD =
=C2=A0 =C2=A0 =C2=A0init/built-in.o<br>arch/um/os-Linux/built-in.o: In func=
tion `os_timer_create&#39;:<br>/home/vegard/linux/arch/um/os-Linux/time.c:5=
1: undefined reference to `timer_create&#39;<br>arch/um/os-Linux/built-in.o=
: In function `os_timer_set_interval&#39;:<br>/home/vegard/linux/arch/um/os=
-Linux/time.c:84: undefined reference to `timer_settime&#39;<br>arch/um/os-=
Linux/built-in.o: In function `os_timer_remain&#39;:<br>/home/vegard/linux/=
arch/um/os-Linux/time.c:109: undefined reference to `timer_gettime&#39;<br>=
arch/um/os-Linux/built-in.o: In function `os_timer_one_shot&#39;:<br>/home/=
vegard/linux/arch/um/os-Linux/time.c:132: undefined reference to `timer_set=
time&#39;<br>arch/um/os-Linux/built-in.o: In function `os_timer_disable&#39=
;:<br>/home/vegard/linux/arch/um/os-Linux/time.c:145: undefined reference t=
o `timer_settime&#39;<br>collect2: error: ld returned 1 exit status<br>make=
: *** [vmlinux] Error 1<br><br><br></div><div>Vegard<br></div></div></div><=
/div>

--047d7b6d8b58491f67052511bb0f--


--===============5643487488555938785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5643487488555938785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5643487488555938785==--


