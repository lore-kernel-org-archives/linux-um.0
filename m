Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOM9T-0003Cl-Rn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:59:31 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HOM9Q-0003hS-7r
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:59:31 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 5 Mar 2007 23:59:13 +0100
References: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
	<20070305204902.9072.1224.stgit@americanbeauty.home.lan>
	<20070305220334.GB7702@ccure.user-mode-linux.org>
In-Reply-To: <20070305220334.GB7702@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703052359.13612.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 04/11] uml - hostfs: avoid possible escapes
	from hostfs=.
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Monday 05 March 2007 23:03, Jeff Dike wrote:
> On Mon, Mar 05, 2007 at 09:49:02PM +0100, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Avoid accepting things like -o .., -o dir/../../dir2, -o dir/../.. .
> > This may be considered useless, but YMMV. I consider that this has a
> > limited security value, exactly like disabling module support (in many
> > case it is useful).
>
> Two comments on this one:
> > +	return  strstr(path, "/../") != NULL ||
> > +		strcmp(path, "..") == 0 ||
> > +		strncmp(path, "../", strlen("../")) == 0 ||
> > +		str_ends_with(path, "/..");
>
> Minor style point - I'd be happier with more parens:
>
> +	return  (strstr(path, "/../") != NULL) ||
> +		(strcmp(path, "..") == 0) ||
> +		(strncmp(path, "../", strlen("../")) == 0) ||
> +		str_ends_with(path, "/..");

Hmm. Personally I prefer the earlier style, but I haven't the last word on 
this.

> C gets operator precedence wrong in one or two cases, so I just put parens
> any place it might matter.

Indeed. For instance this patch is wrong, I did this once in a patch, and I 
saw it another time in current Ubuntu kernels:

-	a + b / 4
+	a + b >> 2

This is instead needed:

+	a + (b >> 2)

> Second, there is code in externfs which does the same thing without
> parsing paths which you might consider instead.

I must, indeed - your comment points out the symlink issue, which I didn't 
think of, and which makes my patch moot.

> It sees whether the 
> requested directory is outside the jail by cd-ing to it and then
> repeatedly cd .. until it either reaches / or the jail root.
>
> A copy is below for your reading pleasure.

I gave a look, and it's nice. Except that maybe "escapes_jail" would be a 
clearer name (there's confusion about the subject of "escaping").

Also, what about concurrent UML threads caring about current directory? I know 
that without SMP/preemption we can't have this problem, but when I see this I 
count a future bug unless this is checked (I think I reason mathematically 
about correctness, even if not formally).

And I haven't the time to check this - I think your version could be merged 
anyway, but I'm not sure.

> 				Jeff

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
