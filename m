Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A32kM-0001oe-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 26 Sep 2003 17:15:38 -0700
Received: from shell.blacknet.de ([80.254.131.106])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A32kK-0006PA-8B
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Sep 2003 17:15:36 -0700
From: Goetz Bock <bock+uml@blacknet.de>
Subject: Re: [uml-devel] Separate COW patch.
Message-ID: <20030926231441.GB15465@shell.blacknet.de>
References: <2D4B6CD74137D4119A1100104BC6BCBF0BC585FC@dubntex006.qwest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D4B6CD74137D4119A1100104BC6BCBF0BC585FC@dubntex006.qwest.net>
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
Date: Sat, 27 Sep 2003 01:14:41 +0200
To: "'user-mode-linux-devel@lists.sourceforge.net'" <user-mode-linux-devel@lists.sourceforge.net>


On Fri, Sep 26 '03 at 18:45, Montgomery, Kendal L wrote:
> I was wondering if there was anyone who is trying to use the COW
> filesystem in a normal linux kernel? [ ... ]
The COW is not a filesystem, it is a block level thingy.

If you only have a small number of changes, the LVM / DM snapshot
feature might be usefill. OTOH it is designed to be merged afterwards,
not discarded.
-- 
/"\ Goetz Bock at blacknet dot de  --  secure mobile Linux everNETting
\ /                     (c) 2003 as GNU FDL 1.1
 X   [ 1. Use descriptive subjects - 2. Edit a reply for brevity -  ]
/ \  [ 3. Reply to the list - 4. Read the archive *before* you post ]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
