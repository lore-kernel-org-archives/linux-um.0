Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCiEJ-0006Fj-E4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 13:12:55 -0800
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCiEI-0000D3-0P
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 13:12:55 -0800
From: Andi Kleen <andi@firstfloor.org>
References: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
Date: Wed, 09 Jan 2008 22:12:43 +0100
In-Reply-To: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu> (Miklos Szeredi's message
	of "Wed\, 09 Jan 2008 22\:01\:36 +0100")
Message-ID: <p734pdmput0.fsf@bingen.suse.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] uml and -regparm=3
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jdike@addtoit.com, akpm@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

> FASTCALL is defined empty in -mm, but UML is not compiled with
> -mregparm=3D3 and so this breaks things (I noticed problems with
> rwsem_down_write_failed).
>
> Tried recompiling UML with -mregparm=3D3, but that resulted in a strange
> failure immediately after startup:
>
> |%G=EF=BF=BD%@: Invalid argument
>
> What's up?

UML links with glibc and that does not use -mregparm. =


You can only use -mregparm in user space if you recompile
all libraries too.

-Andi

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
