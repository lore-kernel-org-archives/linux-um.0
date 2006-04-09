Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FSeCe-0000Rt-4P for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Apr 2006 11:00:00 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FSeCd-00068j-VW
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Apr 2006 11:00:00 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] uml: problem with 2G/2G host address space
Message-ID: <20060409170111.GC2944@ccure.user-mode-linux.org>
References: <20060409105755.GA24319@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060409105755.GA24319@xs4all.nl>
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
Date: Sun, 9 Apr 2006 13:01:11 -0400
To: Joris van Rantwijk <jvrantwijk@xs4all.nl>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Apr 09, 2006 at 12:57:55PM +0200, Joris van Rantwijk wrote:
> It soon made sense to me that a 3G/1G configured UML would crash like
> this, but I then found that UML 2.6.16.2 configured for 2G/2G crashed
> in exactly the same way. I think this is due to the fact that STUB_CODE
> and STUB_DATA are fixed at the 3G/1G settings. After changing these
> settings, everything seems to work properly in 2G/2G mode.

Your analysis is correct, and the patch is fine as far as it goes, but
we were talking about this a week or so ago about detecting the host
address space split at runtime.  There's a lot more potential
flexibility there than just 3/1 and 2/2.

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
