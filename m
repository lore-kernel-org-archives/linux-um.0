Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CowUe-0006br-8a for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 20:21:56 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CowUY-00029H-IL for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 20:21:55 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501130524.07091.blaisorblade@yahoo.it>
Subject: [uml-devel] Fwd: Re: [fuse-devel] Merging?
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
Date: Thu, 13 Jan 2005 05:24:06 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

See what I found on LKML:

,--------------- Messaggio inoltrato (inizio)

 Oggetto: Re: [fuse-devel] Merging?
 Mittente: Miklos Szeredi <miklos@szeredi.hu>
 Data: Wed, 12 Jan 2005 15:51:27 +0100
 Newsgroup: gmane.linux.kernel,gmane.comp.file-systems.fuse.devel

 
 > -You could implement several "not-performance-critical" filesystems (fat,
 >  isofs) with FUSE to avoid possible security issues. Give that nowadays 
 >  usb sticks and cd/dvds are so common it'd be possible to modify a 
filesystem
 >  on purpose to crash the kernel if a bug were found in those filesytems. 
With
 >  FUSE that posibility decreases.
 
 One of my pet ideas, is a userspace loopback mounter, which would use
 UML to actually mount an image, and export the resulting filesystem
 through FUSE to the host.
 
 Brilliant isn't it?
 
 Miklos

`--------------- Messaggio inoltrato (fine)

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
