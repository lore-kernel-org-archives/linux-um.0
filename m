Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EgF2C-00028T-19 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 21:25:08 -0800
Received: from in-ruhr4.ruhr.de ([62.80.13.2] helo=mail.ruhr.de ident=qmailr)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EgF2A-0002fs-F4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Nov 2005 21:25:08 -0800
Date: Sun, 27 Nov 2005 06:22:16 +0100
From: Andreas Wohlfeld <agw@supersonic.ruhr.de>
Subject: Re: [uml-devel] Using lilo on ubda?
Message-ID: <20051127052216.GA18684@supersonic.ruhr.de>
References: <200511261303.42684.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511261303.42684.rob@landley.net>
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
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Nov 26, 2005 at 01:03:42PM -0600, Rob Landley wrote:
> Lilo is saying that ubda is not a device with partitions.
> 
> Anybody know what it's talking about?  (I've got a ubda1.  I'm trying to make 
> a disk image I can test boot with qemu without having to boot a knoppix image 
> to do it...)
> 
Did you use fdisk on your hard file or do you use ist as a super floppy?

Try testing it with a second hardfile and (c)fdisk it with partitions.

Most of us use several hard files as super floppies not putting any
partition table on the disk (you can see a message about that during
boot, I think).


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
