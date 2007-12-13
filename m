Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2pDQ-0005bu-4J for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Dec 2007 06:39:08 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J2pDO-00074V-7Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Dec 2007 06:39:08 -0800
Date: Thu, 13 Dec 2007 09:38:57 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071213143857.GA5768@c2.user-mode-linux.org>
References: <4761327D.8020301@dasistemi.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4761327D.8020301@dasistemi.it>
Subject: Re: [uml-devel] Serial Line ioct and set_termios bypassing
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: tcappellari <tcappellari@dasistemi.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Dec 13, 2007 at 02:24:13PM +0100, tcappellari wrote:
> I'm developing an application that I want to run inside UML system. This 
> application use the serial line, and I need to set/reset the control 
> signals RTS/DTR and read CTS/DSR and also I need to set up the baud rate.
> Into UML kernel the line_ioctl and line_set_termio functions are 
> essentialy empty, so I guess that what I need is intentionally not 
> implemented for divide the Guest system from the Host. (please correct 
> me if I wrong).

I'll implement them if you'll test patches and tell me if they work.

The thing about serial ioctls is that few things use them and it's not
obvious what they are supposed to do.

What ioctls in particular are you missing?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
