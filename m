Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArOLj-0002fK-EK
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 13:26:19 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ArOKN-0003oU-RP
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 13:24:56 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] /dev/anon without /dev/anon ?
Message-ID: <20040212215154.GC4168@ccure.user-mode-linux.org>
References: <1076598155.20064.12.camel@wopr.tektonic.net> <01ee01c3f1a9$06424800$0600a8c0@objexcel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ee01c3f1a9$06424800$0600a8c0@objexcel>
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
Date: Thu, 12 Feb 2004 16:51:54 -0500
To: Peter <support@rimuhosting.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Feb 13, 2004 at 09:43:09AM +1300, Peter wrote:
> This may just be noise, but I also had a host server with 2.4.24 + skas3 + /dev/anon that crashed yesterday after a day or so of running.  Not using ubd=mmap.

Yeah, the patch is not quite kosher.  I've had no problems whatsoever running
skas UMLs, but tt UMLs won't boot with devanon.

				Jeff


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
