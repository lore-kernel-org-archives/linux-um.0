Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJomW-0004ll-8Q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Apr 2005 01:24:00 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJomU-0002EX-NM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Apr 2005 01:24:00 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [patch] Fix broken compiling under 2.6.12-rc2 with
	sed 3.02
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504080126.49602.rob@landley.net>
	<200504080856.35818.blaisorblade@yahoo.it>
In-Reply-To: <200504080856.35818.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504080321.08526.rob@landley.net>
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
Date: Fri, 8 Apr 2005 03:21:07 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Ian McDonald <imcdnzl@gmail.com>

On Friday 08 April 2005 02:56 am, Blaisorblade wrote:
> On Friday 08 April 2005 07:26, Rob Landley wrote:
> > Old versions of sed from 1998 (predating the first release of gcc 2.95,
> > but still in use by debian stable) don't understand the single-line
> > version of the sed append command.  Since newer versions of sed still
> > understand the... ahem, "vintage" form of the command, change it to use
> > that.
> >
> > Signed-off-by: Rob Landley <rob@landley.net>
> > Acked-by: Ian McDonald <imcdnzl@gmail.com>
> >
> > --- linux-2.6.11.old/arch/um/kernel/Makefile	2005-04-08
> > 01:06:15.000000000 -0400
>
> Note that your mailer wrapper the patch (only the first line), the saved
> file is wrapped like above. And Kmail doesn't mangle inline patches on
> saving (I've tested it multiple times). If you can't fix this, next time
> use attachments (with display as inline) with "7bit" encoding (i.e. not
> encoded).

Sigh.  I forgot to turn off wordwrap from the pulldown menu.  Long day...

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
