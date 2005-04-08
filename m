Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJmZZ-0006hR-58 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 23:02:29 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJmZY-0006UL-KN
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 23:02:29 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504070250.10873.rob@landley.net>
	<200504072022.47474.blaisorblade@yahoo.it>
In-Reply-To: <200504072022.47474.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504080059.44620.rob@landley.net>
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
Date: Fri, 8 Apr 2005 00:59:44 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Ian McDonald <imcdnzl@gmail.com>

On Thursday 07 April 2005 02:22 pm, Blaisorblade wrote:
> On Thursday 07 April 2005 08:50, Rob Landley wrote:
> > On Wednesday 06 April 2005 03:36 pm, Blaisorblade wrote:
> > > Anyway, from looking at what you quote, it's identical to the code in
> > > arch/um/kernel/Makefile. Quoting the correct code:
> > >
> > > quiet_cmd_quote2 = QUOTE   $@
> > > cmd_quote2 = sed -e '/CONFIG/{'          \
> > >                   -e 's/"CONFIG"\;/""/'        \
> > >                   -e 'r $(obj)/config.tmp'     \
> > >                   -e 'a""\;'                   \
> > >                   -e '}'                       \
> > >                   $< > $@
>
> Btw, can you please explain me why both you and me didn't notice that
> config.tmp is not needed? Yesterday while at bed I thought to the world
> "pipe" and achieved enlightenment... Am I missing something?
>
> I'll send the patch, unless I get a NACK.

If you can get the sed "r" command to read from a pipe, by my guest.  (I 
mentioned originally that there was probably a cleaner way to do it, but I 
wasn't seeing it at the time...)

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
