Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVb23-0006ro-E7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:45:31 -0700
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GVb23-00010f-1P
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:45:31 -0700
From: Andi Kleen <ak@suse.de>
Date: Thu, 5 Oct 2006 23:45:09 +0200
References: <20061005213212.17268.7409.stgit@memento.home.lan>
	<20061005213839.17268.28062.stgit@memento.home.lan>
In-Reply-To: <20061005213839.17268.28062.stgit@memento.home.lan>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610052345.09704.ak@suse.de>
Subject: Re: [uml-devel] [PATCH 02/14] uml: revert wrong patch
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
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thursday 05 October 2006 23:38, Paolo 'Blaisorblade' Giarrusso wrote:

> Andi Kleen pointed out that -mcmodel=kernel does not make sense for userspace
> code and would stop everything from working, 

did it work at all with it? 

-Andi

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
