Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJYjW-0000eR-HC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Mar 2006 08:20:22 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FJYjV-0002HF-TH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Mar 2006 08:20:22 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Soft lockup with 2.6.15+bs3-tls
Message-ID: <20060315162130.GB4186@ccure.user-mode-linux.org>
References: <20060315135915.63d0443e@thomas.toulouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315135915.63d0443e@thomas.toulouse>
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
Date: Wed, 15 Mar 2006 11:21:30 -0500
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Mar 15, 2006 at 01:59:15PM +0100, Thomas Petazzoni wrote:
> While using 'gcc' under UML 2.6.15 patched with bs3-tls, no patch on
> the host, I get the following soft lockup. The soft lockup is fully
> reproducible, and always occurs while compiling a specific file of the
> software I'm compiling under UML.

Soft lockups are easy to reproduce with any heavy I/O load, but I
haven't figured out what is going on.  They are harmless, though.  If
you don't like the messages, you can just disable them in the config.

The OOM is more interesting.  Is that reproducable?

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
