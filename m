Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200407261816.i6QIGSfL001860@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] Mconsole exec support - rewritten completely 
In-Reply-To: Your message of "Thu, 22 Jul 2004 16:53:38 +0200."
	<200407221653.38293.blaisorblade_spam@yahoo.it> 
References: <200407221653.38293.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 26 Jul 2004 14:16:28 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> Jeff, you can still think that  this feature should not be in the
> kernel support (but why then bother with  the "proc" command?), 

Because "proc" is needed to diagnose sick UMLs, which may not be able to run
commands.  It's also handy to make measurements which may be affected by logging
in.

> even
> if this time there is no more any parsing code;  but anyway, it will
> stay available for who wants it.

You can maintain this yourself if you want, but it's going nowhere near my
tree.  I've said why I don't like it, and haven't heard any real arguments
for it, just whining by people who think parsing login sequences and shell
prompts is hard.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
