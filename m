Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMVxi-0007Dv-IE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 13:03:46 -0800
Received: from wx-out-0506.google.com ([66.249.82.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMVxh-0004aO-Tq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 13:03:46 -0800
Received: by wx-out-0506.google.com with SMTP id i30so374722wxd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 28 Feb 2007 13:03:45 -0800 (PST)
Message-ID: <fccbad840702281303o69a16baay60e6d6a9f30ae84f@mail.gmail.com>
Date: Wed, 28 Feb 2007 18:03:44 -0300
From: "Felipe T." <ftroncos007@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Kernel Source into Guest
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1274495325=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1274495325==
Content-Type: multipart/alternative; 
	boundary="----=_Part_10874_516720.1172696624935"

------=_Part_10874_516720.1172696624935
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I need to install a program into a UML Kernel, this program needs Kernel
Sources (Sebek 3) but I don't know how compile them. In the Host I used
ARCH=um  but if I do the same into guest, I get some errors at execute "make"
for the sebek program, because it doesn't find some .h files. For this
reason I compiled (into guest) without ARCH=um and make sebek it's ok. But I
get a format module error when use insmod, because the difference between
vermagic values, I guess. Does Anyone have some idea how I get the sources
into guest?

Thanks for any help.

------=_Part_10874_516720.1172696624935
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I need to install a program into a UML Kernel, this program needs Kernel Sources (Sebek 3) but I don&#39;t know how compile them. In the Host I used ARCH=um&nbsp; but if I do the same into guest, I get some errors at execute<span style="font-weight: bold;">

 &quot;</span><span></span>make&quot; for the sebek program, because it doesn&#39;t find some .h files. For this reason I compiled (into guest) without ARCH=um and make sebek it&#39;s ok. But I get a format module error when use insmod, because the difference between vermagic values, I guess. Does Anyone have some idea how I get the sources into guest?
<br><br>Thanks for any help.<br>

------=_Part_10874_516720.1172696624935--


--===============1274495325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1274495325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1274495325==--
