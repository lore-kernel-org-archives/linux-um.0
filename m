Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCxtI-0004BW-Ci for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 02:42:40 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DCxtG-0003Eq-39 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 02:42:40 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [patch] Remove unnecessary config symbol from
	makefile.
References: <200503170219.38388.rob@landley.net>
	<200503172022.52943.blaisorblade@yahoo.it>
	<200503171859.52969.rob@landley.net>
In-Reply-To: <200503171859.52969.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503201142.17480.blaisorblade@yahoo.it>
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
Date: Sun, 20 Mar 2005 11:42:17 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Friday 18 March 2005 00:59, Rob Landley wrote:
> On Thursday 17 March 2005 02:22 pm, Blaisorblade wrote:
> > On Thursday 17 March 2005 08:19, Rob Landley wrote:
> > > There can be only one!
> >
> > Yes, but I prefer slightly the current way, since it's more similar to
> > the obj-$(CONFIG_WHATEVER) += whatyouneed.o Kbuild idiom...
>
> What I wanted to do was have my build "make allnoconfig", add the symbols I
> wanted to switch on to the .config, and "yes '' | make oldconfig" to
> resolve dependencies.
>
> The symbol I killed is set Y by make allnoconfig, and disabled by switching
> the other symbol on.

> Without the fix I posted, I have to remove existing 
> symbols from the list,
If you enable the other symbol, Kbuild will remove it from .config for you 
(and output a warning message, yes, but that's hardly a problem). When I 
remove config options from Kconfig files I don't need to remove them 
from .config by hand...
> which is uglier. 
>
> I can snapshot a handtuned .config, but that's A) harder to see what I did,
> B) a lot more version-specific.
>
> Rob
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
