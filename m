Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gz52Q-0004JC-EP for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Dec 2006 21:39:46 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gz52O-0002fz-4x
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Dec 2006 21:39:46 -0800
Message-ID: <4590B5AF.10303@theshore.net>
Date: Tue, 26 Dec 2006 00:39:59 -0500
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
References: <4525802F.1080900@theshore.net>	<200610210305.37629.blaisorblade@yahoo.it>
	<458AAA0D.4020507@theshore.net>
In-Reply-To: <458AAA0D.4020507@theshore.net>
Subject: Re: [uml-devel] 2.6.18-skas-v9-pre9 broken
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
Cc: user-mode-linux-devel@lists.sourceforge.net

Christopher S. Aker wrote:
> Blaisorblade wrote:

>> An important question: you reverted to a 2.6.18 + skas kernel or a 2.6.17 one? 
>> A similar bug is being discussed about a regression in 2.6.18 vanilla...

> All my hosts are running at most 2.6.16.x, so this very well could be a 
> regression in post 2.6.16 kernels.

Confirmed. This is a regression in post 2.6.16.x kernels (well, at least 
2.6.19).  Had a user hit the "VFS: Mounted root (ext3 filesystem) 
readonly" hang on a 2.6.19 kernel with skas3-v8.2, running 2.6.19-um

Any ideas?

-Chris


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
