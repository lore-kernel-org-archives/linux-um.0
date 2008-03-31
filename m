Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JgO5k-0005fl-Su for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 10:46:44 -0700
Received: from stinky.trash.net ([213.144.137.162])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JgO5j-0005vw-Gq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Mar 2008 10:46:44 -0700
Message-ID: <47F1235F.4000704@trash.net>
Date: Mon, 31 Mar 2008 19:46:07 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <47E9E331.1010105@trash.net>
	<20080331140930.GD6540@c2.user-mode-linux.org>
In-Reply-To: <20080331140930.GD6540@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [UML]: uml-net: don't set IFF_ALLMULTI in
	set_multicast_list
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Linux Netdev List <netdev@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Wed, Mar 26, 2008 at 06:46:25AM +0100, Patrick McHardy wrote:
>>     [UML]: uml-net: don't set IFF_ALLMULTI in set_multicast_list
> 
> I don't really understand this, but the people who do seem to like it,
> so I'll drop it in my tree and forward it along if no one else does.

Thanks, its already in Linus' tree.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
