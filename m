Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bk6fY-0008Vo-CM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Jul 2004 12:40:56 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bk6fX-0002eb-TG
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Jul 2004 12:40:56 -0700
Message-Id: <200407122036.i6CKa3Ys001604@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] uml_mconsole issue 
In-Reply-To: Your message of "Wed, 07 Jul 2004 13:43:07 PDT."
	<IFEIKNDOLFNCKMGAENCFEEIECHAA.Anthony_Brock@ous.edu> 
References: <IFEIKNDOLFNCKMGAENCFEEIECHAA.Anthony_Brock@ous.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 12 Jul 2004 16:36:03 -0400
To: Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

Anthony_Brock@ous.edu said:
> (gdb) bt 
> #0  0xa00730df in link_path_walk (name=0xa0a59ca9 "uptime", nd=0xa3fd3aa4) 
> at fs/namei.c:591 

This is known, and I haven't got around to fixing it yet.

				Jeff





-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
