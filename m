Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNFwr-0006sO-Uw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 12:28:37 -0700
Received: from pimout3-ext.prodigy.net ([207.115.63.102])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNFwq-0004ox-97 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 12:28:37 -0700
From: Chris Wedgwood <cw@f00f.org>
Message-ID: <20041028192824.GC851@taniwha.stupidest.org>
References: <200410272223.i9RMNj921852@mail.osdl.org>
	<200410282034.21922.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410282034.21922.blaisorblade_spam@yahoo.it>
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
Date: Thu, 28 Oct 2004 12:28:24 -0700
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com

On Thu, Oct 28, 2004 at 08:34:21PM +0200, Blaisorblade wrote:

> And removing the final Emacs comment is not welcome (I don't care,
> but Jeff does. If that should be removed, that's a separate
> problem).

the emacs comments are gratuitous and completely pointless, they serve
no useful purpose.  fwiw in my .emacs i have:

    (defun cw-linux-c-mode ()
      "C mode with adjusted defaults for use with the Linux kernel."
      (interactive)
      (c-mode)
      (c-set-style "linux"))
    (setq auto-mode-alist
	  (append '(("wk/linux.*/.*\\.[ch]$" . cw-linux-c-mode))
		  '(("/usr/src/linux.*/.*\\.[ch]$" . cw-linux-c-mode))
		  auto-mode-alist))

which actually could be cleaned up a bit (it's been hacked over the
years and never cleaned up suitably) but the idea is pretty simple


  --cw



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
