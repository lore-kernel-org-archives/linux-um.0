Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrPfo-0007TV-0n for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 15:55:40 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CrPfn-0002UE-2p for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 15:55:39 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
In-Reply-To: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501200107.43159.blaisorblade@yahoo.it>
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
Date: Thu, 20 Jan 2005 01:07:43 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, "Christopher S. Aker" <caker@theshore.net>

On Tuesday 18 January 2005 22:28, Jeff Dike wrote:
> It turns out that caker's crashes were being caused by the lack of
> SA_NODEFER in the SIGSEGV handler registration.
As Jeff explained me on IRC, the previous patch sent about the same subject, 
actually, was correct, but not related to the caker's problem.

Since Jeff explained everything on IRC (#uml) I'm just explaining it here for 
the archives.

> I know I fixed this, and I have no idea where the fix went.  Do you have
> any clue what happened to it?

The SA_NODEFER flag was dropped from that call in 2.6.7-2um in the "random" 
patch, in 2.4.24-2um, and finally in  
uml-let-page-faults-always-be-delivered-immediately.patch in 2.6.9-rc2-mm1.

That was compensated by adding the addition of this hunk for TT mode in 
sig_handler_common_tt() :

        /* This is done because to allow SIGSEGV to be delivered inside a SEGV
         * handler.  This can happen in copy_user, and if SEGV is disabled,
         * the process will die.
         */
        if(sig == SIGSEGV)
                change_sig(SIGSEGV, 1);

But this was forgot for sig_handler_common_skas()... and this caused the 
problem.

I found this change to be done also in 2.4.24-2um; moreover, it's part of the 
patch which causes hwclock to hang on 2.4 - I'll try applying your fix to 2.4 
and retesting with hwclock.

What was discovered until now is this:

The relation is obviously hidden somehow... however I sent on the uml-devel 
list a couple of patches from after 2.4.24-1um: without them UML does not 
suffer from the Debian/hwclock crash, while it happens with them. What's 
strange is that the crash happens within TT mode, not within SKAS mode. And 
rather than a crash, it's a hang, due to an infinite number of received 
SIGSEGVs. Inside the couple of patches, there is exactly this problematic 
change.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
