Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gsk5d-0005SF-LQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Dec 2006 10:04:53 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gsk5b-0002Ap-Uw
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Dec 2006 10:04:53 -0800
Date: Fri, 8 Dec 2006 19:04:55 +0100
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20061208180455.GD3356@stusta.de>
References: <20061208125928.GA25427@stusta.de>
	<20061208163304.GA5944@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20061208163304.GA5944@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML and fastcall/FASTCALL
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Dec 08, 2006 at 11:33:04AM -0500, Jeff Dike wrote:
> On Fri, Dec 08, 2006 at 01:59:28PM +0100, Adrian Bunk wrote:
> > UML on i386 is now the only case where fastcall/FASTCALL is not a noop.
> 
> If i386 doesn't use it any more, then UML shouldn't either.  The only reason
> there's support for it in UML is that I was copying i386.

It's a noop on i386 due to -mregparm=3 ...

> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
