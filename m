Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@sigma-star.at>) id 1SCRl3-0006F3-6W
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2012 08:28:01 +0000
Received: from gandalf.sigma-star.at ([95.130.255.141] helo=mail.sigma-star.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SCRkx-0006Qf-Bl for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2012 08:28:01 +0000
Message-ID: <4F717A03.4070404@sigma-star.at>
Date: Tue, 27 Mar 2012 10:27:47 +0200
From: Richard Weinberger <richard@sigma-star.at>
MIME-Version: 1.0
References: <4F71236E.6040400@panasas.com>
In-Reply-To: <4F71236E.6040400@panasas.com>
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
Subject: Re: [uml-devel] [PATCH ] um: uml_setup_stubs': warning: unused
 variable 'pages'
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Am 27.03.2012 04:18, schrieb Boaz Harrosh:
> 
> Fix the following gcc complain
> arch/um/kernel/skas/mmu.c: In function 'uml_setup_stubs':
> arch/um/kernel/skas/mmu.c:106:16: warning: unused variable 'pages' [-Wunused-variable]
> 
> Signed-Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>

Applied.

Thanks,
//richard

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

