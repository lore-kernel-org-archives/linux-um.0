Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC06Y-0004jL-QH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 10:52:22 -0800
Received: from server.ispbrasil.com.br ([66.160.135.36] helo=ispbrasil.com.br)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DC06R-0004Tv-2o
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 10:52:22 -0800
Message-ID: <000d01c52b22$8ab2c020$0201a8c0@lualele>
From: "itamar" <itamar@ispbrasil.com.br>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] uml help __alloc_pages: 0-order allocation failed
	(gfp=0xf0/0)
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
Date: Thu, 17 Mar 2005 15:52:53 -0300
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

I am running a uml machine, and I am getting this errors.

__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)

my host is a 2.6.11.4 kernel with skas-2.6.11-v8-rc5

my guest machine is a 2.4.27 kernel with uml-patch-2.4.27-1.bz2 

Itamar Reis Peixoto
+55 (34) 3238 3845
e-mail : itamar@ispbrasil.com.br
http://vps.ispbrasil.com.br


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
