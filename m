Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgoT2-0005b8-Kj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 13:52:00 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HgoT2-0007UL-6g
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 13:52:00 -0700
Date: Wed, 25 Apr 2007 16:48:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070425204849.GA9505@c2.user-mode-linux.org>
References: <462BACC9.7010303@nagafix.co.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <462BACC9.7010303@nagafix.co.uk>
Subject: Re: [uml-devel] regression: pcap broken in 2.6.20.x
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Apr 22, 2007 at 07:43:21PM +0100, Antoine Martin wrote:
> Using the exact same kernel config with 2.6.19.x works but not with 2.6.20.x
> 
> # ifconfig eth1 0.0.0.0 promisc up
> SIOCSIFADDR: No such device
> eth1: unknown interface: No such device
> eth1: unknown interface: No such device
> eth1: unknown interface: No such device

Works here - what do ifconfig -a and dmesg say?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
