Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6n2W-00027P-P7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 01:54:40 -0800
Received: from baltz-online.de
	([213.146.167.207] helo=mail.baltz-online.de ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6n2V-00057D-Aa for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 01:54:40 -0800
Received: from ssl.baltz-online.de (localhost [127.0.0.1])
	by mail.baltz-online.de (Postfix) with ESMTP id C3EE134113
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  3 Mar 2005 10:54:28 +0100 (CET)
Message-ID: <36618.128.176.89.137.1109843669.squirrel@128.176.89.137>
From: "Oliver Baltz" <info@OliverBaltz.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] UML freezes at hdd-intensive processes
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
Date: Thu, 3 Mar 2005 10:54:29 +0100 (CET)
To: user-mode-linux-devel@lists.sourceforge.net

Hi @all,

my UML hangs while intensive processes that use the HDD. For example:
rgrep, upgrade,...

UML-Hostsystem: 2.4.27-1-386, Intel ICH5 SATA 150-Controller
UML: 2.4.26-3um-1

Any ideas?







-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
