Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9Wwv-0003ZK-Fj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 15:20:13 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1D9Wwr-0006LL-Fx
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 15:20:12 -0800
From: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050310225340.GD3205@stusta.de>
Message-ID: <Pine.LNX.4.58.0503101516190.2530@ppc970.osdl.org>
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
	<20050310225340.GD3205@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: [PATCH 4/9] UML - Export gcov symbol based on gcc
	version
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
Date: Thu, 10 Mar 2005 15:21:42 -0800 (PST)
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net



On Thu, 10 Mar 2005, Adrian Bunk wrote:
> 
> This patch is still wrong.

Can't we just fix it by havign an alias for both names? It seems stupid to 
jump through hoops and worry about compiler versions, when afaik we could 
just do something like

	extern xxxx(...) __attribute__((alias("yyyy")));

instead. Exact details left to the reader who knows more about all the 
magic gcc/linker things..

		Linus


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
