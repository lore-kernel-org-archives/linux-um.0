Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUAa6-00043s-6K	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Oct 2005 15:14:14 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EUAa3-0006d8-4k
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Oct 2005 15:14:14 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Message-Id: <200510221838.17065.blaisorblade@yahoo.it>
Subject: [uml-devel] GFP_ATOMIC/GFP_KERNEL broken for use by block devices!!
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
Date: Sat, 22 Oct 2005 18:38:16 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff, remember I asked you not to merge the UBD rewrite for now? Well, I found 
one more (and bigger) reason for it, though I don't understand it fully.

Quoting from Arjan Van der Ven, "How not to write kernel driver":

In the write path of a ﬁlesystem, using
GFP_KERNEL or GFP_ATOMIC will lead to deadlocks
eventually. [...] GFP_NOFS is there for a reason, as is GFP_NOIO for block 
device drivers.

Though there's no explaination of this, I can guess that GFP_KERNEL could 
cause the kernel to enter the same (or another, but that shouldn't matter) 
block device to free some memory. Not sure what's the problem with GFP_ATOMIC 
though.

However, GFP_NO{FS,IO} both imply !ATOMIC (they include __GFP_WAIT), so we 
cannot use any of them for our purposes.

Which means that we _must_ ask for help from somebody else.

Anyhow, before merging the patches I'd _really_ like if they were reviewed by 
somebody as Jens Axboe or the such, afterwards merged to -mm, and only after 
that merged into mainline.

Please, send some feedback on this email as soon as you read - think to 
replacing UDP with TCP, ok ;-) ?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
