Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hvzqz-0002s9-TQ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 11:03:31 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hvzqx-00066Q-Si
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 11:03:28 -0700
Date: Wed, 6 Jun 2007 11:03:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070606110314.c64f8234.akpm@linux-foundation.org>
In-Reply-To: <20070606151134.GA5972@c2.user-mode-linux.org>
References: <20070605205055.GA9770@c2.user-mode-linux.org>
	<20070605170001.c8b2110e.akpm@linux-foundation.org>
	<20070606003752.GA11511@c2.user-mode-linux.org>
	<20070605182024.003502d4.akpm@linux-foundation.org>
	<20070606151134.GA5972@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/2] UML - Fix kernel stack size on x86_64
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, 6 Jun 2007 11:11:34 -0400 Jeff Dike <jdike@addtoit.com> wrote:

> On Tue, Jun 05, 2007 at 06:20:24PM -0700, Andrew Morton wrote:
> > If you do
> > 
> > -	int "Kernel stack size order"
> > +	int
> > 
> > then this rule will no longer be offered to the user and `make oldconfig'
> > (actually anythingconfig) will override whatever happens to be in .config
> > for KERNEL_STACK_ORDER.
> 
> You're saying that making an option user-visible changes whether
> *config overrides .config?  That's non-intuitive.

Yeah, I thought so.  I discovered it by comparing the behaviour of your
patch against the behaviour of CONFIG_BASE_SMALL, fiddling around and
then saying "wtf".

> > I'm not sure if that's actually what you want, but if the current situation
> > is that a random CONFIG_KERNEL_STACK_ORDER=0 left over in .config will
> > break the kernel at runtime then I think something sterner than editing
> > defconfig is needed?
> 
> That's a good point, but I think I do want it user-visible.  If
> someone sees someething I suspect to be a stack overflow, I'd like to
> be able to tell them to bump KERNEL_STACK_ORDER and see if the problem
> goes away.
> 
> As for something sterner, it turns out that Kbuild provides some
> support for this.  So, drop the previous patch in favor of this one:
> 
> Force KERNEL_STACK_ORDER to be at least 1 on UML/x86_64.
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> --
>  arch/um/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6.21-mm/arch/um/Kconfig
> ===================================================================
> --- linux-2.6.21-mm.orig/arch/um/Kconfig	2007-06-06 09:28:13.000000000 -0400
> +++ linux-2.6.21-mm/arch/um/Kconfig	2007-06-06 11:08:49.000000000 -0400
> @@ -278,6 +278,7 @@ config HIGHMEM
>  config KERNEL_STACK_ORDER
>  	int "Kernel stack size order"
>  	default 1 if 64BIT
> +	range 1 10 if 64BIT
>  	default 0 if !64BIT
>  	help
>  	This option determines the size of UML kernel stacks.  They will

heh, fair enough.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
