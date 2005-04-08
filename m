Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJmXm-0006dg-Dt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 23:00:38 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJmXl-0006Mi-TS
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 23:00:38 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504070250.10873.rob@landley.net>
	<200504072019.14693.blaisorblade@yahoo.it>
In-Reply-To: <200504072019.14693.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504080057.52012.rob@landley.net>
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
Date: Fri, 8 Apr 2005 00:57:52 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Ian McDonald <imcdnzl@gmail.com>

On Thursday 07 April 2005 02:19 pm, Blaisorblade wrote:

> >   CHK     usr/initramfs_list
> >   QUOTE   arch/um/kernel/config.tmp
> >   QUOTE   arch/um/kernel/config.c
> >   CC      arch/um/kernel/config.o
> >
> > And I'm using knoppix, which is based on debian.
>
> But with updated packages (i.e. unstable/testing). If the patch is so
> little and without downsides, there's no point in not merging it.

Agreed.

> > From the error message, it seems to be complaining about the "a" command.
> > If you're using a really really really old version of sed, it might
> > insist on a gratuitous line break before the line to be added.  (I know
> > it did back in the 1970's, but I didn't think anything remotely modern
> > had that limitation.) So try splitting the command in half like this:
> >
> > cmd_quote2 = sed -e '/CONFIG/{'          \
> >                   -e 's/"CONFIG"\;/""/'        \
> >                   -e 'r $(obj)/config.tmp'     \
> >                   -e 'a \'                   \
> >                   -e '""\;'                  \
> >                   -e '}'                       \
> >                   $< > $@
> >
> > I just tried that here and it behaved the same way as the other version,
> > for me...
>
> Ok, Rob, finish handling this issue this and email me the patch (with a
> suitable changelog) when it's ready.

Just waiting to hear back from Ian that it does indeed fix the problem, and I 
see a reply from further down the list...

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
