Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdFi5-00056v-CP	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 15:59:45 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DdFi4-0007qN-Vy	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 15:59:45 -0700
Message-Id: <s29c8a5a.088@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Subject: Re: [uml-devel] Problems applying patches to 2.6.12-rc5-mm1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
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
Date: Tue, 31 May 2005 16:01:17 -0700
Content-Transfer-Encoding: 8bit
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

As an additional FYI, I just refreshed my copy of the tarball. I now stops during compile:

# make ARCH=um && make modules ARCH=um
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-um

< output trimmed >

  SYMLINK arch/um/sys-i386/semaphore.c
  CC      arch/um/sys-i386/semaphore.o
  CC      arch/um/sys-i386/signal.o
  CC      arch/um/sys-i386/sigcontext.o
  AS      arch/um/sys-i386/stub.o
  CC      arch/um/sys-i386/stub_segv.o
fixdep: arch/um/sys-i386/.stub_segv.o.d: No such file or directory
make[1]: *** [arch/um/sys-i386/stub_segv.o] Error 2
make: *** [arch/um/sys-i386] Error 2
# 

Tony

>>> Jeff Dike <jdike@addtoit.com> 05/31/05 03:00PM >>>
On Tue, May 31, 2005 at 11:03:23AM -0700, Anthony Brock wrote:
> patching file arch/um/kernel/main.c
> Hunk #1 FAILED at 1.
> File arch/um/kernel/main.c is not empty after patch, as expected
> 1 out of 1 hunk FAILED -- rejects in file arch/um/kernel/main.c
> patching file arch/um/kernel/um_arch.c
> patching file arch/um/os-Linux/Makefile
> patching file arch/um/os-Linux/main.c
> Patch os-main does not apply (enforce with -f)
> # 

Grab the patches again.  I may have synced the patches when I didn't have
them all pushed.  I just synced again, and everything is applied, so these
should work.

Then get a stack trace from that.  I promise not to change too much in the
next day or two, so your line numbers should still match mine.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
