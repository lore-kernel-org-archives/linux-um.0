Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9nsq-00021L-KB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 09:25:08 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D9nsm-0002Db-VF for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 09:25:08 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Export gcov symbol based on gcc
	version
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
	<20050310225340.GD3205@stusta.de>
In-Reply-To: <20050310225340.GD3205@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503111801.29510.blaisorblade@yahoo.it>
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
Date: Fri, 11 Mar 2005 18:01:29 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Adrian Bunk <bunk@stusta.de>, Jeff Dike <jdike@addtoit.com>, torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org

On Thursday 10 March 2005 23:53, Adrian Bunk wrote:
> On Wed, Mar 09, 2005 at 09:16:02PM -0500, Jeff Dike wrote:
> > The init function called by gcc when gcov is enabled is __gcov_init or
> > __bb_init_func, depending on the gcc version.  Anton is using 3.3.4 and
> > seeing __gcov_init.  I'm using 3.3.2 and seeing __bb_init_func, so we
> > need to close that gap a bit.
> >
> > Signed-off-by: Jeff Dike <jdike@addtoit.com>
> >
> > Index: linux-2.6.11/arch/um/kernel/gmon_syms.c
> > ===================================================================
> > --- linux-2.6.11.orig/arch/um/kernel/gmon_syms.c 2005-03-07
> > 10:53:03.000000000 -0500 +++
> > linux-2.6.11/arch/um/kernel/gmon_syms.c 2005-03-07 16:29:37.000000000
> > -0500 @@ -5,8 +5,14 @@
> >
> >  #include "linux/module.h"
> >
> > +#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
> > + (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
> >...
>
> This patch is still wrong.
>
> It seems my comment on this [1] was lost:
>
> <--  snip  -->
>
> This line has to be something like
>
> ( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4) && \
>    HEAVILY_PATCHED_SUSE_GCC )
>
> I hope SuSE has added some #define to distinguish what they call
> "gcc 3.3.4" from GNU gcc 3.3.4
"You hope" does not mean "it exists".
Secondly, the patch is wrong anyway, as I said elsewhere.
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
