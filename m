Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWFte-00023G-50
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 06:09:58 -0800
Received: from smtp1.att.ne.jp ([165.76.15.137])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWFte-0003Cj-1F
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 06:09:58 -0800
From: Richard Potter <sbuml-deletethispart@zar.att.ne.jp>
Subject: Re: [uml-devel] demo of SBUML - swsusp functionality for UML
In-Reply-To: <200312141608.14353.blaisorblade_spam@yahoo.it>
References: <20031213130717.D57E.SBUML-DELETETHISPART@zar.att.ne.jp> <200312141608.14353.blaisorblade_spam@yahoo.it>
Message-Id: <20031216230846.D592.SBUML-DELETETHISPART@zar.att.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 16 Dec 2003 23:09:41 +0900
To: user-mode-linux-devel@lists.sourceforge.net

>>> Sorry, I've a question: how is this project related with swsusp? 

The short answer is that SBUML does not use any code from swsusp and works today.

>>Should they do the same thing? Or different ones?

One answer is that swsusp was designed to save *one temporary*
snapshot of a notebook computer's state.  In contrast, SBUML saves
*multiple persistent* snapshots of a UML's state.  However, maybe this
is not such an interesting difference, since there must be an easy way
to have swsusp save its data to some location that will survive
multiple save and restore operations.  (Does anybody know of a swsusp
implementation that will save multiple snapshots of a machine
including hard disks at various points in time?)

Another answer is that it is important for SBUML to restore the image
of the UML as exactly as possible, because it is meant to support
programming tools.  For example, it should be possible to be in the
middle of doing kernel debugging, save a snapshot, and continue
debugging with confidence with the snapshot resumed into another UML,
possibly on another physical host machine.  (Unfortunately, the
current version of SBUML does not save the connection to GDB, so this
demo is not quite ready...however it will be in future releases.)

As far as I can tell, swsusp is intended for continuing user sessions,
so it is OK for swsusp to use techniques that might change the kernel
state and other hidden state as long as the changes are transparent
to end users. 

--Richard





-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
