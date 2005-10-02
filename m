Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EM8ip-0004H4-8D	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 11:38:03 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EM8in-0003pL-Ls
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 11:38:03 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20051002183758.GR7992@ftp.linux.org.uk>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<20051002155134.GA3777@ccure.user-mode-linux.org>
	<200510022001.21638.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510022001.21638.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
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
Date: Sun, 2 Oct 2005 19:37:58 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>

On Sun, Oct 02, 2005 at 08:01:21PM +0200, Blaisorblade wrote:
> On Sunday 02 October 2005 17:51, Jeff Dike wrote:
> > On Sun, Oct 02, 2005 at 12:13:39PM +0200, Blaisorblade wrote:
> 
> > He did, and I found the same problem and sent him back the fix.  I guess
> > he sent in the original patch.
> Ok, he just said he sent a mismerged patch, but it's ok.
> > I was planning on sending it in after 2.6.14 because of its size.
> Al, is that ok for you if we follow this original plan?
> 
> In this case, I'll post the dropping patch and re-send the Kbuild fix of my 
> last batch (conflicted with Al's patch, but now it's needed again).

Up to Jeff; IMO it's easier to restore the variant past his review (with
incremental replacing that DEFINE_LONGS), but maintainer gets to decide;
that was the reason for Cc when patch got sent to Linus, after all...

diff -urN RC14-rc2-git6-base/arch/um/sys-i386/user-offsets.c current/arch/um/sys-i386/user-offsets.c
--- RC14-rc2-git6-base/arch/um/sys-i386/user-offsets.c	2005-09-25 23:28:27.000000000 -0400
+++ current/arch/um/sys-i386/user-offsets.c	2005-10-02 14:08:15.000000000 -0400
@@ -46,7 +46,7 @@
 	OFFSET(HOST_SC_FP_ST, _fpstate, _st);
 	OFFSET(HOST_SC_FXSR_ENV, _fpstate, _fxsr_env);
 
-	DEFINE_LONGS(HOST_FRAME_SIZE, FRAME_SIZE);
+	DEFINE(HOST_FRAME_SIZE, FRAME_SIZE);
 	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_i387_struct));
 	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fxsr_struct));
 


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
