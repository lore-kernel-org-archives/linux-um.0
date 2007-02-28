Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMOpo-0000AW-M3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 05:27:08 -0800
Received: from nf-out-0910.google.com ([64.233.182.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMOpo-0000LS-9Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 05:27:08 -0800
Received: by nf-out-0910.google.com with SMTP id c31so952572nfb
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 28 Feb 2007 05:27:07 -0800 (PST)
Message-ID: <c28964800702280527x7c300a39gb6a2cd077e36daaf@mail.gmail.com>
Date: Wed, 28 Feb 2007 22:27:06 +0900
From: "Lakshminarasimhan Naveenam" <lsimhan05@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] Compilation error with 2.6.18 kernel
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1934075746=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1934075746==
Content-Type: multipart/alternative; 
	boundary="----=_Part_27265_8410841.1172669226902"

------=_Part_27265_8410841.1172669226902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
  I downloaded the 2.6.18 kernel and did the following

make defconfig ARCH=um
make menuconfig ARCH=um
make ARCH=um

I got the following error
$make ARCH=um
SYMLINK arch/um/include/kern_constants.h
  SYMLINK arch/um/include/sysdep
  CHK     arch/um/include/uml-config.h
  UPD     arch/um/include/uml-config.h
  CC      arch/um/sys-i386/user-offsets.s
arch/um/sys-i386/user-offsets.c: In function 'foo':
arch/um/sys-i386/user-offsets.c:19: warning: implicit declaration of
function 'offsetof'
arch/um/sys-i386/user-offsets.c:19: error: expected expression before
'struct'

The offsetof macro is defined in <linux/stddef.h> but somehow it is not in
the include path.

Can anyone help?

TIA,
simhan.

------=_Part_27265_8410841.1172669226902
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>&nbsp; I downloaded the 2.6.18 kernel and did the following<br><br>make defconfig ARCH=um<br>make menuconfig ARCH=um<br>make ARCH=um<br><br>I got the following error <br>$make ARCH=um<br>SYMLINK arch/um/include/kern_constants.h
<br>&nbsp; SYMLINK arch/um/include/sysdep<br>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; arch/um/include/uml-config.h<br>&nbsp; UPD&nbsp;&nbsp;&nbsp;&nbsp; arch/um/include/uml-config.h<br>&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/um/sys-i386/user-offsets.s<br>arch/um/sys-i386/user-offsets.c: In function 'foo':<br>
arch/um/sys-i386/user-offsets.c:19: warning: implicit declaration of function 'offsetof'<br>arch/um/sys-i386/user-offsets.c:19: error: expected expression before 'struct'<br><br>The offsetof macro is defined in &lt;linux/stddef.h&gt; but somehow it is not in the include path.
<br><br>Can anyone help?<br><br>TIA,<br>simhan.<br><br><br>

------=_Part_27265_8410841.1172669226902--


--===============1934075746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1934075746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1934075746==--
