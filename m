Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FR9lq-0002yA-4z for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 08:18:10 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FR9ln-0008JE-L7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 08:18:09 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] find_iomem hangs up
Message-ID: <20060405141921.GB4377@ccure.user-mode-linux.org>
References: <4433958F.3090200@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4433958F.3090200@oktetlabs.ru>
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
Date: Wed, 5 Apr 2006 10:19:21 -0400
To: "Victor V. Vengerov" <Victor.Vengerov@oktetlabs.ru>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 05, 2006 at 02:01:51PM +0400, Victor V. Vengerov wrote:
> When I've build uml with mmapper driver in, and attempted to pass 
> something like iomem=xxx,yyy in command line, guest kernel hang up on 
> boot. This is because of error in find_iomem - see patch below.

Applied, thanks.

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
