Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AABAg-0002K5-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 09:40:18 -0700
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AABAe-0007un-Da
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 16 Oct 2003 09:40:16 -0700
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id AD9ED19A
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 12:40:15 -0400 (EDT)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1A8BAR-0003YS-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 11 Oct 2003 00:15:47 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] unkillable UML threads
Message-ID: <20031011041547.GH13041@dijkstra.csh.rit.edu>
References: <25476.1064407242@marajade.sandelman.ottawa.on.ca> <200310062119.h96LIsGj020742@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310062119.h96LIsGj020742@ccure.karaya.com>
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
Date: Sat, 11 Oct 2003 00:15:47 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, Oct 06, 2003 at 05:18:54PM -0400, Jeff Dike wrote:

> mcr@sandelman.ottawa.on.ca said:
> > FYI: This is without the skas patch, with a stock RH9 kernel on the
> > host.
> >
> > Any thoughts or coroboration would be appreciated. Clearly this is a
> > bug in the RH9 kernel.  
> 
> It could easily be a UML bug.  I do have code which continues threads
> so that they die properly, but it seems not to be happening here.  Can
> you tell me how to reproduce it?

I know of no reliable way to reproduce it, but I commonly do things like
"killall linux" and end up with a suspended process left behind.  Maybe it
has something to do with multiple threads receiving the signal?  I think it
has also happened when killing only the first process, but I can't test
right now.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
