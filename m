Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <hno@marasystems.com>
In-Reply-To: <010c01c3b54d$99552830$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0311280938340.3315-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: bug in COW? -  Re: [uml-user] uml 2.6.0-test9 crash
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 28 Nov 2003 09:39:51 +0100 (CET)
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Fri, 28 Nov 2003, roland wrote:

> after making the rootfs-clone a cow-filesystem (by adding ubd2=rootfsclone.cow,rootfsclone.img),
> the freeze happened again when doing some heavy writing. so - am i allowed to assume, that
> there is a bug in the copy-on-write code?

Maybe, maybe not. What does vmstat on the host report while you run this?

> btw: could anybody recommend a general filesystem stresstest-tool which does the worst to
> filesytems, you can do (besides formatting or overwriting)? :D

bonnie++ is a good one..

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
