Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAEnO-0000Na-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 13:32:30 -0700
Received: from blacksheep.csh.rit.edu ([129.21.60.6])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAEnJ-0005Dv-A5
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 16 Oct 2003 13:32:25 -0700
Received: from dijkstra (dijkstra.csh.rit.edu [129.21.60.152])
	by blacksheep.csh.rit.edu (Postfix) with ESMTP id BD72A34F
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 16:32:22 -0400 (EDT)
Received: from mdz by dijkstra with local (Exim 3.35 #1 (Debian))
	id 1AAEnG-0007EG-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 16:32:22 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] unkillable UML threads
Message-ID: <20031016203222.GV15069@dijkstra.csh.rit.edu>
References: <25476.1064407242@marajade.sandelman.ottawa.on.ca> <200310062119.h96LIsGj020742@ccure.karaya.com> <20031011041547.GH13041@dijkstra.csh.rit.edu> <20031016201510.GA31337@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016201510.GA31337@vagabond>
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
Date: Thu, 16 Oct 2003 16:32:22 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Thu, Oct 16, 2003 at 10:15:10PM +0200, Jan Hudec wrote:

> On Sat, Oct 11, 2003 at 00:15:47 -0400, Matt Zimmerman wrote:
> > On Mon, Oct 06, 2003 at 05:18:54PM -0400, Jeff Dike wrote:
> > > It could easily be a UML bug.  I do have code which continues threads
> > > so that they die properly, but it seems not to be happening here.  Can
> > > you tell me how to reproduce it?
> > 
> > I know of no reliable way to reproduce it, but I commonly do things like
> > "killall linux" and end up with a suspended process left behind.  Maybe it
> > has something to do with multiple threads receiving the signal?  I think it
> > has also happened when killing only the first process, but I can't test
> > right now.
> 
> The way out is to also kill with SIGCONT signal. Since umlinux uses
> tracing a lot, some processes are often stopped. When you kill the
> tracer while it's victim is stopped, it's not awoken. So you have to do
> it yourself.

Yes, I understand how signals work, thank you.  Jeff asked how to reproduce
the situation where a suspended process is left behind, because that should
not happen.

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
