Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DqDeF-0008Ji-EI	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jul 2005 10:25:23 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DqDeB-0007UH-Gk	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jul 2005 10:25:23 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML - TT_MODE build fix
References: <42BBA415.20407@gmx.de>
In-Reply-To: <42BBA415.20407@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061931.18701.blaisorblade@yahoo.it>
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
Date: Wed, 6 Jul 2005 19:31:17 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Raphael Bossek <raphael.bossek@gmx.de>

On Friday 24 June 2005 08:11, Raphael Bossek wrote:
> Using of the preprocessor define SUBARCH as part of an directory
> name does not work in linux-2.6.12/arch/um/kernel/uml.lds.S:
>
> arch/um/sys-SUBARCH/unmap_fin.o => arch/um/sys- i386 /unmap_fin.o
>
> This patch works with linux 2.6.12-mm1 and gcc 2.95.
Ok, I've thought to this, and it's simpler IMHO to pass

-DSUBARCH_FILE=arch/um/sys-i386/unmap_fin.o

the linker will happily ignore the following space, since there's already one 
space in that position.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
