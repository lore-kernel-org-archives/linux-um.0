Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By8iT-00089u-Tt for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 05:41:57 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1By8iS-0002sv-4x
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 05:41:57 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040820122445.GA21790@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [ann] kraxel's 2.6.8 uml patch kit
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
Date: Fri, 20 Aug 2004 14:24:45 +0200
To: Jeff Dike <jdike@addtoit.com>, uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

I've just uploaded a bunch of uml kernel patches to
http://www.suse.de/~kraxel/uml/patches/

This basically is the current state of the suse kernel for
the next suse linux release.  The patches create one source
tree for both i386 and uml kernels.  Some of these patches
have been mailed to this list in the past.  The README for
the patch kit is attached below for convenience.

What is the status of the amd64 port?  The 2.6.4 patch on
sf.net produces lots of rejects when I try to apply it on
top of the 2.6.7 uml patch.  Is a newer version available
somewhere?  Or can I just ignore all the rejects (guess not)?

What is the status if the umlfb/x11/pthread issue, i.e. uml
kernel crashing as soon as one tries to link against libpthread
(which is needed for libX11)?  Any progress here?

  Gerd

==============================[ cut here ]==============================

kraxel's 2.6.8 uml patch kit [2004-08-20]
=========================================

The patches must be applied in the order listed here.
Patch descriptions:

host-skas3-2.6.7-v1.patch
	blaisorblade's skas patch -- as-is

uml-patch-2.6.7-2
	jeff's uml patch -- with some stuff removed which is already
	in the skas patch.

uml-fix-skas
	some fixes needed to make the resulting tree build for both
	i386 and um archs.

uml-fixes-for-2.6.8
	some updates to make uml build on 2.6.8
	
uml-extraversion
	don't change the EXTRAVERSION

uml-raise-tty-limit
	use 16 instead of 8 ttys.

uml-pretend-to-be-i586
	make the uml virtual machine claim to be a i586 machine.  At
	least suse's yast2 installer will pick the glibc version without
	tls/nptl support then, thus this avoids trouble due to the the
	not-yet implemented tls/nptl syscalls in uml kernels.  Maybe
	useful for other distros as well.
	
uml-core-on-panic
	Make the uml kernel dump core on kernel panics for later analysis.
	Default: off, there is a kernel cmd line arg to enable that.

uml-fix-umldir-order
	fold the tree setup functions in umid.c into one, fixes some init
	call ordering issue I had some time ago.  Also makes the error
	messages more verbose.

uml-fix-export-symbol
	exports one missing symbol (needed for xfs).

uml-general-protection-fault
	attempt to handle general protection faults more correctly.

uml-net-flush-on-ifup
	flush incoming packets on ifup -- fixes networks stalls which happen in
	case the unix socket buffer is already full when the interface is up'ed
	(due to SIGIO never signaling arrived data).

uml-fix-mconsole-proc
	fix kernel crash triggered by running "uml_mconsole <umid> proc <some-file>"
	multipole times.

uml-terminal-cleanup
	tty / console handling cleanups.  The patchfile itself has a long
	description.



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
