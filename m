Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVxjN-0002Qg-TW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 14:59:46 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVxjN-0002WQ-CZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Oct 2006 14:59:45 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 5 Oct 2006 23:45:03 +0200
References: <20061005213212.17268.7409.stgit@memento.home.lan>
	<20061005213839.17268.28062.stgit@memento.home.lan>
	<200610052345.09704.ak@suse.de>
In-Reply-To: <200610052345.09704.ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610052345.03900.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org

On Thursday 05 October 2006 23:45, Andi Kleen wrote:
> On Thursday 05 October 2006 23:38, Paolo 'Blaisorblade' Giarrusso wrote:
> > Andi Kleen pointed out that -mcmodel=kernel does not make sense for
> > userspace code and would stop everything from working,
>
> did it work at all with it?
Guess not, I should have boot-tested it... :-(. Sorry.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
