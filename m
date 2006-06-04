Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnR9h-0001V7-6n for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 19:18:53 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fmysd-0002ho-8k for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 13:07:23 -0700
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FmysQ-0004Xv-OM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 13:07:12 -0700
From: Andi Kleen <ak@suse.de>
Date: Sun, 4 Jun 2006 21:06:07 +0200
References: <20060604185212.28436.74951.stgit@memento.home.lan>
In-Reply-To: <20060604185212.28436.74951.stgit@memento.home.lan>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606042106.08121.ak@suse.de>
Subject: Re: [uml-devel] [PATCH] uml: fix signal code x86-64 [for 2.6.15]
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
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net


> It isn't yet perfect, because we don't yet save floating point context. But
> that will come later. Additionally, there's a potential problem since RED
> zones will alternate stacks are used, unlike x86_64, so more stack space
> (128 bytes more) is used. But this shouldn't be a problem.
> Instead, having no red zone (like x86_64) 

x86-64 has a red zone. Is your description confused or your code?

-Andi



_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
