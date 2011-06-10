Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QV7t8-0001wn-ST
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2011 20:01:02 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QV7t7-0005f5-7R
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2011 20:01:02 +0000
From: Richard Weinberger <richard@nod.at>
Date: Fri, 10 Jun 2011 22:00:50 +0200
References: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
	<1307711457-17613-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <1307711457-17613-1-git-send-email-minipli@googlemail.com>
MIME-Version: 1.0
Message-Id: <201106102200.50655.richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH] um, exec: remove redundant set_fs(USER_DS)
To: Mathias Krause <minipli@googlemail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Am Freitag 10 Juni 2011, 15:10:57 schrieb Mathias Krause:
> The address limit is already set in flush_old_exec() so this
> set_fs(USER_DS) is redundant.
> 
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> Cc: Richard Weinberger <richard@nod.at>

Applied.

Thanks,
//richard

------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

