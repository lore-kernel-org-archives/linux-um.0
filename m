Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040101191630.GA23954@elte.hu>
References: <Pine.LNX.4.58.0312171735540.8123@earth>
	<20031217174901.GA6709@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0312171924290.12482@earth>
	<Pine.LNX.4.58.0312172249020.19508@earth>
	<200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0312181036220.31295@earth>
	<Pine.LNX.4.58.0312181122070.32554@earth>
	<Pine.LNX.4.58.0312181209230.1327@earth>
	<Pine.LNX.4.58.0312181304250.3617@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312181304250.3617@earth>
Subject: [uml-devel] [UML combo patch] uml-combo-2.6.0-A7
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 1 Jan 2004 20:16:30 +0100
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

here's a new combo all-in-one UML patch against the vanilla 2.6.0
kernel:

 	redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A7

i've merged the various fixes collected by Paolo, plus fixed a bug in
the __do_mmap_pgoff() change that caused host kernel bootup hangs. The
usual disclaimers wrt. devel patches apply.

	Ingo


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
