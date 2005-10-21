Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ESuod-0001ON-SE	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 04:12:03 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ESuoZ-0006uV-7s
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 04:12:03 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.13.4-bs4 released - fixes for SKAS0 problems -
	careful about COW
References: <200510151325.50461.blaisorblade@yahoo.it>
	<1129841654.10146.14.camel@localhost.localdomain>
In-Reply-To: <1129841654.10146.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ILLWDvk+oEYMcOB"
Message-Id: <200510211120.08231.blaisorblade@yahoo.it>
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
Date: Fri, 21 Oct 2005 11:20:06 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Phill Wombat <uml@webwombat.com>

--Boundary-00=_ILLWDvk+oEYMcOB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 20 October 2005 22:54, Phill Wombat wrote:
> Hi List,
>
> Start the process of compiling 2.6.13.4-bs4.
>
> x86_64 host, i386 UML.
>
> Using same config as successful 2.6.12.5-bb12-skas0.
>
> Some compile errors encountered:
Can't reproduce that on my i386 host, and probably can't reproduce it on my=
=20
x86_64 compile environment (but I'm too lazy to reboot there).

I would bet your glibc headers have a bug somewhere (this seems a "double=20
inclusion of the same header" problem). However, try the attached patch.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SNIP =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>   AS      arch/um/sys-i386/stub.o
>   CC      arch/um/sys-i386/stub_segv.o
> In file included from /usr/include/asm/sigcontext.h:7,
>                  from arch/um/sys-i386/stub_segv.c:7:
> /usr/include/asm-i386/sigcontext.h:18: error: redefinition of =E2=80=98st=
ruct
> _fpreg=E2=80=99 /usr/include/asm-i386/sigcontext.h:23: error: redefinitio=
n of
> =E2=80=98struct _fpxreg=E2=80=99 /usr/include/asm-i386/sigcontext.h:29: e=
rror: redefinition
> of =E2=80=98struct _xmmreg=E2=80=99 /usr/include/asm-i386/sigcontext.h:33=
: error:
> redefinition of =E2=80=98struct _fpstate=E2=80=99 /usr/include/asm-i386/s=
igcontext.h:57:
> error: redefinition of =E2=80=98struct sigcontext=E2=80=99 make[1]: ***
> [arch/um/sys-i386/stub_segv.o] Error 1

=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_ILLWDvk+oEYMcOB
Content-Type: text/x-diff;
  charset="utf-8";
  name="uml-stub-segv_c-compile-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-stub-segv_c-compile-fix"

Index: linux-2.6.13/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.13.orig/arch/um/sys-i386/stub_segv.c
+++ linux-2.6.13/arch/um/sys-i386/stub_segv.c
@@ -4,7 +4,6 @@
  */
 
 #include <signal.h>
-#include <asm/sigcontext.h>
 #include <asm/unistd.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"

--Boundary-00=_ILLWDvk+oEYMcOB--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
