Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DECSI-0003VW-Fa for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 12:27:54 -0800
Received: from server.ispbrasil.com.br ([66.160.135.36] helo=ispbrasil.com.br)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DECSF-0003HF-Dd
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 12:27:54 -0800
Message-ID: <002001c52fe6$e51158b0$0201a8c0@lualele>
From: "itamar" <itamar@ispbrasil.com.br>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] swap problem solved.
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
Date: Wed, 23 Mar 2005 17:28:33 -0300
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net, monsta@monsta.hu

I am found a solution for my problem in this page

http://uml.pimb.org/howto/uml-debian-install.html#SWAP

You only need to run the following commands the first time you use a copy of 
the installer. They are needed to configure the ubd device nodes correctly, 
as the presupplied ones have got the wrong minor numbers


# cd /dev
# rm ubd*
# mknod ubd0 b 98 0
# mknod ubd1 b 98 16
# mknod ubd2 b 98 32
# mknod ubd3 b 98 48
# mknod ubd4 b 98 64
# mknod ubd5 b 98 80
# mknod ubd6 b 98 96
# mknod ubd7 b 98 112


Itamar Reis Peixoto
+55 (34) 3238 3845
e-mail : itamar@ispbrasil.com.br
http://www.ispbrasil.com.br


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




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
