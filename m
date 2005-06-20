Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkRuC-0004IW-3x	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 12:26:00 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DkRu9-0005zK-Gf
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 12:25:59 -0700
Received: from sphinx.mythic-beasts.com ([212.69.37.6])
	by externalmx-1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DkRu6-0005jH-Fw
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 12:25:57 -0700
Received: from pdw by sphinx.mythic-beasts.com with local (Exim 4.51)
	id 1DkRu1-000341-Uz	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 20:25:49 +0100
From: Paul Warren <pdw@ex-parrot.com>
Message-ID: <20050620202549.A6907@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Entropy on boot
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
Date: Mon, 20 Jun 2005 20:25:49 +0100
To: user-mode-linux-devel@lists.sourceforge.net

We've recently prepared a filesystem image for the latest Debian
distribution, and hit a problem with it hanging on starting Apache2.  We
traced this to a lack of entropy to feed /dev/random, causing the
Apache's startssl to block.

Chris Lightfoot has developed this patch to feed the guest's entropy
pool with data read from the host's /dev/random on boot:

	http://mythic-beasts.com/uml/random-seed.patch

Paul


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
