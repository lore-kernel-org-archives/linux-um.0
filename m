Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNWUv-0008Ix-BM for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 06:08:53 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CNWUt-0005YH-TD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 06:08:53 -0700
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/1] SYSEMU: avoid intercepting syscall on
	return when using SYSCALL again.
References: <20041021231834.9D3833F37@zion.localdomain>
	<41819A8A.20403@fujitsu-siemens.com>
	<20041029075124.GA14311@bytesex>
In-Reply-To: <20041029075124.GA14311@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410291509.57662.blaisorblade_spam@yahoo.it>
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
Date: Fri, 29 Oct 2004 15:09:57 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, jdike@addtoit.com

On Friday 29 October 2004 09:51, Gerd Knorr wrote:
> > Here's the patch:
>
> Hmm, your mailer seems to mangle whitespaces, I often can apply your
> patches mailed inline with "patch -l" only (the mime attached ones are
> fine).
>
> Two small fixes I need in the big stack of patches i have now to
> build kernels successfully.  The first is a simple missing include:

> ==============================[ cut here ]==============================
> --- linux-uml-2.6.9.orig/arch/um/os-Linux/signal.c 2004-10-28
> 20:11:02.757586671 +0200 +++
> linux-uml-2.6.9/arch/um/os-Linux/signal.c 2004-10-28 20:23:32.730183963
> +0200 @@ -6,6 +6,7 @@
>  #include <signal.h>
>  #include "time_user.h"
>  #include "mode.h"
> +#include "choose-mode.h"
>  #include "sysdep/signal.h"
I'll make sure that is in.

>  void sig_handler(int sig)
> ==============================[ cut here ]==============================
>
> The second one is a fixup for the host-skas3 patch.  That one is needed
> if you use one source tree for both host and uml builds.  Without that
> fixup the host-skas3 patch breaks uml kernel builds (and also all other
> architectures as only i386 has sysemu right now ...).
Yes, I saw it in your tree. I'm including that in -v7 (I'm holding a bit on 
that to see if any other bug is found).


> It's kida quick&dirty, the real fix probably would be to have the skas
> ptrace stuff in *one* place, guess that isn't going to happen before
> skas is merged mainline through.  Whats the status on skas4 btw.?
See Jeff's diary. He has started again working on that, quite unsuccessfully 
however. If you want to look at the code, you can find it inside the UML 
amd64 patch for 2.6.4 (mm_indirect() is more or less supported for both i386 
and UML).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
