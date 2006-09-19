Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GPhQr-00072I-70 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Sep 2006 08:22:45 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GPhQp-0002To-Nb
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Sep 2006 08:22:45 -0700
Date: Tue, 19 Sep 2006 11:21:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060919152129.GC4820@ccure.user-mode-linux.org>
References: <20060829083009.95142.qmail@web25224.mail.ukl.yahoo.com>
	<20060912170841.GA7980@ccure.user-mode-linux.org>
	<200609172010.13315.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200609172010.13315.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Using -fcombine for UML
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
Cc: UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Sep 17, 2006 at 08:10:13PM +0200, Blaisorblade wrote:
> I was thinking by thematic areas - for instance each _user with its _kern 
> (there are still some such examples). Having little wrappers inlined 
> (especially for some ones in the hot paths, I'm recalling something about mm 
> fault handling or such) would help however, and could be prioritized.

That's an interesting idea.  However, I'm trying to get rid of the
_user/_kern pairs, and have mostly succeeded by now.  We would have to
pair up files in different directories.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
