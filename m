Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DE8pW-0005oT-K2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 08:35:38 -0800
Received: from server.ispbrasil.com.br ([66.160.135.36] helo=ispbrasil.com.br)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DE8pU-0005j8-PJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 08:35:38 -0800
Message-ID: <002901c52fc6$649f51c0$0201a8c0@lualele>
From: "itamar" <itamar@ispbrasil.com.br>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] swap help->  swapon: /dev/ubd/1: No such device
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
Date: Wed, 23 Mar 2005 13:35:52 -0300
To: user-mode-linux-devel@lists.sourceforge.net

I am starting my guest machine with ubd1=/uml/clau/swap.img


-bash-2.05b# swapon -a
swapon: /dev/ubd/1: No such device
-bash-2.05b#


my fstab
/dev/ubd/0      /               ext3    defaults,usrquota 1 1
/proc           /proc           proc    defaults
devpts          /dev/pts        devpts  mode=0622 0 0
/dev/ubd/1      none            swap    sw      0       0


How to make my swap working ?


Itamar Reis Peixoto
+55 (34) 3238 3845
e-mail : itamar@ispbrasil.com.br
http://www.ispbrasil.com.br


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
