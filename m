Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hviwm-0001Yo-B4 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 17:00:34 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hviwm-0001ZE-4H
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 17:00:20 -0700
Date: Tue, 5 Jun 2007 17:00:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070605170001.c8b2110e.akpm@linux-foundation.org>
In-Reply-To: <20070605205055.GA9770@c2.user-mode-linux.org>
References: <20070605205055.GA9770@c2.user-mode-linux.org>
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

On Tue, 5 Jun 2007 16:50:55 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> [ This is 2.6.22 material ]
> 
> Having KERNEL_STACK_ORDER in defconfig overrides the value provided by
> Kconfig, breaking UML/x86_64, which wants 2 page stacks.
> 
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>
> --
>  arch/um/defconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> Index: linux-2.6.21-mm/arch/um/defconfig
> ===================================================================
> --- linux-2.6.21-mm.orig/arch/um/defconfig	2007-06-05 12:18:35.000000000 -0400
> +++ linux-2.6.21-mm/arch/um/defconfig	2007-06-05 12:19:12.000000000 -0400
> @@ -86,7 +86,6 @@ CONFIG_MCONSOLE=y
>  # CONFIG_MAGIC_SYSRQ is not set
>  CONFIG_NEST_LEVEL=0
>  # CONFIG_HIGHMEM is not set
> -CONFIG_KERNEL_STACK_ORDER=0
>  CONFIG_UML_REAL_TIME_CLOCK=y
>  

That means the Kconfig rules are wrong, surely?

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
