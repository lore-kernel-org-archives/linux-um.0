Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GoR8w-0004xi-4n for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 13:02:34 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user54890)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GoR8u-0001EO-La
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 13:02:29 -0800
From: Nix <nix@esperi.org.uk>
Date: Sun, 26 Nov 2006 21:02:22 +0000
Message-ID: <8764d1aplt.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: [uml-devel] PATCH [00/03]: allow building of UML with skas headers
	installed via `make headers_install'
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade@yahoo.it

I recently upgraded my glibc to 2.5, and upgraded the userspace headers
at the same time. As a result, I've had several problems with UML.

One of these Jeff has seen reported and fixed, although the correct
cause was not described (the #inclusion of <linux/stddef.h> instead of
<stddef.h> in user-offsets.c).

However, other problems are so-far undescribed. There's one trivial one
(fixed in patch 3 in this series, should be uncontroversial).

And then there's this:

  CC      arch/um/os-Linux/process.o
In file included from arch/um/include/skas_ptrace.h:12,
                 from arch/um/os-Linux/process.c:23:
arch/um/include/sysdep/skas_ptrace.h:9: error: redefinition of `struct ptrace_faultinfo'
arch/um/include/sysdep/skas_ptrace.h:14: error: redefinition of `struct ptrace_ldt'

The problem is that I installed my host kernel's headers, and that
kernel has the skas patch installed, so the skas ptrace structures
are already defined in <asm/ptrace.h>. Thankfully it's guarded by a
#define that we can test, but even so we need to split that SKAS
section out into a new header. (diff attached, not gitted since
the SKAS part isn't maintained in git anyway.)

So the following patches are a terribly provisional way to fix this:
it works but it may not maintain the separation between skas and
mainline that you want. At least it points up the existence of the
problems.

There are two patches in this series: one which splits the skas part of
ptrace.h into its own header, so that UML can use it, and one that
uses that header instead of skas_ptrace.h.

(All diffs against 2.6.18.x: I can respin against 2.6.19-pre if you
want, but, again, this area changes little so I'd expect things to
apply reasonably well anyway.)

-- 
`The main high-level difference between Emacs and (say) UNIX, Windows,
 or BeOS... is that Emacs boots quicker.' --- PdS

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
