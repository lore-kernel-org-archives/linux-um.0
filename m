Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBPBq-0007iq-OJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 19:22:50 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBPBq-0006yS-Bd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 19:22:50 -0700
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id i381wGK14042
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 7 Apr 2004 21:58:20 -0400
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id
	i382iWbe009336 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 7 Apr 2004 22:44:32 -0400
Message-Id: <200404080244.i382iWbe009336@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml_utilities_20040406
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
Date: Wed, 07 Apr 2004 22:44:32 -0400
To: user-mode-linux-devel@lists.sourceforge.net

The main feature of this release is humfsify.  See my humfs HOWTO for more
details.

jailer.pl now has persistent cell and reuse cell options, it makes sure that
UML is statically linked, and it binds /proc/mm into the jail.

There are a batch of small changes from Dan Shearer in mconsole and port-helper.

The mconsole "log" command now puts a newline after its input.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
