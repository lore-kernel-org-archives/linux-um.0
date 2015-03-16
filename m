Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YXTOp-0006AS-V7
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 11:41:35 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXTOo-0006DH-Mi for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 11:41:35 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:04 +0100
Message-Id: <1426506079-26183-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
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
Subject: [uml-devel] Hostfs updates
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org

Host got a visit from the janitor.

[PATCH 01/15] hostfs: hostfs_file_open: Switch to data locking model
[PATCH 02/15] hostfs: hostfs_file_open: Fix a fd leak in
[PATCH 03/15] hostfs: Allow fsync on directories
[PATCH 04/15] hostfs: Handle bogus st.mode
[PATCH 05/15] hostfs: Make hostfs_readpage more readable
[PATCH 06/15] hostfs: Add a BUG_ON to detect behavior changes of
[PATCH 07/15] hostfs: Remove open coded strcpy()
[PATCH 08/15] hostfs: Use __getname() in follow_link
[PATCH 09/15] hostfs: Report append flag in ->show_options()
[PATCH 10/15] hostfs: Remove superfluous test in hostfs_open()
[PATCH 11/15] hostfs: hostfs_open: Reset open flags upon each retry
[PATCH 12/15] hostfs: Remove superfluous initializations in
[PATCH 13/15] hostfs: Set page flags in hostfs_readpage() correctly
[PATCH 14/15] hostfs: Use page_offset()
[PATCH 15/15] hostfs: No need to box and later unbox the file mode

Thanks,
//richard

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

