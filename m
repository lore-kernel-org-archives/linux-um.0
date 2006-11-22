Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmvGc-0001WL-78 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Nov 2006 08:48:10 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GmvGb-0006Cq-Qg
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Nov 2006 08:48:10 -0800
Date: Wed, 22 Nov 2006 11:44:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061122164446.GB5120@ccure.user-mode-linux.org>
References: <22a33e9f0611180345w7ec64513l34424a59e1671479@mail.gmail.com>
	<200611210813.14745.blaisorblade@yahoo.it>
	<22a33e9f0611211123w3b57d6bdh5e599a87589816c9@mail.gmail.com>
	<200611220122.24515.blaisorblade@yahoo.it>
	<22a33e9f0611220004m46ce8d98nc7f21eff09febc89@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <22a33e9f0611220004m46ce8d98nc7f21eff09febc89@mail.gmail.com>
Subject: Re: [uml-devel] Problem with newer (>2.6.14) UML kernels hanging
	under Xen DomU/Centos 4.4
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
To: Matt Willsher <matt@monki.org.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 22, 2006 at 08:04:59AM +0000, Matt Willsher wrote:
> UML running in TT mode

Sorry about that last suggestion - I missed that you were trying an
old UML.

I have to repeat what BB said about the "init not found" error.  I
never seen that not be a filesystem problem.  Can you try booting that
filesystem in an environment which is known to work, to make sure that
it is sane?

				Jeff
-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
