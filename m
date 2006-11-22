Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmvDJ-00015O-F3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Nov 2006 08:44:45 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GmvDG-0006Xy-H4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Nov 2006 08:44:44 -0800
Date: Wed, 22 Nov 2006 11:41:18 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061122164118.GA5120@ccure.user-mode-linux.org>
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
> 
> Does that not indicate that it is running in TT mode? The kernel
> option for TT mode is set. I tried to disable SKAS support but the
> kernel won't compile with out that set (check_host_supports_tls not
> found, as reported on the user mailing list last month). I will
> however try with 2.6.13 and 2.6.14.

Disable CONFIG_MODE_TT.  Its presence in the binary, even if it's not running,
has caused boot failures.

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
