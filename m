Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AG52I-000170-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 01 Nov 2003 15:20:02 -0800
Received: from laposte.enst-bretagne.fr ([192.108.115.3])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AG52H-0000K4-FG
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 01 Nov 2003 15:20:01 -0800
Received: from maisel-gw.enst-bretagne.fr (maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6p2/8.11.6/2003.04.01) with ESMTP id hA1NJrV15340
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 2 Nov 2003 00:19:53 +0100
Received: from peck.maisel.enst-bretagne.fr (peck.maisel.enst-bretagne.fr [172.16.23.6])
	by maisel-gw.enst-bretagne.fr (Postfix) with ESMTP id 1FFDE405D
	for <user-mode-linux-devel@lists.sourceforge.net.>; Sun,  2 Nov 2003 00:19:49 +0100 (CET)
From: Benoit <benoit.peccatte@enst-bretagne.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311020019.48773.benoit.peccatte@enst-bretagne.fr>
Subject: [uml-devel] Linking 2 switches
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
Date: Sun, 2 Nov 2003 00:19:48 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

In order tu make a network of uml located on different machines, I nedded to 
link 2 uml_switch's between themselves via a network connexion. The goal is 
to use UML for linux practices on real machines where we can't have a tun/tap 
connections. 
So I modified uml_switch to listen on tcp port and created uml_uplink which is 
able to connect to a local switch via unix socket and to another switch via a 
tcp connection.

Do you think his is a good solution ?

Benoit



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
