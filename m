Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtmEq-0008OZ-Sb for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 04:25:36 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CtmEm-0002lb-50 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 04:25:36 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: skas3 patch breaks ATI video drivers
References: <41F54FE9.7060503@better.se>
	<200501242113.16569.blaisorblade@yahoo.it>
	<ct7r17$cqj$1@sea.gmane.org>
In-Reply-To: <ct7r17$cqj$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200501261324.52933.blaisorblade@yahoo.it>
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
Date: Wed, 26 Jan 2005 13:24:52 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>

On Wednesday 26 January 2005 11:24, Sven K=F6hler wrote:


Please note this exact sentence:
> > I.e. the compilation problem is not in the kernel module, right?

> > In this=20
> > case, the problem is that you have /usr/include/asm symlinked to your
> > kernel's include/asm-i386 directory, which is the wrong setup. However
> > your solution should not give any problem.

> Kernel-Modules are usually compiled against the sources in either
> /usr/src/linux or /lib/modules/<version>/build.

> Take a look at the nvidia-kernel ebuild or other ebuilds that build
> kernel modules. It would be fatal to compile them against the headers in
> /usr/include. On Gentoo, you can have linux26-headers-2.6.7 installed,
> but actually be running a 2.6.10 Kernel - and even worse, it is even
> possible to keep 2.4 headers when running a 2.6 kernel.

Sven, that is clear *and* obvious... what I was *refusing* to believe was t=
hat=20
a kernel module would be using the "syscall" macro - I explained it by=20
thinking it was userspace code.

Maybe that use is even legitimate (1), after all, but it astonished me a bi=
t=20
first... and my experience with NVIDIA driver was they also had a userspace=
=20
part to link with X11.

(1) legitimate means "ugly hack which can make sense with non-GPL modules, =

i.e. does not make sense anyway". I'm not flaming ATI / NVIDIA, let's leave=
=20
this duty to people with more spare time.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
