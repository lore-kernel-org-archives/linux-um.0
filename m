Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJbYW-0006e0-L8 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 11:16:40 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DJbYU-0001I8-S6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 11:16:40 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504062136.26895.blaisorblade@yahoo.it>
	<200504070250.10873.rob@landley.net>
In-Reply-To: <200504070250.10873.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504072022.47474.blaisorblade@yahoo.it>
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
Date: Thu, 7 Apr 2005 20:22:47 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Ian McDonald <imcdnzl@gmail.com>

On Thursday 07 April 2005 08:50, Rob Landley wrote:
> On Wednesday 06 April 2005 03:36 pm, Blaisorblade wrote:
> > Anyway, from looking at what you quote, it's identical to the code in
> > arch/um/kernel/Makefile. Quoting the correct code:
> >
> > quiet_cmd_quote2 = QUOTE   $@
> > cmd_quote2 = sed -e '/CONFIG/{'          \
> >                   -e 's/"CONFIG"\;/""/'        \
> >                   -e 'r $(obj)/config.tmp'     \
> >                   -e 'a""\;'                   \
> >                   -e '}'                       \
> >                   $< > $@
Btw, can you please explain me why both you and me didn't notice that 
config.tmp is not needed? Yesterday while at bed I thought to the world 
"pipe" and achieved enlightenment... Am I missing something?

I'll send the patch, unless I get a NACK.
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
