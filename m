Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPoIo-0003CR-4n for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 13:01:34 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPoIn-0008S2-Hg for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 13:01:33 -0700
Message-ID: <02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Mon, 17 May 2004 22:08:33 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: LaurentVivier@wanadoo.fr

hi !
has this / will this be ported to 2.6 ?
have there been made further performance comparisons ?
regards
roland


>Well, we just looked at the context switches. We started 3 UMLs which
>were doing a make world for xfree. Without patches the number of
>context switches per second was around 60k, with the patch it was around
>40k - so it's noticeable, at least from the cs.
>Sven

----- Original Message ----- 
From: "Jeff Dike" <jdike@addtoit.com>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Sunday, February 29, 2004 6:35 AM
Subject: [uml-devel] [PATCH] host context switch reduction


> The patches below are from Laurent Vivier who didn't make them public.  They
> add a new feature to ptrace on the host which cuts down on the number of
> context switches needed for a UML system call, plus makes UML use it.
> 
> There's some interest in this, so I'm putting it out as-is.  I haven't played
> with it.
> 
> Laurent did some performance testing and found ~40% speedup on a getpid
> loop, and a 3.5% speedup on a kernel build.
> 
> Jeff
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
