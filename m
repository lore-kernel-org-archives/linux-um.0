Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2Uv0-000462-2q for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 04:40:38 -0800
Received: from av5-1-sn1.fre.skanova.net ([81.228.11.111])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2Uuy-0006lO-MR for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 04:40:36 -0800
References: <200403120313.i2C3DstV005296@ccure.user-mode-linux.org>
From: Peter Osterlund <petero2@telia.com>
In-Reply-To: <200403120313.i2C3DstV005296@ccure.user-mode-linux.org>
Message-ID: <m2brmz1u11.fsf@p4.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: uml-patch-2.6.4-1
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
Date: 14 Mar 2004 13:40:26 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> writes:

> This patch updates UML to 2.6.4.  Besides the update, there were the following
> changes since the last patch:
> 	a bug which caused either a crash in the kernel or a BUG at exit.c:793
> was fixed
> 	a bug which caused a crash when a process tried to dump core was fixed
> 	the hang early in boot on GHz hosts is gone
> 	various other
> 
> The 2.6.4-1 UML patch is available at
> 	http://www.user-mode-linux.org/mirror/uml-patch-2.6.4-1.bz2

+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */


I think it's cleaner to handle this in your .emacs file. Here is what
I use:

(add-to-list 'auto-mode-alist '("/home/petero/kernel.*/.*\\.[ch]$" . linux-c-mode))

(defun linux-c-mode ()
  "C mode with adjusted defaults for the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8))

This way it will work for all kernel files, not just the ones
containing special emacs comments.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
