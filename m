Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1e0NA5-0003g9-8j for user-mode-linux-devel@lists.sourceforge.net;
 Fri, 06 Oct 2017 07:35:09 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1e0NA1-0002J8-By
 for user-mode-linux-devel@lists.sourceforge.net;
 Fri, 06 Oct 2017 07:35:09 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri,  6 Oct 2017 08:34:54 +0100
Message-Id: <20171006073457.15448-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] PATCH v5
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard.weinberger@gmail.com

Patches 1 and 2 are the same as before, patch 3 adds TSO, GRO and
full scatter gather support as well as ability to on/off all
features from commandline and/or ethtool where applicable.

The result from patch 3 is 5.6Gbit on tcp throughput using the
tap/raw driver on a 3.5GHz AMD A4 desktop.

I am parking this now for the time being as I needed it mostly as
a test harness for another project which I now have to go and
beat into shape :)

Brgds,

A.


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

