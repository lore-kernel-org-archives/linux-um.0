Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Crxoz-0000sG-Iw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 04:23:25 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Crxow-00009Z-O8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 04:23:25 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501200107.43159.blaisorblade@yahoo.it>
	<200501192252.54585.rob@landley.net>
In-Reply-To: <200501192252.54585.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501211335.37894.blaisorblade@yahoo.it>
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
Date: Fri, 21 Jan 2005 13:35:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Thursday 20 January 2005 04:52, Rob Landley wrote:
> On Wednesday 19 January 2005 07:07 pm, Blaisorblade wrote:
> > What was discovered until now is this:
> >
> > The relation is obviously hidden somehow... however I sent on the
> > uml-devel list a couple of patches from after 2.4.24-1um: without them
> > UML does not suffer from the Debian/hwclock crash, while it happens with
> > them. What's strange is that the crash happens within TT mode, not within
> > SKAS mode. And rather than a crash, it's a hang, due to an infinite
> > number of received SIGSEGVs. Inside the couple of patches, there is
> > exactly this problematic change.
>
> Ooh, ooh!  Hang in TT mode is what I'm seeing with my makefile hang.  (sh
> -x dosn't help if the makefile doesn't call out to stuff with it.)
>
> If the previous patch doesn't address it, is there a new patch I could try?
Well, you solved this problem with the 2.6.11-rc1-mm2, right (from the message 
below)?

The patch which was merged there is the one posted with title "[uml-devel] 
[PATCH] Fix stack corruption" on this list..., I guess... it will be in 
2.6.9-bs6 and 2.6.10-bb1 (both to release) - are you willing to test one of 
them, when I do the release? I'd be very thankful to accept your help...
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
