Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD9pM-0005Nu-DF for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 15:27:24 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DD9pK-0000Tr-SG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 15:27:24 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [patch] Remove unnecessary config symbol from
	makefile.
References: <200503170219.38388.rob@landley.net>
	<200503171859.52969.rob@landley.net>
	<200503201142.17480.blaisorblade@yahoo.it>
In-Reply-To: <200503201142.17480.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503201724.35155.rob@landley.net>
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
Date: Sun, 20 Mar 2005 17:24:33 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade@yahoo.it>

On Sunday 20 March 2005 05:42 am, Blaisorblade wrote:

> > Without the fix I posted, I have to remove existing
> > symbols from the list,
>
> If you enable the other symbol, Kbuild will remove it from .config for you
> (and output a warning message, yes, but that's hardly a problem). When I
> remove config options from Kconfig files I don't need to remove them
> from .config by hand...

How does oldconfig know which one "wins" when they're both set in the .config?  
I'm not running menuconfig, I have a script that is appending more symbols to 
the .config file, which works fine for normal symbols (ones that are 
commented out when they're not set), and I'm starting with a "make 
allnoconfig" that I then append extra symbols to and run make oldconfig to 
resolve dependencies...

Trying to set up something with make config and expect would be more brittle 
and version specific than just snapshotting a .config file in the first 
place, and would defeat the purpose anyway.  The point is, I wanted my build 
script to be self-documenting about what symbols it needed.  The ones it 
appends are the ones it needs, and the ones you'd have to switch on by hand 
if you did a make allnoconfig followed by make menuconfig yourself..

See what I'm getting at?

If you're saying that there's a hard rule that any symbol that's set by make 
allnoconfig will automatically lose to any other symbol that isn't if both 
are set in the config and oldconfig has to resolve an inconsistent state, I 
suppose I can live with that.  I'm a bit uncomfortable relying on that unless 
it's documented somewhere...

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
