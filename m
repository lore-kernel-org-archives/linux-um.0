Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGbQH-0005MI-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 03 Nov 2003 01:54:57 -0800
Received: from laposte.enst-bretagne.fr ([192.108.115.3])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AGbQG-0004VQ-TN
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 03 Nov 2003 01:54:57 -0800
Received: from maisel-gw.enst-bretagne.fr (maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6p2/8.11.6/2003.04.01) with ESMTP id hA39sn526902
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 3 Nov 2003 10:54:49 +0100
Received: from peck.maisel.enst-bretagne.fr (peck.maisel.enst-bretagne.fr [172.16.23.6])
	by maisel-gw.enst-bretagne.fr (Postfix) with ESMTP id 7EF4140A9
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon,  3 Nov 2003 10:54:44 +0100 (CET)
From: Benoit <benoit.peccatte@enst-bretagne.fr>
Subject: Re: [uml-devel] Linking 2 switches
References: <200311020019.48773.benoit.peccatte@enst-bretagne.fr> <200311030238.hA32cqgX002509@ccure.karaya.com> <3FA5BF94.4050501@davidcoulson.net>
In-Reply-To: <3FA5BF94.4050501@davidcoulson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311031054.44262.benoit.peccatte@enst-bretagne.fr>
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
Date: Mon, 3 Nov 2003 10:54:44 +0100
To: user-mode-linux-devel@lists.sourceforge.net

On Monday 03 November 2003 03:38, you wrote:
> Jeff Dike wrote:
> > What's the matter with just hooking the switches together directly by
> > UDP?
>
> I usually just bridge tap devices across a physical network, or use the
> VLAN stuff in the kernel. Does uml_switch support UDP? Maybe it'd be
> cool if it used multicast out of specified network interfaces :-)

The problen with tap is that root need to configure a tap device. I can't 
afford such a thing.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
