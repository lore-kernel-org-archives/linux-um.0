Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] [PATCH] Mconsole exec support - rewritten completely
Message-ID: <20040727031320.GD3792@alcor.net>
References: <200407221653.38293.blaisorblade_spam@yahoo.it>
	<200407261816.i6QIGSfL001860@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407261816.i6QIGSfL001860@ccure.user-mode-linux.org>
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
Date: Mon, 26 Jul 2004 20:13:20 -0700
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Mon, Jul 26, 2004 at 02:16:28PM -0400, Jeff Dike wrote:

> You can maintain this yourself if you want, but it's going nowhere near my
> tree.  I've said why I don't like it, and haven't heard any real arguments
> for it, just whining by people who think parsing login sequences and shell
> prompts is hard.

I wouldn't say "hard"..."nasty" seems more appropriate, or "not robust".
Then again, I don't like the mconsole approach, either.  So far, I've been
running a daemon inside UML which speaks a simple protocol over a UML
channel.  This works OK, but has the disadvantage of requiring specialized
software running under the UML guest.

-- 
 - mdz


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
