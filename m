Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Zuov5-0004Br-MJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Nov 2015 21:51:39 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zuov4-0002bi-6U
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Nov 2015 21:51:39 +0000
References: <saurabh.truth@gmail.com>
	<1446132632-23623-1-git-send-email-saurabh.truth@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <563D20E0.6010702@nod.at>
Date: Fri, 6 Nov 2015 22:51:28 +0100
MIME-Version: 1.0
In-Reply-To: <1446132632-23623-1-git-send-email-saurabh.truth@gmail.com>
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
Subject: Re: [uml-devel] [PATCH v4] um: net: replace GFP_KERNEL with
 GFP_ATOMIC when spinlock is held
To: Saurabh Sengar <saurabh.truth@gmail.com>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org

Am 29.10.2015 um 16:30 schrieb Saurabh Sengar:
> since GFP_KERNEL with GFP_ATOMIC while spinlock is held,
> as code while holding a spinlock should be atomic.
> GFP_KERNEL may sleep and can cause deadlock,
> where as GFP_ATOMIC may fail but certainly avoids deadlockdex f70dd54..d898f6c 100644
> 
> Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>

Applied!

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

