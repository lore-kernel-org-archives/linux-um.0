Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rmy@tigress.co.uk>) id 1YeI9d-0000yp-8v
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Apr 2015 07:06:05 +0000
Received: from [87.86.166.5] (helo=intgat.tigress.co.uk)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YeI9b-00025L-KV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Apr 2015 07:06:05 +0000
From: Ron Yorston <rmy@tigress.co.uk>
Message-Id: <201504040650.t346ofGm029561@helium.internal.tigress.co.uk>
Date: Sat, 04 Apr 2015 07:50:41 +0100
References: <1428072686.106641.7.camel@m3y3r.de>
In-Reply-To: <1428072686.106641.7.camel@m3y3r.de>
MIME-Version: 1.0
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH v3] um: Print minimum physical memory
 requirement
To: user-mode-linux-devel@lists.sourceforge.net, thomas@m3y3r.de

Thomas Meyer wrote:
>+		printf("Too few physical memory! Needed=%d, given=%d\n",

I think 'Too little physical memory' would be more correct.  Or maybe
'Insufficient physical memory'.

Ron

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

