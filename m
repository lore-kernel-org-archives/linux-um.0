Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Clnfb-0004ai-7s for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Jan 2005 04:20:15 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1ClnfV-0005eG-UD
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Jan 2005 04:20:15 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20050104115947.GA3715@bytesex>
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200501031249.26675.Armin.Warda@gmx.de>
	<20050103133412.GA25262@bytesex>
	<200501031531.19246.Armin.Warda@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501031531.19246.Armin.Warda@gmx.de>
Subject: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE 9.2)
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
Date: Tue, 4 Jan 2005 12:59:47 +0100
To: "Armin M. Warda" <Armin.Warda@gmx.de>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Paolo Giarrusso <blaisorblade_personal@yahoo.it>, "Christopher S. Aker" <caker@theshore.net>

> Thus the bugfix must have been introduced somewhere between 
> 2.6.10-rc2-bk7 and 2.6.10-rc3-bk10.

Thats a pretty wide range (Nov 22 => Dec 16), anyone tried kernels
inbetween and can narrow that a bit?

Intrestingly mm/shmem.c (which implements shmfs/tmpfs) hasn't been
touched since Nov 19 according to bitkeeper ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
