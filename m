Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5TIv-0007z2-VU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 11:05:53 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C5TIu-00084X-Op for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 11:05:53 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 1/1] uml:fix ubd deadlock on SMP
References: <20040908172503.384144933@zion.localdomain>
	<20040908111204.I1973@build.pdx.osdl.net>
In-Reply-To: <20040908111204.I1973@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409092002.19134.blaisorblade_spam@yahoo.it>
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
Date: Thu, 9 Sep 2004 20:02:19 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Wednesday 08 September 2004 20:12, Chris Wright wrote:
> * blaisorblade_spam@yahoo.it (blaisorblade_spam@yahoo.it) wrote:
> > Trivial: don't lock the queue spinlock when called from the request
> > function. Since the faulty function must use spinlock in another case,
> > double-case it. And since we will never use both functions together, let
> > no object code be shared between them.
>
> Why not add a helper which locks around the core function.  Then either
> call helper or core function directly depending on locking needs?
I'm happy with whatever is nicer.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
