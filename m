Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEHUg-00064k-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 27 Oct 2003 16:13:54 -0800
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEHU6-0004Xd-58
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 27 Oct 2003 16:13:18 -0800
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id E956BBC
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 27 Oct 2003 19:13:16 -0500 (EST)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1AEHU4-0005eX-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 27 Oct 2003 19:13:16 -0500
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Has anyone ever considered a COW patch for loop.c
Message-ID: <20031028001316.GT6350@dijkstra.csh.rit.edu>
References: <3F9DA82B.7020808@easyco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9DA82B.7020808@easyco.com>
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
Date: Mon, 27 Oct 2003 19:13:16 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, Oct 27, 2003 at 03:20:11PM -0800, Doug Dumitru wrote:

> It would be really intersting to do a cow format compatible patch for 
> loop.c so that the standard loopback device could mount cow file pairs.
> 
> Has anyone considered/started on this.  If not, I might give it a hack.

As I've said before, I think the way to go would be to teach device-mapper
about the COW on-disk metadata format, and treat it as a snapshot.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
