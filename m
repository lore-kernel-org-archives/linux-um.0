Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMW3Z-0007pA-BM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 13:09:49 -0800
Received: from wx-out-0506.google.com ([66.249.82.233])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMW3Y-0002X8-GW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 13:09:48 -0800
Received: by wx-out-0506.google.com with SMTP id i30so377089wxd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 28 Feb 2007 13:09:47 -0800 (PST)
Message-ID: <fccbad840702281309s58f19fb5q26a8c33cc9613fae@mail.gmail.com>
Date: Wed, 28 Feb 2007 18:09:47 -0300
From: "Felipe T." <ftroncos007@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Sources into UML guest
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0009735284=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============0009735284==
Content-Type: multipart/alternative; 
	boundary="----=_Part_10902_20151742.1172696987349"

------=_Part_10902_20151742.1172696987349
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello:
I need to install a program into a UML Kernel, this program needs Kernel
Sources (Sebek 3) but I don't know how compile this sources. In the Host I
used ARCH=um  but if I do the same into guest, get a errors when  do make
for the sebek program because doesn't find some .h. For this reason I
compile (into guest) without ARCH=um and make sebek it's ok. But I get a
error when use insmod (error with the format module), I think for the
difference between vermagic values. Someone has some idea

------=_Part_10902_20151742.1172696987349
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello:<br>I need to install a program into a UML Kernel, this program needs Kernel Sources (Sebek 3) but I don&#39;t know how compile this sources. In the Host I used ARCH=um&nbsp; but if I do the same into guest, get a errors when&nbsp; do make for the sebek program because doesn&#39;t find some .h. For this reason I compile (into guest) without ARCH=um and make sebek it&#39;s ok. But I get a error when use insmod (error with the format module), I think for the difference between vermagic values. Someone has some idea
<br>

------=_Part_10902_20151742.1172696987349--


--===============0009735284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0009735284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0009735284==--
