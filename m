Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJG1a-0003vr-33 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Mar 2006 12:21:46 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FJG1Y-0005Nw-Lg
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Mar 2006 12:21:46 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Occasional hang starting up.
Message-ID: <20060314202249.GB22286@ccure.user-mode-linux.org>
References: <200603111301.42195.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603111301.42195.rob@landley.net>
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
Date: Tue, 14 Mar 2006 15:22:49 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 11, 2006 at 01:01:41PM -0500, Rob Landley wrote:
> On linux-2.6.16-rc5 I'm occasionally getting a hang starting up (with 
> rootfstype=hostfs), right after the initializing VFS line.  

I'm in the process of beating on the newer externfs-based hostfs and humfs,
so I'm not too concerned with bugs in the old hostfs.  Having said that,
if you can get a stack from the hang, it might turn out to be an easily
diagnosed and fixed bug.

> This time when I
> killed it, I got the following error (repeated twice):
> 
> remove_umid_dir - actually_do_remove failed with err = -2

There's some confusion sometimes during shutdown when UML is forcibly killed.
I haven't really looked at this, but it's harmless.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
