Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOMFl-0003ob-Rj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:06:01 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOMFk-0005Ji-6M
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:06:01 -0800
Date: Mon, 5 Mar 2007 15:05:47 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070305150547.c30339f5.akpm@linux-foundation.org>
In-Reply-To: <200703052245.27260.blaisorblade@yahoo.it>
References: <200703052245.27260.blaisorblade@yahoo.it>
Mime-Version: 1.0
Subject: Re: [uml-devel] Remap_file_pages protection support: when to send
	patches?
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-mm@kvack.org, Jeff Dike <jdike@addtoit.com>, Ingo@sc8-sf-spam2-b.sourceforge.net, Molnar <mingo@redhat.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 5 Mar 2007 22:45:26 +0100
Blaisorblade <blaisorblade@yahoo.it> wrote:

> Hi Andrew, I've been resurrecting lately remap_file_pages protection support 
> for UML.
> 
> I've updated it to 2.6.20 and it passes its unit test, and the 
> resulting kernel has no stability problems in my experience on my Dual Core 
> laptop (I've been using it for long time).
> 
> Since last time I sent it, I've fixed remaining problems and TODOs, and 
> cleaned up the split (I'm just improving the way patches are split). Now it 
> is a patchset with 13 patches, and the diffstat is attached.
> 
> Now I'm curious about when I should or could better send those patches - i.e. 
> when they bring less noise into the -mm tree?
> 
> This would allow me to snapshot the git and/or -mm tree, test the patches 
> against that kernel with my unit testing program, and only then send these 
> patches to get them at least included into -mm.
> 
> Any suggestion? Obviously if you want to see the code first, in the standard 
> way, I'll follow usual practice  - just tell it me (and I'll send it shortly 
> anyway, if I get no answer).

Just send them out, against next -mm please.  Be sure to cc linux-mm.

I'm going to have to ask other developers for more help reviewing and testing
things like this in the future.  Things just aren't working.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
