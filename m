Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GrhUc-0000qC-0p for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Dec 2006 13:06:24 -0800
Received: from einhorn.in-berlin.de ([192.109.42.8] ident=root)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GrhUY-000690-AJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Dec 2006 13:06:21 -0800
Message-ID: <4575DF28.6020001@s5r6.in-berlin.de>
Date: Tue, 05 Dec 2006 22:05:44 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
References: <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>	<24327.1165348363@redhat.com>
	<20061205121632.65572efb.akpm@osdl.org>
In-Reply-To: <20061205121632.65572efb.akpm@osdl.org>
Subject: Re: [uml-devel] GIT pull on work_struct reduction tree
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
To: Andrew Morton <akpm@osdl.org>
Cc: jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, torvalds@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk

Andrew Morton wrote:
> On Tue, 05 Dec 2006 19:52:43 +0000
> David Howells <dhowells@redhat.com> wrote:
> 
>> I've brought the work_struct reduction patches up to date.  They're in a GIT
>> tree for you to pull when you're ready.
> 
> Given that I (and probably many others) now have a pile of build errors to
> fix, it would be nice to have a short-but-full description of what one must
> do to fix those up, please.

And how is the merge to be timed anyway? IOW will the manual merging
have to be done by people like Andrew and me, or by David, or by Linus?

(I wanted to set up a 2.6.19"-final" based linux1394-2.6.git branch for
Linus to pull from tomorrow or in the latter half of this week. There
will be conflicts between mine and David's stuff, although nothing
serious. I'm just asking to make it as smooth as possible.)
-- 
Stefan Richter
-=====-=-==- ==-- --=-=
http://arcgraph.de/sr/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
