Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZBz3-0007Uy-3g for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 09:40:13 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CZBz1-0002xW-3G
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 09:40:13 -0800
Subject: Re: [uml-devel] skas mode on a non-skas host
References: <200411292250.iATMoWOF004837@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0411291623340.5077@sparrow>
	<200411301710.15691.blaisorblade_spam@yahoo.it>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <200411301710.15691.blaisorblade_spam@yahoo.it>
Message-ID: <871xebdzif.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: 30 Nov 2004 18:20:56 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: William Stearns <wstearns@pobox.com>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade <blaisorblade_spam@yahoo.it> writes:

> I don't know the quilt syntax but it won't be totally different - it seems it 
> is "quilt push 50".

Either "quilt push" (single patch), "quilt push -a" (all patches) or
"quilt push <name>" (all up to and including patch "name").  It's a
very nice tool, I've aliased it to "q" because I'm using it that often.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
