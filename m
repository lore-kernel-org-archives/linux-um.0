Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTR9a-0000ic-IW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 15:48:22 -0700
Received: from smtp-out.google.com ([216.239.45.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GTR9a-00073P-CX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 15:48:22 -0700
Received: from zps77.corp.google.com (zps77.corp.google.com [172.25.146.77])
	by smtp-out.google.com with ESMTP id k8TMm7tt015451
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Sep 2006 15:48:07 -0700
Received: from smtp-out2.google.com (fpr7.prod.google.com [10.253.18.7])
	by zps77.corp.google.com with ESMTP id k8TMGZcC024692
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Sep 2006 15:48:04 -0700
Received: by smtp-out2.google.com with SMTP id 7so205fpr
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Sep 2006 15:48:04 -0700 (PDT)
Message-ID: <65dd6fd50609291548x39707437yb7f1308c3397c488@mail.google.com>
Date: Fri, 29 Sep 2006 15:48:04 -0700
From: "Ollie Wild" <aaw@google.com>
In-Reply-To: <20060929153853.9bab3ca7.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
	<65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
	<20060929153853.9bab3ca7.akpm@osdl.org>
Subject: Re: [uml-devel] [PATCH 2/2] UML - Don't roll my own random MAC
	generator
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
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, dhollis@davehollis.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jason Lunz <lunz@falooley.org>

You can use "make ARCH=um SUBARCH=i386 .." to build for i386.

Ollie

On 9/29/06, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 29 Sep 2006 15:18:52 -0700
> "Ollie Wild" <aaw@google.com> wrote:
>
> > This patch as provided breaks my build due to a missing semicolon.
> >
> > ..
> >
> > -     random_ether_addr(addr)
> > +     random_ether_addr(addr);
>
> ahem.  That must have had a lot of testing ;)
>
> Jeff, could we pleeeeeze arrange for UML's `make allmodconfig' to work, and
> to continue to work?
>
> Right now it goes splut with
>
> arch/um/os-Linux/sys-x86_64/registers.c: In function 'get_thread_regs':
> arch/um/os-Linux/sys-x86_64/registers.c:85: error: 'JB_PC' undeclared (first use in this function)
> arch/um/os-Linux/sys-x86_64/registers.c:85: error: (Each undeclared identifier is reported only once
> arch/um/os-Linux/sys-x86_64/registers.c:85: error: for each function it appears in.)
> arch/um/os-Linux/sys-x86_64/registers.c:86: error: 'JB_RSP' undeclared (first use in this function)
> arch/um/os-Linux/sys-x86_64/registers.c:87: error: 'JB_RBP' undeclared (first use in this function)
>
>
> How does one build uml-for-i386 on an x86_64 host, btw?
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
