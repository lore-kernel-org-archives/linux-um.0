Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KXjyF-0006jd-A2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Aug 2008 14:51:31 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KXjyD-0006CR-QY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Aug 2008 14:51:31 -0700
Date: Mon, 25 Aug 2008 17:51:24 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080825215124.GB12626@c2.user-mode-linux.org>
References: <4898AC10.3010602@meduna.org>
	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
	<48995D1A.6030203@meduna.org> <489AC525.3060305@meduna.org>
	<489AE6DD.2000200@meduna.org> <489C3D9B.7070605@meduna.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <489C3D9B.7070605@meduna.org>
Subject: Re: [uml-devel] FP registers corruption
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Stanislav Meduna <stano@meduna.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Aug 08, 2008 at 02:35:39PM +0200, Stanislav Meduna wrote:
> Erm.. after debugging the FP corruption for several hours
> trying to isolate the cause I stumbled upon a patch from
> Jeff Dike from February:
>
> http://article.gmane.org/gmane.linux.uml.devel/11412
>
> Did this or equivalent patch get into the mainline kernel?
> Browsing through the source I don't think so :( If not,
> where is the best place to fetch the UML tree with the
> patches that the developers seem to find necessary,
> applied?

It's there.  I just eyeballed the source.  It's commit
2f56debd77a8f52f1ac1d3c3d89cc7ce5e083230 - the only way you wouldn't
have it is by having a too-old version of UML.

     	      	       	       Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
