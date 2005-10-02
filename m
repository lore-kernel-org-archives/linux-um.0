Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMBQM-0008VA-Oc	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 14:31:10 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EM0vB-0001bl-0u
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 03:18:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UL7PDw8YqlreT9x"
Message-Id: <200510021213.40191.blaisorblade@yahoo.it>
Subject: [uml-devel] UML/2.6.14-rc3 doesn't work fixes
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
Date: Sun, 2 Oct 2005 12:13:39 +0200
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>

--Boundary-00=_UL7PDw8YqlreT9x
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The patch in Al Viro's:

ecba97d4aacf4e80c56eb73e39af0369cb8539a4

messed up UML (in particular skas0, which doesn't boot any more - or maybe it 
boots one out of 10 times).

Btw: did Al CC you on it, at least?

The reason is that he messed up HOST_FRAME_SIZE on i386 (by using 
DEFINE_LONGS). I.e. HOST_FRAME_SIZE, which was 17, became 17/sizeof(long). 
Uh, nice.

A fix is attached (at least it boots with it), together with a lenghty comment 
about how stability-friendly such a big unreviewable patch can be.

Also, he did the same to arch/um/sys-x86_64/user-offsets.c, but apparently 
this is justified in that case because in the original sources 
(arch/um/kernel/skas/util/mk_ptregs-x86_64.c)

#define SHOW(name) \
       printf("#define %s (%d / sizeof(unsigned long))\n", #name, name)

which is not done on i386.

So, Jeff, as said in the email, since we are in the "stable" phase, I suggest 
dropping for now Al's nice* cleanup and moving it to 2.6.15 cycle (and to the 
current -mm). Actually, the patch size can be reduced effectively;
changes such as:
-       OFFSET(SC_RBX, sigcontext, rbx);
+       OFFSET(HOST_SC_RBX, sigcontext, rbx);
are pointless, given that you can turn put HOST_ in OFFSET(), since it is done 
for every call to OFFSET.

* I'm not joking, I too feel this must be done, but not *now*, quietly, 
without boot testing.

Jeff, also, what about my last five patches, which weren't merged yet? The 
first one conflicts with this Viro's patch, but the rest should really be 
applied (especially to fix SKAS3).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_UL7PDw8YqlreT9x
Content-Type: text/x-diff;
  charset="us-ascii";
  name="uml-fix-alviros-mess"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="uml-fix-alviros-mess"

RFC: revert Al Viro's "Uml makefile sanitized"

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Recent Al Viro's commit ecba97d4aacf4e80c56eb73e39af0369cb8539a4 broke SKAS0
mode, causing random corruptions at startup of the first userspace process.

One bug I found is that HOST_FRAME_SIZE value, which is fixed below to match the
definition before that commit. With this patch, the kernel boots again.

Given the light testing I've done on it, other bugs may slip through; given that
*) we are now in "no-merge" mode (only real bug fixes)
*) this patch was merged without CC'ing any UML public list, nor me, nor (maybe)
   Jeff Dike,
*) the patch is big, typo's here can be catastrophic, and other bugs may sleep
   easily (who will review this line-by-line, especially *now*?)
*) bugs in FP state handling would *never* be caught

and, above all

*) it doesn't fix any bug, it's just a (very nice indeed) cleanup;

I therefore request that Viro's patch to be dropped for now, and moved to the
2.6.15 release cycle, together with this fixup and the others which will be
needed.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/sys-i386/user-offsets.c
===================================================================
--- linux-2.6.git.orig/arch/um/sys-i386/user-offsets.c
+++ linux-2.6.git/arch/um/sys-i386/user-offsets.c
@@ -46,7 +46,7 @@ void foo(void)
 	OFFSET(HOST_SC_FP_ST, _fpstate, _st);
 	OFFSET(HOST_SC_FXSR_ENV, _fpstate, _fxsr_env);
 
-	DEFINE_LONGS(HOST_FRAME_SIZE, FRAME_SIZE);
+	DEFINE(HOST_FRAME_SIZE, FRAME_SIZE);
 	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_i387_struct));
 	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fxsr_struct));
 

--Boundary-00=_UL7PDw8YqlreT9x--


	

	
		
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
