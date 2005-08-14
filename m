Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4BdR-0003rW-Tf	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Aug 2005 23:06:17 -0700
Received: from mail01.syd.optusnet.com.au ([211.29.132.182])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1E4BdQ-0000Fx-Vo
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Aug 2005 23:06:17 -0700
Received: from [192.168.1.20] (c210-49-175-223.mckinn1.vic.optusnet.com.au
	[210.49.175.223])j7E667uv012670
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Aug 2005 16:06:07 +1000
From: Phill Wombat <uml@webwombat.com>
Content-Type: multipart/alternative; boundary="=-7rjMyz+VkA7Qb0YoiFw5"
Message-Id: <1123999566.17043.9.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [uml-devel] Compile UML-2.4.28+bs2 on FC4 with gcc4 - with my hack
	(yuk)
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
Date: Sun, 14 Aug 2005 16:06:06 +1000
To: UML Devel List <user-mode-linux-devel@lists.sourceforge.net>


--=-7rjMyz+VkA7Qb0YoiFw5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mail01.syd.optusnet.com.au id j7E667uv012670

 cc -D__KERNEL__ -I/home/phill/linux-2.4.28/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-U__i386__ -Ui386 -DUM_FASTCALL -g -D__arch_um__ -DSUBARCH=3D"i386"
-D_LARGEFILE64_SOURCE -I/home/phill/linux-2.4.28/arch/um/include
-Derrno=3Dkernel_errno
-I/home/phill/linux-2.4.28/arch/um/kernel/tt/include
-I/home/phill/linux-2.4.28/arch/um/kernel/skas/include
-fno-unit-at-a-time   -nostdinc -iwithprefix include
-DKBUILD_BASENAME=3Dbinfmt_elf -save-temps -c -o binfmt_elf.o binfmt_elf.=
c
In file included
from /home/phill/linux-2.4.28/include/asm/byteorder.h:5,

from /home/phill/linux-2.4.28/include/linux/kernel.h:16,

from /home/phill/linux-2.4.28/include/asm/arch/system.h:6,

from /home/phill/linux-2.4.28/include/asm/system-generic.h:5,
                 from /home/phill/linux-2.4.28/include/asm/system.h:5,

from /home/phill/linux-2.4.28/include/linux/spinlock.h:7,

from /home/phill/linux-2.4.28/include/linux/module.h:13,
                 from binfmt_elf.c:13:
/home/phill/linux-2.4.28/include/asm/arch/byteorder.h:14: warning: type
qualifiers ignored on function return type
/home/phill/linux-2.4.28/include/asm/arch/byteorder.h:30: warning: type
qualifiers ignored on function return type
In file included
from /home/phill/linux-2.4.28/include/linux/byteorder/little_endian.h:12,

from /home/phill/linux-2.4.28/include/asm/arch/byteorder.h:66,

from /home/phill/linux-2.4.28/include/asm/byteorder.h:5,

from /home/phill/linux-2.4.28/include/linux/kernel.h:16,

from /home/phill/linux-2.4.28/include/asm/arch/system.h:6,

from /home/phill/linux-2.4.28/include/asm/system-generic.h:5,
                 from /home/phill/linux-2.4.28/include/asm/system.h:5,

from /home/phill/linux-2.4.28/include/linux/spinlock.h:7,

from /home/phill/linux-2.4.28/include/linux/module.h:13,
                 from binfmt_elf.c:13:
/home/phill/linux-2.4.28/include/linux/byteorder/swab.h:160: warning:
type qualifiers ignored on function return type
/home/phill/linux-2.4.28/include/linux/byteorder/swab.h:173: warning:
type qualifiers ignored on function return type
/home/phill/linux-2.4.28/include/linux/byteorder/swab.h:186: warning:
type qualifiers ignored on function return type
/home/phill/linux-2.4.28/include/linux/byteorder/swab.h:200: warning:
type qualifiers ignored on function return type
binfmt_elf.c: In function =E2=80=98load_elf_binary=E2=80=99:
binfmt_elf.c:828: error: invalid lvalue in assignment
binfmt_elf.c:828: error: invalid lvalue in assignment
binfmt_elf.c:828: error: invalid lvalue in assignment
binfmt_elf.c:828: error: invalid lvalue in assignment
binfmt_elf.c:828: error: invalid lvalue in assignment
binfmt_elf.c:828: error: invalid lvalue in assignment
binfmt_elf.c:828: error: invalid lvalue in assignment

so I looked at the preprocessor output and it showed this for the macro
expansion (which looks correct??):

 do { (mode_tt ? (*((unsigned long *) &(((char *)
(((&(regs)->regs)->tt.sc)))[32]))) :
((((&(regs)->regs)->skas.regs)[0]))) =3D 0; (mode_tt ? (*((unsigned long
*) &(((char *) (((&(regs)->regs)->tt.sc)))[40]))) :
((((&(regs)->regs)->skas.regs)[1]))) =3D 0; (mode_tt ? (*((unsigned long
*) &(((char *) (((&(regs)->regs)->tt.sc)))[36]))) :
((((&(regs)->regs)->skas.regs)[2]))) =3D 0; (mode_tt ? (*((unsigned long
*) &(((char *) (((&(regs)->regs)->tt.sc)))[20]))) :
((((&(regs)->regs)->skas.regs)[3]))) =3D 0; (mode_tt ? (*((unsigned long
*) &(((char *) (((&(regs)->regs)->tt.sc)))[16]))) :
((((&(regs)->regs)->skas.regs)[4]))) =3D 0; (mode_tt ? (*((unsigned long
*) &(((char *) (((&(regs)->regs)->tt.sc)))[24]))) :
((((&(regs)->regs)->skas.regs)[5]))) =3D 0; (mode_tt ? (*((unsigned long
*) &(((char *) (((&(regs)->regs)->tt.sc)))[44]))) :
((((&(regs)->regs)->skas.regs)[6]))) =3D 0; } while(0);

which I hacked at to produce this (which compiles - don't know if it
works or is equivalent even):

if (mode_tt)
{
 (*((unsigned long *) &(((char *) (((&(regs)->regs)->tt.sc)))[32]))) =3D
0;
 (*((unsigned long *) &(((char *) (((&(regs)->regs)->tt.sc)))[40]))) =3D
0;
 (*((unsigned long *) &(((char *) (((&(regs)->regs)->tt.sc)))[36]))) =3D
0;
 (*((unsigned long *) &(((char *) (((&(regs)->regs)->tt.sc)))[20]))) =3D
0;
 (*((unsigned long *) &(((char *) (((&(regs)->regs)->tt.sc)))[16]))) =3D
0;
 (*((unsigned long *) &(((char *) (((&(regs)->regs)->tt.sc)))[24]))) =3D
0;
 (*((unsigned long *) &(((char *) (((&(regs)->regs)->tt.sc)))[44]))) =3D
0;
} else {
 ((((&(regs)->regs)->skas.regs)[0])) =3D 0;
 ((((&(regs)->regs)->skas.regs)[1])) =3D 0;
 ((((&(regs)->regs)->skas.regs)[2])) =3D 0;
 ((((&(regs)->regs)->skas.regs)[3])) =3D 0;
 ((((&(regs)->regs)->skas.regs)[4])) =3D 0;
 ((((&(regs)->regs)->skas.regs)[5])) =3D 0;
 ((((&(regs)->regs)->skas.regs)[6])) =3D 0;
};

Cheers
Phill.


--=-7rjMyz+VkA7Qb0YoiFw5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; CHARSET=3DUTF-8">
  <META NAME=3D"GENERATOR" CONTENT=3D"GtkHTML/3.6.2">
</HEAD>
<BODY>
 cc -D__KERNEL__ -I/home/phill/linux-2.4.28/include -Wall -Wstrict-prototyp=
es -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common&nbsp; -U__i386__ -Ui=
386 -DUM_FASTCALL -g -D__arch_um__ -DSUBARCH=3D&quot;i386&quot; -D_LARGEFIL=
E64_SOURCE -I/home/phill/linux-2.4.28/arch/um/include -Derrno=3Dkernel_errn=
o -I/home/phill/linux-2.4.28/arch/um/kernel/tt/include -I/home/phill/linux-=
2.4.28/arch/um/kernel/skas/include -fno-unit-at-a-time&nbsp;&nbsp; -nostdin=
c -iwithprefix include -DKBUILD_BASENAME=3Dbinfmt_elf -save-temps -c -o bin=
fmt_elf.o binfmt_elf.c<BR>
In file included from /home/phill/linux-2.4.28/include/asm/byteorder.h:5,<B=
R>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/linux/kernel.h:=
16,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/asm/arch/system=
.h:6,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/asm/system-gene=
ric.h:5,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/asm/system.h:5,=
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/linux/spinlock.=
h:7,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/linux/module.h:=
13,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from binfmt_elf.c:13:<BR>
/home/phill/linux-2.4.28/include/asm/arch/byteorder.h:14: warning: type qua=
lifiers ignored on function return type<BR>
/home/phill/linux-2.4.28/include/asm/arch/byteorder.h:30: warning: type qua=
lifiers ignored on function return type<BR>
In file included from /home/phill/linux-2.4.28/include/linux/byteorder/litt=
le_endian.h:12,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/asm/arch/byteor=
der.h:66,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/asm/byteorder.h=
:5,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/linux/kernel.h:=
16,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/asm/arch/system=
.h:6,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/asm/system-gene=
ric.h:5,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/asm/system.h:5,=
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/linux/spinlock.=
h:7,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from /home/phill/linux-2.4.28/include/linux/module.h:=
13,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; from binfmt_elf.c:13:<BR>
/home/phill/linux-2.4.28/include/linux/byteorder/swab.h:160: warning: type =
qualifiers ignored on function return type<BR>
/home/phill/linux-2.4.28/include/linux/byteorder/swab.h:173: warning: type =
qualifiers ignored on function return type<BR>
/home/phill/linux-2.4.28/include/linux/byteorder/swab.h:186: warning: type =
qualifiers ignored on function return type<BR>
/home/phill/linux-2.4.28/include/linux/byteorder/swab.h:200: warning: type =
qualifiers ignored on function return type<BR>
binfmt_elf.c: In function &#8216;load_elf_binary&#8217;:<BR>
binfmt_elf.c:828: error: invalid lvalue in assignment<BR>
binfmt_elf.c:828: error: invalid lvalue in assignment<BR>
binfmt_elf.c:828: error: invalid lvalue in assignment<BR>
binfmt_elf.c:828: error: invalid lvalue in assignment<BR>
binfmt_elf.c:828: error: invalid lvalue in assignment<BR>
binfmt_elf.c:828: error: invalid lvalue in assignment<BR>
binfmt_elf.c:828: error: invalid lvalue in assignment<BR>
<BR>
so I looked at the preprocessor output and it showed this for the macro exp=
ansion (which looks correct??):<BR>
<BR>
 do { (mode_tt ? (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;re=
gs)-&gt;tt.sc)))[32]))) : ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[0]))) =
=3D 0; (mode_tt ? (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;r=
egs)-&gt;tt.sc)))[40]))) : ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[1]))) =
=3D 0; (mode_tt ? (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;r=
egs)-&gt;tt.sc)))[36]))) : ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[2]))) =
=3D 0; (mode_tt ? (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;r=
egs)-&gt;tt.sc)))[20]))) : ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[3]))) =
=3D 0; (mode_tt ? (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;r=
egs)-&gt;tt.sc)))[16]))) : ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[4]))) =
=3D 0; (mode_tt ? (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;r=
egs)-&gt;tt.sc)))[24]))) : ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[5]))) =
=3D 0; (mode_tt ? (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;r=
egs)-&gt;tt.sc)))[44]))) : ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[6]))) =
=3D 0; } while(0);<BR>
<BR>
which I hacked at to produce this (which compiles - don't know if it works =
or is equivalent even):<BR>
<BR>
if (mode_tt)<BR>
{<BR>
 (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;regs)-&gt;tt.sc)))=
[32]))) =3D 0;<BR>
 (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;regs)-&gt;tt.sc)))=
[40]))) =3D 0;<BR>
 (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;regs)-&gt;tt.sc)))=
[36]))) =3D 0;<BR>
 (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;regs)-&gt;tt.sc)))=
[20]))) =3D 0;<BR>
 (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;regs)-&gt;tt.sc)))=
[16]))) =3D 0;<BR>
 (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;regs)-&gt;tt.sc)))=
[24]))) =3D 0;<BR>
 (*((unsigned long *) &amp;(((char *) (((&amp;(regs)-&gt;regs)-&gt;tt.sc)))=
[44]))) =3D 0;<BR>
} else {<BR>
 ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[0])) =3D 0;<BR>
 ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[1])) =3D 0;<BR>
 ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[2])) =3D 0;<BR>
 ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[3])) =3D 0;<BR>
 ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[4])) =3D 0;<BR>
 ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[5])) =3D 0;<BR>
 ((((&amp;(regs)-&gt;regs)-&gt;skas.regs)[6])) =3D 0;<BR>
};<BR>
<BR>
Cheers<BR>
Phill.<BR>
<BR>
</BODY>
</HTML>

--=-7rjMyz+VkA7Qb0YoiFw5--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
