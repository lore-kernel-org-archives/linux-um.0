Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL3EJ-0007fF-Gk for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 10:29:31 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CL3EI-0007bb-R2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 10:29:31 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410221929.07592.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] FAQ: 2.6.9 - why "make linux ARCH=um" fails?
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
Date: Fri, 22 Oct 2004 19:29:07 +0200
To: User Mode Linux User <user-mode-linux-user@lists.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

Q: Why does "make linux ARCH=um" fail?
R: Just use "make vmlinux ARCH=um", which creates the "vmlinux" binary, which 
is what you must use.

Or even simply do "make ARCH=um", which is the same as:
make vmlinux modules ARCH=um

* Q: Why did you do this change?
R: This is the result of a change which allows /proc/kallsyms to work, 
allowing UML to print stack traces on panic.

* Q: Why did not you added a notice about "make linux ARCH=um"?
R: I did that, only it was merged after 2.6.9.

* Q: What did you do?
R: within next version, each time you do "make linux ARCH=um", a hardlink is 
created from linux to vmlinux. I.e. they are two copies of the same file, 
sharing the content. If you do a "make vmlinux ARCH=um", instead of leaving a 
stale linux file with the old content, or relinking it, we simply remove the 
vmlinux file. It is assumed that if you do "make vmlinux ARCH=um", you 
already know of this change.

* Q: Why didn't you do simply "mv vmlinux linux"?
R: because that way another "make linux" would relink again the files.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
