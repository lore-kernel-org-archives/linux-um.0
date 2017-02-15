Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <natale.patriciello@gmail.com>) id 1cdzgj-0005Fa-24
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Feb 2017 13:32:05 +0000
Received: from mail-wm0-f54.google.com ([74.125.82.54])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cdzgi-0002cG-8f
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Feb 2017 13:32:05 +0000
Received: by mail-wm0-f54.google.com with SMTP id r141so40671614wmg.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 15 Feb 2017 05:32:04 -0800 (PST)
Received: from localhost (81.61.180.6.dyn.user.ono.com. [81.61.180.6])
	by smtp.gmail.com with ESMTPSA id
	p62sm5402559wmb.25.2017.02.15.05.31.57
	for <user-mode-linux-devel@lists.sourceforge.net>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 Feb 2017 05:31:57 -0800 (PST)
Date: Wed, 15 Feb 2017 15:31:53 +0100
From: Natale Patriciello <natale.patriciello@gmail.com>
Message-ID: <20170215143153.4h3uwrkpt4odkavr@judith.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] FPU patches broke UML on i7-7700 CPU
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
To: user-mode-linux-devel@lists.sourceforge.net


Hello,

as I've reported here [1], by changing the work station I've got the
same UML guest not working anymore. I investigated and the problem root
is in the code added in this patchset [2] (add extended processor state
save/restore support). In particular, the ptrace returns < 0 and the
errno is set to 14. Reverting the code to use the functions
*_i387_registers () makes everything to work correctly.

There is something I can do for further debugging the issue? Or should I
live with a modified kernel tree with a reverse patch applied ?

Thank you


[1] https://sourceforge.net/p/user-mode-linux/mailman/message/35663374/
[2] https://sourceforge.net/p/user-mode-linux/mailman/message/34911221/

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

