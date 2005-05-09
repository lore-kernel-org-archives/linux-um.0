Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVI2C-00050n-Js	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:51:36 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DVI29-0002HM-Uk	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:51:36 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Kernel panic with 2.6.11.6
Message-ID: <20050509225716.GA13334@ccure.user-mode-linux.org>
References: <s2788296.000@ORANGE.OUS.EDU>
	<20050507031500.GE14445@ccure.user-mode-linux.org>
	<20050509094050.lmdi6vnoex8g4g84@www.scgiservices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050509094050.lmdi6vnoex8g4g84@www.scgiservices.com>
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
Date: Mon, 9 May 2005 18:57:16 -0400
To: Anthony Brock <brocka@sterlingcgi.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, May 09, 2005 at 09:40:50AM -0700, Anthony Brock wrote:
> `FIXADDR_USER_START' undeclared (first use in this function)
> /srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24: 
> error:
> (Each undeclared identifier is reported only once
> /srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24: 
> error:
> for each function it appears in.)
> /srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24: 
> error:
> `FIXADDR_USER_END' undeclared (first use in this function)
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2

Looks like you tried to push the entire patchset.  The skas0 comment about
applying up to there also means you shouldn't go any further.  There are
later patches which are missing x86_64 support.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
