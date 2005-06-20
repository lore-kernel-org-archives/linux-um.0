Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkVjA-0000kC-9X	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 16:30:52 -0700
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DkVj9-0003mv-Nj	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 16:30:52 -0700
From: Domen Puncer <domen@coderock.org>
Subject: Re: [uml-devel] [patch 1/1] um: copy_from_user size fix in signal.c
Message-ID: <20050620233041.GG3906@nd47.coderock.org>
References: <20050620215041.767887000@nd47.coderock.org>
	<200506210038.23729.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506210038.23729.blaisorblade@yahoo.it>
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
Date: Tue, 21 Jun 2005 01:30:41 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com

On 21/06/05 00:38 +0200, Blaisorblade wrote:
> On Monday 20 June 2005 23:50, domen@coderock.org wrote:
> > From: Domen Puncer <domen@coderock.org>
> >
> >
> > Size of pointer doesn't seem right, but maybe my solution isn't
> > either (sig_size maybe?).
> Your patch had already been submitted by Jeff a couple of hours before this 
> mail. Thanks!

And a put it in my dontsend file; another bug to be killed, i guess.
Sorry for the noise!

> > Signed-off-by: Domen Puncer <domen@coderock.org>
> >
> > ---
> >  signal.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> >
> > Index: quilt/arch/um/sys-i386/signal.c


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
