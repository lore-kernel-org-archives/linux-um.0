Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAEXr-0006iv-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 13:16:27 -0700
Received: from panoramix.vasoftware.com
	([198.186.202.147] helo=externalmx.vasoftware.com ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAEXo-0002El-En
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 16 Oct 2003 13:16:24 -0700
Received: from cimice4.lam.cz ([212.71.168.94]:44685 helo=vagabond.light.src)
	by externalmx.vasoftware.com with esmtp (Exim 4.22 #1 (Debian))
	id 1AAEX8-0005sm-8d
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 13:15:42 -0700
Received: from bulb by vagabond.light.src with local (Exim 3.36 #1 (Debian))
	id 1AAEWc-0008Kc-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 22:15:10 +0200
From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [uml-devel] unkillable UML threads
Message-ID: <20031016201510.GA31337@vagabond>
References: <25476.1064407242@marajade.sandelman.ottawa.on.ca> <200310062119.h96LIsGj020742@ccure.karaya.com> <20031011041547.GH13041@dijkstra.csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011041547.GH13041@dijkstra.csh.rit.edu>
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
Date: Thu, 16 Oct 2003 22:15:10 +0200
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 11, 2003 at 00:15:47 -0400, Matt Zimmerman wrote:
> On Mon, Oct 06, 2003 at 05:18:54PM -0400, Jeff Dike wrote:
> 
> > mcr@sandelman.ottawa.on.ca said:
> > > FYI: This is without the skas patch, with a stock RH9 kernel on the
> > > host.
> > >
> > > Any thoughts or coroboration would be appreciated. Clearly this is a
> > > bug in the RH9 kernel.  
> > 
> > It could easily be a UML bug.  I do have code which continues threads
> > so that they die properly, but it seems not to be happening here.  Can
> > you tell me how to reproduce it?
> 
> I know of no reliable way to reproduce it, but I commonly do things like
> "killall linux" and end up with a suspended process left behind.  Maybe it
> has something to do with multiple threads receiving the signal?  I think it
> has also happened when killing only the first process, but I can't test
> right now.

The way out is to also kill with SIGCONT signal. Since umlinux uses
tracing a lot, some processes are often stopped. When you kill the
tracer while it's victim is stopped, it's not awoken. So you have to do
it yourself.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
