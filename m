Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLZAV-0000zc-WC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 21:07:59 -0700
Received: from [209.67.213.234] (helo=ispbrasil.com.br)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DLZAU-0005Ye-2i
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 21:07:59 -0700
Message-ID: <000501c53fde$626198a0$0201a8c0@lualele>
From: "itamar" <itamar@ispbrasil.com.br>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] resizing root_fs
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
Date: Wed, 13 Apr 2005 01:07:57 -0300
To: uml-user <user-mode-linux-user@lists.sourceforge.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

dd if=/dev/zero of=root_fs.ext3 bs=1 count=1 seek=40G conv=notrunc

[root@router conacci]# resize2fs -p root_fs.ext3
resize2fs 1.36 (05-Feb-2005)
resize2fs: File too large while trying to determine filesystem size
[root@router conacci]#

how to resize this file ?

Itamar Reis Peixoto
+55 (34) 3238 3845
e-mail : itamar@ispbrasil.com.br
http://www.ispbrasil.com.br


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
