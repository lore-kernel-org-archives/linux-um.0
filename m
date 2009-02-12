Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Geert.Uytterhoeven@sonycom.com>) id 1LXcjx-0005V7-38
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Feb 2009 14:40:33 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LXcju-00087F-0H for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Feb 2009 14:40:33 +0000
Date: Thu, 12 Feb 2009 15:40:23 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <20090207125956.110591c9@osiris.boeblingen.de.ibm.com>
Message-ID: <alpine.LRH.2.00.0902121539340.29413@vixen.sonytel.be>
References: <20090115194033.GA10926@hack.private>
	<20090116124158.4364e269.akpm@linux-foundation.org>
	<200901170328.15178.rob@landley.net>
	<dc84318c0901172223p57872a8cr227d940b1c0a908a@mail.gmail.com>
	<20090119152104.GC6432@c2.user-mode-linux.org>
	<dc84318c0901191746g31d51c23g65da89190dc8bfd2@mail.gmail.com>
	<49753063.8040007@hathawaymix.org>
	<alpine.LRH.2.00.0902041803360.7690@vixen.sonytel.be>
	<Pine.LNX.4.64.0902042115530.25136@anakin>
	<20090204204009.GA10680@suse.de>
	<Pine.LNX.4.64.0902042150550.25136@anakin>
	<20090207125956.110591c9@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [Patch] uml: fix a link error
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Greg KH <gregkh@suse.de>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Rob Landley <rob@landley.net>, Am?rico Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Shane Hathaway <shane@hathawaymix.org>, Daolong Wang <ahlongxp@gmail.com>, stable@kernel.org

On Sat, 7 Feb 2009, Heiko Carstens wrote:
> On Wed, 4 Feb 2009 21:54:12 +0100 (CET)
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I verified that Shane's solution:
> > =

> > #define sys_sigprocmask sys_kernel_sigprocmask
> > =

> > works for me, but that's definitely not the cleanest way.
> > =

> > Al Viro also had a suggestion to rework the SYSCALL_DEFINE* macros, but=
 I
> > haven't tried it yet.
> =

> =

> Patch below should fix it.

Thanks! I only managed to try it a few minutes ago...

> Subject: [PATCH] syscall define: fix uml compile bug
> =

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> =

> With the new system call defines we get this on uml:
> =

> arch/um/sys-i386/built-in.o: In function `sys_call_table':
> (.rodata+0x308): undefined reference to `sys_sigprocmask'
> =

> Reason for this is that uml passes the preprocessor option
> -Dsigprocmask=3Dkernel_sigprocmask to gcc when compiling the kernel.
> This causes SYSCALL_DEFINE3(sigprocmask, ...) to be expanded to
> SYSCALL_DEFINEx(3, kernel_sigprocmask, ...) and finally to a system call
> named sys_kernel_sigprocmask. However sys_sigprocmask is missing because
> of this.
> To avoid macro expansion for the system call name just concatenate the
> name at first define instead of carrying it through severel levels.
> This was pointed out by Al Viro.
> =

> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

For the record:

Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010

---------------------------------------------------------------------------=
---
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(T=
M)
software. With Adobe AIR, Ajax developers can use existing skills and code =
to
build responsive, highly engaging applications that combine the power of lo=
cal
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

