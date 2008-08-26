Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KY53x-00020k-O3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 13:22:49 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KY53w-0006NG-6F
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Aug 2008 13:22:49 -0700
Date: Tue, 26 Aug 2008 16:22:39 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080826202239.GG24342@c2.user-mode-linux.org>
References: <20080818230509.23819.90290.reportbug@carrera.home.cobb.me.uk>
	<20080819120155.GD7425@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080819120155.GD7425@inferi.kami.home>
Subject: Re: [uml-devel] [Pkg-uml-pkgs] Bug#495611:
	user-mode-linux:	page_mapcount(page) went negative!
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
To: Mattia Dongili <malattia@linux.it>
Cc: Graham Cobb <g+debian@cobb.uk.net>, 495611@bugs.debian.org, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Aug 19, 2008 at 09:01:55PM +0900, Mattia Dongili wrote:
> one more bug report on 2.6.26.2. It looks like .25 is affected as well
> are both suffering from it.

Sigh, I was hoping that this wasn't seen on anything later than 2.6.24.

Any chance it can be bisected?  Since this is an overnight test, it
would take a week or two, probably.

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
