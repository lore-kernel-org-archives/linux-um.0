Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYXK1-0004ue-7W for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Nov 2005 15:19:41 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EYXJz-0004hv-Gr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Nov 2005 15:19:41 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] The web page doesn't say where to get the switch
	daemon.
References: <200511041900.37782.rob@landley.net>
	<20051105051643.GA15683@ccure.user-mode-linux.org>
In-Reply-To: <20051105051643.GA15683@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511051300.57818.rob@landley.net>
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
Date: Sat, 5 Nov 2005 13:00:57 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Friday 04 November 2005 23:16, Jeff Dike wrote:
> On Fri, Nov 04, 2005 at 07:00:37PM -0600, Rob Landley wrote:
> > Let's see, the uml_net link from the download page (the difference
> > between that and uml_switch is...?) links to a generic page about CVS,
> > which isn't installed on my laptop.  (Subversion is, but doesn't help
> > here.)  Ok, a web browsing link...  No tarball.  Ok, maybe it's one
> > source file I can get and compile, ala ifenslave...
>
> Let's see.  On the downloads page, there is a utilities section which says
> something about uml_switch.  Grabbing that tarball shows me a directory
> called uml_router (which is probably the problem - that's the old name
> before people clued me in that I hadn't really implemented a router) with
> something called uml_switch.c in it.  Building that might give you
> something called uml_switch.

I never found a utilities tarball.  (I looked for a while.)

I ended up following the link to CVS, wandering around in there for a bit 
until I found the uml_router directory (at which point I remembered reading 
about the old name) doing a right-click save-as on the "download" link of 
the .c file, then grabbing the .h files it couldn't find, then grabbing 
port.c and hash.c too...  Then it built.

I'll look again for the tarball next time I'm online.  (Laptop at Einstein's 
bagels at the moment: no net access.)

>     Jeff

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
