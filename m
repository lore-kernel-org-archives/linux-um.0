Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBYQ8-00082U-OC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 05:14:12 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BBYQ8-0003Wn-5y
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Apr 2004 05:14:12 -0700
Message-Id: <200404081252.i38Cq3B6002530@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] A quick humfs HOWTO 
In-Reply-To: Your message of "Thu, 08 Apr 2004 10:54:32 BST."
	<20040408095432.GA10043@axis.demon.co.uk> 
References: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
	<20040408095432.GA10043@axis.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 08 Apr 2004 08:52:03 -0400
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

ncw1@axis.demon.co.uk said:
> Does uml actually obey this total in the superblock?  Ie does this
> setting act as a quota? 

It will, I'm not sure if it does right now.  I think that needs to be put
in the superblock at mount time.

Also, it should be possible to have UML notice changes there and have them
take effect immediately.  With it watching the file with dnotify, and reading
it whenever it changes, you should be able to modify filesystem sizes on the
fly.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
