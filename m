Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPNt3-0002GE-J8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 08:21:29 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CPNt2-0006ty-Q3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 08:21:29 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Fwd: [uml-devel] devfs_mk_symlink abuse in arch/um/drivers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411030156.36319.blaisorblade_spam@yahoo.it>
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
Date: Wed, 3 Nov 2004 01:56:36 +0100
To: user-mode-linux-devel@lists.sourceforge.net

This is from some time ago. I'm going to implement this and test if this fixed 
the DevFS problems we are getting.

----------  Forwarded Message  ----------

Subject: [uml-devel] devfs_mk_symlink abuse in arch/um/drivers
Date: Wednesday 11 June 2003 13:28
From: Christoph Hellwig <hch@lst.de>
To: user-mode-linux-devel@lists.sourceforge.net

Could you please decide what names to use in devfs for the um
drivers,. i.e. pick on of

/dev/mmapper0 vs /dev/mmapper
/dev/serial/* vs /dev/tts/*
/dev/ttys/* vs  /dev/vc/*

devfs_mk_symlink as public API will fade away soon.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
