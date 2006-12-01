Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GpwEp-0001CD-S0 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Nov 2006 16:26:47 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GpwEo-0006BF-BQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Nov 2006 16:26:47 -0800
Date: Thu, 30 Nov 2006 19:22:52 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061201002252.GF8331@ccure.user-mode-linux.org>
References: <22a33e9f0611180345w7ec64513l34424a59e1671479@mail.gmail.com>
	<200611210813.14745.blaisorblade@yahoo.it>
	<22a33e9f0611211123w3b57d6bdh5e599a87589816c9@mail.gmail.com>
	<200611220122.24515.blaisorblade@yahoo.it>
	<22a33e9f0611220004m46ce8d98nc7f21eff09febc89@mail.gmail.com>
	<20061122164446.GB5120@ccure.user-mode-linux.org>
	<22a33e9f0611232329g6c8a8614x3472a0da3416aba5@mail.gmail.com>
	<20061124202512.GD4745@ccure.user-mode-linux.org>
	<22a33e9f0611241310y42962e8exce5011f2d6b99435@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <22a33e9f0611241310y42962e8exce5011f2d6b99435@mail.gmail.com>
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
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Nov 24, 2006 at 09:10:50PM +0000, Matt Willsher wrote:
> The very same image, uncopied. I have a directory tree set up and
> scripts I use and all I did was to change the script to call the newer
> kernel.

And the exact same UML binary?  I'm grabbing at straws here, in case
somehow the broken one is lacking binfmt support for /sbin/init.

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
