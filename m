Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z2nTq-000525-No
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:24:14 +0000
Received: from hilses.de ([213.133.103.163])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2nTo-0006yt-Ew
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:24:14 +0000
Received: from [10.0.0.1] (helo=localhost) by hilses.de with esmtpa (Exim 4.85)
	(envelope-from <hwhilse@gmail.com>) id 1Z2nTU-0006PO-KZ
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 23:23:52 +0200
MIME-Version: 1.0
Date: Wed, 10 Jun 2015 23:23:52 +0200
From: Hans-Werner Hilse <hwhilse@gmail.com>
In-Reply-To: <5578aa6d.417c320a.2479.4260SMTPIN_ADDED_BROKEN@mx.google.com>
References: <5578aa6d.417c320a.2479.4260SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <98515ab47d325387cf88c5ccd1d6e38f@hilses.de>
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
Subject: Re: [uml-devel]
 =?utf-8?q?=5BPATCH_1/3=5D_um=3A_Fallback_when_C_libra?=
 =?utf-8?q?ry_does_not_provide_=5F=5Fptr=5Ft?=
To: User-mode-linux-devel@lists.sourceforge.net

Hi,

Am 2015-06-10 23:20, schrieb Hans-Werner Hilse:
[...]

This three-part patch series will allow to compile UML against the musl 
libc implementation - even statically.

Take it as a suggestion, but I think most things are quite sensible. The 
__ptr_t stuff is admittedly a bit ugly.

-hwh

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

