Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNHPF-0004Dl-93 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:02:01 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CNHPC-0003LF-Ve for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:02:01 -0700
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <200410272223.i9RMNj921852@mail.osdl.org>
	<200410282034.21922.blaisorblade_spam@yahoo.it>
	<20041028192824.GC851@taniwha.stupidest.org>
In-Reply-To: <20041028192824.GC851@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410282302.48311.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [patch 7/7] uml: resolve symbols in back-traces
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
Date: Thu, 28 Oct 2004 23:02:48 +0200
To: Chris Wedgwood <cw@f00f.org>
Cc: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com

On Thursday 28 October 2004 21:28, Chris Wedgwood wrote:
> On Thu, Oct 28, 2004 at 08:34:21PM +0200, Blaisorblade wrote:
> > And removing the final Emacs comment is not welcome (I don't care,
> > but Jeff does. If that should be removed, that's a separate
> > problem).

> the emacs comments are gratuitous and completely pointless, they serve
> no useful purpose.  fwiw in my .emacs i have:

>     (defun cw-linux-c-mode ()
>       "C mode with adjusted defaults for use with the Linux kernel."
>       (interactive)
>       (c-mode)
>       (c-set-style "linux"))
>     (setq auto-mode-alist
>    (append '(("wk/linux.*/.*\\.[ch]$" . cw-linux-c-mode))
>     '(("/usr/src/linux.*/.*\\.[ch]$" . cw-linux-c-mode))
>     auto-mode-alist))
>
> which actually could be cleaned up a bit (it's been hacked over the
> years and never cleaned up suitably) but the idea is pretty simple

I mostly agree on this, and thought it myself (I *never* use Emacs, only Vim, 
but no flames here).

However, let's be kind with Jeff, since he's the UML maintainer. You can be 
right, but there's also courtesy.

If Jeff says "OK", then someone can submit a separate patch removing all the 
final comments.

Until then, please don't.

And never mix such unrelated changes in a patch.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
