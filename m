Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJbV6-0006Te-Je for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 11:13:08 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DJbV3-0002yC-Uc for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 11:13:08 -0700
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
Message-Id: <200504072019.14693.blaisorblade@yahoo.it>
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
Date: Thu, 7 Apr 2005 20:19:14 +0200
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Ian McDonald <imcdnzl@gmail.com>

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
> >
> > As you see, there is a fourth expression, *here*. But it's -e '}'.
> >
> > This patch went in after 2.6.11, I'm noticing - wow, are releases getting
> > so slow?
> >
> > > > System is Debian Woody,
> >
> > Can you post your sed version? and Rob, can you then test it and fix the
> > code? Please save the correct config.c currently created and check it for
> > reference.
>
> I enabled SKAS mode and the build finished.  The sed bit didn't break for
> me:
>
>   CHK     usr/initramfs_list
>   QUOTE   arch/um/kernel/config.tmp
>   QUOTE   arch/um/kernel/config.c
>   CC      arch/um/kernel/config.o
>
> And I'm using knoppix, which is based on debian.
But with updated packages (i.e. unstable/testing). If the patch is so little 
and without downsides, there's no point in not merging it.
> From the error message, it seems to be complaining about the "a" command. 
> If you're using a really really really old version of sed, it might insist
> on a gratuitous line break before the line to be added.  (I know it did
> back in the 1970's, but I didn't think anything remotely modern had that
> limitation.) So try splitting the command in half like this:
>
> cmd_quote2 = sed -e '/CONFIG/{'          \
>                   -e 's/"CONFIG"\;/""/'        \
>                   -e 'r $(obj)/config.tmp'     \
>                   -e 'a \'                   \
>                   -e '""\;'                  \
>                   -e '}'                       \
>                   $< > $@
>
> I just tried that here and it behaved the same way as the other version,
> for me...
Ok, Rob, finish handling this issue this and email me the patch (with a 
suitable changelog) when it's ready.

Bye
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
