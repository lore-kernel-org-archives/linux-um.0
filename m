Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGUbh-0003K0-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 02 Nov 2003 18:38:17 -0800
Received: from tailtiu.davidcoulson.net ([207.166.203.132] helo=mail.mx.davidcoulson.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AGUbg-0002lr-Lv
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 02 Nov 2003 18:38:16 -0800
Message-ID: <3FA5BF94.4050501@davidcoulson.net>
From: David Coulson <david@davidcoulson.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] Linking 2 switches
References: <200311020019.48773.benoit.peccatte@enst-bretagne.fr> <200311030238.hA32cqgX002509@ccure.karaya.com>
In-Reply-To: <200311030238.hA32cqgX002509@ccure.karaya.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sun, 02 Nov 2003 21:38:12 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: Benoit <benoit.peccatte@enst-bretagne.fr>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> What's the matter with just hooking the switches together directly by UDP?

I usually just bridge tap devices across a physical network, or use the 
VLAN stuff in the kernel. Does uml_switch support UDP? Maybe it'd be 
cool if it used multicast out of specified network interfaces :-)

David

-- 
David Coulson                                    email: d@vidcoulson.com
Linux Developer /                          web: http://davidcoulson.net/
Network Engineer                                   phone: (216) 533-6967



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
