Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3g7C-0000sG-Ah for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Feb 2005 11:54:38 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D3g77-0007LG-Dq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Feb 2005 11:54:38 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] cross-build patch breaks UML build
References: <4214934C.9030105@fujitsu-siemens.com>
In-Reply-To: <4214934C.9030105@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502222053.08135.blaisorblade@yahoo.it>
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
Date: Tue, 22 Feb 2005 20:53:07 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Thursday 17 February 2005 13:51, Bodo Stroesser wrote:
> Have setup a new tree with all of the latest incremental patches included.
> UML build fails with:
>     make[1]: *** No rule to make target `arch/um/kernel/vmlinux.lds',
> needed by `__build'.  Stop. The problem is, that after applying cross-build
> patch, the symbolic link vmlinux.lds.S to uml.lds.S or dyn.lds.S no longer
> is created by make. After having linked by hand, make finished
> successfully.
The Al Viro's original patch had a vmlinus.lds.S created in form of a file 
#including the right one. The Jeff's version lost the file. See the 
discussion above for the original URL.
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
