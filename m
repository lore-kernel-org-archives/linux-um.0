Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnR01-0006NM-H8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 19:08:53 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FnHBs-00056N-P0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 08:40:28 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FnHBj-0007Vx-5X
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 08:40:21 -0700
Date: Mon, 5 Jun 2006 11:40:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060605154017.GA24405@ccure.user-mode-linux.org>
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
	<a36005b50602071123r8179c7di8e95bf0a336f1b0c@mail.gmail.com>
	<20060208164301.GC5240@ccure.user-mode-linux.org>
	<200606042020.00120.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200606042020.00120.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 2/8] UML - Define jmpbuf access constants
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Jun 04, 2006 at 08:19:59PM +0200, Blaisorblade wrote:
> What about #ifdef'ing out the offending code #ifndef one of these constants 
> (they'll be defined or not altogether). As expectable, this wasn't yet 
> implemented - let's give the right priority to things.
> (I've just met this on my SuSE, btw, which prompted me to write this email).

I think hpa just came to our rescue.  There's a setjmp/longjmp
implementation in klibc.  If we pull that in and use it, we don't need
our own copy.

				Jeff


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
