Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEtJf-0004rY-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 08:37:03 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEtJf-0003lJ-GB
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 29 Oct 2003 08:37:03 -0800
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id 6FAD6144
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 11:37:02 -0500 (EST)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1AEtJe-0003Jz-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 11:37:02 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] About COW & filesystems
Message-ID: <20031029163702.GA6350@dijkstra.csh.rit.edu>
References: <BAY2-DAV62hA53ZpEVm00000924@hotmail.com> <200310281723.h9SHNLLJ002565@ccure.karaya.com> <BAY10-DAV26Yvm7kLig00008a71@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY10-DAV26Yvm7kLig00008a71@hotmail.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 29 Oct 2003 11:37:02 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Wed, Oct 29, 2003 at 06:16:18AM -0800, James McMechan wrote:

> Well above ubd we can use DM from inside the UML but outside of the UML
> I still want to be able to set up COW files at the system level.
> Matt Zimmerman said that DM is in 2.4 which I had somehow missed and
> that
> the DM snapshot feature could be used in place of COW

No, I said it was available...it is not in 2.4 stock, but a 2.4 patch is
actively maintained; I use it on many systems.  It might not be infeasible
for it to be included in a later 2.4, but I don't track that sort of thing.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
