Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dAegl-0003cJ-T0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2017 15:47:07 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dAegj-0003Hq-0i
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2017 15:47:07 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Message-ID: <131837db-75e3-f78f-6aae-6b7be8d051a8@m3y3r.de>
Date: Tue, 16 May 2017 17:46:47 +0200
MIME-Version: 1.0
Subject: Re: [uml-devel] [RFC PATCH 1/7] um: Use printk instead of printf in
	make_uml_dir
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: mhiramat@kernel.org
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Hi,

as far as I understand everything under os-Linux should be OS specific 
and shouldn't rely on kernel functions.

@Richard: What do you think about this patch?

See: https://marc.info/?l=linux-kernel&m=149337493432407&w=2

with kind regards
thomas

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

