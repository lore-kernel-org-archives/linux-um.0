Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XW8XT-0005WF-7n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 18:40:43 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XW8XR-0000Jt-2k
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Sep 2014 18:40:42 +0000
Message-ID: <54206CFB.4070308@kot-begemot.co.uk>
Date: Mon, 22 Sep 2014 19:39:55 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <E1XW6rt-0005E0-Pl@sog-mx-2.v43.ch3.sourceforge.com>
In-Reply-To: <E1XW6rt-0005E0-Pl@sog-mx-2.v43.ch3.sourceforge.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9140350386362268788=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Fwd: Mail delivery failed: returning message to sender
To: richard.weinberger@gmail.com, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============9140350386362268788==
Content-Type: multipart/alternative;
	boundary="------------010902080300000801060309"

This is a multi-part message in MIME format.
--------------010902080300000801060309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi RIchard, hi list,

There is some problem with the list on sourceforge. It has bounced one
of the patches - no 4.

I can resend this for book-keeping purposes.

If memory serves me right there are no changes in this particular one so
the earlier version (3) from ~ 2 weeks ago can be used instead.

A.


-------- Original Message --------
Subject: 	Mail delivery failed: returning message to sender
Date: 	Mon, 22 Sep 2014 16:53:41 +0000
From: 	Mail Delivery System <Mailer-Daemon@sourceforge.net>
To: 	anton.ivanov@kot-begemot.co.uk



This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  user-mode-linux-devel@lists.sourceforge.net
    SMTP error from remote mail server after RCPT TO:<user-mode-linux-devel@lists.sourceforge.net>:
    host sfs-lb-ml.v29.ch3.sourceforge.com [172.29.29.17]:
    550 Unknown user

------ This is a copy of the message, including all the headers. ------
------ The body of the message is 29686 characters long; only the first
------ 16384 or so are included here.

Return-path: <anton.ivanov@kot-begemot.co.uk>
Received-SPF: pass (sog-mx-2.v43.ch3.sourceforge.com: domain of kot-begemot.co.uk designates 89.200.143.206 as permitted sender) client-ip=89.200.143.206; envelope-from=anton.ivanov@kot-begemot.co.uk; helo=ivanoab3.miniserver.com;
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	id 1XW6ro-0005DR-7p
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Sep 2014 16:53:38 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6] helo=falkor.sigsegv.cx)
	by ivanoab3.miniserver.com with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1XW6qk-0001BT-B3; Mon, 22 Sep 2014 16:52:30 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80] helo=MonstrousNightmare.cisco.com)
	by falkor.sigsegv.cx with esmtp (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1XW6rf-0002Zt-Ty; Mon, 22 Sep 2014 17:53:28 +0100
From: anton.ivanov@kot-begemot.co.uk
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Ivanov <antivano@cisco.com>
Subject: [PATCH v4 04/11] L2TPv3 Transport Driver for UML
Date: Mon, 22 Sep 2014 17:53:17 +0100
Message-Id: <1411404804-871910-5-git-send-email-anton.ivanov@kot-begemot.co.uk>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
X-Spam-Score: -1.5 (-)
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
 See http://spamassassin.org/tag/ for more details.
 -1.5 SPF_CHECK_PASS         SPF reports sender host as permitted sender for
                             sender-domain
 -0.0 SPF_PASS               SPF: sender matches SPF record
X-Headers-End: 1XW6ro-0005DR-7p

From: Anton Ivanov <antivano@cisco.com>

This transport allows a UML to connect to another UML local
or remote, the Linux host or any other network device running
the industry standard Ethernet over L2TPv3 protocol as per
RFC 3931 (and successors).

The transport supports a common set of features with the kernel
implementation as well as the Cisco contributed L2TPv3 transport
for QEMU/KVM. In all cases this is static tunnels only, no L2TPv3
control plane.

Additionally, the transport supports the so called "soft"
termination where it can listen for an incoming connection
which does not require the remote endpoint to be specified
at configuration time.

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/Kconfig.net               |   10 +
 arch/um/drivers/Makefile          |    2 +
 arch/um/drivers/uml_l2tpv3.h      |  111 ++++++++++
 arch/um/drivers/uml_l2tpv3_kern.c |  434 +++++++++++++++++++++++++++++++++++++
 arch/um/drivers/uml_l2tpv3_user.c |  409 ++++++++++++++++++++++++++++++++++
 5 files changed, 966 insertions(+)
 create mode 100644 arch/um/drivers/uml_l2tpv3.h
 create mode 100644 arch/um/drivers/uml_l2tpv3_kern.c
 create mode 100644 arch/um/drivers/uml_l2tpv3_user.c

diff --git a/arch/um/Kconfig.net b/arch/um/Kconfig.net
index e4a7cf2..d84a1ee 100644
--- a/arch/um/Kconfig.net
+++ b/arch/um/Kconfig.net
@@ -93,6 +93,16 @@ config UML_NET_SLIP
         UMLs on a single host).  You may choose more than one without
         conflict.  If you don't need UML networking, say N.
 
+config UML_NET_L2TPV3
+	bool "L2TPV3 transport"
+	depends on UML_NET
+	help
+        This User-Mode Linux network transport allows one or more running
+        UMLs on single or multiple hosts to communicate with each other,
+        the host as well as other remote or local network devices supporting
+        the industry standard Ethernet over L2TPv3 protocol as described in
+        the applicable RFCs
+

[snip]

A.


--------------010902080300000801060309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi RIchard, hi list,<br>
    <br>
    There is some problem with the list on sourceforge. It has bounced
    one of the patches - no 4.<br>
    <br>
    I can resend this for book-keeping purposes. <br>
    <br>
    If memory serves me right there are no changes in this particular
    one so the earlier version (3) from ~ 2 weeks ago can be used
    instead.<br>
    <br>
    A.<br>
    <div class="moz-forward-container"><br>
      <br>
      -------- Original Message --------
      <table class="moz-email-headers-table" border="0" cellpadding="0"
        cellspacing="0">
        <tbody>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">Subject:
            </th>
            <td>Mail delivery failed: returning message to sender</td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">Date: </th>
            <td>Mon, 22 Sep 2014 16:53:41 +0000</td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">From: </th>
            <td>Mail Delivery System
              <a class="moz-txt-link-rfc2396E" href="mailto:Mailer-Daemon@sourceforge.net">&lt;Mailer-Daemon@sourceforge.net&gt;</a></td>
          </tr>
          <tr>
            <th align="RIGHT" nowrap="nowrap" valign="BASELINE">To: </th>
            <td><a class="moz-txt-link-abbreviated" href="mailto:anton.ivanov@kot-begemot.co.uk">anton.ivanov@kot-begemot.co.uk</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      <pre>This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  <a class="moz-txt-link-abbreviated" href="mailto:user-mode-linux-devel@lists.sourceforge.net">user-mode-linux-devel@lists.sourceforge.net</a>
    SMTP error from remote mail server after RCPT TO:<a class="moz-txt-link-rfc2396E" href="mailto:user-mode-linux-devel@lists.sourceforge.net">&lt;user-mode-linux-devel@lists.sourceforge.net&gt;</a>:
    host sfs-lb-ml.v29.ch3.sourceforge.com [172.29.29.17]:
    550 Unknown user

------ This is a copy of the message, including all the headers. ------
------ The body of the message is 29686 characters long; only the first
------ 16384 or so are included here.

Return-path: <a class="moz-txt-link-rfc2396E" href="mailto:anton.ivanov@kot-begemot.co.uk">&lt;anton.ivanov@kot-begemot.co.uk&gt;</a>
Received-SPF: pass (sog-mx-2.v43.ch3.sourceforge.com: domain of kot-begemot.co.uk designates 89.200.143.206 as permitted sender) client-ip=89.200.143.206; <a class="moz-txt-link-abbreviated" href="mailto:envelope-from=anton.ivanov@kot-begemot.co.uk">envelope-from=anton.ivanov@kot-begemot.co.uk</a>; helo=ivanoab3.miniserver.com;
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	id 1XW6ro-0005DR-7p
	for <a class="moz-txt-link-abbreviated" href="mailto:user-mode-linux-devel@lists.sourceforge.net">user-mode-linux-devel@lists.sourceforge.net</a>; Mon, 22 Sep 2014 16:53:38 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6] helo=falkor.sigsegv.cx)
	by ivanoab3.miniserver.com with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <a class="moz-txt-link-rfc2396E" href="mailto:anton.ivanov@kot-begemot.co.uk">&lt;anton.ivanov@kot-begemot.co.uk&gt;</a>)
	id 1XW6qk-0001BT-B3; Mon, 22 Sep 2014 16:52:30 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80] helo=MonstrousNightmare.cisco.com)
	by falkor.sigsegv.cx with esmtp (Exim 4.80)
	(envelope-from <a class="moz-txt-link-rfc2396E" href="mailto:anton.ivanov@kot-begemot.co.uk">&lt;anton.ivanov@kot-begemot.co.uk&gt;</a>)
	id 1XW6rf-0002Zt-Ty; Mon, 22 Sep 2014 17:53:28 +0100
From: <a class="moz-txt-link-abbreviated" href="mailto:anton.ivanov@kot-begemot.co.uk">anton.ivanov@kot-begemot.co.uk</a>
To: <a class="moz-txt-link-abbreviated" href="mailto:user-mode-linux-devel@lists.sourceforge.net">user-mode-linux-devel@lists.sourceforge.net</a>
Cc: Anton Ivanov <a class="moz-txt-link-rfc2396E" href="mailto:antivano@cisco.com">&lt;antivano@cisco.com&gt;</a>
Subject: [PATCH v4 04/11] L2TPv3 Transport Driver for UML
Date: Mon, 22 Sep 2014 17:53:17 +0100
Message-Id: <a class="moz-txt-link-rfc2396E" href="mailto:1411404804-871910-5-git-send-email-anton.ivanov@kot-begemot.co.uk">&lt;1411404804-871910-5-git-send-email-anton.ivanov@kot-begemot.co.uk&gt;</a>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <a class="moz-txt-link-rfc2396E" href="mailto:1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk">&lt;1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk&gt;</a>
References: <a class="moz-txt-link-rfc2396E" href="mailto:1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk">&lt;1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk&gt;</a>
X-Spam-Score: -1.5 (-)
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
 See <a class="moz-txt-link-freetext" href="http://spamassassin.org/tag/">http://spamassassin.org/tag/</a> for more details.
 -1.5 SPF_CHECK_PASS         SPF reports sender host as permitted sender for
                             sender-domain
 -0.0 SPF_PASS               SPF: sender matches SPF record
X-Headers-End: 1XW6ro-0005DR-7p

From: Anton Ivanov <a class="moz-txt-link-rfc2396E" href="mailto:antivano@cisco.com">&lt;antivano@cisco.com&gt;</a>

This transport allows a UML to connect to another UML local
or remote, the Linux host or any other network device running
the industry standard Ethernet over L2TPv3 protocol as per
RFC 3931 (and successors).

The transport supports a common set of features with the kernel
implementation as well as the Cisco contributed L2TPv3 transport
for QEMU/KVM. In all cases this is static tunnels only, no L2TPv3
control plane.

Additionally, the transport supports the so called "soft"
termination where it can listen for an incoming connection
which does not require the remote endpoint to be specified
at configuration time.

Signed-off-by: Anton Ivanov <a class="moz-txt-link-rfc2396E" href="mailto:antivano@cisco.com">&lt;antivano@cisco.com&gt;</a>
---
 arch/um/Kconfig.net               |   10 +
 arch/um/drivers/Makefile          |    2 +
 arch/um/drivers/uml_l2tpv3.h      |  111 ++++++++++
 arch/um/drivers/uml_l2tpv3_kern.c |  434 +++++++++++++++++++++++++++++++++++++
 arch/um/drivers/uml_l2tpv3_user.c |  409 ++++++++++++++++++++++++++++++++++
 5 files changed, 966 insertions(+)
 create mode 100644 arch/um/drivers/uml_l2tpv3.h
 create mode 100644 arch/um/drivers/uml_l2tpv3_kern.c
 create mode 100644 arch/um/drivers/uml_l2tpv3_user.c

diff --git a/arch/um/Kconfig.net b/arch/um/Kconfig.net
index e4a7cf2..d84a1ee 100644
--- a/arch/um/Kconfig.net
+++ b/arch/um/Kconfig.net
@@ -93,6 +93,16 @@ config UML_NET_SLIP
         UMLs on a single host).  You may choose more than one without
         conflict.  If you don't need UML networking, say N.
 
+config UML_NET_L2TPV3
+	bool "L2TPV3 transport"
+	depends on UML_NET
+	help
+        This User-Mode Linux network transport allows one or more running
+        UMLs on single or multiple hosts to communicate with each other,
+        the host as well as other remote or local network devices supporting
+        the industry standard Ethernet over L2TPv3 protocol as described in
+        the applicable RFCs
+

[snip]

A.

</pre>
    </div>
  </body>
</html>

--------------010902080300000801060309--


--===============9140350386362268788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
--===============9140350386362268788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============9140350386362268788==--


