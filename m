Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBYCg-0005uz-GV for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 05:00:18 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BBYCf-0001nf-Tw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 05:00:18 -0700
References: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
Message-ID: <87smfevfq2.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: A quick humfs HOWTO
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
Date: 08 Apr 2004 14:03:49 +0200
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> writes:

> As the readers of uml-devel are aware by now, there is a new virtual UML 
> filesystem called humfs.  This is a hostfs-like filesystem which does ownerships
> right, by separating them from the actual file, ala umsdos.

Hmm.  Why separate?  These days almost all filesystems in 2.6 support
extended attributes, that would be the ideal place for such metadata
IMHO ...

  Gerd

-- 
http://bigendian.bytesex.org


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
