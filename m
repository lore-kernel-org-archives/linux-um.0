Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvkCd-0001FL-Nz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 18:20:48 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HvkCd-00032i-EB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 18:20:47 -0700
Date: Tue, 5 Jun 2007 18:20:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070605182024.003502d4.akpm@linux-foundation.org>
In-Reply-To: <20070606003752.GA11511@c2.user-mode-linux.org>
References: <20070605205055.GA9770@c2.user-mode-linux.org>
	<20070605170001.c8b2110e.akpm@linux-foundation.org>
	<20070606003752.GA11511@c2.user-mode-linux.org>
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

On Tue, 5 Jun 2007 20:37:52 -0400 Jeff Dike <jdike@addtoit.com> wrote:

> On Tue, Jun 05, 2007 at 05:00:01PM -0700, Andrew Morton wrote:
> > On Tue, 5 Jun 2007 16:50:55 -0400
> > Jeff Dike <jdike@addtoit.com> wrote:
> > 
> > > [ This is 2.6.22 material ]
> > > 
> > > Having KERNEL_STACK_ORDER in defconfig overrides the value provided by
> > > Kconfig, breaking UML/x86_64, which wants 2 page stacks.
> 
> > That means the Kconfig rules are wrong, surely?
> 
> I'm far from a Kconfig expert,

Me either.  I learn enough for the problem at hand, then instaforget it
again.  Kinda like perl.

> but what I have is
> 
> config KERNEL_STACK_ORDER
> 	int "Kernel stack size order"
> 	default 1 if 64BIT
> 	default 0 if !64BIT
> 
> which seems reasonably clear and simple...
> 

hm, OK, there's the problem.  This is an offered-to-the-user config option.

If you do

-	int "Kernel stack size order"
+	int

then this rule will no longer be offered to the user and `make oldconfig'
(actually anythingconfig) will override whatever happens to be in .config
for KERNEL_STACK_ORDER.

I'm not sure if that's actually what you want, but if the current situation
is that a random CONFIG_KERNEL_STACK_ORDER=0 left over in .config will
break the kernel at runtime then I think something sterner than editing
defconfig is needed?


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
