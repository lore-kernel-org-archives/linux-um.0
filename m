Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cs4KB-0005ra-RQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 11:20:03 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cs4KA-0007Pe-90
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 11:20:03 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501192252.54585.rob@landley.net>
	<200501211335.37894.blaisorblade@yahoo.it>
In-Reply-To: <200501211335.37894.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501211318.16848.rob@landley.net>
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
Date: Fri, 21 Jan 2005 13:18:16 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 21 January 2005 07:35 am, Blaisorblade wrote:

> > Ooh, ooh!  Hang in TT mode is what I'm seeing with my makefile hang.  (sh
> > -x dosn't help if the makefile doesn't call out to stuff with it.)
> >
> > If the previous patch doesn't address it, is there a new patch I could
> > try?
>
> Well, you solved this problem with the 2.6.11-rc1-mm2, right (from the
> message below)?

With 2.6.11-rc1-mm2, my toolchain build runs through to completion under UML.  
(Very very slowly, but it does.  Tested on a 1.6 ghz 2 meg cache computer, 
which runs it under UML at about the speed of my 700 mhz 128k cache laptop 
without UML.  But hey, it's using tt mode, and completing correctly.  That's 
the important thing...)

> The patch which was merged there is the one posted with title "[uml-devel]
> [PATCH] Fix stack corruption" on this list..., I guess... it will be in
> 2.6.9-bs6 and 2.6.10-bb1 (both to release) - are you willing to test one of
> them, when I do the release? I'd be very thankful to accept your help...

I'll happily try out 2.6.10-bb1, sure.

The mm2 changelog says it has:

-uml-avoid-null-dereference-in-linec.patch
-uml-readd-config_magic_sysrq-for-uml.patch
-uml-commentary-addition-to-recent-sysemu-fix.patch
-uml-drop-unused-buffer_headh-header-from-hostfs.patch
-uml-delete-unused-header-umnh.patch
-uml-commentary-about-sigwinch-handling-for-consoles.patch
-uml-fail-xterm_open-when-we-have-no-display.patch
-uml-depend-on-usermode-in-drivers-block-kconfig-and-drop-arch-um-kconfig_block.patch
-uml-makefile-simplification-and-correction.patch
-uml-fix-compilation-for-missing-headers.patch
-uml-fix-some-uml-own-initcall-macros.patch
-uml-refuse-to-run-without-skas-if-no-tt-mode-in.patch
-uml-for-ubd-cmdline-param-use-colon-as-delimiter.patch
-uml-allow-free-ubd-flag-ordering.patch
-uml-move-code-from-ubd_user-to-ubd_kern.patch
-uml-fix-and-cleanup-code-in-ubd_kernc-coming-from-ubd_userc.patch
-uml-add-stack-content-to-dumps.patch
-uml-add-stack-addresses-to-dumps.patch
-uml-update-ld-scripts-to-newer-binutils.patch

More later, lunch is over...

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
