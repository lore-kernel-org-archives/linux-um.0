Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] [POLL] Putting UML/2.4 into "fixes-only" mode
In-Reply-To: <200501262310.49814.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0501301406390.13409@filer.marasystems.com>
References: <200501262310.49814.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Sun, 30 Jan 2005 14:28:54 +0100 (CET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Wed, 26 Jan 2005, Blaisorblade wrote:

> So, I'd suggest to follow this policy to choose the work to merge:
>
> - reduce *a lot* what is going to be merged... no new features, no code
> cleanups (especially NOT the Makefiles cleanups)...
>
> - concentrate on stability... and on backing out the hostfs rewrite.

I am all for this. People wanting "new fetures" should be using the 2.6 
tree + relevant patches anyway. 2.4 should focus only on stability, 
nothing else.

If there is users willing to have new features in 2.4 to the point that 
they provide these features backported to 2.4 then I am OK with having an 
"experimental" 2.4 patch with these aplied, but I do not think these 
belongs in the main 2.4 patch.

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
