Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzJEn-0007zL-R7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 10:40:25 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CzJEn-0003P2-1B for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 10:40:25 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502101939.23300.blaisorblade@yahoo.it>
Subject: [uml-devel] uml kbuild cleanup (cross-build) - some fixes and comments
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
Date: Thu, 10 Feb 2005 19:39:23 +0100
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

First, Al, thanks a lot for succeeding in solving this... I had tried a lot of 
time ago to make sure that O= worked... (I think that -j already worked, 
unless somebody re-broke it after I fixed that). Plus you fix a lot of other 
stuff.

There are (at least) two bugs to fix about this patch, plus some comments:

http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.11-rc3-mm1/patches/cross-build

1) typo here: "objtre" should be "objtree"

Index: linux-2.6.10/arch/um/kernel/Makefile
===================================================================

@@ -50,7 +50,7 @@
 quiet_cmd_quote2 = QUOTE   $@
       cmd_quote2 = sed -e '/CONFIG/{'          \
   -e 's/"CONFIG"\;/""/'        \
-  -e 'r $(obj)/config.tmp'     \
+  -e 'r $(objtre)/config.tmp'  \

2) More serious: the value for SETOPTIONS should be the 2.4 one, not the 2.6 
one which is incompatible with 2.4 host kernel (it's an issue for 2.6 headers 
in general).

In fact, a built UML binary must work on top of a 2.4 host kernel, too.

This IMHO would be a general issue about ABI compatibility, except that only 
userspace headers must define the correct value (the old, 2.4-compatible 
one)...

#define PTRACE_OLDSETOPTIONS         21

I just noticed we forgot to merge the patch for this in the current tree, 
which is:

+#ifndef PTRACE_OLDSETOPTIONS
+#define PTRACE_OLDSETOPTIONS PTRACE_SETOPTIONS
+#endif
and then use OLDSETOPTIONS instead of SETOPTIONS.

I'm sending it now for 2.6.11.

Then, some more comments:

3) I don't understand how vmlinux.lds.S is created... it's a symlink, but it's 
created nowhere after the patch - maybe I overlook something, maybe you 
didn't do "make clean" and retest.

4) Since you went with gen-asm-offsets, I think it would be nice (but also 
long, so if I find time I'll work on it) to use directly the generated 
headers, instead of compiling a program which mangles their content and 
reprints the same info in different form.

5) About the USER_OBJS: it was rejected in the current form for going in 
scripts/Makefile long time ago... the proposed alternatives where:

a) rebuild the thing from scratch, without using the obj-[ymn] code (a lot of 
code); or
b) do a) in a way which could also work for klibc (problem: klibc is not 
linked inside the kernel image)

when I have time, I'll try to get people to simply accept a way to specificate 
CFLAGS for some files which totally replace the normal ones.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
