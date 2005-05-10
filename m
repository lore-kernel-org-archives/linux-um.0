Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVbY7-0002Tk-Mw	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 13:41:51 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DVbY6-0006yW-15	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 13:41:51 -0700
From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [uml-devel] Re: [patch 1/6] uml: remove elf.h [ compile-fix, for
	2.6.12 ]
Message-ID: <20050510204048.GX3590@stusta.de>
References: <20050509224509.0C105416E4@zion>
	<20050509183401.28082cbc.akpm@osdl.org>
	<Pine.LNX.4.61.0505101525360.16461@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505101525360.16461@filer.marasystems.com>
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
Date: Tue, 10 May 2005 22:40:49 +0200
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: Andrew Morton <akpm@osdl.org>, blaisorblade@yahoo.it, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, May 10, 2005 at 03:37:33PM +0200, Henrik Nordstrom wrote:
>...
> The /dev/null trick only works well for adding files, not removing them.

It works fine for removing files except when they have a zero length.

> Regards
> Henrik

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
