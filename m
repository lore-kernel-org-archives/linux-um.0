Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzKfK-0004c8-6Z for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 12:11:54 -0800
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CzKfH-0006PR-OF
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 12:11:54 -0800
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by externalmx-1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CzKfB-0005jx-4s
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Feb 2005 12:11:47 -0800
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Message-ID: <20050210201128.GD8859@parcelfarce.linux.theplanet.co.uk>
References: <200502101939.23300.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502101939.23300.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: uml kbuild cleanup (cross-build) - some fixes and
	comments
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
Date: Thu, 10 Feb 2005 20:11:28 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 10, 2005 at 07:39:23PM +0100, Blaisorblade wrote:
> First, Al, thanks a lot for succeeding in solving this... I had tried a lot of 
> time ago to make sure that O= worked... (I think that -j already worked, 
> unless somebody re-broke it after I fixed that). Plus you fix a lot of other 
> stuff.
> 
> There are (at least) two bugs to fix about this patch, plus some comments:
> 
> http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.11-rc3-mm1/patches/cross-build
> 
> 1) typo here: "objtre" should be "objtree"
> 
> Index: linux-2.6.10/arch/um/kernel/Makefile
> ===================================================================
> 
> @@ -50,7 +50,7 @@
>  quiet_cmd_quote2 = QUOTE   $@
>        cmd_quote2 = sed -e '/CONFIG/{'          \
>    -e 's/"CONFIG"\;/""/'        \
> -  -e 'r $(obj)/config.tmp'     \
> +  -e 'r $(objtre)/config.tmp'  \

	Where had that come from?  The patch I've done is on
ftp://ftp.linux.org.uk/pub/people/viro/UML-kbuild.  I don't see that
chunk in there.  The closest I can find is

-QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
+QUOTE = 'my $$config=`cat $(objtree)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
 
 quiet_cmd_quote = QUOTE   $@
 cmd_quote = $(PERL) -e $(QUOTE) < $< > $@
 
 targets += config.c
-$(obj)/config.c : $(src)/config.c.in $(TOPDIR)/.config FORCE
+$(obj)/config.c : $(src)/config.c.in $(objtree)/.config FORCE

Note that it's not -mm-based; problem with porting to -mm, maybe?  Or
I might have equivalent typo in one of the older versions of patch and
it migrated...

BTW, that chunk in your patch looks bogus regardless of typos - you have
config.tmp in clean-files, so it'd better be in arch/um/kernel, not in
the root...


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
