Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CrUKt-0006YB-Us for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 20:54:23 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CrUKt-0005sG-EL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 Jan 2005 20:54:23 -0800
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.12.11/8.12.11) with ESMTP id j0K63FaB007469
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 20 Jan 2005 01:03:16 -0500
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501200107.43159.blaisorblade@yahoo.it>
In-Reply-To: <200501200107.43159.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501192252.54585.rob@landley.net>
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
Date: Wed, 19 Jan 2005 22:52:54 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 19 January 2005 07:07 pm, Blaisorblade wrote:

> What was discovered until now is this:
>
> The relation is obviously hidden somehow... however I sent on the uml-devel
> list a couple of patches from after 2.4.24-1um: without them UML does not
> suffer from the Debian/hwclock crash, while it happens with them. What's
> strange is that the crash happens within TT mode, not within SKAS mode. And
> rather than a crash, it's a hang, due to an infinite number of received
> SIGSEGVs. Inside the couple of patches, there is exactly this problematic
> change.

Ooh, ooh!  Hang in TT mode is what I'm seeing with my makefile hang.  (sh -x 
dosn't help if the makefile doesn't call out to stuff with it.)

If the previous patch doesn't address it, is there a new patch I could try?

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
