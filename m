Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRvgq-0006fR-OF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 12:00:28 -0700
Received: from waste.org ([66.93.16.53])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GRvgp-00012s-6k
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 12:00:28 -0700
Date: Mon, 25 Sep 2006 13:58:52 -0500
From: Matt Mackall <mpm@selenic.com>
Message-ID: <20060925185852.GR6412@waste.org>
References: <200609251834.k8PIYftQ005046@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200609251834.k8PIYftQ005046@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH 6/8] UML - Add checkstack support
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, Paolo Giarrusso <blaisorblade@yahoo.it>, Joern Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Sep 25, 2006 at 02:34:41PM -0400, Jeff Dike wrote:
> Make checkstack work for UML.  We need to pass the underlying architecture
> name, rather than "um" to checkstack.pl.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
