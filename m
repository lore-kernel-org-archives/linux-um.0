Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200402130523.i1D5NTgR005420@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 05 Feb 2004 21:07:37 +0100."
             <200402052107.37625.blaisorblade_spam@yahoo.it> 
References: <200402052107.37625.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [uml-user] UML (unofficial) patches against vanilla 2.6.2
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 13 Feb 2004 00:23:29 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> I've updated my patches for modules and so on to 2.6.2. Since the main
> Uml  patch against 2.6.1 needs some easy-but-not-trivial changes to
> work onto  2.6.2

OK, I'm finishing merging this in.  

I don't understand what you're doing with G-02-LinkScriptCleanup.patch.  The
stuff you're adding to vmlinux.lds.S is only needed for the final binary, 
which isn't built by this script.  The next three hunks are also somewhat 
obscure.  The final one is merged.

I don't like H-01-Pcap_link_fix.patch.  As much as that fixes pcap, we really
need to find a fix that's local to arch/um/drivers.  I'll merge this only
as a last-ditch thing if it becomes clear that there is no other way.

H-02-Fixdep-improve.patch is similar, except it's not clear to me what
you're fixing.  Here also, I don't want to munge the global kbuild with
UML special cases.

In H-04-Kbuild_cleanup.patch, the skas/Makefile patch isn't obviously an
improvement over what's already there.  In arch/um/Makefile, what's that @:
doing?  A quiet true?  I left out the commented stuff.  Send it back in when
you're sure what you want there.

As for I-01-Debian_workaround.patch, I had the impression that this was
caused by a Debian bug.  If so, they should fix it, and I shouldn't have
to put workarounds in UML for it.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
