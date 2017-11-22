Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1eHTem-0000Jt-LB
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 22 Nov 2017 11:57:32 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eHTel-0007gq-9f for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 22 Nov 2017 11:57:32 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Wed, 22 Nov 2017 11:57:21 +0000
Message-Id: <20171122115723.12010-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] PATCH v11
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard.weinberger@gmail.com

This revision adds EXPORT for deactivate_irq_by_fd as needed
by the random driver with some kernel configs


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

