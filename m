Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdaF2-0001MJ-HT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jun 2004 12:50:36 -0700
Received: from nova.math.tau.ac.il ([132.67.192.133] helo=tau.ac.il)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BdaF1-0002dA-Qo for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jun 2004 12:50:36 -0700
From: Hayim Shaul <hayim@post.tau.ac.il>
Message-ID: <Pine.LNX.4.44.0406242229170.6064-100000@nova.math.tau.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] trouble mounting hostfs
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
Date: Thu, 24 Jun 2004 22:48:27 +0300 (IDT)
To: wstearns@pobox.com
Cc: user-mode-linux-devel@lists.sourceforge.net


I'm running linux 2.6.7 ext3, and tring to run a virtual uml.
I used root_fs.rh-9-full.pristine.20030724 as root_fs

Whenever I try to mount the hostfs the uml prints an error
and freezes.

-bash-2.05b# mount none /mnt/host -thostfs
Child 7869 exited with signal 11


I checked the uml. It has hostfs in /proc/filesystem.
However it does not have ext3 support.

Is the problem because I don't have ext3 support in the uml?
I thought that the uml accesses the hostfs through the host functions, and 
it does not need ext3 support itself.

If not, what is the problem?

How can I add ext3 support to the uml? or create a new rootfs?

Can I mount some partition of the host (other than /) ?

Thanks,
  Hayim.



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
