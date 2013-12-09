Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <antoine@nagafix.co.uk>) id 1VptiF-0004gW-H8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Dec 2013 05:48:59 +0000
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VptiE-00040R-2h for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Dec 2013 05:48:59 +0000
Message-ID: <52A55556.7090009@nagafix.co.uk>
Date: Mon, 09 Dec 2013 12:29:58 +0700
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5743678671916618983=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] 3.4.73 affected by "uml: signal.c build errors"
To: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============5743678671916618983==
Content-Type: multipart/alternative;
	boundary="------------060408080808030508080409"

This is a multi-part message in MIME format.
--------------060408080808030508080409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Richard,

Not sure how this got fixed in HEAD, but the same fix needs to be
applied on top of 3.4.73
I've just added the includes to arch/um/os-Linux/start_up.c, as per:
https://lkml.org/lkml/2012/10/24/791
And the kernel builds again.

Compile-tested-by: Antoine Martin <antoine@nagafix.co.uk>

Cheers
Antoine

--------------060408080808030508080409
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Richard,<br>
    <br>
    Not sure how this got fixed in HEAD, but the same fix needs to be
    applied on top of 3.4.73<br>
    I've just added the includes to
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    arch/um/os-Linux/start_up.c, as per:<br>
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    <a href="https://lkml.org/lkml/2012/10/24/791">https://lkml.org/lkml/2012/10/24/791</a><br>
    And the kernel builds again.<br>
    <br>
    Compile-tested-by: Antoine Martin <a class="moz-txt-link-rfc2396E" href="mailto:antoine@nagafix.co.uk">&lt;antoine@nagafix.co.uk&gt;</a><br>
    <br>
    Cheers<br>
    Antoine<br>
  </body>
</html>

--------------060408080808030508080409--


--===============5743678671916618983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
--===============5743678671916618983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5743678671916618983==--


