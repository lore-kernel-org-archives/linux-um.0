Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMWA1-0005qG-QA for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 12:11:57 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMWA0-0000KO-9t
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 12:11:57 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Occasional hang starting up.
Message-ID: <20060323201301.GA6025@ccure.user-mode-linux.org>
References: <200603111301.42195.rob@landley.net>
	<200603172036.59218.blaisorblade@yahoo.it>
	<20060321010025.GC7860@ccure.user-mode-linux.org>
	<200603210221.41654.blaisorblade@yahoo.it>
	<20060323184551.GA5398@ccure.user-mode-linux.org>
	<20060323160533.D8529@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323160533.D8529@almesberger.net>
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
Date: Thu, 23 Mar 2006 15:13:01 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>

On Thu, Mar 23, 2006 at 04:05:33PM -0300, Werner Almesberger wrote:
> Hmm, is this a link ?
> 
> % find linux-2.6.15.5/arch/um -name sigio.c
> %

Nope, it's just later in my patchset than one which moves the file.

> The patch applies cleanly to arch/um/kernel/sigio_user.c of 2.6.16,
> though, and indeed seems to solve the problem.

Yup, and that's the original location.

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
