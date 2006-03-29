Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOfzr-0005GG-0F for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Mar 2006 11:06:23 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FOfzp-0005ay-JW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Mar 2006 11:06:23 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060329190723.GA4940@ccure.user-mode-linux.org>
References: <8c064ef30603272133o437f925fja562b4bcb53a039a@mail.gmail.com>
	<20060328142243.GA3811@ccure.user-mode-linux.org>
	<8c064ef30603282122x1db12cb6h557642ee8130f899@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c064ef30603282122x1db12cb6h557642ee8130f899@mail.gmail.com>
Subject: [uml-devel] Re: [uml-user] uml hangs with no errors
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
Date: Wed, 29 Mar 2006 14:07:23 -0500
To: Jack Sparrow <virtualspy3@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Mar 28, 2006 at 11:22:20PM -0600, Jack Sparrow wrote:
> [dheeraj@localhost linux-2.6.14.6]$ ./linux ubd0=root_fs_slack8.1 stderr=1
> Checking PROT_EXEC mmap in /tmp...OK
> Checking for /proc/mm...found
> Checking for the skas3 patch in the host...found
> UML running in SKAS3 mode
> 
> It still is the same. It hangs at the above statement. Where it might have
> got wrong?

Can you try a 2.6.16 UML to make sure this is still a problem?

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
