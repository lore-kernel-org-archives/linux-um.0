Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C69ZR-0003S4-AV for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 08:13:45 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C69ZP-0004iC-8m for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 08:13:45 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml-patch-2.6.7-2
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
	<200408251746.53523.blaisorblade_spam@yahoo.it>
	<200409090035.i890ZYBP016288@ccure.user-mode-linux.org>
In-Reply-To: <200409090035.i890ZYBP016288@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409111641.15496.blaisorblade_spam@yahoo.it>
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
Date: Sat, 11 Sep 2004 16:41:15 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thursday 09 September 2004 02:35, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > * First, please do a "make clean" before releasing the patch. There
> > are some  binaries included in it! And also semaphore.c, which is a
> > symlink normally.
>
> I do.  It's just that make clean didn't catch everything.
Btw, inside patch-scripts they provide a script which rather than diffing two 
trees, calls "combinediff" (from patchutils) to merge the patches statically, 
without need of the patched files. I've been very confortable with it - 
doesn't quilt have something such?

About patchutils (quoting from Andrew Morton):

  See http://cyberelk.net/tim/patchutils/ (Don't download the
  "experimental" patchutils - it seems to only have half of the
  commands in it.  Go for "stable")

> > * About filehandle_switch: you deleted a line (probably by mistake).
> > Reread  more carefully the separate patches you get with quilt: when
> > you see the  other attached patch (uml-restore-lost-code.patch),
> > you'll agree with me.

> Yuck, I have no idea how that happened.
Btw, I'm assuming that you didn't want to drop the HPPFS compile line in 
"externfs" (since that's not documented), right?

--- um.orig/fs/Makefile 2004-08-06 15:17:22.000000000 -0400
+++ um/fs/Makefile      2004-08-06 15:17:25.000000000 -0400
@@ -91,5 +91,4 @@
 obj-$(CONFIG_XFS_FS)           += xfs/
 obj-$(CONFIG_AFS_FS)           += afs/
 obj-$(CONFIG_BEFS_FS)          += befs/
-obj-$(CONFIG_HOSTFS)           += hostfs/
-obj-$(CONFIG_HPPFS)            += hppfs/   # <---- WHY?
+obj-$(CONFIG_EXTERNFS)         += hostfs/

> > However, IMHO, since you cannot close and reopen a pipe, it's
> > braindead that  the switch_pipe[] array is an array of filehandles.

> Yeah, this is fixed in my 2.6 tree now.
Yes, I saw it, a lot after writing the message (I sent it a lot after writing 
it).

However, another thing: I think that the handling of EMFILE/ENFILE (too many 
fd's for the app or for the system) should be moved inside the os_ layer. Or 
will you create yet a filehandle wrapper for functions like 
os_connect_socket() (which calls socket(), which requests an fd)? Do you 
agree or have any arguments to support the current design?

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
