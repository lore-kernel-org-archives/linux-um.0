Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6UVq-000507-Nn for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 06:07:42 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D6UVm-0007Cl-RU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 06:07:42 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML 2.4 shmem.c changes? panic w/ backtrace
References: <41A35EF5.4080302@enterasys.com> <421E5F9A.6030109@enterasys.com>
	<200502281944.j1SJiHMY003270@ccure.user-mode-linux.org>
In-Reply-To: <200502281944.j1SJiHMY003270@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503021507.21524.blaisorblade@yahoo.it>
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
Date: Wed, 2 Mar 2005 15:07:20 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, "D. Bahi" <dbahi@enterasys.com>

On Monday 28 February 2005 20:44, Jeff Dike wrote:
> dbahi@enterasys.com said:
> > This happens everytime i try to load an application of ours that uses
> > shmem for syslog...
>
> I persist in seeing no particular UML involvement with this crash :-)
>
> Can you boil your app down to a test case which reproduces this?
Jeff, since the UML changes to the shmem.c code are currently unused, just to 
make sure, can you remove them from the patch, so that we can make sure? They 
are, actually, the devanon patch.

Or even you, D. Bahi?

Go reading the devanon patch on the site to understand exactly what to do 
(apart little rejects, it should probably be possible to reverse that patch). 
If you did the backporting to the 2.4.20 correctly (which can also be in 
doubt, since there is a bug - please don't get me wrong, I don't want to 
criticize you personally), you should be able to do it.

Be careful, because the changes are not insulated inside shmem.c: the addition 
of ->munmap inside <linux/fs.h>, all the references to it, the changes to 
shmem_fs.h... and maybe something else.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
